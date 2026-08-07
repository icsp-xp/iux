sealed class ProjectsUiEvent {
  const ProjectsUiEvent();
}

final class FailedToChooseProjectDir extends ProjectsUiEvent {
  const FailedToChooseProjectDir();
}

final class FailedToCreateTheProject extends ProjectsUiEvent {
  const FailedToCreateTheProject();
}
