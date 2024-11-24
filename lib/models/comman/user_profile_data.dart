
class UserProfileData {
  int? id;
  String? fullName;
  String? email;
  String? dateOfBirth;
  String? mobileNo;
  String? gander;
  String? education;
  String? category;
  String? country;
  String? state;
  String? district;
  String? town;
  String? pincode;
  String? images;
  String? examBoardId;
  String? examNameId;

  UserProfileData({
    this.id,
    this.fullName,
    this.email,
    this.dateOfBirth,
    this.mobileNo,
    this.gander,
    this.education,
    this.category,
    this.country,
    this.state,
    this.district,
    this.town,
    this.pincode,
    this.images,
    this.examBoardId,
    this.examNameId,
  });

  UserProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['FullName'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
    mobileNo = json['mobileNo'];
    gander = json['gander'];
    education = json['education'];
    category = json['category'];
    country = json['country'];
    state = json['state'];
    district = json['district'];
    town = json['town'];
    pincode = json['pincode'];
    images = json['images'].replaceAll("https://examopd.com/upload/", "");
    examBoardId = json['exam_board_id'];
    examNameId = json['exam_name_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'FullName': fullName,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'mobileNo': mobileNo,
      'gander': gander,
      'education': education,
      'category': category,
      'country': country,
      'state': state,
      'district': district,
      'town': town,
      'pincode': pincode,
      'images': images,
      'exam_board_id': examBoardId,
      'exam_name_id': examNameId,
    };
  }
}
