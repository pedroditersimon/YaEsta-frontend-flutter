import '/flutter_flow/flutter_flow_util.dart';
import 'listadeeventos_widget.dart' show ListadeeventosWidget;
import 'package:flutter/material.dart';

class ListadeeventosModel extends FlutterFlowModel<ListadeeventosWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
