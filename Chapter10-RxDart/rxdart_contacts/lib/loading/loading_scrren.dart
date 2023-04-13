import 'dart:async';

import 'package:flutter/material.dart';

import 'loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();

  /// Singleton instance
  factory LoadingScreen.instance() => _shared;

  /// if [LoadingScreen] is displayed, controller is not null, and otherwise null

  LoadingScreenController? _controller;

  /// if [LoadingScreen] is already shown, just update the loading message.
  ///  Otherwise, create the [LoadingScreen] and show text with it
  void show(BuildContext context, String text) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = _showOverlay(context: context, text: text);
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController _showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final textController = StreamController<String>();
    textController.add(text);

    // Overlay works separately from your widget tree, and
    //  Overlay is displayed on top of anything, such modals, dialogs and toasts

    final renderBox = context.findRenderObject()
        as RenderBox; // this context is from widget tree
    final availableSize = renderBox.size;

    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: availableSize.width * 0.8,
                minWidth: availableSize.width * 0.5,
                maxHeight: availableSize.height * 0.8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      StreamBuilder<String>(
                        stream: textController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              text,
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    // display the overlay
    final overlayState = Overlay.of(context);
    overlayState.insert(overlayEntry);

    return LoadingScreenController(
      close: () {
        textController.close();
        overlayEntry.remove();
        return true;
      },
      update: (text) {
        textController.add(text);
        return true;
      },
    );
  }
}
