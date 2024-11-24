import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import '../../../checkScore/list1.dart';
import '../../../checkScore/omrsheet.dart';
import '../../../helpers/preferences_helper.dart';
import '../../../models/checkScrore/checkExamResponse.dart';
import '../../../models/checkScrore/cutOffScoreResponse.dart';
import '../../../models/checkScrore/examsiftsetingResponse.dart';

import '../../../models/checkScrore/omrResult.dart';
import '../../../models/checkScrore/scoreCardDetailsResponse.dart';
import '../../../models/checkScrore/scoreHistoryResponse.dart';
import '../../../models/comman/user_profile_data.dart';
import '../../../repository/checkScroe_repository.dart';
import '../../../repository/hero_repository.dart';
import '../../../utils/app_url.dart';
import '../../../view_models/UserDataViewModel.dart';
import '../profile/profile_view_model.dart';

class CheckScoreViewModel extends GetxController with GetSingleTickerProviderStateMixin{
  final checkScoreRepository = Get.put(CheckScoreRepository());
  late String token;
  var selectedOptions = <String, Map<int, int>>{}.obs;

  final vm = ProfileViewModel();
  RxBool loading = false.obs;
  var isSubmitted = false.obs;
  RxList<ExamsData> examList = <ExamsData>[].obs;
  RxList<ScoreHistoryData> scoreDataList = <ScoreHistoryData>[].obs;
  final _formKey = GlobalKey<FormState>();
  var scoreCardDetails = Rx<ScoreCardDetailsResponse?>(null);
  Rx<ExamSiftSettingResponse?> settingDetails = Rx<ExamSiftSettingResponse?>(null);
  var selectedIndex = 0.obs;
  RxList<Sectiondetails> sectionDetails = <Sectiondetails>[].obs;
  Rx<UserDetails?> scoreCardUserDetails = Rx<UserDetails?>(null);
  Rx<UserProfileData?> userData = Rx<UserProfileData?>(null);
  Rx<SectionWiseMarks?> scoreCardSectionWiseMarks = Rx<SectionWiseMarks?>(null);

  Rx<Female?> femaleCutOff = Rx<Female?>(null);
  Rx<Female?> maleCutOff = Rx<Female?>(null);
  Rx<Female?> allCutOff = Rx<Female?>(null);
  RxString selectedGender = 'All'.obs;

  RxInt totalQualify = 0.obs;
  RxInt totalCandidates = 0.obs;
  File? _selectedFile;
  TabController? tabController;

