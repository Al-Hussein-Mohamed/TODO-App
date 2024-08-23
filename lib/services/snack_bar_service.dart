import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SnackBarService {
  static void showSuccessMessage(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (void Function() cancelFunc) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: double.maxFinite,
            height: msg.length > 80 ? 100 : 75,
            padding: const EdgeInsets.only(right: 8),
            margin: const EdgeInsets.only(
              left: 24,
              right: 24,
            ),
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(12),
            ),
            child: msg.length > 80
                ? Row(
                    children: [
                      Container(
                        height: double.infinity,
                        width: 10,
                        decoration: const BoxDecoration(
                            color: Color(0xFF46c234),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Lottie.asset(
                          "assets/icons/face_success_icon.json",
                          repeat: false,
                          height: 250,
                          width: 250,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Success",
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              msg,
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.black26,
                        thickness: 2,
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: cancelFunc,
                          icon: const Text(
                            "close",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: double.infinity,
                        width: 10,
                        decoration: const BoxDecoration(
                            color: Color(0xFF46c234),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Lottie.asset(
                          "assets/icons/face_success_icon.json",
                          repeat: false,
                          height: 250,
                          width: 250,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Success",
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              msg,
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.black26,
                        thickness: 2,
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: cancelFunc,
                          icon: const Text(
                            "close",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
      duration: const Duration(
        seconds: 3,
      ),
      dismissDirections: [DismissDirection.endToStart],
    );
  }

  static void showErrorMessage(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (void Function() cancelFunc) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: double.maxFinite,
            height: msg.length > 80 ? 110 : 85,
            padding: const EdgeInsets.only(right: 8),
            margin: const EdgeInsets.only(
              left: 24,
              right: 24,
            ),
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(12),
            ),
            child: msg.length > 80
                ? Row(
                    children: [
                      Container(
                        height: double.infinity,
                        width: 10,
                        decoration: const BoxDecoration(
                            color: Color(0xFFd12e2e),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Lottie.asset(
                          "assets/icons/face_wrong_icon.json",
                          repeat: true,
                          height: 250,
                          width: 250,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Error",
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              msg,
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.black26,
                        thickness: 2,
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: cancelFunc,
                          icon: const Text(
                            "close",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: double.infinity,
                        width: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFFd12e2e),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Lottie.asset(
                          "assets/icons/face_wrong_icon.json",
                          width: 200,
                          height: 200,
                          repeat: false,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Error",
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              msg,
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.black26,
                        thickness: 2,
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: cancelFunc,
                          icon: const Text(
                            "close",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
      duration: const Duration(
        seconds: 3,
      ),
      dismissDirections: [DismissDirection.endToStart],
    );
  }
}
