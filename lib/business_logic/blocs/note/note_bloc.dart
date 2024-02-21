import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/read_and_write_file_services/read_and_write_file_repository.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {

  NoteBloc() : super(NoteInitialState()){
    on<AddNewNote>((AddNewNote event, Emitter<NoteState> emit) async {
      emit(NoteLoadingState());
      try {
        await _repository.writeData(event.fileName, event.fileContent);
        emit(NoteSucessState(fileName: event.fileName));
      } catch (e) {
        emit(NoteFaileState(error: e.toString()));
      }
    });
  }
  
  final ReadAndWriteFileRepository _repository = ReadAndWriteFileRepository();
}
