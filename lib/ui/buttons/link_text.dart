import 'package:flutter/material.dart';

class LinkText extends StatefulWidget {
  final String text;
  final Function? onPressed;

  const LinkText({super.key, required this.text, this.onPressed});

  @override
  State<LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  bool isHover = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(widget.onPressed != null) widget.onPressed!();
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 16,
              color: isHover ? Colors.grey : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }
}