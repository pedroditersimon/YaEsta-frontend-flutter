import '/flutter_flow/flutter_flow_util.dart';
import 'mis_canales_widget.dart' show MisCanalesWidget;
import 'package:flutter/material.dart';

class MisCanalesModel extends FlutterFlowModel<MisCanalesWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
