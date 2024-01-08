import 'package:atlas_company/src/modules/maintence_report/cubit/maintence_report_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class ReportSignatures extends StatelessWidget {
  const ReportSignatures({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocConsumer<MaintenceReportCubit, MaintenceReportState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
            child: Column(children: [
          const SizedBox(height: 8),
          signature(size, context, "Client Name", 0),
          const SizedBox(height: 15),
          signature(size, context, "Client Signature", 1),
          const SizedBox(height: 15),
          signature(size, context, "Technician Signature", 2),
          const SizedBox(height: 15)
        ]));
      },
    );
  }

  Column signature(Size size, BuildContext context, String label, int index) {
    return Column(children: [
      Container(
          color: Colors.white,
          width: size.width,
          height: 60,
          child: Row(children: [
            const SizedBox(width: 12),
            SizedBox(
              child: Text(label,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  )),
            ),
            const Spacer(),
            if (MaintenceReportCubit.get(context).signatures[index] == null)
              buildButton(
                  fontSize: 14,
                  radius: 5,
                  width: 75,
                  height: 10,
                  text: "Add",
                  backgroundColor: secondaryColor,
                  borderColor: secondaryColor,
                  foregroundColor: Colors.white,
                  function: () {
                    MaintenceReportCubit.get(context)
                        .getResultFromNextScreen(context, index);
                  }),
            if (MaintenceReportCubit.get(context).signatures[index] != null)
              buildButton(
                  fontSize: 14,
                  radius: 5,
                  width: 75,
                  height: 10,
                  text: "Clear",
                  backgroundColor: Colors.red,
                  borderColor: Colors.red,
                  foregroundColor: Colors.white,
                  function: () {
                    MaintenceReportCubit.get(context).signatures[index] = null;
                    MaintenceReportCubit.get(context)
                        .signaturesListString[index] = null;
                    MaintenceReportCubit.get(context).refresh();
                  }),
            const SizedBox(width: 12),
          ])),
      const SizedBox(height: 10),
      MaintenceReportCubit.get(context).signatures[index] != null
          ? Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: size.width - 100,
              height: 125,
              child: Center(
                child: Image.memory(
                    MaintenceReportCubit.get(context).signatures[index]!,
                    fit: BoxFit.contain),
              ))
          : Container()
    ]);
  }
}
