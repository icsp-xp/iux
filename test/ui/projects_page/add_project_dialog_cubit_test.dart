import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:iux/core/supported_target_platform.dart';
import 'package:iux/domain/failure.dart';
import 'package:iux/domain/model/iux_settings.dart';
import 'package:iux/ui/projects/projects_ui_event.dart';
import 'package:iux/ui/projects/widgets/add_project_dialog/cubit/add_project_dialog_cubit.dart';
import 'package:iux/ui/projects/widgets/add_project_dialog/cubit/add_project_dialog_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_get_folder_path_use_case.dart';
import '../../mocks/mock_iux_settings_repository.dart';
import '../../mocks/mock_projects_repository.dart';

void main() {
  late AddProjectDialogCubit cubit;
  late MockProjectsRepository mockProjectsRepository;
  late MockIuxSettingsRepository mockIuxSettingsRepository;
  late MockGetFolderPathUseCase mockGetFolderPathUseCase;

  const String defaultProjectDirPath = '/home/user/projects';
  const String defaultWindowsProjectDirPath = r'C:\Users\user\projects';

  const IuxSettings mockSettings = IuxSettings(
    defaultProjectDirPath: defaultProjectDirPath,
  );
  const IuxSettings mockWindowsSettings = IuxSettings(
    defaultProjectDirPath: defaultWindowsProjectDirPath,
  );

  setUp(() {
    mockProjectsRepository = MockProjectsRepository();
    mockIuxSettingsRepository = MockIuxSettingsRepository();
    mockGetFolderPathUseCase = MockGetFolderPathUseCase();

    cubit = AddProjectDialogCubit(
      projectsRepository: mockProjectsRepository,
      iuxSettingsRepository: mockIuxSettingsRepository,
      getFolderPathUseCase: mockGetFolderPathUseCase,
    );
  });

  tearDown(() async {
    await cubit.close();
  });

  group('AddProjectDialogCubit initialization', () {
    test('initial state is correct', () {
      expect(cubit.state, const AddProjectDialogState());
    });
  });

  for (final platform in STP.platforms) {
    group('setDirPathToDefault', () {
      setUp(() => debugDefaultTargetPlatformOverride = platform);
      tearDown(() => debugDefaultTargetPlatformOverride = null);

      if (platform == TargetPlatform.linux ||
          platform == TargetPlatform.macOS) {
        blocTest<AddProjectDialogCubit, AddProjectDialogState>(
          'emits state with default dir path when getSettings() succeeds',
          build: () => cubit,
          setUp: () {
            when(
              () => mockIuxSettingsRepository.getSettings(),
            ).thenAnswer((_) => TaskEither.right(mockSettings));
          },
          act: (cubit) => cubit.setDirPathToDefault(),
          expect: () => [
            const AddProjectDialogState(
              dirPath: defaultProjectDirPath,
              isDirPathValid: true,
            ),
          ],
          verify: (_) {
            verify(() => mockIuxSettingsRepository.getSettings()).called(1);
          },
        );

        blocTest<AddProjectDialogCubit, AddProjectDialogState>(
          'emits nothing when getSettings() fails',
          build: () => cubit,
          setUp: () {
            when(
              () => mockIuxSettingsRepository.getSettings(),
            ).thenAnswer((_) => TaskEither.left(const UnexpectedFailure()));
          },
          act: (cubit) => cubit.setDirPathToDefault(),
          expect: () => [],
          verify: (_) {
            verify(() => mockIuxSettingsRepository.getSettings()).called(1);
          },
        );
      } else if (platform == TargetPlatform.windows) {
        blocTest<AddProjectDialogCubit, AddProjectDialogState>(
          'emits state with default Windows dir path when getSettings() succeeds',
          build: () => cubit,
          setUp: () {
            when(
              () => mockIuxSettingsRepository.getSettings(),
            ).thenAnswer((_) => TaskEither.right(mockWindowsSettings));
          },
          act: (cubit) => cubit.setDirPathToDefault(),
          expect: () => [
            const AddProjectDialogState(
              dirPath: defaultWindowsProjectDirPath,
              isDirPathValid: true,
            ),
          ],
          verify: (_) {
            verify(() => mockIuxSettingsRepository.getSettings()).called(1);
          },
        );

        blocTest<AddProjectDialogCubit, AddProjectDialogState>(
          'emits nothing when getSettings() fails',
          build: () => cubit,
          setUp: () {
            when(
              () => mockIuxSettingsRepository.getSettings(),
            ).thenAnswer((_) => TaskEither.left(const UnexpectedFailure()));
          },
          act: (cubit) => cubit.setDirPathToDefault(),
          expect: () => [],
          verify: (_) {
            verify(() => mockIuxSettingsRepository.getSettings()).called(1);
          },
        );
      }
    });
  }

  group('onNameChanged', () {
    blocTest<AddProjectDialogCubit, AddProjectDialogState>(
      'emits state with trimmed name',
      build: () => cubit,
      act: (cubit) => cubit.onNameChanged('  New Project  '),
      expect: () => [const AddProjectDialogState(name: 'New Project')],
    );
  });

  for (final platform in STP.platforms) {
    group('onDirPathChanged', () {
      setUp(() => debugDefaultTargetPlatformOverride = platform);
      tearDown(() => debugDefaultTargetPlatformOverride = null);

      if (platform == TargetPlatform.linux ||
          platform == TargetPlatform.macOS) {
        blocTest<AddProjectDialogCubit, AddProjectDialogState>(
          'emits trimmed dirPath and updates validity to true when path is valid',
          build: () => cubit,
          act: (cubit) => cubit.onDirPathChanged('  /valid/path  '),
          expect: () => [
            const AddProjectDialogState(
              dirPath: '/valid/path',
              isDirPathValid: true,
            ),
          ],
        );

        blocTest<AddProjectDialogCubit, AddProjectDialogState>(
          'emits trimmed dirPath and updates validity to false when path is not valid',
          build: () => cubit,
          act: (cubit) => cubit.onDirPathChanged('  /invalid/path\x00  '),
          expect: () => [
            const AddProjectDialogState(
              dirPath: '/invalid/path\x00',
              isDirPathValid: false,
            ),
          ],
        );
      } else if (platform == TargetPlatform.windows) {
        blocTest<AddProjectDialogCubit, AddProjectDialogState>(
          'emits trimmed dirPath and updates validity to true when Windows path is valid',
          build: () => cubit,
          act: (cubit) => cubit.onDirPathChanged(r'  C:\valid\path  '),
          expect: () => [
            const AddProjectDialogState(
              dirPath: r'C:\valid\path',
              isDirPathValid: true,
            ),
          ],
        );

        blocTest<AddProjectDialogCubit, AddProjectDialogState>(
          'emits trimmed dirPath and updates validity to false when Windows path contains invalid characters',
          build: () => cubit,
          act: (cubit) => cubit.onDirPathChanged(r'  C:\inva<lid>path|?  '),
          expect: () => [
            const AddProjectDialogState(
              dirPath: r'C:\inva<lid>path|?',
              isDirPathValid: false,
            ),
          ],
        );
      }
    });
  }

  group('getProjectDir', () {
    const String dialogTitle = 'Select Project Directory';

    blocTest<AddProjectDialogCubit, AddProjectDialogState>(
      'emits updated dirPath and isDirPathValid = true when folder path is selected',
      build: () => cubit,
      setUp: () {
        when(
          () => mockGetFolderPathUseCase.get(dialogTitle),
        ).thenAnswer((_) => Future.value(right('/selected/path')));
      },
      act: (cubit) => cubit.getProjectDir(dialogTitle),
      expect: () => [
        const AddProjectDialogState(
          dirPath: '/selected/path',
          isDirPathValid: true,
        ),
      ],
      verify: (_) {
        verify(() => mockGetFolderPathUseCase.get(dialogTitle)).called(1);
      },
    );

    blocTest<AddProjectDialogCubit, AddProjectDialogState>(
      'emits isDirPathValid = false when folder selection is cancelled',
      build: () => cubit,
      setUp: () {
        when(
          () => mockGetFolderPathUseCase.get(dialogTitle),
        ).thenAnswer((_) => Future.value(left(const InvalidDataFailure())));
      },
      act: (cubit) => cubit.getProjectDir(dialogTitle),
      expect: () => [const AddProjectDialogState(isDirPathValid: false)],
      verify: (_) {
        verify(() => mockGetFolderPathUseCase.get(dialogTitle)).called(1);
      },
    );
  });

  group('onAdd', () {
    const String validName = 'My App';
    const String validDirPath = '/home/user/projects/my_app';

    blocTest<AddProjectDialogCubit, AddProjectDialogState>(
      'does nothing when canAdd() returns false',
      build: () => cubit,
      act: (cubit) => cubit.onAdd(),
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockProjectsRepository.create(any(), any()));
      },
    );

    blocTest<AddProjectDialogCubit, AddProjectDialogState>(
      'emits isAdding true then false when repository creation succeeds',
      build: () => cubit,
      seed: () => const AddProjectDialogState(
        name: validName,
        dirPath: validDirPath,
        isDirPathValid: true,
      ),
      setUp: () {
        when(
          () => mockProjectsRepository.create(validName, validDirPath),
        ).thenAnswer((_) => TaskEither.right(unit));
      },
      act: (cubit) => cubit.onAdd(),
      expect: () => [
        const AddProjectDialogState(
          name: validName,
          dirPath: validDirPath,
          isDirPathValid: true,
          isAdding: true,
        ),
        const AddProjectDialogState(
          name: validName,
          dirPath: validDirPath,
          isDirPathValid: true,
          isAdding: false,
        ),
      ],
      verify: (_) {
        verify(
          () => mockProjectsRepository.create(validName, validDirPath),
        ).called(1);
      },
    );

    blocTest<AddProjectDialogCubit, AddProjectDialogState>(
      'emits isAdding true then false and emit FailedToCreateTheProject presentation event when repository creation fails',
      build: () => cubit,
      seed: () => const AddProjectDialogState(
        name: validName,
        dirPath: validDirPath,
        isDirPathValid: true,
      ),
      setUp: () {
        when(
          () => mockProjectsRepository.create(validName, validDirPath),
        ).thenAnswer((_) => TaskEither.left(const UnexpectedFailure()));
      },
      act: (cubit) {
        expectLater(
          cubit.presentation,
          emits(const FailedToCreateTheProject()),
        );

        cubit.onAdd();
      },
      expect: () => [
        const AddProjectDialogState(
          name: validName,
          dirPath: validDirPath,
          isDirPathValid: true,
          isAdding: true,
        ),
        const AddProjectDialogState(
          name: validName,
          dirPath: validDirPath,
          isDirPathValid: true,
          isAdding: false,
        ),
      ],
      verify: (_) {
        verify(
          () => mockProjectsRepository.create(validName, validDirPath),
        ).called(1);
      },
    );
  });
}
