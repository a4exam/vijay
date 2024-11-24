import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/custom_text_field.dart';

class RatingScreen extends StatefulWidget {

  const RatingScreen({
    super.key,
  });

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double _rating = 3.0;
  TextEditingController feedbackController = TextEditingController();

  void handleSubmitBtn() {
    print('Submitted rating: $_rating');
    print('Submitted feedback: ${feedbackController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Our App'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text('How would you rate our app?',
                  style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text('Your feedback:', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              CustomTextField(
                labelText: "Feedback",
                hintText: "Enter your feedback here...",
                controller: feedbackController,
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: "Submit",
                width: MediaQuery.of(context).size.width,
                onPressed: () {
                  handleSubmitBtn();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
