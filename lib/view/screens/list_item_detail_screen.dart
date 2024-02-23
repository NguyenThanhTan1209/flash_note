import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/list_file/list_file_bloc.dart';
import '../../business_logic/blocs/list_file/list_file_event.dart';
import '../../business_logic/blocs/list_item_detail/list_item_detail_bloc.dart';
import '../../business_logic/blocs/list_item_detail/list_item_detail_event.dart';
import '../../business_logic/blocs/list_item_detail/list_item_detail_state.dart';
import '../../business_logic/blocs/note/note_bloc.dart';
import '../../business_logic/blocs/note/note_event.dart';
import '../utils/color_contants.dart';
import '../utils/number_contants.dart';
import '../utils/string_contants.dart';

class ListItemDetailScreen extends StatefulWidget {
  const ListItemDetailScreen({super.key, required this.fileName});

  final String fileName;

  @override
  State<ListItemDetailScreen> createState() => _ListItemDetailScreenState();
}

class _ListItemDetailScreenState extends State<ListItemDetailScreen> {
  late final TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();

    context
        .read<ListItemDetalBloc>()
        .add(GetFileDetail(fileName: widget.fileName));
  }

  @override
  void dispose() {
    super.dispose();
    _editingController.dispose();
  }

  void _updateNote(String fileName, String fileContent) {
    if (fileContent.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(StringContants.warningAboutEmptyFileContent),
        ),
      );
    } else {
      context
          .read<NoteBloc>()
          .add(AddNewNote(fileName: fileName, fileContent: fileContent));
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            StringContants.notificationOfSuccessfulFileSaving(fileName),
          ),
        ),
      );
    }
  }

  void _handleDeleteFile(String fileName) {
    context.read<NoteBloc>().add(
          DeleteNote(
            fileName: fileName,
          ),
        );
    Navigator.of(context).pop();
    Navigator.of(context).pop(); //return main page
    context.read<ListFileBloc>().add(GetListFile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fileName),
        backgroundColor: ColorContants.mainColor,
        foregroundColor: ColorContants.whiteColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(NumberContants.padding16),
          child: BlocBuilder<ListItemDetalBloc, ListItemDetailState>(
            builder: (BuildContext context, ListItemDetailState state) {
              if (state is ListItemDetailSuccessState) {
                _editingController.text = state.note.noteFileContent;

                return Column(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        controller: _editingController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: StringContants.addNoteHintText,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        OutlinedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete File'),
                                  content: Text(
                                    StringContants.warningAboutFileDeletion(
                                      widget.fileName,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        _handleDeleteFile(widget.fileName);
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('No'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                          ),
                          child: const Text('Delete'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _updateNote(
                              widget.fileName,
                              _editingController.text,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: ColorContants.blackColor,
                            backgroundColor: ColorContants.secondaryColor,
                          ),
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ],
                );
              } else if (state is ListItemDetailFailedState) {
                return Center(
                  child: Text(state.error),
                );
              } else if (state is ListItemDetailLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
