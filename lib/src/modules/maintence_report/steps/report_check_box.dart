import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/styles/colors.dart';
import '../cubit/maintence_report_cubit.dart';

class ReportCheckBox extends StatelessWidget {
  const ReportCheckBox({
    super.key,
    required this.dataKey,
    required this.data,
  });

  final String dataKey;
  final Map<String, Map<String, bool>> data;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocConsumer<MaintenceReportCubit, MaintenceReportState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
            height: size.height - 225,
            child: Scrollbar(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: data[dataKey]!.length,
                  itemBuilder: (context, index) {
                    List<String> dataKeys =
                        data[dataKey]!.entries.map((e) => e.key).toList();

                    return Column(children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 18),
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dataKeys[index],
                                style: const TextStyle(fontSize: 16)),
                            Checkbox(
                                activeColor: secondaryColor,
                                value: MaintenceReportCubit.get(context)
                                    .data[dataKey]![dataKeys[index]],
                                onChanged: (val) {
                                  MaintenceReportCubit.get(context)
                                      .data[dataKey]![dataKeys[index]] = val!;
                                  MaintenceReportCubit.get(context)
                                      .checkIsAllTrue();
                                  MaintenceReportCubit.get(context).refresh();
                                })
                          ],
                        ),
                      ),
                    ]);
                  }),
            ));
      },
    );
  }
}