  int? examId;
  int? rollNo;
  final Map<String, List<String>> stateDistrictMap = {
    'Andhra Pradesh': ['Anantapur', 'Chittoor', 'East Godavari', 'Guntur', 'Krishna', 'Kurnool', 'Nellore', 'Prakasam', 'Srikakulam', 'Visakhapatnam', 'Vizianagaram', 'West Godavari', 'YSR Kadapa'],
    'Arunachal Pradesh': ['Anjaw', 'Changlang', 'East Kameng', 'East Siang', 'Kra Daadi', 'Kurung Kumey', 'Lepa Rada', 'Lohit', 'Longding', 'Lower Dibang Valley', 'Lower Siang', 'Lower Subansiri', 'Namsai', 'Pakke Kessang', 'Papum Pare', 'Shi Yomi', 'Siang', 'Tawang', 'Tirap', 'Upper Dibang Valley', 'Upper Siang', 'Upper Subansiri', 'West Kameng', 'West Siang'],
    'Assam': ['Baksa', 'Barpeta', 'Biswanath', 'Bongaigaon', 'Cachar', 'Charaideo', 'Chirang', 'Darrang', 'Dhemaji', 'Dhubri', 'Dibrugarh', 'Dima Hasao', 'Goalpara', 'Golaghat', 'Hailakandi', 'Hojai', 'Jorhat', 'Kamrup Metropolitan', 'Kamrup', 'Karbi Anglong', 'Karimganj', 'Kokrajhar', 'Lakhimpur', 'Majuli', 'Morigaon', 'Nagaon', 'Nalbari', 'Sivasagar', 'Sonitpur', 'South Salmara-Mankachar', 'Tinsukia', 'Udalguri', 'West Karbi Anglong'],
    'Bihar': ['Araria', 'Arwal', 'Aurangabad', 'Banka', 'Begusarai', 'Bhagalpur', 'Bhojpur', 'Buxar', 'Darbhanga', 'East Champaran', 'Gaya', 'Gopalganj', 'Jamui', 'Jehanabad', 'Kaimur', 'Katihar', 'Khagaria', 'Kishanganj', 'Lakhisarai', 'Madhepura', 'Madhubani', 'Munger', 'Muzaffarpur', 'Nalanda', 'Nawada', 'Patna', 'Purnia', 'Rohtas', 'Saharsa', 'Samastipur', 'Saran', 'Sheikhpura', 'Sheohar', 'Sitamarhi', 'Siwan', 'Supaul', 'Vaishali', 'West Champaran'],
    'Chhattisgarh': ['Balod', 'Baloda Bazar', 'Balrampur', 'Bastar', 'Bemetara', 'Bijapur', 'Bilaspur', 'Dantewada', 'Dhamtari', 'Durg', 'Gariaband', 'Gaurela Pendra Marwahi', 'Janjgir-Champa', 'Jashpur', 'Kabirdham', 'Kanker', 'Kondagaon', 'Korba', 'Koriya', 'Mahasamund', 'Mungeli', 'Narayanpur', 'Raigarh', 'Raipur', 'Rajnandgaon', 'Sukma', 'Surajpur', 'Surguja'],
    'Goa': ['North Goa', 'South Goa'],
    'Gujarat': ['Ahmedabad', 'Amreli', 'Anand', 'Aravalli', 'Banaskantha', 'Bharuch', 'Bhavnagar', 'Botad', 'Chhota Udaipur', 'Dahod', 'Dang', 'Devbhoomi Dwarka', 'Gandhinagar', 'Gir Somnath', 'Jamnagar', 'Junagadh', 'Kheda', 'Kutch', 'Mahisagar', 'Mehsana', 'Morbi', 'Narmada', 'Navsari', 'Panchmahal', 'Patan', 'Porbandar', 'Rajkot', 'Sabarkantha', 'Surat', 'Surendranagar', 'Tapi', 'Vadodara', 'Valsad'],
    'Haryana': ['Ambala', 'Bhiwani', 'Charkhi Dadri', 'Faridabad', 'Fatehabad', 'Gurgaon', 'Hisar', 'Jhajjar', 'Jind', 'Kaithal', 'Karnal', 'Kurukshetra', 'Mahendragarh', 'Mewat', 'Palwal', 'Panchkula', 'Panipat', 'Rewari', 'Rohtak', 'Sirsa', 'Sonipat', 'Yamunanagar'],
    'Himachal Pradesh': ['Bilaspur', 'Chamba', 'Hamirpur', 'Kangra', 'Kinnaur', 'Kullu', 'Lahaul and Spiti', 'Mandi', 'Shimla', 'Sirmaur', 'Solan', 'Una'],
    'Jharkhand': ['Bokaro', 'Chatra', 'Deoghar', 'Dhanbad', 'Dumka', 'East Singhbhum', 'Garhwa', 'Giridih', 'Godda', 'Gumla', 'Hazaribagh', 'Jamtara', 'Khunti', 'Koderma', 'Latehar', 'Lohardaga', 'Pakur', 'Palamu', 'Ramgarh', 'Ranchi', 'Sahebganj', 'Seraikela Kharsawan', 'Simdega', 'West Singhbhum'],
    'Karnataka': ['Bagalkot', 'Ballari', 'Belagavi', 'Bengaluru Rural', 'Bengaluru Urban', 'Bidar', 'Chamarajanagar', 'Chikkaballapur', 'Chikkamagaluru', 'Chitradurga', 'Dakshina Kannada', 'Davanagere', 'Dharwad', 'Gadag', 'Hassan', 'Haveri', 'Kalaburagi', 'Kodagu', 'Kolar', 'Koppal', 'Mandya', 'Mysuru', 'Raichur', 'Ramanagara', 'Shivamogga', 'Tumakuru', 'Udupi', 'Uttara Kannada', 'Vijayapura', 'Yadgir'],
    'Kerala': ['Alappuzha', 'Ernakulam', 'Idukki', 'Kannur', 'Kasaragod', 'Kollam', 'Kottayam', 'Kozhikode', 'Malappuram', 'Palakkad', 'Pathanamthitta', 'Thiruvananthapuram', 'Thrissur', 'Wayanad'],
    'Madhya Pradesh': ['Agar Malwa', 'Alirajpur', 'Anuppur', 'Ashoknagar', 'Balaghat', 'Barwani', 'Betul', 'Bhind', 'Bhopal', 'Burhanpur', 'Chhatarpur', 'Chhindwara', 'Damoh', 'Datia', 'Dewas', 'Dhar', 'Dindori', 'Guna', 'Gwalior', 'Harda', 'Hoshangabad', 'Indore', 'Jabalpur', 'Jhabua', 'Katni', 'Khandwa', 'Khargone', 'Mandla', 'Mandsaur', 'Morena', 'Narsinghpur', 'Neemuch', 'Niwari', 'Panna', 'Raisen', 'Rajgarh', 'Ratlam', 'Rewa', 'Sagar', 'Satna', 'Sehore', 'Seoni', 'Shahdol', 'Shajapur', 'Sheopur', 'Shivpuri', 'Sidhi', 'Singrauli', 'Tikamgarh', 'Ujjain', 'Umaria', 'Vidisha'],
    'Maharashtra': ['Ahmednagar', 'Akola', 'Amravati', 'Aurangabad', 'Beed', 'Bhandara', 'Buldhana', 'Chandrapur', 'Dhule', 'Gadchiroli', 'Gondia', 'Hingoli', 'Jalgaon', 'Jalna', 'Kolhapur', 'Latur', 'Mumbai City', 'Mumbai Suburban', 'Nagpur', 'Nanded', 'Nandurbar', 'Nashik', 'Osmanabad', 'Palghar', 'Parbhani', 'Pune', 'Raigad', 'Ratnagiri', 'Sangli', 'Satara', 'Sindhudurg', 'Solapur', 'Thane', 'Wardha', 'Washim', 'Yavatmal'],
    'Manipur': ['Bishnupur', 'Chandel', 'Churachandpur', 'Imphal East', 'Imphal West', 'Jiribam', 'Kakching', 'Kamjong', 'Kangpokpi', 'Noney', 'Pherzawl', 'Senapati', 'Tamenglong', 'Tengnoupal', 'Thoubal', 'Ukhrul'],
    'Meghalaya': ['East Garo Hills', 'East Jaintia Hills', 'East Khasi Hills', 'North Garo Hills', 'Ri Bhoi', 'South Garo Hills', 'South West Garo Hills', 'South West Khasi Hills', 'West Garo Hills', 'West Jaintia Hills', 'West Khasi Hills'],
    'Mizoram': ['Aizawl', 'Champhai', 'Hnahthial', 'Khawzawl', 'Kolasib', 'Lawngtlai', 'Lunglei', 'Mamit', 'Saiha', 'Saitual', 'Serchhip'],
    'Nagaland': ['Chümoukedima', 'Dimapur', 'Kiphire', 'Kohima', 'Longleng', 'Mokokchung', 'Mon', 'Noklak', 'Peren', 'Phek', 'Tuensang', 'Wokha', 'Zünheboto'],
    'Odisha': ['Angul', 'Balangir', 'Balasore', 'Bargarh', 'Bhadrak', 'Boudh', 'Cuttack', 'Debagarh', 'Dhenkanal', 'Gajapati', 'Ganjam', 'Jagatsinghpur', 'Jajpur', 'Jharsuguda', 'Kalahandi', 'Kandhamal', 'Kendrapara', 'Kendujhar', 'Khordha', 'Koraput', 'Malkangiri', 'Mayurbhanj', 'Nabarangpur', 'Nayagarh', 'Nuapada', 'Puri', 'Rayagada', 'Sambalpur', 'Sonepur', 'Sundargarh'],
    'Punjab': ['Amritsar', 'Barnala', 'Bathinda', 'Faridkot', 'Fatehgarh Sahib', 'Fazilka', 'Ferozepur', 'Gurdaspur', 'Hoshiarpur', 'Jalandhar', 'Kapurthala', 'Ludhiana', 'Mansa', 'Moga', 'Muktsar', 'Nawanshahr', 'Pathankot', 'Patiala', 'Rupnagar', 'Sangrur', 'SAS Nagar', 'Tarn Taran'],
    'Rajasthan': ['Ajmer', 'Alwar', 'Banswara', 'Baran', 'Barmer', 'Bharatpur', 'Bhilwara', 'Bikaner', 'Bundi', 'Chittorgarh', 'Churu', 'Dausa', 'Dholpur', 'Dungarpur', 'Hanumangarh', 'Jaipur', 'Jaisalmer', 'Jalore', 'Jhalawar', 'Jhunjhunu', 'Jodhpur', 'Karauli', 'Kota', 'Nagaur', 'Pali', 'Pratapgarh', 'Rajsamand', 'Sawai Madhopur', 'Sikar', 'Sirohi', 'Sri Ganganagar', 'Tonk', 'Udaipur'],
    'Sikkim': ['East Sikkim', 'North Sikkim', 'South Sikkim', 'West Sikkim'],
    'Tamil Nadu': ['Ariyalur', 'Chengalpattu', 'Chennai', 'Coimbatore', 'Cuddalore', 'Dharmapuri', 'Dindigul', 'Erode', 'Kallakurichi', 'Kancheepuram', 'Karur', 'Krishnagiri', 'Madurai', 'Mayiladuthurai', 'Nagapattinam', 'Namakkal', 'Nilgiris', 'Perambalur', 'Pudukkottai', 'Ramanathapuram', 'Ranipet', 'Salem', 'Sivaganga', 'Tenkasi', 'Thanjavur', 'Theni', 'Thiruvallur', 'Thiruvarur', 'Thoothukudi', 'Tiruchirappalli', 'Tirunelveli', 'Tirupattur', 'Tiruppur', 'Tiruvannamalai', 'Vellore', 'Viluppuram', 'Virudhunagar'],
    'Telangana': ['Adilabad', 'Bhadradri Kothagudem', 'Hyderabad', 'Jagtial', 'Jangaon', 'Jayashankar Bhupalpally', 'Jogulamba Gadwal', 'Kamareddy', 'Karimnagar', 'Khammam', 'Komaram Bheem Asifabad', 'Mahabubabad', 'Mahabubnagar', 'Mancherial', 'Medak', 'Medchal Malkajgiri', 'Mulugu', 'Nagarkurnool', 'Nalgonda', 'Narayanpet', 'Nirmal', 'Nizamabad', 'Peddapalli', 'Rajanna Sircilla', 'Ranga Reddy', 'Sangareddy', 'Siddipet', 'Suryapet', 'Vikarabad', 'Wanaparthy', 'Warangal Rural', 'Warangal Urban', 'Yadadri Bhuvanagiri'],
    'Tripura': ['Dhalai', 'Gomati', 'Khowai', 'North Tripura', 'Sepahijala', 'South Tripura', 'Unakoti', 'West Tripura'],
    'Uttar Pradesh': ['Agra', 'Aligarh', 'Ambedkar Nagar', 'Amethi', 'Amroha', 'Auraiya', 'Ayodhya', 'Azamgarh', 'Badaun', 'Baghpat', 'Bahraich', 'Ballia', 'Balrampur', 'Banda', 'Barabanki', 'Bareilly', 'Basti', 'Bhadohi', 'Bijnor', 'Bulandshahr', 'Chandauli', 'Chitrakoot', 'Deoria', 'Etah', 'Etawah', 'Farrukhabad', 'Fatehpur', 'Firozabad', 'Gautam Buddha Nagar', 'Ghaziabad', 'Ghazipur', 'Gonda', 'Gorakhpur', 'Hamirpur', 'Hapur', 'Hardoi', 'Hathras', 'Jalaun', 'Jaunpur', 'Jhansi', 'Kannauj', 'Kanpur Dehat', 'Kanpur Nagar', 'Kasganj', 'Kaushambi', 'Kushinagar', 'Lakhimpur Kheri', 'Lalitpur', 'Lucknow', 'Maharajganj', 'Mahoba', 'Mainpuri', 'Mathura', 'Mau', 'Meerut', 'Mirzapur', 'Moradabad', 'Muzaffarnagar', 'Pilibhit', 'Pratapgarh', 'Rae Bareli', 'Rampur', 'Saharanpur', 'Sambhal', 'Sant Kabir Nagar', 'Shahjahanpur', 'Shamli', 'Shrawasti', 'Siddharthnagar', 'Sitapur', 'Sonbhadra', 'Sultanpur', 'Unnao', 'Varanasi'],
    'Uttarakhand': ['Almora', 'Bageshwar', 'Chamoli', 'Champawat', 'Dehradun', 'Haridwar', 'Nainital', 'Pauri Garhwal', 'Pithoragarh', 'Rudraprayag', 'Tehri Garhwal', 'Udham Singh Nagar', 'Uttarkashi'],
    'West Bengal': ['Alipurduar', 'Bankura', 'Birbhum', 'Cooch Behar', 'Dakshin Dinajpur', 'Darjeeling', 'Hooghly', 'Howrah', 'Jalpaiguri', 'Jhargram', 'Kalimpong', 'Kolkata', 'Malda', 'Murshidabad', 'Nadia', 'North 24 Parganas', 'Paschim Bardhaman', 'Paschim Medinipur', 'Purba Bardhaman', 'Purba Medinipur', 'Purulia', 'South 24 Parganas', 'Uttar Dinajpur'],
    'Andaman and Nicobar Islands': ['Nicobar', 'North and Middle Andaman', 'South Andaman'],
    'Chandigarh': ['Chandigarh'],
    'Dadra and Nagar Haveli and Daman and Diu': ['Dadra and Nagar Haveli', 'Daman', 'Diu'],
    'Lakshadweep': ['Lakshadweep'],
    'Delhi': ['Central Delhi', 'East Delhi', 'New Delhi', 'North Delhi', 'North East Delhi', 'North West Delhi', 'Shahdara', 'South Delhi', 'South East Delhi', 'South West Delhi', 'West Delhi'],
    'Puducherry': ['Karaikal', 'Mahe', 'Puducherry', 'Yanam'],
    'Ladakh': ['Kargil', 'Leh'],
    'Jammu and Kashmir': ['Anantnag', 'Bandipora', 'Baramulla', 'Budgam', 'Doda', 'Ganderbal', 'Jammu', 'Kathua', 'Kishtwar', 'Kulgam', 'Kupwara', 'Poonch', 'Pulwama', 'Rajouri', 'Ramban', 'Reasi', 'Samba', 'Shopian', 'Srinagar', 'Udhampur']
  };

