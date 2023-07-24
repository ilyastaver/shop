import 'package:flutter/material.dart';
import 'package:theshop/my_flutter_app_icons.dart';

class CartButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final int counter;
  final ValueChanged<int> onCounterChanged;

  const CartButton({
    required this.onPressed,
    required this.counter,
    required this.onCounterChanged,
  });

  @override
  _CartButtonState createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  void _incrementCounter() {
    widget.onCounterChanged(widget.counter + 1);
  }

  void _decrementCounter() {
    if (widget.counter > 0) {
      widget.onCounterChanged(widget.counter - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'В КОРЗИНУ',
      child: Center(
        child: widget.counter == 0
            ? InkWell(
          onTap: () {
            if (widget.onPressed != null) {
              widget.onPressed!();
            }
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                MyFlutterApp.korzina,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'В КОРЗИНУ',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              alignment: Alignment.center,
              onPressed: _decrementCounter,
              icon: const Icon(Icons.remove, color: Colors.white),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 68, vertical: 6),
              color: Colors.white70,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'В КОРЗИНЕ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 11
                    ),
                  ),
                  Text(
                    widget.counter.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: _incrementCounter,
              icon: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
