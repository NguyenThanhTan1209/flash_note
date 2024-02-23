// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class ListItemDetailEvent {
  
}

class GetFileDetail extends ListItemDetailEvent {
  final String fileName;
  GetFileDetail({
    required this.fileName,
  });
}
