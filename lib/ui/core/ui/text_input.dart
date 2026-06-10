import 'package:flutter/widgets.dart';
import 'package:iux/ui/core/theme/theme_provider.dart';

class TextInput extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String>? onChanged;
  final bool obscureText;

  const TextInput({
    this.initialValue = '',
    this.onChanged,
    this.obscureText = false,
    super.key,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController();

    _updateText(widget.initialValue);
  }

  void _updateText(String text) {
    _controller.value = _controller.value.copyWith(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context);
    final colorScheme = theme.colorScheme;
    final typography = theme.typography;
    final radiusSize = theme.radiusSize;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: _focusNode.hasFocus
              ? colorScheme.primary
              : colorScheme.outline,
        ),
        borderRadius: BorderRadius.circular(radiusSize.small),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: EditableText(
          controller: _controller,
          focusNode: _focusNode,
          style: typography.bodyMedium,
          cursorColor: colorScheme.primary,
          backgroundCursorColor: colorScheme.surfaceContainer,
          obscureText: widget.obscureText,
          onChanged: widget.onChanged,
          showCursor: true,
        ),
      ),
    );
  }
}
