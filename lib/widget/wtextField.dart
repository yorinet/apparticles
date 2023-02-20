import 'package:flutter/material.dart';

class WtextField extends StatelessWidget {
  final String? textHint;
  final TextEditingController? controller;
  void Function(String)? onChanged;
  WtextField({super.key, this.textHint, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: false,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
        hintText: textHint,
      ),
    );
  }
}




/*
Column(
      children: [
        
        ElevatedButton(onPressed: (){
          setState(() {
            displayText = textController.text;
          });
        }, child: Text("Show Text")),
        Text(displayText,style: TextStyle(fontSize: 20),)
      ],
    );
    */