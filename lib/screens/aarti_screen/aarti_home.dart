import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testingnew/controller/controller.dart';
import 'package:testingnew/custom_widget/custom_widget.dart';

class AartiHome extends StatefulWidget {
  final String title;
  static const String route = "/AartiHome";

  const AartiHome({super.key, required this.title});

  @override
  State<AartiHome> createState() => _AartiHomeState();
}

class _AartiHomeState extends State<AartiHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Api>(
      init: Api(),
      builder: (controller) {
        final List<dynamic> itemList = widget.title == "Aarti"
            ? controller.arti
            : widget.title == "Bhajan"
                ? controller.bhajan
                : controller.mahabharat;

        return Container(
          height: 1.sh,
          width: 1.sw,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffF26B0F),
                Color(0xffFCC737),
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: CustomAppBar(title: widget.title),
            body: itemList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).viewPadding.top +
                          kToolbarHeight,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(8),
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        final item = itemList[index];

                        return InkWell(
                          onTap: () {
                            Get.toNamed(
                              '/AartiDetails',
                              arguments: item,
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.orange,
                                    Colors.orangeAccent,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      height: 100,
                                      width: 100,
                                      imageUrl: item['bc_image'] ?? '',
                                      placeholder: (context, url) => Center(
                                          child:
                                              const CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.broken_image,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['Heading'] ?? "No Title",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '${item['HeadingLine']}'.replaceAll(
                                              "<br>",
                                              ''
                                                  ''),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
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
