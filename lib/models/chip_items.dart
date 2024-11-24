class ChipClass {
  int? id;
  String? title;
  String? qsno;
  bool? isSelected;

  ChipClass({this.id, this.isSelected, this.title, this.qsno});
}

class FilterDataClass {
  String? mainTitle;
  String? qsno;
  int? id;
  List<ChipClass>? filterValue;

  FilterDataClass({this.id, this.mainTitle, this.filterValue, this.qsno});
}