import 'package:dip_edge_front/app/pages/home/model/dip_cctv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'common.dart';

part 'cctv_controller.g.dart';

@riverpod
class CCTVController extends _$CCTVController {
  @override
  List<DIP_CCTV> build() {
    supabase
        .from('dip_list_cctv')
        .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
      ref.read(cCTVControllerProvider.notifier).updateServiceList(data);
    });

    return [];
  }

  void updateServiceList(List<Map<String, dynamic>> data) {
    var list = <DIP_CCTV>[];
    list.addAll(data.map((e) => DIP_CCTV.fromJson(e)));
    state = list;
  }

  void deleteCCTV(DIP_CCTV svc) async {
    var resp = await supabase.from('dip_list_cctv').delete().eq('id', svc.id);
    print(resp);
  }
}
