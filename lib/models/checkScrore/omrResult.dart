class OmrResult {
  final int examId;
  final String rollNo;
  final Map<String, int> answers; // Map of question identifiers to selected options

  OmrResult({
    required this.examId,
    required this.rollNo,
    required this.answers,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exam_id'] = examId;
    data['roll_no'] = rollNo;
    data.addAll(answers.map((key, value) => MapEntry(key, value)));
    return data;
  }
}
