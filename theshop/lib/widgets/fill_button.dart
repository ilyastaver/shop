import 'package:flutter/material.dart';

class FillButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? buttonName;

  const FillButton({required this.onPressed, required this.buttonName, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'В КОРЗИНУ',
      child: Center(
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Hero(
              tag: 'unique_tag_for_this_hero',
              child: Text(
                buttonName!,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
