import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

void showErrorToast({
  required final BuildContext context,
  required final String errorMsg,
}) => showFToast(
  context: context,
  variant: .destructive,
  icon: const Icon(FLucideIcons.circleX),
  title: Text(errorMsg),
);

void showWarningToast({
  required final BuildContext context,
  required final String warningMsg,
}) => showFToast(
  context: context,
  icon: const Icon(FLucideIcons.triangleAlert),
  title: Text(warningMsg),
);

void showInfoToast({
  required final BuildContext context,
  required final String infoMsg,
}) => showFToast(
  context: context,
  icon: const Icon(FLucideIcons.info),
  title: Text(infoMsg),
);
