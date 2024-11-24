import 'package:get/get.dart';
import 'package:mcq/views/components/drop_down/drop_down_utils.dart';

class ExamPreparationListItem {
  String? type;
  String? name;
  String? id;
  String? image;
  String? selectedName = "";
  RxString selectedId = "".obs;
  List<DropdownListItem>? data = [];

  ExamPreparationListItem({
    this.type,
    this.name,
    this.id,
    this.image,
    this.data,
  });

  ExamPreparationListItem.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    id = json['id'];
    image = json['image'];
    if (json['data'] != null) {
      data = <DropdownListItem>[];
      json['data'].forEach((v) {
        final item = DropdownListItem(title: v["name"], id: v["id"]);
        data?.add(item);
      });
    }
  }
}
