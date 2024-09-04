import 'package:dip_edge_front/app/common/nvr_add_dialog.dart';
import 'package:dip_edge_front/app/common/responsive.dart';
import 'package:dip_edge_front/app/pages/home/controller/nvr_controller.dart';
import 'package:dip_edge_front/app/pages/home/model/dip_nvr.dart';
import 'package:dip_edge_front/colors.dart';
import 'package:dip_edge_front/const.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class NVRField extends StatelessWidget {
  const NVRField({super.key});
  Widget _render(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Network Video Recorder',
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
                        ...ref.watch(nVRControllerProvider).map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: _NVRComponent(nvr: e),
                              ),
                            ),
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            makeNVRAddDialog(context);
                          },
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

class _NVRComponent extends StatefulWidget {
  final DIP_NVR nvr;
  const _NVRComponent({required this.nvr});

  @override
  State<_NVRComponent> createState() => __NVRComponentState();
}

class __NVRComponentState extends State<_NVRComponent> {
  var isShow = false;
  var isDgragged = false;
  var isBlack = false;
  @override
  Widget build(BuildContext context) {
    return Container(
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
          _makeRichText(context, "Name : ", widget.nvr.name),
          const SizedBox(height: 16),
          !Responsive.isMobile(context)
              ? _makeRichText(context, "ID : ", widget.nvr.id)
              : Text(
                  widget.nvr.id,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16),
                ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () async {
              await launchUrl(Uri.parse(widget.nvr.addr));
            },
            child: Text(widget.nvr.addr),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 500,
                  child: Image.network(widget.nvr.thumbnails),
                ),
                if (isBlack)
                  Container(
                    width: 500,
                    height: 300,
                    color: Colors.black,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
