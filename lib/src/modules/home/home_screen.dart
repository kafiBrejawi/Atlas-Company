import 'package:atlas_company/src/models/contract.dart';
import 'package:atlas_company/src/modules/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/styles/colors.dart';
import '../../shared/components/components.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeLoading) {
            circularProgress(context);
          }
          if (state is HomeSuccess) {
            Navigator.pop(context);
          }
          if (state is HomeFailure) {
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
            backgroundColor: Colors.white,
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 125,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: forthColor,
                    boxShadow: [
                      BoxShadow(
                        color: thirdColor,
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    "Clients",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 70, right: 25, left: 25),
                  height: 40,
                  child: defaultFormField(
                    controller: HomeCubit.get(context).searchController,
                    type: TextInputType.visiblePassword,
                    hint: 'Search',
                    prefix: Icons.search,
                    suffix: HomeCubit.get(context).searchController.text != ""
                        ? Icons.cancel
                        : null,
                    suffixPressed: () {
                      HomeCubit.get(context).searchController.text = "";
                      HomeCubit.get(context).results = [];
                      HomeCubit.get(context).refresh();
                    },
                    onChange: (val) {
                      HomeCubit.get(context).refresh();
                    },
                    onSubmit: (val) {
                      HomeCubit.get(context).refresh();
                      if (HomeCubit.get(context).searchController.text != "") {
                        HomeCubit.get(context).search();
                      }
                    },
                  ),
                ),
                if (HomeCubit.get(context).results.isEmpty)
                  SizedBox(
                    height: size.height,
                    child: const Center(
                        child: Text("No Results",
                            style: TextStyle(color: thirdColor, fontSize: 25))),
                  ),
                Column(
                  children: [
                    const SizedBox(height: 120),
                    Expanded(
                      child: Scrollbar(
                          thumbVisibility: false,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: HomeCubit.get(context).results.length,
                              itemBuilder: (context, index) {
                                return Column(children: [
                                  Card(
                                      elevation: 0,
                                      child: InkWell(
                                        onTap: () {
                                          HomeCubit.get(context)
                                              .navToMaintenceReport(
                                                  context, index);
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10, right: 10),
                                              child: IconButton(
                                                  onPressed: () {
                                                    if (context.mounted) {
                                                      showBottomSheet(
                                                          context,
                                                          HomeCubit.get(context)
                                                              .results[index]);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.info,
                                                    color: secondaryColor,
                                                    size: 40,
                                                  )),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${HomeCubit.get(context).results[index].interest!.client!.name}',
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        child: Text(
                                                          HomeCubit.get(context)
                                                              .results[index]
                                                              .interest!
                                                              .client!
                                                              .date!
                                                              .substring(0, 10),
                                                          style: const TextStyle(
                                                              color:
                                                                  thirdColor),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                      'ATS: ${HomeCubit.get(context).results[index].ats}',
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 14,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  const Padding(
                                      padding:
                                          EdgeInsets.only(left: 60, right: 15),
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.black12,
                                      ))
                                ]);
                              })),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showBottomSheet(BuildContext context, Results model) {
    List<String> labels = [
      "Name",
      "Arabic Name",
      "Phone",
      "ATS",
      "City",
      "Company Name",
      "Lift Type",
      "Size",
      "Floors",
      "Villa No",
      "Location"
    ];
    List<String> data = [
      model.interest!.client!.name!,
      model.interest!.client!.arabicName!,
      model.interest!.client!.mobilePhone!,
      model.ats!,
      model.interest!.client!.city!,
      model.interest!.companyName!,
      model.liftType!,
      model.size!.toString(),
      model.floors!,
      model.villaNo!,
      model.location!
    ];
    showModalBottomSheet<void>(
        backgroundColor: Colors.white,
        context: context,
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        builder: (context) => Column(children: [
              const ImageIcon(AssetImage("assets/images/dash.png"),
                  color: Colors.black26, size: 40),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Client Details",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 42, 16, 16),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, top: 5),
                        child: GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse(data[10]));
                            },
                            child: const Icon(
                              Icons.location_pin,
                              color: secondaryColor,
                              size: 30,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.black12,
              ),
              Expanded(
                child: Scrollbar(
                    thumbVisibility: false,
                    child: ListView(
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          for (int i = 0; i < 10; i++)
                            Column(children: [
                              Card(
                                  elevation: 0,
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data[i],
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                              )),
                                          Text(
                                            labels[i],
                                            style: const TextStyle(
                                              color: thirdColor,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              if (i != 9)
                                const Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ))
                            ])
                        ])),
              ),
            ]));
  }
}
