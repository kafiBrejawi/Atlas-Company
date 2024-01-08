import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signature/signature.dart';

part 'review_signature_state.dart';

class ReviewSignatureCubit extends Cubit<ReviewSignatureState> {
  ReviewSignatureCubit() : super(ReviewSignatureInitial());

  static ReviewSignatureCubit get(context) => BlocProvider.of(context);

  void refresh() {
    emit(ReviewSignatureRefresh());
  }

  SignatureController signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.white,
    exportBackgroundColor: Colors.white,
  );

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
        penStrokeWidth: 3,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white,
        points: signatureController.points);
    //converting the signature to png bytes
    final signature = exportController.toPngBytes();
    //clean up the memory
    exportController.dispose();
    return signature;
  }

  void setOrientation(Orientation orientation) {
    if (orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }
}
