import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(this.heading);
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          heading,
          style: const TextStyle(fontSize: 24),
        ),
      );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content);
  final String content;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      );
}

class IconAndDetail extends StatelessWidget {
  const IconAndDetail(this.icon, this.detail);
  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              detail,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      );
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
            // side: const BorderSide(color: Colors.deepPurple)),
            side: const BorderSide(color: Colors.deepOrangeAccent)),
        onPressed: onPressed,
        child: child,
      );
}

class ForgotPwdButton extends StatelessWidget {
  const ForgotPwdButton({required this.child, required this.onTap});
  final Widget child;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: child,
      );
}

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.deepOrangeAccent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      ),
    );
  }
}
