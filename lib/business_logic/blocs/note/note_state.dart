abstract class NoteState {
  
}

class NoteInitialState extends NoteState {
  
}

class NoteLoadingState extends NoteState {
  
}

class NoteSucessState extends NoteState {
  NoteSucessState({required this.fileName});

  final String fileName;
}

class NoteFaileState extends NoteState {
  NoteFaileState({required this.error});

  final String error;
}
