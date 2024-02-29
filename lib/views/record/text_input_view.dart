import 'package:bibletree/statics/app_statics.dart';
import 'package:flutter/material.dart';

class TextInputView extends StatefulWidget {
  final String? thought;
  final Function(String) onTextChanged;
  const TextInputView(
      {super.key, required this.onTextChanged, required this.thought});

  @override
  State<TextInputView> createState() => _TextInputViewState();
}

class _TextInputViewState extends State<TextInputView> {
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
            fontSize: AppStatics.body,
            fontWeight: AppStatics.medium,
          ),
        ),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
              hintText: '말씀을 묵상하고 느낀 점을 적어주세요', border: InputBorder.none),
          maxLength: 255,
          maxLines: null,
          onChanged: (text) {
            widget.onTextChanged(text);
          },
        ),
      ],
    );
  }
}
