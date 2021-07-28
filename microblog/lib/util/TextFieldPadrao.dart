import 'package:flutter/material.dart';

class TextFieldPadrao extends StatelessWidget {
  final Function(String text) onChanged;
  final String titulo, value;
  final bool obscureText;
  const TextFieldPadrao(
      {Key key,
      this.onChanged,
      this.titulo,
      this.obscureText = false,
      this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: titulo?.isNotEmpty ?? false,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text("$titulo"),
              )),
          Container(
            height: 50,
            child: TextField(
              onChanged: onChanged,
              obscureText: obscureText,
              controller: TextEditingController(text: value ?? ""),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  fillColor: Colors.white70),
            ),
          )
        ]);
  }
}