  @override
  void onInit() {
    super.onInit();
    init();
  }
  @override
  void onClose() {
    tabController!.dispose();
    super.onClose();
  }
  Future<void> init() async {
    token = await PreferenceHelper.getToken();
    await fetchExamsData();
    fetchData();

  }

  void updateSelectedOption(String sectionId, int questionNumber, int option) {
    if (!selectedOptions.containsKey(sectionId)) {
      selectedOptions[sectionId] = {}; // Initialize the section if not already present
    }
    selectedOptions[sectionId]![questionNumber] = option; // Update the selected option for the question
  }

  int? getSelectedOption(String sectionId, int questionNumber) {
    return selectedOptions[sectionId]?[questionNumber];
  }


  Future<void> fetchExamsData() async {
    loading.value = true;
    final response = await checkScoreRepository.fetchExams();
    if (response != null && response.exams != null) {
      examList.value = response.exams!??[];
      getScoreCard(examList[0].id.toString());
    } else {
      print("Exam List data: ${response}");
      print("Failed to load exam data");
    }

    loading.value = false;
  }


  Future<void> getCutoff(int? examId) async {
    loading.value = true;
    try {
      final response = await http.get(Uri.parse('${AppUrl.GETCUTOFF_URL}$examId'));
      print('GET Cutoff Response Status: ${response.statusCode}');
      print('GET Cutoff Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final cutoffResponse = CutOffScoreResponse.fromJson(jsonData);
        femaleCutOff.value = cutoffResponse.cutoffScore?.gender?.female;
        maleCutOff.value = cutoffResponse.cutoffScore?.gender?.male;
        allCutOff.value = cutoffResponse.cutoffScore?.gender?.all;
        filterData();
      } else {
        print('Error: Failed to load cutoff scores with status ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while getting cutoff scores: $e');
    } finally {
      loading.value = false;
    }
  }



  Future<ExamSiftSettingResponse?> fetchExamShiftSetting(int examId) async {
    final url = 'https://examopd.com/api/v1/exam-shift-setting?exam_id=$examId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return ExamSiftSettingResponse.fromJson(jsonResponse);
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while fetching data: $e');
    }

    return null;
  }


