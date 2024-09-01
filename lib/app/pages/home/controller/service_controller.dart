import 'package:dip_edge_front/app/pages/home/model/dip_svc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'common.dart';

part 'service_controller.g.dart';

@riverpod
class ServiceController extends _$ServiceController {
  @override
  List<DIP_Svc> build() {
    supabase
        .from('dip_list_svcs')
        .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
      ref.read(serviceControllerProvider.notifier).updateServiceList(data);
    });

    return [];
  }

  void updateServiceList(List<Map<String, dynamic>> data) {
    var list = <DIP_Svc>[];
    list.addAll(data.map((e) => DIP_Svc.fromJson(e)));
    state = list;
  }

  void installService(String imgId) async {
    var resp =
        await supabase.rpc('dip_func_install_svc', params: {'_uuid': imgId});
    print(resp);
  }

  void deleteService(DIP_Svc svc) async {
    var resp = await supabase.from('dip_list_svcs').delete().eq('id', svc.id);
    print(resp);
  }
}
