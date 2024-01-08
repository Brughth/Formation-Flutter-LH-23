import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../shared/theming/app_colors.dart';
import '../../shared/widgets/app_button.dart';

class ConformWidget extends StatelessWidget {
  final VoidCallback? onConfirm;
  const ConformWidget({
    super.key,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: MediaQuery.sizeOf(context).width * .5,
        width: MediaQuery.sizeOf(context).width * .9,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Material(
          color: AppColors.white,
          child: Column(
            children: [
              const Text(
                "Attention !!!",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Text(
                "Are you sure you want to delete this person?\nPlease note that this action is irreversible",
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      onPressed: onConfirm,
                      bgColor: const Color.fromRGBO(35, 204, 183, 1),
                      child: const Text(
                        "Yes",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: AppButton(
                      onPressed: () {
                        context.router.pop();
                      },
                      borderColor: AppColors.bordeColor,
                      child: const Text(
                        "No",
                        style: TextStyle(
                          color: AppColors.blackBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
