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
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
              hintText: '말씀을 묵상하고 느낀 점을 적어주세요.',
              hintStyle: const TextStyle(
                  fontSize: AppStatics.body, color: AppStatics.secondary),
              counterStyle: const TextStyle(
                  fontSize: AppStatics.footnote, color: AppStatics.secondary),
              filled: true,
              fillColor: AppStatics.green200,
              contentPadding: const EdgeInsets.all(8),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10))),
          style: const TextStyle(fontSize: AppStatics.body),
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
