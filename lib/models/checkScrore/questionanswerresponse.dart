class CheckQuestionResponse {
  final int status;
  final int totalQuestions;
  final SectionWiseMarks sectionWiseMarks;

  CheckQuestionResponse({
    required this.status,
    required this.totalQuestions,
    required this.sectionWiseMarks,
  });

  factory CheckQuestionResponse.fromJson(Map<String, dynamic> json) {
    return CheckQuestionResponse(
      status: json['status'] ?? 0,
      totalQuestions: json['totalQuestions'] ?? 0,
      sectionWiseMarks: SectionWiseMarks.fromJson(
          json['sectionWiseMarks'] as Map<String, dynamic>),
    );
  }
}



class SectionWiseMarks {
  final English gk;
  final English math;
  final English hindi;
  final English english;

  SectionWiseMarks({
    required this.gk,
    required this.math,
    required this.hindi,
    required this.english,
  });

  factory SectionWiseMarks.fromJson(Map<String, dynamic> json) {
    return SectionWiseMarks(
      gk: English.fromJson(json['GK'] as Map<String, dynamic>),
      math: English.fromJson(json['Math'] as Map<String, dynamic>),
      hindi: English.fromJson(json['Hindi'] as Map<String, dynamic>),
      english: English.fromJson(json['English'] as Map<String, dynamic>),
    );
  }
}



class English {
  final int totalquestion;
  final Map<String, QuestionDetail> questionDetails;

  English({
    required this.totalquestion,
    required this.questionDetails,
  });

  factory English.fromJson(Map<String, dynamic> json) {
    return English(
      totalquestion: json['totalquestion'] ?? 0,
      questionDetails: (json['questionDetails'] as Map<String, dynamic>)
          .map((key, value) =>
          MapEntry(key, QuestionDetail.fromJson(value as Map<String, dynamic>))),
    );
  }
}



class QuestionDetail {
  final int id;
  final int examId;
  final String examCategoryId;
  final String examBoardId;
  final String examNameId;
  final String examShiftId;
  final dynamic examSectionId;
  final String sheetId;
  final dynamic language;
  final int questionNo;
  final String question;
  final String questionHi;
  final String options1;
  final String options2;
  final String options3;
  final String options4;
  final String options5;
  final String options1Hi;
  final String options2Hi;
  final String options3Hi;
  final String options4Hi;
  final String options5Hi;
  final int correctoption;
  final String solution;
  final String solutionHi;
  final dynamic ename;
  final dynamic remarks;
  final dynamic tags;
  final String userGivenAnswer;

  QuestionDetail({
    required this.id,
    required this.examId,
    required this.examCategoryId,
    required this.examBoardId,
    required this.examNameId,
    required this.examShiftId,
    required this.examSectionId,
    required this.sheetId,
    required this.language,
    required this.questionNo,
    required this.question,
    required this.questionHi,
    required this.options1,
    required this.options2,
    required this.options3,
    required this.options4,
    required this.options5,
    required this.options1Hi,
    required this.options2Hi,
    required this.options3Hi,
    required this.options4Hi,
    required this.options5Hi,
    required this.correctoption,
    required this.solution,
    required this.solutionHi,
    required this.ename,
    required this.remarks,
    required this.tags,
    required this.userGivenAnswer,
  });

  factory QuestionDetail.fromJson(Map<String, dynamic> json) {
    return QuestionDetail(
      id: json['id'] ?? 0,
      examId: json['exam_id'] ?? 0,
      examCategoryId: json['exam_category_id'] ?? '',
      examBoardId: json['exam_board_id'] ?? '',
      examNameId: json['exam_name_id'] ?? '',
      examShiftId: json['exam_shift_id'] ?? '',
      examSectionId: json['exam_section_id'],
      sheetId: json['sheet_id'] ?? '',
      language: json['language'],
      questionNo: json['question_no'] ?? 0,
      question: json['question'] ?? '',
      questionHi: json['question_hi'] ?? '',
      options1: json['options1'] ?? '',
      options2: json['options2'] ?? '',
      options3: json['options3'] ?? '',
      options4: json['options4'] ?? '',
      options5: json['options5'] ?? '',
      options1Hi: json['options1_hi'] ?? '',
      options2Hi: json['options2_hi'] ?? '',
      options3Hi: json['options3_hi'] ?? '',
      options4Hi: json['options4_hi'] ?? '',
      options5Hi: json['options5_hi'] ?? '',
      correctoption: json['correctoption'] ?? 0,
      solution: json['solution'] ?? '',
      solutionHi: json['solution_hi'] ?? '',
      ename: json['ename'],
      remarks: json['remarks'],
      tags: json['tags'],
      userGivenAnswer: json['userGivenAnswer'] ?? '',
    );
  }
}