  Future<void> getScoreCard(String examId) async {
    loading.value = true;
    try {
      final url = '${AppUrl.GETSCOREHISTORY_URL}${vm.userdataVm.userData.value!.id}&exam_id=$examId';
      print('GET ScoreCard URL: $url');

      final response = await http.get(Uri.parse(url));
      print('GET ScoreCard Response Status: ${response.statusCode}');
      print('GET ScoreCard Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final score = jsonData['history'] as List;
        scoreDataList.value = score.map((score) => ScoreHistoryData.fromJson(score)).toList();
        print('Score Data List Length: ${scoreDataList.length}');
        fetchScoreCardDetails(scoreDataList[0].examId.toString(),scoreDataList[0].rollNo.toString());
      } else {
        print('Error: Failed to load ScoreData with status ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while getting ScoreData: $e');
    } finally {
      loading.value = false;
    }
  }

  void filterData() {
    final data = selectedGender.value == 'Female'
        ? femaleCutOff.value
        : selectedGender.value == 'Male'
        ? maleCutOff.value
        : allCutOff.value;

    if (data == null) {
      totalQualify.value = 0;
      totalCandidates.value = 0;
      return;
    }

    int totalQualifyLocal = 0;
    int totalCandidatesLocal = 0;

    if (data.ews != null) {
      totalQualifyLocal += data.ews?.qualifyUser ?? 0;
      totalCandidatesLocal += data.ews?.totalUser ?? 0;
    }
    if (data.general != null) {
      totalQualifyLocal += data.general?.qualifyUser ?? 0;
      totalCandidatesLocal += data.general?.totalUser ?? 0;
    }
    if (data.obc != null) {
      totalQualifyLocal += data.obc?.qualifyUser ?? 0;
      totalCandidatesLocal += data.obc?.totalUser ?? 0;
    }
    if (data.sc != null) {
      totalQualifyLocal += data.sc?.qualifyUser ?? 0;
      totalCandidatesLocal += data.sc?.totalUser ?? 0;
    }
    if (data.st != null) {
      totalQualifyLocal += data.st?.qualifyUser ?? 0;
      totalCandidatesLocal += data.st?.totalUser ?? 0;
    }

    totalQualify.value = totalQualifyLocal;
    totalCandidates.value = totalCandidatesLocal;
  }

  String formatDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) {
      return 'Invalid Date';
    }
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('MMMM d, yyyy, hh:mm a').format(dateTime);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  Future<void> uploadAdmitCard(int shift, String gender, String category, String? horizontalReservation, String? state, String? district, File? admitCardFile,) async {
    if (admitCardFile == null) {
      Get.snackbar('Error', 'Please select a file');
      return;
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://examopd.com/api/v1/upload-admit-card'),
      );

      // Add other form fields
      request.fields['exam_mode'] = examList[0].examModeUi==1?"Online":"offline";
      request.fields['exam_id'] = scoreDataList[0].examId.toString();
      request.fields['shift'] = scoreDataList[0].shiftId.toString();
      request.fields['user_id'] = scoreDataList[0].userId.toString();

      request.fields['set_no'] = scoreDataList[0].setNo.toString();
      request.fields['dob'] = scoreDataList[0].dob.toString();
      request.fields['gender'] = gender;
      request.fields['category'] = category;
      request.fields['horizontal_reservation'] = horizontalReservation ?? '';
      request.fields['state'] = state ?? '';
      request.fields['district'] = district ?? '';
      request.fields['exam_post']= "";



      request.fields['answer_key_url']="";

      // Attach the file
      request.files.add(
        await http.MultipartFile.fromPath(
          'admit-card', // Update to the correct field name expected by the server
          admitCardFile.path,
        ),
      );

      // Send the request
      var response = await request.send();

      // Read the response
      String responseBody = await response.stream.bytesToString();
      print('Response Body: $responseBody'); // For debugging

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(responseBody);

        if (jsonResponse['status'] == 200) {
          // Store exam_id and roll_no
          examId = jsonResponse['User']['exam_id'];
           rollNo = jsonResponse['User']['roll_no'];

          Get.snackbar('Success', 'Admit card uploaded successfully');
          // Navigate to the OMR sheet or handle success
          Get.to(const OmrSheet());
        } else {
          Get.snackbar('Info', jsonResponse['responseMessage'] ?? 'Unknown response from server');
        }
      } else {
        Get.snackbar('Upload failed', 'Server responded with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Upload error: $e');
      Get.snackbar('Error', 'Upload failed: $e');
    }
  }


  void fetchData() async {
    try {
      var response = await http.get(Uri.parse('https://examopd.com/api/v1/exam-shift-setting?exam_id=$examId'));
      if (response.statusCode == 200) {
        var data = ExamSiftSettingResponse.fromJson(jsonDecode(response.body));
        settingDetails.value = data;

        // Initialize TabController only if sectiondetails is not null
        if (data.shiftSettingDetails?.sectiondetails != null) {
          tabController = TabController(
            length: data.shiftSettingDetails!.sectiondetails!.length,
            vsync: this,
          );
        }
      } else {
        // Handle non-200 status code
      }
    } catch (e) {
      print("Error fetching data: $e");
      // Handle the error appropriately
    }
  }


  // Method to submit results


  Future<bool> submitOmrResults() async {
    if (examId == null || rollNo == null) {
      Get.snackbar('Error', 'Exam ID or Roll No is missing');
      return false; // Indicate failure
    }

    loading.value = true;
    const apiUrl = 'https://examopd.com/api/v1/omr-result';

    // Create the request payload
    final requestData = {
      'exam_id': examId,
      'roll_no': rollNo,
      ...selectedOptions.map((key, value) => MapEntry(key, value.toString())),
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      loading.value = false;

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody['message'] == 'This user allready check answer') {
          return true; // Indicate that the result has already been submitted
        } else {
          Get.snackbar("Success", "Data submitted successfully!");
          print("data submitted: ${responseBody}");
          print("exam ID $examId");
          print("Roll number $rollNo");
          print("userId ${scoreDataList[0].userId.toString()}");
          return false; // Indicate successful submission
        }
      } else {
        Get.snackbar("Error", "Failed to submit data: ${response.reasonPhrase}");
        return false; // Indicate failure
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar("Error", "An error occurred: $e");
      return false; // Indicate failure
    }
  }



  Future<void> fetchScoreCardDetails(String examId, String rollNo) async {
    loading.value = true;
    print("ScorCard url: https://examopd.com/api/v1/score-card?exam_id=$examId&roll_no=$rollNo");
    try {
      final response = await http.get(Uri.parse('https://examopd.com/api/v1/score-card?exam_id=$examId&roll_no=$rollNo'));
      print('GET ScoreCard Details Response Status: ${response.statusCode}');
      print('GET ScoreCard Details Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['status'] == 200) {
          scoreCardDetails.value = ScoreCardDetailsResponse.fromJson(jsonData);
        } else {
          print('Error: API returned a non-200 status');
          throw Exception('Failed to load score card');
        }
      } else {
        print('Error: Failed to load exams with status ${response.statusCode}');
        throw Exception('Failed to load score card');
      }
    } catch (e) {
      print('Error occurred while getting exams: $e');
    } finally {
      loading.value = false;
    }
  }


}


