// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:atlas_company/src/modules/review_signature/review_signature_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../core/locator.dart';
import '../../../../core/shared_prefrence_repository.dart';
import '../../../shared/end_points.dart';
import 'package:image_picker/image_picker.dart';

part 'maintence_report_state.dart';

class MaintenceReportCubit extends Cubit<MaintenceReportState> {
  MaintenceReportCubit() : super(MaintenceReportInitial());

  static MaintenceReportCubit get(context) => BlocProvider.of(context);
  String token =
      "KIiCCxOfPUsM52BRdf7zJFeXKtfsT43iW2oU2L78MyhKJISRlidZcF8rw6LMyGzi";
  final remarksController = TextEditingController();
  final helper1 = TextEditingController();
  final helper2 = TextEditingController();
  int? userId;
  DateTime? selectedDate;
  String? maintenanceType;

  XFile? pickedImage;
  File? file;
  List<File> imagesList = [];
  List<String> imagesListString = [];

  int currentStep = 0;
  bool isAllTrue = false;

  List<Uint8List?> signatures = [null, null, null];
  List<String?> signaturesListString = [null, null, null];

  Future<void> getResultFromNextScreen(BuildContext context, int index) async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ReviewSignatureScreen()));
    signatures[index] = result;
    if (result != null) {
      signaturesListString[index] =
          "data:image/png;base64,${base64Encode(result)}";
    }
    emit(MaintenceReportRefresh());
  }

  List<String> title = [
    "Report Information",
    "Machine Room Maintenance",
    "Traction Room Maintenance",
    "Hydraulic Room Maintenance",
    "Pit Maintenance",
    "Run The Lift Maintenance",
    "Shaft and Car Maintenance",
    "Signatures"
  ];

  Map<String, Map<String, bool>> data = {
    "Machine Room": {
      "Hoist Ropes": false,
      "Coupling": false,
      "Points of Lubrication": false,
      "Control Board": false,
      "Fuses": false,
      "Motor Protection": false,
    },
    "Traction Room": {
      "Governor Rope": false,
      "Is Break": false,
      "Gear Bearing": false,
    },
    "Hydraulic Room": {
      "Piston Units": false,
      "Oil Change": false,
      "Pump": false,
      "Valve": false,
    },
    "Pit": {
      "Cleanliness": false,
      "Buffers": false,
      "Limit Switch": false,
      "Safety Link": false,
      "Under Drive": false,
      "Points of Lubrication": false,
    },
    "Run The Lift": {
      "Landing Calls Signals": false,
      "Door Outside Hangers": false,
      "Door Close Photocell": false,
      "Leveling": false,
      "C.O.P Lights": false,
      "Condition of Car": false,
      "Smooth and Soundless Run": false,
      "Start Stop Process": false,
      "Door Switch Looking Device": false,
    },
    "Shaft and Car": {
      "Clean Lines": false,
      "Final Limits": false,
      "Car Switch": false,
      "Car Insulation": false,
      "Safety Device Link Age": false,
      "Operation of Safety Device": false,
      "Door Operation": false,
      "Door Locks": false,
      "Door Inside": false,
      "Shaft Switches": false,
      "Guide Rails Car": false,
      "Guide Rails Shoes Car": false,
      "Traveling Cable": false,
    }
  };

  String? changeCurrentStep(int step) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (step > 0) {
      if (currentStep == 0) {
        if (maintenanceType != null && remarksController.text != "") {
          currentStep += step;
          emit(MaintenceReportRefresh());
        } else {
          return "incompleted";
        }
      } else if (currentStep == 7) {
        if (signatures[0] != null &&
            signatures[1] != null &&
            signatures[2] != null) {
          return "completed";
        } else {
          return "incompleted";
        }
      } else {
        currentStep += step;
        checkIsAllTrue();
        emit(MaintenceReportRefresh());
      }
    } else {
      currentStep += step;
      checkIsAllTrue();
      emit(MaintenceReportRefresh());
      return "back";
    }
    return null;
  }

  void changeMaintenanceType(dynamic input) {
    maintenanceType = input;
    emit(MaintenceReportRefresh());
  }

  void checkAll() {
    List<String> keys = data.entries.map((e) => e.key).toList();
    Map<String, bool> checks = data[keys[currentStep - 1]]!;
    isAllTrue = checks.values.every((element) => element == true);
    if (isAllTrue) {
      checks.updateAll((name, value) => value = false);
      isAllTrue = false;
    } else {
      checks.updateAll((name, value) => value = true);
      isAllTrue = true;
    }
    emit(MaintenceReportRefresh());
  }

  void checkIsAllTrue() {
    if (currentStep > 0 && currentStep < 7) {
      List<String> keys = data.entries.map((e) => e.key).toList();
      Map<String, bool> checks = data[keys[currentStep - 1]]!;
      isAllTrue = checks.values.every((element) => element == true);
    }
  }

  Future pickImageFromGallery() async {
    try {
      pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      file = File(pickedImage!.path);
      var image = file!.readAsBytesSync();
      String base64Image = "data:image/png;base64,${base64Encode(image)}";
      imagesList.add(file!);
      imagesListString.add(base64Image);
      emit(MaintenceReportRefresh());
    } catch (e) {
      print(e);
    }
  }

  Future pickImageFromCamera() async {
    try {
      pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
      file = File(pickedImage!.path);
      var image = file!.readAsBytesSync();
      String base64Image = "data:image/png;base64,${base64Encode(image)}";
      imagesList.add(file!);
      imagesListString.add(base64Image);
      emit(MaintenceReportRefresh());
    } catch (e) {
      print(e);
    }
  }

  Future<void> maintenance(String id) async {
    try {
      emit(MaintenceReportLoading());
      getuserid();
      var url = Uri.parse(
          "${ConstantsService.baseUrl}${ConstantsService.maintenanceEndpoint}$id/");
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token $token'
          },
          body: jsonEncode(<String, dynamic>{
            "type_name": maintenanceType!,
            "remarks": remarksController.text,
            "date": selectedDate.toString().substring(0, 10),
            "check_images": imagesListString,
            "helper1": helper1.text,
            "helper2": helper2.text,
            "user_id": userId.toString(),
            "signatures": signaturesListString,
            "sections_data": data
          }));

      var responseBody = jsonDecode(response.body);
      emit(MaintenceReportSuccess(responseBody["detail"]));
    } catch (e) {
      print(e);
      emit(MaintenceReportFailure(e.toString()));
    }
  }

  void getuserid() {
    userId = locator<SharedPreferencesRepository>().getUserInfo().result!.id;
  }

  void refresh() {
    emit(MaintenceReportRefresh());
  }
}
