class HeroResponse {
  List<QuestionListItem>? data;

  HeroResponse({this.data});

  HeroResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <QuestionListItem>[];
      json['data'].forEach((v) {
        data!.add(new QuestionListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionListItem {
  String? id;
  Null? title;
  String? question;
  String? questionHi;
  String? book;
  String? chapter;
  String? subject;
  String? questiontype;
  String? series;
  String? questionno;
  String? ename;
  Null? remarks;
  Null? slug;
  Null? categId;
  String? options1;
  String? options2;
  String? options3;
  String? options4;
  String? options1Hi;
  String? options2Hi;
  String? options3Hi;
  String? options4Hi;
  String? correctoption;
  Null? img;
  Null? video;
  String? solution;
  String? solutionHi;
  Null? ref;
  Null? createdBy;
  String? createdAt;
  String? updatedAt;
  String? status;

  QuestionListItem(
      {this.id,
        this.title,
        this.question,
        this.questionHi,
        this.book,
        this.chapter,
        this.subject,
        this.questiontype,
        this.series,
        this.questionno,
        this.ename,
        this.remarks,
        this.slug,
        this.categId,
        this.options1,
        this.options2,
        this.options3,
        this.options4,
        this.options1Hi,
        this.options2Hi,
        this.options3Hi,
        this.options4Hi,
        this.correctoption,
        this.img,
        this.video,
        this.solution,
        this.solutionHi,
        this.ref,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.status});

  QuestionListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    question = json['question'];
    questionHi = json['question_hi'];
    book = json['book'];
    chapter = json['chapter'];
    subject = json['subject'];
    questiontype = json['questiontype'];
    series = json['series'];
    questionno = json['questionno'];
    ename = json['ename'];
    remarks = json['remarks'];
    slug = json['slug'];
    categId = json['categ_id'];
    options1 = json['options1'];
    options2 = json['options2'];
    options3 = json['options3'];
    options4 = json['options4'];
    options1Hi = json['options1_hi'];
    options2Hi = json['options2_hi'];
    options3Hi = json['options3_hi'];
    options4Hi = json['options4_hi'];
    correctoption = json['correctoption'];
    img = json['img'];
    video = json['video'];
    solution = json['solution'];
    solutionHi = json['solution_hi'];
    ref = json['ref'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['question'] = this.question;
    data['question_hi'] = this.questionHi;
    data['book'] = this.book;
    data['chapter'] = this.chapter;
    data['subject'] = this.subject;
    data['questiontype'] = this.questiontype;
    data['series'] = this.series;
    data['questionno'] = this.questionno;
    data['ename'] = this.ename;
    data['remarks'] = this.remarks;
    data['slug'] = this.slug;
    data['categ_id'] = this.categId;
    data['options1'] = this.options1;
    data['options2'] = this.options2;
    data['options3'] = this.options3;
    data['options4'] = this.options4;
    data['options1_hi'] = this.options1Hi;
    data['options2_hi'] = this.options2Hi;
    data['options3_hi'] = this.options3Hi;
    data['options4_hi'] = this.options4Hi;
    data['correctoption'] = this.correctoption;
    data['img'] = this.img;
    data['video'] = this.video;
    data['solution'] = this.solution;
    data['solution_hi'] = this.solutionHi;
    data['ref'] = this.ref;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}
