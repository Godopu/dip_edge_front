import 'package:dip_edge_front/app/common/responsive.dart';
import 'package:dip_edge_front/app/pages/home/controller/cctv_controller.dart';
import 'package:dip_edge_front/app/pages/home/model/dip_cctv.dart';
import 'package:dip_edge_front/colors.dart';
import 'package:dip_edge_front/const.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CCTVField extends StatelessWidget {
  const CCTVField({super.key});

  Widget _render(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'CCTV Panel',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
        ),
        const SizedBox(height: defaultPadding),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ScrollConfiguration(
            behavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
              },
            ),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...ref.watch(cCTVControllerProvider).map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: _CCTVComponent(cctv: e),
                              ),
                            ),
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {},
                          child: Container(
                            width: 265,
                            height: 265,
                            decoration: BoxDecoration(
                              color: secondaryColor.withOpacity(0.5),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: const Icon(Icons.add, size: 80),
                          ),
                        )
                      ],
                    );
                  },
                )),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: _render(context),
      tablet: _render(context),
      mobile: _render(context),
    );
  }
}

Widget _makeRichText(BuildContext context, String key, String value) {
  return RichText(
    text: TextSpan(
      text: key,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Colors.white,
            fontSize: 22,
          ),
      children: [
        TextSpan(
          text: value,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.white,
                // fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
        ),
      ],
    ),
  );
}

class _CCTVComponent extends StatefulWidget {
  final DIP_CCTV cctv;
  const _CCTVComponent({required this.cctv});

  @override
  State<_CCTVComponent> createState() => __CCTVComponentState();
}

class __CCTVComponentState extends State<_CCTVComponent> {
  var isShow = true;
  var isDgragged = false;
  var isBlack = false;
  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onAcceptWithDetails: (data) async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Confirm"),
              content: const Text(
                  "Do you want to register face recognition service to this CCTV?"),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        isDgragged = true;
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text("Yes")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("No")),
              ],
            );
          },
        );
      },
      builder: (context, candidateData, rejectedData) => Container(
        decoration: candidateData.isEmpty
            ? const BoxDecoration()
            : BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.red,
                ),
              ),
        child: Container(
          width: Responsive.isMobile(context) ? 320 : 520,
          // height: height,
          padding: const EdgeInsets.all(defaultPadding * 2),
          decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _makeRichText(context, "Name : ", widget.cctv.name),
              const SizedBox(height: 16),
              !Responsive.isMobile(context)
                  ? _makeRichText(context, "ID : ", widget.cctv.id)
                  : Text(
                      widget.cctv.id,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
                    ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.cctv.status ? "Connected" : "Disconnected",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.cctv.status ? Colors.green : Colors.red,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isShow = !isShow;
                      });
                    },
                    child: Text(
                      isShow ? "hide" : "show",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isShow ? 500 : 0,
                      child: Image.network(widget.cctv.addr),
                    ),
                    if (isBlack)
                      Container(
                        width: 500,
                        height: 300,
                        color: Colors.black,
                      )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Material(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(80),
                      ),
                    ),
                    // Clip.hardEdge가 뭔지 조사해보기
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      focusColor: Colors.black,
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.purple.withAlpha(50),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(80),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text('Media file management'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (isDgragged)
                    Material(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(80),
                        ),
                      ),
                      // Clip.hardEdge가 뭔지 조사해보기
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        focusColor: Colors.black,
                        onTap: () async {
                          setState(() {
                            isBlack = true;
                          });
                          // await makeServiceDialog(context);
                          // Future.delayed(const Duration(milliseconds: 500), () {
                          //   setState(() {
                          //     isBlack = false;
                          //   });
                          // });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.withAlpha(50),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(80),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text('Face recognition'),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
