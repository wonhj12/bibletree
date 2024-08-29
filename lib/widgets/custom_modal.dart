import 'package:bibletree/widgets/modal_inkwell.dart';
import 'package:flutter/material.dart';

class CustomModal extends StatelessWidget {
  final List<Widget> buttons;

  const CustomModal({super.key, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Button area
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Ink(
              height: (56 * buttons.length).toDouble(),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(children: buttons),
            ),
          ),
          const SizedBox(height: 8),

          // Cancel button
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Ink(
              height: 56,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: ModalInkwell(
                title: '취소',
                isTop: true,
                isBottom: true,
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
