import 'dart:async';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:iux/domain/failure.dart';
import 'package:iux/domain/model/iux_settings.dart';
import 'package:iux/domain/model/project.dart';
import 'package:iux/domain/request_status.dart';
import 'package:iux/ui/projects/cubit/projects_cubit.dart';
import 'package:iux/ui/projects/cubit/projects_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes/fake_directory.dart';
import '../../mocks/mock_get_folder_path_use_case.dart';
import '../../mocks/mock_iux_settings_repository.dart';
import '../../mocks/mock_projects_repository.dart';

void main() {
  late ProjectsCubit projectsCubit;
  late MockProjectsRepository mockProjectsRepository;
  late MockIuxSettingsRepository mockIuxSettingsRepository;
  late MockGetFolderPathUseCase mockGetFolderPathUseCase;

  const String defaultProjectDirPath = '/home/user/projects';
  const IuxSettings mockSettings = IuxSettings(
    defaultProjectDirPath: defaultProjectDirPath,
  );
  final List<Project> mockProjects = [
    Project(
      name: 'Project 1',
      dirPath: '/path/to/project1',
      createdAt: DateTime.now(),
    ),
    Project(
      name: 'Project 2',
      dirPath: '/path/to/project2',
      createdAt: DateTime.now(),
    ),
  ];

  setUpAll(() {
    registerFallbackValue(FakeDirectory(''));
    registerFallbackValue(const UnexpectedFailure());
  });

  setUp(() {
    mockProjectsRepository = MockProjectsRepository();
    mockIuxSettingsRepository = MockIuxSettingsRepository();
    mockGetFolderPathUseCase = MockGetFolderPathUseCase();

    projectsCubit = ProjectsCubit(
      projectsRepository: mockProjectsRepository,
      iuxSettingsRepository: mockIuxSettingsRepository,
      getFolderPathUseCase: mockGetFolderPathUseCase,
    );
  });

  tearDown(() async {
    await projectsCubit.close();
  });

  group('ProjectsCubit initialization', () {
    test('initial state is correct', () {
      expect(projectsCubit.state, const ProjectsState());
    });

    blocTest<ProjectsCubit, ProjectsState>(
      'emits correct states when init() succeeds',
      build: () => projectsCubit,
      setUp: () {
        when(
          () => mockIuxSettingsRepository.getSettings(),
        ).thenAnswer((_) => TaskEither.right(mockSettings));
        when(
          () => mockProjectsRepository.watchProjects(any()),
        ).thenAnswer((_) => Stream.value(mockProjects));
      },
      act: (cubit) => cubit.init(),
      expect: () => [
        const ProjectsState(
          projectsDirPath: defaultProjectDirPath,
          projects: RequestStatus.idle(),
        ),
        const ProjectsState(
          projectsDirPath: defaultProjectDirPath,
          projects: RequestStatus.pending(),
        ),
        ProjectsState(
          projectsDirPath: defaultProjectDirPath,
          projects: RequestStatus.succeeded(mockProjects),
        ),
      ],
      verify: (cubit) {
        verify(() => mockIuxSettingsRepository.getSettings()).called(1);
        verify(
          () =>
              mockProjectsRepository.watchProjects(any(that: isA<Directory>())),
        ).called(1);
      },
    );

    blocTest<ProjectsCubit, ProjectsState>(
      'emits error state when getSettings() fails',
      build: () => projectsCubit,
      setUp: () {
        when(
          () => mockIuxSettingsRepository.getSettings(),
        ).thenAnswer((_) => TaskEither.left(const UnexpectedFailure()));
      },
      act: (cubit) => cubit.init(),
      expect: () => [
        const ProjectsState(
          projects: RequestStatus.failed(UnexpectedFailure()),
        ),
      ],
      verify: (cubit) {
        verify(() => mockIuxSettingsRepository.getSettings()).called(1);
        verifyNever(() => mockProjectsRepository.watchProjects(any()));
      },
    );

    late StreamController<List<Project>> firstStreamController;
    late StreamController<List<Project>> secondStreamController;
    blocTest<ProjectsCubit, ProjectsState>(
      'cancels previous subscription when changing project directory',
      build: () => projectsCubit,
      setUp: () {
        firstStreamController = StreamController<List<Project>>();
        secondStreamController = StreamController<List<Project>>();

        when(
          () => mockIuxSettingsRepository.getSettings(),
        ).thenAnswer((_) => TaskEither.right(mockSettings));
        when(
          () => mockProjectsRepository.watchProjects(
            any(
              that: isA<Directory>().having(
                (d) => d.path,
                'path',
                defaultProjectDirPath,
              ),
            ),
          ),
        ).thenAnswer((_) => firstStreamController.stream);
        when(
          () => mockProjectsRepository.watchProjects(
            any(
              that: isA<Directory>().having((d) => d.path, 'path', '/new/path'),
            ),
          ),
        ).thenAnswer((_) => secondStreamController.stream);
        when(
          () => mockGetFolderPathUseCase.get(any()),
        ).thenAnswer((_) => Future.value(const Right('/new/path')));
      },
      act: (cubit) async {
        await cubit.init();
        firstStreamController.add(mockProjects);
        await pumpEventQueue();

        await cubit.chooseProjectDir('Select');
        secondStreamController.add([]);
        await pumpEventQueue();

        expect(firstStreamController.hasListener, isFalse);
        expect(secondStreamController.hasListener, isTrue);
      },
      expect: () => [
        const ProjectsState(
          projectsDirPath: defaultProjectDirPath,
          projects: RequestStatus.idle(),
        ),
        const ProjectsState(
          projectsDirPath: defaultProjectDirPath,
          projects: RequestStatus.pending(),
        ),
        ProjectsState(
          projectsDirPath: defaultProjectDirPath,
          projects: RequestStatus.succeeded(mockProjects),
        ),
        ProjectsState(
          projectsDirPath: '/new/path',
          projects: RequestStatus.succeeded(mockProjects),
        ),
        const ProjectsState(
          projectsDirPath: '/new/path',
          projects: RequestStatus.pending(),
        ),
        const ProjectsState(
          projectsDirPath: '/new/path',
          projects: RequestStatus.succeeded([]),
        ),
      ],
      verify: (cubit) {
        verify(() => mockProjectsRepository.watchProjects(any())).called(2);
      },
      tearDown: () {
        firstStreamController.close();
        secondStreamController.close();
      },
    );
  });

  group('Delete project', () {
    blocTest<ProjectsCubit, ProjectsState>(
      'calls delete on repository when delete() is called',
      build: () => projectsCubit,
      setUp: () {
        when(
          () => mockProjectsRepository.delete(any()),
        ).thenAnswer((_) => TaskEither.right(unit));
      },
      act: (cubit) => cubit.delete('/path/to/project'),
      verify: (cubit) {
        verify(
          () => mockProjectsRepository.delete('/path/to/project'),
        ).called(1);
      },
    );

    blocTest<ProjectsCubit, ProjectsState>(
      'handles delete failure gracefully',
      build: () => projectsCubit,
      setUp: () {
        when(
          () => mockProjectsRepository.delete(any()),
        ).thenAnswer((_) => TaskEither.left(const UnexpectedFailure()));
      },
      act: (cubit) => cubit.delete('/path/to/project'),
      expect: () => [],
      verify: (cubit) {
        verify(
          () => mockProjectsRepository.delete('/path/to/project'),
        ).called(1);
      },
    );
  });

  group('Choose project directory', () {
    blocTest<ProjectsCubit, ProjectsState>(
      'emits new directory path and watches projects when path is selected',
      build: () => projectsCubit,
      setUp: () {
        when(
          () => mockGetFolderPathUseCase.get(any()),
        ).thenAnswer((_) => Future.value(const Right('/new/projects/path')));
        when(
          () => mockProjectsRepository.watchProjects(any()),
        ).thenAnswer((_) => Stream.value(mockProjects));
      },
      act: (cubit) => cubit.chooseProjectDir('Select Project Directory'),
      expect: () => [
        const ProjectsState(
          projectsDirPath: '/new/projects/path',
          projects: RequestStatus.idle(),
        ),
        const ProjectsState(
          projectsDirPath: '/new/projects/path',
          projects: RequestStatus.pending(),
        ),
        ProjectsState(
          projectsDirPath: '/new/projects/path',
          projects: RequestStatus.succeeded(mockProjects),
        ),
      ],
      verify: (cubit) {
        verify(
          () => mockGetFolderPathUseCase.get('Select Project Directory'),
        ).called(1);
        verify(() => mockProjectsRepository.watchProjects(any())).called(1);
      },
    );

    blocTest<ProjectsCubit, ProjectsState>(
      'does nothing when user cancels directory selection',
      build: () => projectsCubit,
      setUp: () {
        projectsCubit.emit(
          ProjectsState(
            projectsDirPath: defaultProjectDirPath,
            projects: RequestStatus.succeeded(mockProjects),
          ),
        );
        when(
          () => mockGetFolderPathUseCase.get(any()),
        ).thenAnswer((_) => Future.value(left(const UnexpectedFailure())));
      },
      act: (cubit) => cubit.chooseProjectDir('Select Project Directory'),
      expect: () => [],
      verify: (cubit) {
        verify(
          () => mockGetFolderPathUseCase.get('Select Project Directory'),
        ).called(1);
        verifyNever(() => mockProjectsRepository.watchProjects(any()));
      },
    );
  });
}
