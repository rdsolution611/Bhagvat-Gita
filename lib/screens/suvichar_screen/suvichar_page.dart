import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:testingnew/controller/controller.dart';

class SuvicharPage extends StatefulWidget {
  static const String route = "/SuvicharPage";

  const SuvicharPage({super.key});

  @override
  State<SuvicharPage> createState() => _SuvicharPageState();
}

class _SuvicharPageState extends State<SuvicharPage> {
  void _copyToClipboard(String suvichar) {
    Clipboard.setData(ClipboardData(text: suvichar));
    Get.snackbar(
      'Copied',
      'Suvichar copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Api>(
      init: Api(),
      builder: (ctrl) {
        return Container(
          height: 1.sh,
          width: 1.sw,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xffF26B0F),
                const Color(0xffFCC737),
              ],
            ),
          ),
          child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text(
                'Suvichar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: ctrl.suvichar.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + kToolbarHeight,
                      left: 10,
                      right: 10,
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: ctrl.suvichar.length,
                      itemBuilder: (context, index) {
                        final GlobalKey _stackKey = GlobalKey();

                        final suvichar = ctrl.suvichar[index]['suvichar'] ??
                            'No data available';

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: [
                              RepaintBoundary(
                                key: _stackKey,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/wallpaper.png',
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        '$suvichar',
                                        textAlign: TextAlign.justify,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      try {
                                        final boundary = _stackKey
                                                .currentContext
                                                ?.findRenderObject()
                                            as RenderRepaintBoundary?;
                                        if (boundary == null) {
                                          print(
                                              "RenderRepaintBoundary is null");
                                          return;
                                        }

                                        final image = await boundary.toImage(
                                            pixelRatio: 3.0);
                                        final byteData = await image.toByteData(
                                            format: ImageByteFormat.png);
                                        final bytes =
                                            byteData?.buffer.asUint8List();

                                        if (bytes == null) {
                                          print("Image bytes are null");
                                          return;
                                        }

                                        final tempDir =
                                            await getTemporaryDirectory();
                                        final file = await File(
                                                '${tempDir.path}/suvichar.png')
                                            .create();
                                        await file.writeAsBytes(bytes);

                                        print('Sharing file: ${file.path}');
                                        await Share.shareXFiles(
                                          [
                                            XFile(file.path)
                                          ], // Use XFile for sharing files
                                          text: 'સુવિચાર બીજાને મોકલો',
                                        );
                                      } catch (e) {
                                        print("Error sharing image: $e");
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.share,
                                      size: 35,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => _copyToClipboard(suvichar),
                                    icon: const Icon(
                                      Icons.copy,
                                      size: 35,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ),
        );
      },
    );
  }
}
