import '/flutter_flow/flutter_flow_util.dart';
import 'search_public_channels_widget.dart' show SearchPublicChannelsWidget;
import 'package:flutter/material.dart';

class SearchPublicChannelsModel
    extends FlutterFlowModel<SearchPublicChannelsWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
