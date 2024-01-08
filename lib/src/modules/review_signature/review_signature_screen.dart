import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signature/signature.dart';
import 'cubit/review_signature_cubit.dart';

class ReviewSignatureScreen extends StatelessWidget {
  const ReviewSignatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocProvider(
        create: (context) => ReviewSignatureCubit(),
        child: BlocConsumer<ReviewSignatureCubit, ReviewSignatureState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                  backgroundColor: Colors.teal,
                  appBar: AppBar(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.teal,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ReviewSignatureCubit.get(context)
                            .setOrientation(Orientation.portrait);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () async {
                          await ReviewSignatureCubit.get(context)
                              .exportSignature()
                              .then((signature) {
                            Navigator.pop(context, signature);
                            ReviewSignatureCubit.get(context)
                                .setOrientation(Orientation.portrait);
                          });

                          //
                        },
                        icon: const Icon(Icons.save),
                      ),
                    ],
                    centerTitle: true,
                    title: const Text('Save Signature'),
                  ),
                  body: Stack(
                    children: [
                      Center(
                          child: Signature(
                              controller: ReviewSignatureCubit.get(context)
                                  .signatureController,
                              width: size.width,
                              height: size.height,
                              backgroundColor: Colors.teal)),
                      Positioned(
                          bottom: 0, child: buildSwapOrientation(context))
                    ],
                  ));
            }));
  }

  Widget buildSwapOrientation(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final newOrientation =
            isPortrait ? Orientation.landscape : Orientation.portrait;

        ReviewSignatureCubit.get(context).signatureController.clear();
        ReviewSignatureCubit.get(context).setOrientation(newOrientation);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPortrait
                  ? Icons.screen_lock_portrait
                  : Icons.screen_lock_landscape,
              size: 40,
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              'Tap to change signature orientation',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
