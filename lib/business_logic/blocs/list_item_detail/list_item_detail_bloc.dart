import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/note.dart';
import '../../services/read_and_write_file_services/read_and_write_file_repository.dart';
import 'list_item_detail_event.dart';
import 'list_item_detail_state.dart';

class ListItemDetalBloc extends Bloc<ListItemDetailEvent, ListItemDetailState> {

  ListItemDetalBloc(): super(ListItemDetailInitialState()){
    on<GetFileDetail>((GetFileDetail event, Emitter<ListItemDetailState> emit) async {
      emit(ListItemDetailLoadingState());
      try {
        final String result = await _repository.readData(event.fileName);
        emit(ListItemDetailSuccessState(note: Note(noteFileName: event.fileName, noteFileContent: result)));
      } catch (e) {
        emit(ListItemDetailFailedState(error: e.toString()));
      }
    });
  }

  final ReadAndWriteFileRepository _repository = ReadAndWriteFileRepository();
}
