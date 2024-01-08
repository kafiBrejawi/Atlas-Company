import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/styles/colors.dart';
import '../cubit/maintence_report_cubit.dart';

class ReportInformation extends StatelessWidget {
  const ReportInformation({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocConsumer<MaintenceReportCubit, MaintenceReportState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
            child: Column(children: [
          const SizedBox(height: 8),
          Container(
              color: Colors.white,
              width: size.width,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    width: size.width,
                    child: const Text("Date of contract",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            MaintenceReportCubit.get(context)
                                .selectedDate
                                .toString()
                                .substring(0, 10),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            )),
                      ),
                      IconButton(
                          onPressed: () async {
                            MaintenceReportCubit.get(context).selectedDate =
                                await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day),
                                    firstDate: DateTime(2020, 1, 1),
                                    lastDate: DateTime(2050, 1, 1));

                            if (context.mounted) {
                              if (MaintenceReportCubit.get(context)
                                      .selectedDate ==
                                  null) {
                                MaintenceReportCubit.get(context).selectedDate =
                                    DateTime.now();
                              }
                              MaintenceReportCubit.get(context).refresh();
                            }
                          },
                          icon: const Icon(
                            Icons.date_range,
                            color: secondaryColor,
                            size: 25,
                          )),
                    ],
                  ),
                ]),
              )),
          const SizedBox(height: 8),
          Container(
              color: Colors.white,
              width: size.width,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    width: size.width,
                    child: const Text("Maintenance type",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                  ),
                  const SizedBox(height: 5),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Emergency",
                            style: TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          Radio(
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return secondaryColor;
                              }
                              return thirdColor;
                            }),
                            value: "EMERGENCY",
                            groupValue: MaintenceReportCubit.get(context)
                                .maintenanceType,
                            onChanged: (value) {
                              MaintenceReportCubit.get(context)
                                  .changeMaintenanceType(value);
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Predictive periodic",
                            style: TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          Radio(
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return secondaryColor;
                              }
                              return thirdColor;
                            }),
                            value: "PREDICTIVE PERIODIC",
                            groupValue: MaintenceReportCubit.get(context)
                                .maintenanceType,
                            onChanged: (value) {
                              MaintenceReportCubit.get(context)
                                  .changeMaintenanceType(value);
                            },
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
              )),
          const SizedBox(height: 8),
          Container(
              color: Colors.white,
              width: size.width,
              height: 180,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    width: size.width,
                    child: const Text("Helpers",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: MaintenceReportCubit.get(context).helper1,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: secondaryColor,
                      ),
                      hintText: 'Helper 1',
                      filled: true,
                      fillColor: forthColor,
                      contentPadding: EdgeInsets.all(12),
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: MaintenceReportCubit.get(context).helper2,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: secondaryColor,
                      ),
                      hintText: 'Helper 2',
                      filled: true,
                      fillColor: forthColor,
                      contentPadding: EdgeInsets.all(12),
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                  ),
                ]),
              )),
          const SizedBox(height: 8),
          Container(
              color: Colors.white,
              width: size.width,
              height: 160,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    width: size.width,
                    child: const Text("Remarks",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller:
                        MaintenceReportCubit.get(context).remarksController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: forthColor,
                      contentPadding: EdgeInsets.all(10),
                    ),
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                  ),
                ]),
              )),
          const SizedBox(height: 15),
          CircleAvatar(
            backgroundColor: secondaryColor,
            radius: 20,
            child: IconButton(
                onPressed: () {
                  showBottomSheet(context);
                },
                icon: const Icon(
                  Icons.add_a_photo_sharp,
                  color: forthColor,
                )),
          ),
          const SizedBox(height: 10),
          if (MaintenceReportCubit.get(context).imagesList.isNotEmpty)
            SizedBox(
                height: 120,
                width: size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount:
                        MaintenceReportCubit.get(context).imagesList.length,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: const EdgeInsets.all(10),
                          child: Stack(children: <Widget>[
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.file(
                                File(MaintenceReportCubit.get(context)
                                    .imagesList[index]
                                    .path),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                right: 2,
                                top: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    MaintenceReportCubit.get(context)
                                        .imagesList
                                        .removeAt(index);
                                    MaintenceReportCubit.get(context)
                                        .imagesListString
                                        .removeAt(index);
                                    MaintenceReportCubit.get(context).refresh();
                                  },
                                  child: const Icon(Icons.cancel,
                                      color: Colors.red),
                                ))
                          ]));
                    })),
          const SizedBox(height: 100)
        ]));
      },
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        backgroundColor: forthColor,
        context: context,
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        builder: (privateContext) => SizedBox(
              height: 200,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22, right: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Upload Contract Picture",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel_sharp,
                            color: thirdColor,
                          )),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.all(
                      Radius.circular(
                        12.0,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  child: Column(
                    children: [
                      const Spacer(),
                      Card(
                          elevation: 0,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              MaintenceReportCubit.get(context)
                                  .pickImageFromCamera();
                            },
                            child: const Row(
                              children: [
                                Text(
                                  "Take Photo",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                                Spacer(),
                                Icon(Icons.photo_camera)
                              ],
                            ),
                          )),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          )),
                      Card(
                          elevation: 0,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              MaintenceReportCubit.get(context)
                                  .pickImageFromGallery();
                            },
                            child: const Row(
                              children: [
                                Text(
                                  "Choose Photo",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                                Spacer(),
                                Icon(Icons.photo)
                              ],
                            ),
                          )),
                      const Spacer()
                    ],
                  ),
                ),
              ]),
            ));
  }
}
