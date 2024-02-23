abstract class NoteEvent {
  
}

class AddNewNote extends NoteEvent {

  AddNewNote({required this.fileName, required this.fileContent});

  final String fileName;
  final String fileContent;
}

class DeleteNote extends NoteEvent {
  DeleteNote({required this.fileName});

  final String fileName;
}
