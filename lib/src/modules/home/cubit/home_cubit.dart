import 'dart:convert';
import 'package:atlas_company/src/models/contract.dart';
import 'package:atlas_company/src/modules/maintence_report/maintence_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../shared/components/components.dart';
import '../../../shared/end_points.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  String token =
      "KIiCCxOfPUsM52BRdf7zJFeXKtfsT43iW2oU2L78MyhKJISRlidZcF8rw6LMyGzi";
  final searchController = TextEditingController();
  List<Results> results = [];

  void refresh() {
    emit(HomeRefresh());
  }

  void navToMaintenceReport(BuildContext context, int index) {
    navigateTo(
        context,
        MaintenceReportScreen(
            id: '${results[index].id}',
            name: '${results[index].interest!.client!.name}'));
  }

  Future<void> search() async {
    try {
      emit(HomeLoading());
      var url = Uri.parse(
          "${ConstantsService.baseUrl}${ConstantsService.searchEndpoint}?search=${searchController.text}");
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token'
        },
      );

      var responseBody = jsonDecode(response.body);
      Contract contract = Contract.fromJson(responseBody);
      results = contract.results!;

      if (response.statusCode == 200) {
        emit(HomeSuccess());
      } else {
        throw Exception('invalid');
      }
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
