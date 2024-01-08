part of 'maintence_report_cubit.dart';

@immutable
abstract class MaintenceReportState {}

class MaintenceReportInitial extends MaintenceReportState {}

class MaintenceReportLoading extends MaintenceReportState {}

class MaintenceReportSuccess extends MaintenceReportState {
  final String message;
  MaintenceReportSuccess(this.message);
}

class MaintenceReportFailure extends MaintenceReportState {
  final String error;
  MaintenceReportFailure(this.error);
}

class MaintenceReportRefresh extends MaintenceReportState {}
