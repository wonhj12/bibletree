// import 'package:bibletree/statics/app_statics.dart';
// import 'package:flutter/material.dart';

// class NameAlert extends StatefulWidget {
//   const NameAlert({super.key});

//   @override
//   State<NameAlert> createState() => _NameAlertState();
// }

// class _NameAlertState extends State<NameAlert> {
//   final controller = TextEditingController();
//   String? _errorText;

//   @override
//   Widget build(BuildContext context) {
//     return

//   void _validate() {
//     if (controller.text.isEmpty) {
//       setState(() {
//         _errorText = '이름을 입력하세요';
//       });
//     } else {
//       Navigator.pop(context, controller.text);
//     }
//   }
// }

import 'package:bibletree/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 이름 입력 팝업을 띄우는 위젯
/// * `BuildContext context`
/// * `TextEditingController controller`
///
/// 아무것도 입력하지 않고 확인 버튼을 클릭하면 에러 메세지를 적용
/// <br /> 텍스트를 입력하면 팝업을 종료
Future<void> showNameDialog(
  BuildContext context,
  TextEditingController controller,
) async {
  String? errorText;

  await showDialog(
    context: context,
    builder: (BuildContext context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '이름을 지어주세요!',
              style: TextStyle(fontSize: Palette.body),
            ),
            const SizedBox(height: 4),

            // Name textfield
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: '이름을 입력해 주세요',
                errorText: errorText,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.trim().isEmpty) {
                  setState(() {
                    errorText = '이름을 입력하세요';
                  });
                } else {
                  context.pop();
                }
              },
              child: const Text('확인'),
            )
          ],
        ),
      ),
    ),
  );
}
