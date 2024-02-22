import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/read_and_write_file_services/read_and_write_file_repository.dart';
import 'list_file_event.dart';
import 'list_file_state.dart';

class ListFileBloc extends Bloc<ListFileEvent, ListFileState> {

  ListFileBloc() : super(ListFileInitialState()){
    on<GetListFile>((GetListFile event, Emitter<ListFileState> emit) async {
      emit(ListFileLoadingState());
      try {
        final List<FileSystemEntity> result = await _repository.getData();
        emit(ListFileSucessState(fileList: result));
      } catch (e) {
        emit(ListFileFailedState(error: e.toString()));
      }
    });
  }

  final ReadAndWriteFileRepository _repository = ReadAndWriteFileRepository();
  
}
