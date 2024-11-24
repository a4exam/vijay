import 'package:flutter/material.dart';
// Adjust the import path

class QuestionReport extends StatefulWidget {
  final String questionEn;
  final String questionHi;

  QuestionReport({required this.questionEn, required this.questionHi});

  @override
  _QuestionReportState createState() => _QuestionReportState();
}

class _QuestionReportState extends State<QuestionReport> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _optionAController = TextEditingController();
  final TextEditingController _optionBController = TextEditingController();
  final TextEditingController _optionCController = TextEditingController();
  final TextEditingController _optionDController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _questionController.text = widget.questionHi;
  }

   submitReport() async {
    final reportData = {
      'question_id': '120',
      'question_language': 'hindi',
      'report_question': _questionController.text,
      'report_option_a': _optionAController.text,
      'report_option_b': _optionBController.text,
      'report_option_c': _optionCController.text,
      'report_option_d': _optionDController.text,
      'report_description': _descriptionController.text,
      'report_correct_answer': 'c', // Adjust based on user input if needed
      'report_exam_shift': 'test',
      'user_notes': _notesController.text,
    };

    final reportResponse = await submitReport();

    if (reportResponse != null) {
      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update Success'),
            content: const Text('Your report has been submitted successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Failed'),
            content: Text('Failed to submit your report. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question report'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Handle action button pressed
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Question',
              ),
              maxLines: null,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _optionAController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Option A',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _optionBController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Option B',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _optionCController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Option C',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _optionDController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Option D',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              maxLines: null,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Notes',
              ),
              maxLines: null,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: submitReport,
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
