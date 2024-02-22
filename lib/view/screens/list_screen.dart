import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/list_file/list_file_bloc.dart';
import '../../business_logic/blocs/list_file/list_file_event.dart';
import '../../business_logic/blocs/list_file/list_file_state.dart';
import '../utils/color_contants.dart';
import '../utils/number_contants.dart';
import '../utils/string_contants.dart';
import 'list_item_detail_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ListFileBloc>().add(GetListFile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringContants.appBarNoteListTitle),
        backgroundColor: ColorContants.mainColor,
        foregroundColor: ColorContants.whiteColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(NumberContants.padding16),
          child: BlocBuilder<ListFileBloc, ListFileState>(
            builder: (BuildContext context, ListFileState state) {
              if (state is ListFileSucessState) {
                return state.fileList.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          final FileSystemEntity item = state.fileList[index];
                          final String fileName = item.path.split('/').last.split('.').first;
                          
                          return ListTile(
                            title: Text(fileName),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return ListItemDetailScreen(
                                      fileName: fileName,
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                        itemCount: state.fileList.length,
                      )
                    : const Center(
                        child: Text('There are no notes files'),
                      );
              } else if (state is ListFileFailedState) {
                return Center(
                  child: Text(state.error),
                );
              } else if (state is ListFileLoadingState) {
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
