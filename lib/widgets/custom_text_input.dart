import 'package:bibletree/config/palette.dart';
import 'package:flutter/material.dart';

/// 느낀 점 입력 위젯
/// * `String? thought` : 이미 작성한 느낀 점이 있을 때 표시할 텍스트
/// * `Function(String) onTextChanged`
class CustomTextInput extends StatefulWidget {
  final String? thought;
  final Function(String) onTextChanged;
  const CustomTextInput(
      {super.key, required this.onTextChanged, required this.thought});

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.thought != null) {
      controller.text = widget.thought!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '어떤 메시지가 있었나요?',
          style: TextStyle(
            fontSize: Palette.body,
            fontWeight: Palette.medium,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: '말씀을 묵상하고 느낀 점을 적어주세요.',
            hintStyle: TextStyle(
              fontSize: Palette.body,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            counterStyle: TextStyle(
              fontSize: Palette.footnote,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.secondary,
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: const TextStyle(fontSize: Palette.body),
          maxLength: 255,
          maxLines: 10,
          onChanged: (text) {
            widget.onTextChanged(text);
          },
        ),
      ],
    );
  }
}
