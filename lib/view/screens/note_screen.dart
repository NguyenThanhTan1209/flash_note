import 'dart:developer';

import 'package:flutter/material.dart';

import '../utils/color_contants.dart';
import '../utils/number_contants.dart';
import '../utils/string_contants.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final TextEditingController _noteEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringContants.appBarAddNoteTitle),
        backgroundColor: ColorContants.mainColor,
        foregroundColor: ColorContants.whiteColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(NumberContants.padding16),
          child: Column(
            children: <Widget>[
              Expanded(
                child: TextField(
                  autofocus: true,
                  controller: _noteEditingController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: StringContants.addNoteHintText,
                  ),
                ),
              ),
              const SizedBox(height: NumberContants.height16),
              ElevatedButton(
                onPressed: () {
                  log('save ${_noteEditingController.text}');
                },
                child: const Text(StringContants.saveNoteButtonTitle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
