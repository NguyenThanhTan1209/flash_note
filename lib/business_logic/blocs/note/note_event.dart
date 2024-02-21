abstract class NoteEvent {
  
}

class AddNewNote extends NoteEvent {

  AddNewNote({required this.fileName, required this.fileContent});

  final String fileName;
  final String fileContent;
}
