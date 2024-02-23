import '../../models/note.dart';

abstract class ListItemDetailState {
  
}

class ListItemDetailInitialState extends ListItemDetailState {
  
}

class ListItemDetailLoadingState extends ListItemDetailState {
  
}

class ListItemDetailSuccessState extends ListItemDetailState {
  ListItemDetailSuccessState({required this.note});

  final Note note;
}

class ListItemDetailFailedState extends ListItemDetailState {
  ListItemDetailFailedState({required this.error});

  final String error;
}
