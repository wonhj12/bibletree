import 'package:flutter/material.dart';

class NameAlert extends StatefulWidget {
  const NameAlert({super.key});

  @override
  State<NameAlert> createState() => _NameAlertState();
}

class _NameAlertState extends State<NameAlert> {
  final controller = TextEditingController();
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      // title: const Text('이름을 지어주세요!'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('이름을 지어주세요!'),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: '이름을 입력해 주세요',
              errorText: _errorText,
            ),
          ),
          TextButton(
            onPressed: () => _validate(),
            child: const Text('확인'),
          )
        ],
      ),
    );
  }

  void _validate() {
    if (controller.text.isEmpty) {
      setState(() {
        _errorText = '이름을 입력하세요';
      });
    } else {
      Navigator.pop(context, controller.text);
    }
  }
}
