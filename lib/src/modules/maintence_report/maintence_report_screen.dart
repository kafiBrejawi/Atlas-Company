import 'package:atlas_company/src/modules/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/styles/colors.dart';
import '../../shared/components/components.dart';
import 'cubit/maintence_report_cubit.dart';
import 'steps/report_check_box.dart';
import 'steps/report_information.dart';
import 'steps/report_signatures.dart';

class MaintenceReportScreen extends StatelessWidget {
  const MaintenceReportScreen(
      {super.key, required this.id, required this.name});
  final String? id;
  final String? name;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) =>
          MaintenceReportCubit()..selectedDate = DateTime.now(),
      child: BlocConsumer<MaintenceReportCubit, MaintenceReportState>(
        listener: (context, state) {
          if (state is MaintenceReportLoading) {
            circularProgress(context);
          }
          if (state is MaintenceReportSuccess) {
            Navigator.pop(context);
            showSnackBar(
                context: context,
                message: state.message,
                duration: 3,
                icon: state.message == "Maintenance added successfully"
                    ? Icons.check
                    : null);
            if (state.message == "Maintenance added successfully") {
              navigateAndFinish(context, const HomeScreen());
            }
          }
          if (state is MaintenceReportFailure) {
            Navigator.pop(context);
            showSnackBar(
                context: context,
                message: "Try again later",
                duration: 3,
                icon: Icons.error_outline);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: forthColor,
            appBar: AppBar(
              actions: [
                MaintenceReportCubit.get(context).currentStep != 0 &&
                        MaintenceReportCubit.get(context).currentStep != 7
                    ? IconButton(
                        onPressed: () {
                          MaintenceReportCubit.get(context).checkAll();
                        },
                        icon: Icon(Icons.check_box,
                            color: MaintenceReportCubit.get(context).isAllTrue
                                ? secondaryColor
                                : thirdColor))
                    : Container()
              ],
              toolbarHeight: 60,
              title: Text(
                MaintenceReportCubit.get(context)
                    .title[MaintenceReportCubit.get(context).currentStep],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0.75,
              centerTitle: true,
            ),
            body: Theme(
              data: ThemeData(
                  fontFamily: GoogleFonts.openSans().fontFamily,
                  primarySwatch: Colors.orange,
                  canvasColor: Colors.white,
                  colorScheme: const ColorScheme.light(
                    primary: primaryColor,
                  )),
              child: SizedBox(
                width: size.width,
                child: Stepper(
                  physics: const NeverScrollableScrollPhysics(),
                  type: StepperType.horizontal,
                  elevation: 0,
                  steps:
                      getSteps(context, MaintenceReportCubit.get(context).data),
                  currentStep: MaintenceReportCubit.get(context).currentStep,
                  controlsBuilder:
                      (BuildContext context, ControlsDetails controls) {
                    final isLastStep =
                        MaintenceReportCubit.get(context).currentStep ==
                            getSteps(context,
                                        MaintenceReportCubit.get(context).data)
                                    .length -
                                1;
                    return Row(children: <Widget>[
                      if (MaintenceReportCubit.get(context).currentStep != 0)
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: buildButton(
                              height: 38,
                              fontSize: 16,
                              radius: 5,
                              width: size.width,
                              text: "Back",
                              backgroundColor: thirdColor,
                              borderColor: thirdColor,
                              foregroundColor: Colors.white,
                              function: () {
                                MaintenceReportCubit.get(context)
                                    .changeCurrentStep(-1);
                              }),
                        )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: buildButton(
                            height: 38,
                            fontSize: 16,
                            radius: 5,
                            width: size.width,
                            text: isLastStep ? "Confirm" : "Continue",
                            backgroundColor: primaryColor,
                            borderColor: primaryColor,
                            foregroundColor: Colors.white,
                            function: () {
                              String? status = MaintenceReportCubit.get(context)
                                  .changeCurrentStep(1);
                              if (status == "completed") {
                                MaintenceReportCubit.get(context)
                                    .maintenance(id!);
                              } else if (status == "incompleted") {
                                showSnackBar(
                                    context: context,
                                    message: "Enter all required data",
                                    duration: 3,
                                    icon: Icons.error_outline);
                              }
                            }),
                      ))
                    ]);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Step> getSteps(
      BuildContext context, Map<String, Map<String, bool>> data) {
    return [
      Step(
        title: const Text(""),
        isActive: MaintenceReportCubit.get(context).currentStep >= 0,
        content: SizedBox(
            height: MediaQuery.of(context).size.height - 225,
            child: const ReportInformation()),
      ),
      for (String dataKey in data.entries.map((e) => e.key).toList())
        Step(
          title: const Text(""),
          isActive: MaintenceReportCubit.get(context).currentStep >=
              data.entries.map((e) => e.key).toList().indexOf(dataKey) + 1,
          content: ReportCheckBox(dataKey: dataKey, data: data),
        ),
      Step(
        title: const Text(""),
        isActive: MaintenceReportCubit.get(context).currentStep >= 7,
        content: SizedBox(
            height: MediaQuery.of(context).size.height - 225,
            child: const ReportSignatures()),
      )
    ];
  }
}
