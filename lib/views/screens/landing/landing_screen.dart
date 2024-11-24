import 'package:flutter/material.dart';
import 'package:mcq/views/components/custom_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                    'https://drive.google.com/uc?id=1-XNy4IJMoC4D6rJbYC1O7kdGYjtTssdK',
                    height: 100,
                    width: 100),
              ),
              const SizedBox(height: 20),
              const Text(
                'Make learning easy',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              const Text(
                'Founder: Manish Gurjar',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Co-founder: Shivam Gurjar',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/images/youtube.png',
                    width: 20,
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/instagram.png',
                    width: 20,
                    height: 20,
                  ),
                  const Icon(Icons.telegram),
                  const Icon(Icons.facebook),
                  Image.asset(
                    'assets/images/twitter.png',
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                  title: 'Contact us',
                  width: MediaQuery.of(context).size.width, onPressed: () {  },),
              const SizedBox(height: 20),
              const Text(
                'Subjects',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              const Text(
                'Hero',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                '- Hindi\n- English\n- Reasoning\n- Maths',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Genius',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                '- Static GS\n- History\n- Science\n- Political\n- etc.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Special 26',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                '- Uttar Pradesh GK\n- Delhi GK\n- Driver\n- PGT\n- etc.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Pre. Year',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                '- One day all previous exam\n- Ex:- UP police (Constable, Jail warden, Fireman, SI,etc), Lekhpal/Patwari, Delhi police constable, SSC (GD, MTS, LDC, CPO,etc)',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Features',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              const Text(
                  '1. Subject wise mix practices\n2. Questions dividing in 6 category\n3. Timer ⌛\n4. Question share in Social media\n5. Multiple languages question\n6. More than one solution in One question\n7. Question filter\n8. Question divided in 3 level\n9. No repeat question\n10. Add favourite question list\n11. Options elimination feature\n12. View Exam name\n13. You add better solution than others\n14. Contact us'),
              const SizedBox(height: 10),
              const Text(
                'Benefits',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                '- Easily Analysis questions \n- Same time  \n- Bookmark question\n- All exam questions in one book subject wise\n- Latest question\n- "Question filter" feature\n- Multiple solutions\n- Multiple languages\n- Time to time updating\n- Easy to Carey\n- More than one solution\n- Easy to sharing',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'graphic chart',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                '- No.of students\n- No.of questions\n- No.of exam\n- No.of subjects',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
