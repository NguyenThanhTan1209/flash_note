import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/note/note_bloc.dart';
import '../../business_logic/blocs/note/note_event.dart';
import '../../business_logic/blocs/note/note_state.dart';
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
  final TextEditingController _fileNameEditingController =
      TextEditingController();

  void _showAddNoteDialog() {
    if (_noteEditingController.text.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text(StringContants.addNoteDialogTitle),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: NumberContants.contentPadding16,
            ),
            children: <Widget>[
              const SizedBox(
                height: NumberContants.height16,
              ),
              TextField(
                autofocus: true,
                controller: _fileNameEditingController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: StringContants.addNoteHintText,
                ),
              ),
              const SizedBox(
                height: NumberContants.height16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(
                    width: NumberContants.width16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _handleCreateNewNote(
                        _fileNameEditingController.text,
                        _noteEditingController.text,
                      );
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
              const SizedBox(
                height: NumberContants.height16,
              ),
            ],
          );
        },
      );
    }
  }

  void _handleCreateNewNote(String fileName, String fileContent) {
    if (fileName.isEmpty || fileName.contains(' ')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(StringContants.textInvalidFileNameWarning),
        ),
      );
    } else {
      context
          .read<NoteBloc>()
          .add(AddNewNote(fileName: fileName, fileContent: fileContent));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringContants.appBarAddNoteTitle),
        backgroundColor: ColorContants.mainColor,
        foregroundColor: ColorContants.whiteColor,
      ),
      body: BlocListener<NoteBloc, NoteState>(
        listener: (BuildContext context, NoteState state) {
          if (state is NoteSucessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('File ${state.fileName} lưu thành công')),
            );
          }
          if (state is NoteFaileState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Có lỗi xảy ra: ${state.error}')),
            );
          }
        },
        child: SafeArea(
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
                    _showAddNoteDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorContants.secondaryColor,
                    foregroundColor: ColorContants.blackColor,
                  ),
                  child: const Text(StringContants.saveNoteButtonTitle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
