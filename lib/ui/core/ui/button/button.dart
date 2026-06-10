import 'package:flutter/widgets.dart';
import 'package:iux/ui/core/theme/data/button_theme_data.dart';
import 'package:iux/ui/core/theme/theme_provider.dart';
import 'package:iux/ui/core/ui/gap.dart';

enum _ButtonType { primary, secondary, error, none }

class Button extends StatefulWidget {
  final ButtonThemeData? buttonThemeData;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final Widget child;
  final _ButtonType _buttonType;

  const Button({
    required this.child,
    required this.buttonThemeData,
    this.leading,
    this.trailing,
    this.onPressed,
    super.key,
  }) : _buttonType = _ButtonType.none;

  const Button.primary({
    required this.child,
    this.leading,
    this.trailing,
    this.onPressed,
    super.key,
  }) : buttonThemeData = null,
       _buttonType = _ButtonType.primary;

  const Button.secondary({
    required this.child,
    this.leading,
    this.trailing,
    this.onPressed,
    super.key,
  }) : buttonThemeData = null,
       _buttonType = _ButtonType.secondary;

  const Button.error({
    required this.child,
    this.leading,
    this.trailing,
    this.onPressed,
    super.key,
  }) : buttonThemeData = null,
       _buttonType = _ButtonType.error;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context);

    final buttonTheme =
        widget.buttonThemeData ??
        switch (widget._buttonType) {
          _ButtonType.primary => theme.primaryButtonThemeData,
          _ButtonType.secondary => theme.secondaryButtonThemeData,
          _ButtonType.error => theme.errorButtonThemeData,
          _ButtonType.none => theme.primaryButtonThemeData,
        };

    final isDisabled = widget.onPressed == null;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: isDisabled
                ? buttonTheme.disabledColor
                : (_isHovering
                      ? buttonTheme.hoverColor
                      : buttonTheme.backgroundColor),
            borderRadius: buttonTheme.borderRadius,
            border: buttonTheme.border,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                if (widget.leading != null) ...[
                  IconTheme(
                    data: IconThemeData(color: buttonTheme.foregroundColor),
                    child: DefaultTextStyle(
                      style: TextStyle(color: buttonTheme.foregroundColor),
                      child: widget.leading!,
                    ),
                  ),
                  Gap(theme.spacing.smaller),
                ],

                IconTheme(
                  data: IconThemeData(color: buttonTheme.foregroundColor),
                  child: DefaultTextStyle(
                    style: TextStyle(color: buttonTheme.foregroundColor),
                    child: widget.child,
                  ),
                ),

                if (widget.trailing != null) ...[
                  Gap(theme.spacing.smaller),
                  IconTheme(
                    data: IconThemeData(color: buttonTheme.foregroundColor),
                    child: DefaultTextStyle(
                      style: TextStyle(color: buttonTheme.foregroundColor),
                      child: widget.trailing!,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
