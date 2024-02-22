import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/list_item_detail/list_item_detail_bloc.dart';
import '../../business_logic/blocs/list_item_detail/list_item_detail_event.dart';
import '../../business_logic/blocs/list_item_detail/list_item_detail_state.dart';
import '../utils/color_contants.dart';
import '../utils/number_contants.dart';

class ListItemDetailScreen extends StatefulWidget {
  const ListItemDetailScreen({super.key, required this.fileName});

  final String fileName;

  @override
  State<ListItemDetailScreen> createState() => _ListItemDetailScreenState();
}

class _ListItemDetailScreenState extends State<ListItemDetailScreen> {

  @override
  void initState() {
    super.initState();
    context.read<ListItemDetalBloc>().add(GetFileDetail(fileName: widget.fileName));
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
                return Center(
                  child: Text(state.note.noteFileContent),
                );
              } else if(state is ListItemDetailFailedState){
                return Center(
                  child: Text(state.error),
                );
              } else if(state is ListItemDetailLoadingState) {
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
