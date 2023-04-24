import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:version_checker/logic/application_version_checker/application_version_checker_cubit.dart';

class CriticalUpdateScreen extends StatelessWidget {
  final String message;
  final String applicationDownloadLink;
  const CriticalUpdateScreen({
    Key? key,
    required this.message,
    required this.applicationDownloadLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              onPressed: () {
                context
                    .read<ApplicationVersionCheckerCubit>()
                    .updateApplciation(
                        applciationDownloadLink: applicationDownloadLink);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                child: Text(
                  "Update",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
