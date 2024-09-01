import 'package:dip_edge_front/app/pages/home/model/dip_svc.dart';
import 'package:dip_edge_front/colors.dart';
import 'package:dip_edge_front/const.dart';
import 'package:flutter/material.dart';

class ImageFieldComponent extends StatelessWidget {
  final DIP_Svc info;
  final void Function(DIP_Svc svc) onDeleted;
  final double width;
  final double height;
  final double zoomRatioWhenDragging;

  const ImageFieldComponent(
      {super.key,
      required this.info,
      required this.onDeleted,
      this.width = 280,
      this.height = 200,
      this.zoomRatioWhenDragging = 1.1});

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                '1 containers',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                info.status == 'disabled'
                    ? const Icon(Icons.cancel_outlined,
                        size: 24, color: Colors.red)
                    : info.status == 'installing'
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.lightBlue,
                            ))
                        : const Icon(
                            Icons.check_circle_outline,
                            size: 30,
                            color: Colors.green,
                          ),
                IconButton(
                  icon: const Icon(
                    size: 24,
                    Icons.delete_outline,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    onDeleted(info);
                  },
                )
              ],
            ),
          ],
        ),
        Text(
          info.imgName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontSize: 18,
              ),
        ),
        TextButton(
          child: Text(
            info.imgId,
            maxLines: 1,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: info,
      feedback: Container(
        width: width * zoomRatioWhenDragging,
        height: height * zoomRatioWhenDragging,
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor.withAlpha(100),
          borderRadius: BorderRadius.circular(10),
        ),
        child: _body(context),
      ),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: _body(context),
      ),
    );
  }
}
