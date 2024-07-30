import '/flutter_flow/flutter_flow_util.dart';
import 'proximos_eventos_widget.dart' show ProximosEventosWidget;
import 'package:flutter/material.dart';

class ProximosEventosModel extends FlutterFlowModel<ProximosEventosWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
