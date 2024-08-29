import 'package:bibletree/statics/app_statics.dart';
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
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '이름을 지어주세요!',
            style: TextStyle(fontSize: AppStatics.body),
          ),
          const SizedBox(height: 4),

          // Name textfield
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: '이름을 입력해 주세요',
              errorText: _errorText,
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.secondary),
              ),
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