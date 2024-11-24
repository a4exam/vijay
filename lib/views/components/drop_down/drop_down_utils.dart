class DropdownListItem {
  final String title;
  final String id;
  String? img;
  bool isSelected;

  DropdownListItem({
    required this.title,
    required this.id,
    this.img,
    this.isSelected = false,
  });
}

class DropDownUtils {
  static final educationItems = [
    DropdownListItem(title: '10th Pass', id: '1'),
    DropdownListItem(title: '12th Pass', id: '2'),
    DropdownListItem(title: 'BA', id: '3'),
    DropdownListItem(title: 'B.Arch', id: '4'),
    DropdownListItem(title: 'B.A.LLB', id: '5'),
    DropdownListItem(title: 'B.Des', id: '6'),
    DropdownListItem(title: 'B.ELED', id: '7'),
    DropdownListItem(title: 'B.P.Ed', id: '8'),
    DropdownListItem(title: 'B.U.M.S', id: '9'),
    DropdownListItem(title: 'BAMS', id: '10'),
    DropdownListItem(title: 'BCA', id: '11'),
    DropdownListItem(title: 'B.B.A/B.M.S', id: '12'),
    DropdownListItem(title: 'BOS', id: '13'),
    DropdownListItem(title: 'B.Com', id: '14'),
    DropdownListItem(title: 'B.Ed', id: '15'),
    DropdownListItem(title: 'BOS', id: '16'),
    DropdownListItem(title: 'BFA', id: '17'),
    DropdownListItem(title: 'BHM', id: '18'),
    DropdownListItem(title: 'B.Pharma', id: '19'),
    DropdownListItem(title: 'B.Tech/B.E.', id: '20'),
    DropdownListItem(title: 'BHMS', id: '21'),
    DropdownListItem(title: 'LLB', id: '22'),
    DropdownListItem(title: 'MBBS', id: '23'),
    DropdownListItem(title: 'Diploma', id: '24'),
    DropdownListItem(title: 'BVSC', id: '25'),
    DropdownListItem(title: 'CA', id: '26'),
    DropdownListItem(title: 'CS', id: '27'),
    DropdownListItem(title: 'DM', id: '28'),
    DropdownListItem(title: 'ICWA (CMA)', id: '29'),
    DropdownListItem(title: 'Integrated PG/Dual Degree (Eng)', id: '30'),
    DropdownListItem(title: 'Integrated PG/Dual Degree (Non Eng)', id: '31'),
    DropdownListItem(title: 'LLM', id: '32'),
    DropdownListItem(title: 'MA', id: '33'),
    DropdownListItem(title: 'M.Arch', id: '34'),
    DropdownListItem(title: 'M.Ch', id: '35'),
    DropdownListItem(title: 'M.Com', id: '36'),
    DropdownListItem(title: 'M.Des', id: '37'),
    DropdownListItem(title: 'M.Ed', id: '38'),
    DropdownListItem(title: 'M.Pharma', id: '39'),
    DropdownListItem(title: 'MDS', id: '40'),
    DropdownListItem(title: 'MFA', id: '41'),
    DropdownListItem(title: 'MDS', id: '42'),
    DropdownListItem(title: 'MFA', id: '43'),
    DropdownListItem(title: 'MS/M.Sc(Science)', id: '44'),
    DropdownListItem(title: 'M.Tech', id: '45'),
    DropdownListItem(title: 'MBA/PGDM', id: '46'),
    DropdownListItem(title: 'MCA', id: '47'),
    DropdownListItem(title: 'Medical MS/MD', id: '48'),
    DropdownListItem(title: 'PG Diploma', id: '49'),
    DropdownListItem(title: 'MCM', id: '50'),
    DropdownListItem(title: 'MVSC', id: '51'),
    DropdownListItem(title: 'Other', id: '52'),
  ];

  static final genderItems = [
    DropdownListItem(title: "Male", id: "1"),
    DropdownListItem(title: "Female", id: "2"),
    DropdownListItem(title: "Other", id: "3"),
  ];

  static String getGanderIdByName(String name) {
    if (name.isEmpty) return name;
    for (var item in genderItems) {
      if (item.title == name) {
        return item.id;
      }
    }
    return "";
  }

  static final categoryItems = [
    DropdownListItem(title: "General", id: "1"),
    DropdownListItem(title: "EWS", id: "2"),
    DropdownListItem(title: "OBC", id: "3"),
    DropdownListItem(title: "SC", id: "4"),
    DropdownListItem(title: "ST", id: "5"),
    DropdownListItem(title: "Ex serviceman", id: "6"),
    DropdownListItem(title: "PWD", id: "7"),
  ];

  static final examPreparationItems = [
    DropdownListItem(title: "UPSC", id: "1"),
    DropdownListItem(title: "STATE", id: "2"),
    DropdownListItem(title: "CAT", id: "3"),
    DropdownListItem(title: "SSC", id: "4"),
    DropdownListItem(title: "RAILWAY", id: "5"),
    DropdownListItem(title: "Other", id: "6"),
  ];

  static final countryItems = [DropdownListItem(title: "India", id: "IN")];

  static final reportItems = [
    DropdownListItem(title: "Wrong Question", id: "1"),
    DropdownListItem(title: "Repeat/Mismatch series", id: "2"),
    DropdownListItem(title: "Both", id: "3"),
  ];

  static final wrongQuestionItems = [
    DropdownListItem(title: "Hindi", id: "1"),
    DropdownListItem(title: "English", id: "2"),
    DropdownListItem(title: "Both", id: "3"),
  ];
  static final repeatAndMismatchItems = [
    DropdownListItem(title: "Mismatch Series", id: "1"),
    DropdownListItem(title: "Repeat Question", id: "2"),
  ];
  static final languageItems = [
    DropdownListItem(title: "Hindi", id: "1"),
    DropdownListItem(title: "English", id: "2"),
  ];

  static final issueItems = [
    DropdownListItem(title: "UPSC", id: "1"),
    DropdownListItem(title: "STATE", id: "2"),
    DropdownListItem(title: "CAT", id: "3"),
    DropdownListItem(title: "SSC", id: "4"),
    DropdownListItem(title: "RAILWAY", id: "5"),
    DropdownListItem(title: "Other", id: "6"),
  ];
}
