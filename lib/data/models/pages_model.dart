class PagesModel {
  final int pages;
  final String? next;
  final String? previous;

  PagesModel({required this.pages, required this.next, required this.previous});
  factory PagesModel.fromJson(jsonData) {
    return PagesModel(
        pages: jsonData['pages'],
        next: jsonData['next'] ?? '',
        previous: jsonData['previous'] ?? '');
  }
}
