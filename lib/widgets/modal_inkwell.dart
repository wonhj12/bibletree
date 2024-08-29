import 'package:bibletree/statics/app_statics.dart';
import 'package:flutter/material.dart';

class ModalInkwell extends StatelessWidget {
  final String title;
  final bool isTop;
  final bool isBottom;
  final VoidCallback? onTap;

  const ModalInkwell({
    super.key,
    required this.title,
    this.isTop = false,
    this.isBottom = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // Operate onTap function
            if (onTap != null) onTap!();
            // Close modal
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(isTop ? 10 : 0),
            bottom: Radius.circular(isBottom ? 10 : 0),
          ),
          child: Container(
            height: 56,
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: AppStatics.body,
                fontWeight: AppStatics.regular,
              ),
            ),
          ),
        ),

        // Add divider if not last element
        !isBottom
            ? Divider(
                height: 0, color: Theme.of(context).colorScheme.onTertiary)
            : Container(),
      ],
    );
  }
}
