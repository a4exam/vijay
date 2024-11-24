import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mcq/views/screens/question_screen/components/point_and_information.dart';
import 'package:mcq/views/screens/question_screen/components/user_action_button.dart';

class ShowDescription extends StatefulWidget {
  final String? descriptionDetails;
  final bool? isDescription;
  final double? zoomScale;

  const ShowDescription({
    super.key,
    this.descriptionDetails,
    this.isDescription,
    this.zoomScale,
  });

  @override
  State<ShowDescription> createState() => _ShowDescriptionState();
}

class _ShowDescriptionState extends State<ShowDescription> {
  bool descriptionToggel = true;

  @override
  Widget build(BuildContext context) {
    var Sized = MediaQuery.of(context).size;
    return Visibility(
      visible: widget.isDescription!,
      child: Column(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0), color: Colors.grey),
            child: Row(
              children: [
                const SizedBox(width: 10),
                const Text(
                  "Description...",
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(FontAwesomeIcons.sliders)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      descriptionToggel = !descriptionToggel;
                    });
                  },
                  icon: Icon(descriptionToggel
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down),
                )
              ],
            ),
          ),
          Visibility(
            visible: descriptionToggel,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      /// Add Your Solution
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: SizedBox(
                                width: 60,
                                height: 60,
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/images/profile.png",
                                  ),
                                )),
                          ),
                          const SizedBox(width: 10),
                          const Flexible(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(Icons.attach_file),
                                  hintText: "Add Your Solution"),
                            ),
                          ),
                        ],
                      ),

                      /// divider
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        color: Colors.grey,
                        width: Sized.width,
                        height: 2,
                      ),

                      const SizedBox(height: 10),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: SizedBox(
                                width: 60,
                                height: 60,
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/images/profile.png",
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "ExamOPD",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "35 min ago",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          UserActionButton(
                            iconData: FontAwesomeIcons.heart,
                            color: Colors.yellow,
                            value: "57", onTap: () {  },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                          "Russia has been accused of planning to use thermobaric weapons in its invasion of Ukraine"),

                      const SizedBox(height: 10),

                      PointAndInformation(
                          image: "assets/images/key.png",
                          title: "Key Points",
                          subTitle: "Thermobaric Weapon",
                          description:
                              "Thermobaric Weapons also known as aerosol bombs, fuel-air explosives orr Vaccum bombs user ozygen from the air for a large, high-temperature blast. Hence, option1 is correct. A thermobaric weapon causes significantly greater devastation than a conventional bomb of"),

                      const SizedBox(height: 10),

                      PointAndInformation(
                          image: "assets/images/handwritten.png",
                          title: "Additional Information",
                          subTitle: "Thermobaric Weapon",
                          description:
                              "Thermobaric Weapons also known as aerosol bombs, fuel-air explosives orr Vaccum bombs user ozygen from the air for a large, high-temperature blast. Hence, option1 is correct. A thermobaric weapon causes significantly greater devastation than a conventional bomb of"),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey,
                  width: Sized.width,
                  height: 1,
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                     UserActionButton(
                      iconData: FontAwesomeIcons.solidThumbsUp,
                      color: Colors.yellow,
                      value: "57", onTap: () {  },
                    ),
                    const SizedBox(width: 10),
                     UserActionButton(
                      iconData: FontAwesomeIcons.comment,
                      color: Colors.yellow,
                      value: "57", onTap: () {  },
                    ),
                    const SizedBox(width: 10),
                     UserActionButton(
                      iconData: FontAwesomeIcons.solidShareFromSquare,
                      color: Colors.yellow,
                      value: "57", onTap: () {  },
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.more_vert))
                  ],
                ),
                Container(
                  color: Colors.grey,
                  width: Sized.width,
                  height: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
