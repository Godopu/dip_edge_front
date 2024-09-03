import 'package:dip_edge_front/app/pages/home/controller/service_controller.dart';
import 'package:dip_edge_front/app/pages/home/model/dip_svc.dart';
import 'package:dip_edge_front/app/pages/home/view/cctv_field.dart';
import 'package:dip_edge_front/app/pages/home/view/nvr_field.dart';
import 'package:dip_edge_front/app/pages/home/view/components/image_field_component.dart';
import 'package:dip_edge_front/colors.dart';
import 'package:dip_edge_front/const.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardPanel extends StatelessWidget {
  const DashboardPanel({super.key});

  Widget _renderServiceField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Cloud Service',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.withAlpha(150),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {},
              child: const Icon(Icons.search),
            )
          ],
        ),
        const SizedBox(height: defaultPadding),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Consumer(
              builder: (context, ref, child) {
                final services = ref.watch(serviceControllerProvider);

                return Row(
                  children: [
                    ...services.map(
                      (service) => Padding(
                        padding: const EdgeInsets.only(right: smallPadding),
                        child: ImageFieldComponent(
                          info: service,
                          onDeleted: (DIP_Svc svc) {},
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {},
                      child: Container(
                        width: 200,
                        height: 200,
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
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
        },
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding,
          horizontal: defaultPadding * 2,
        ),
        child: Column(
          children: [
            _renderServiceField(context),
            const SizedBox(height: defaultPadding * 2),
            const CCTVField(),
            const SizedBox(height: defaultPadding * 2),
            const NVRField(),
          ],
        ),
      ),
    );
  }
}
