import 'package:dip_edge_front/app/pages/home/model/dip_nvr.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'common.dart';

part 'nvr_controller.g.dart';

@riverpod
class NVRController extends _$NVRController {
  @override
  List<DIP_NVR> build() {
    supabase
        .from('dip_list_nvrs')
        .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
      ref.read(nVRControllerProvider.notifier).updateServiceList(data);
    });

    return [];
  }

  void updateServiceList(List<Map<String, dynamic>> data) {
    var list = <DIP_NVR>[];
    list.addAll(data.map((e) => DIP_NVR.fromJson(e)));
    state = list;
  }

  void deleteNVR(DIP_NVR svc) async {
    var resp = await supabase.from('dip_list_nvrs').delete().eq('id', svc.id);
    print(resp);
  }
}
