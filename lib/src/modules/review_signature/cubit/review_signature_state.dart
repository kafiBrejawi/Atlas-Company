part of 'review_signature_cubit.dart';

@immutable
abstract class ReviewSignatureState {}

class ReviewSignatureInitial extends ReviewSignatureState {}

class ReviewSignatureLoading extends ReviewSignatureState {}

class ReviewSignatureSuccess extends ReviewSignatureState {}

class ReviewSignatureFailure extends ReviewSignatureState {
  final String error;

  ReviewSignatureFailure(this.error);
}

class ReviewSignatureRefresh extends ReviewSignatureState {}
