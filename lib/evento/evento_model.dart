import '/flutter_flow/flutter_flow_util.dart';
import 'evento_widget.dart' show EventoWidget;
import 'package:flutter/material.dart';

class EventoModel extends FlutterFlowModel<EventoWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
