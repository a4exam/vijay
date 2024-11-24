import 'package:flutter/material.dart';
import 'package:mcq/themes/color.dart';
import 'package:provider/provider.dart';
import 'package:mcq/views/screens/subscription/subscription_view_model.dart';
import 'component/subscription_Item_view.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SubscriptionViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Subscription"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Your Current Subscription ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 17),
                ),
                const SizedBox(height: 6),
                Consumer<SubscriptionViewModel>(
                  builder: (context, viewModel, _) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            viewModel.selectSubscription(index);
                          },
                          child: SubscriptionItemBuilder(
                            isSelected: viewModel.selectedSubscription == index,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        persistentFooterButtons: [
          Consumer<SubscriptionViewModel>(
            builder: (context, viewModel, _) {
              return Container(
                height: 45,
                margin: const EdgeInsets.symmetric(horizontal: 12.0),
                color: AppColors.primaryColor,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    viewModel.payNow();
                  },
                  child: Text(
                    "Pay now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade50,
                        fontSize: 17),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
