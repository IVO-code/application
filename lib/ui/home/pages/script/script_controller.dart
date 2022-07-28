import 'package:application/model/script_model.dart';
import 'package:application/services/script_service.dart';
import 'package:application/ui/register/script/register_script_view.dart';
import 'package:get/get.dart';

class ScriptController extends GetxController with StateMixin {
  List<Scripts> _script = [];
  RxList<Scripts> Script = RxList<Scripts>();

  ScriptController() {
    //_load();
  }

  void toRegisterScript() async {
    await Get.to(() => RegisterScriptsView());
    //_load();
  }

  void _load() async {
    change(null, status: RxStatus.loading());
    await _loadScript();
  }

  void _find(string) async {
    change(null, status: RxStatus.loading());

    Script.clear();
    try {
      List<Scripts> Script = _script
          .where(
              (i) => i.title!.text.toUpperCase().contains(string.toUpperCase()))
          .toList();

      for (var i = 0; i < Script.length; i++) {
        this.Script.add(Script[i]);
      }
      change(Script, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  _loadScript() async {
    change(null, status: RxStatus.loading());
    _script.clear();
    Script.clear();
    try {
      _script = await ScriptService().findAllScripts();
      for (var i = 0; i < _script.length; i++) {
        Script.add(_script[i]);
      }
      change(Script, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
