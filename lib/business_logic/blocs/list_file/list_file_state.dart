import 'dart:io';

abstract class ListFileState {
  
}

class ListFileInitialState extends ListFileState {
  
}

class ListFileLoadingState extends ListFileState {
  
}

class ListFileSucessState extends ListFileState {
  ListFileSucessState({required this.fileList});

  final List<FileSystemEntity> fileList;
}

class ListFileFailedState extends ListFileState {
  ListFileFailedState({required this.error});

  final String error;
}
