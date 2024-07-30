import '/flutter_flow/flutter_flow_util.dart';
import 'eventos_copy_widget.dart' show EventosCopyWidget;
import 'package:flutter/material.dart';

class EventosCopyModel extends FlutterFlowModel<EventosCopyWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
