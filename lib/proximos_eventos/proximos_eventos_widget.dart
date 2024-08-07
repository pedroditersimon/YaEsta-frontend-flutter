import 'package:ya_esta/ApiClient/api_client.dart';
import 'package:ya_esta/ApiClient/response_models.dart';
import 'package:ya_esta/evento/evento_widget.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'proximos_eventos_model.dart';
export 'proximos_eventos_model.dart';

class ProximosEventosWidget extends StatefulWidget {
  const ProximosEventosWidget({super.key});

  @override
  State<ProximosEventosWidget> createState() => _ProximosEventosWidgetState();
}

class _ProximosEventosWidgetState extends State<ProximosEventosWidget> {
  late ProximosEventosModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  Map<ResponseChannel, List<ResponseChannelEvent>> upcomingChannelEvents = {};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProximosEventosModel());

    GetUpcomingEvents();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> GetUpcomingEvents() async {
    Map<ResponseChannel, List<ResponseChannelEvent>> data = {};

    // get user channels
    final user_channels = await GetUserChannels();

    // get events of every user channel
    for (var ch in user_channels) {
      final chEvents = await GetChannelEvents(ch);
      data[ch] = chEvents;
    }

    /*
    // no data
    if (data.isEmpty)
      return;
    */

    upcomingChannelEvents = data;
  }

  Future<List<ResponseChannel>> GetUserChannels() async {
    setState(() { isLoading = true; });
    final channels = await apiClient.getUserChannels();
    setState(() { isLoading = false; });
    return channels;
  }

  Future<List<ResponseChannelEvent>> GetChannelEvents(ResponseChannel channel) async {
    if (!channel.isValid())
      return List.empty();

    setState(() { isLoading = true; });
    final events = await apiClient.getChannelCompletedEvents(channel.id);
    setState(() { isLoading = false; });
    return events;
  }

  Widget GetEventStatusWidget(String status) {
    if (status == "completed") {
      return Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    0.0, 12.0, 0.0, 0.0),
                child: Container(
                  height: 32.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context)
                        .success,
                    borderRadius:
                        BorderRadius.circular(12.0),
                    border: Border.all(
                      color:
                          FlutterFlowTheme.of(context)
                              .success,
                      width: 2.0,
                    ),
                  ),
                  child: Align(
                    alignment:
                        const AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional
                          .fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                      child: Text(
                        'completado',
                        style:
                            FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme
                                          .of(context)
                                      .primaryBackground,
                                  letterSpacing: 0.0,
                                ),
                      ),
                    ),
                  ),
                ),
              );
    }
    else /*if (status == "pending" || status == "registered")*/ {
        return Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 12.0, 0.0, 0.0),
                    child: Container(
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context)
                            .info,
                        borderRadius:
                            BorderRadius.circular(12.0),
                        border: Border.all(
                          color:
                              FlutterFlowTheme.of(context)
                                  .info,
                          width: 2.0,
                        ),
                      ),
                      child: Align(
                        alignment:
                            const AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional
                              .fromSTEB(
                                  12.0, 0.0, 12.0, 0.0),
                          child: Text(
                            'pendiente',
                            style:
                                FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme
                                              .of(context)
                                          .primaryBackground,
                                      letterSpacing: 0.0,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  );
    }

  }


  Widget CreateEventWidget(ResponseChannel channel, ResponseChannelEvent channelEvent) {
    return Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    16.0, 0.0, 16.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => EventoWidget(params: {"channelEvent": channelEvent.toJson()}),
                    ));
                  },
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      maxWidth: 570.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color:
                            FlutterFlowTheme.of(context).secondaryText,
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 12.0, 16.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 12.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  textScaler:
                                      MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${channelEvent.title}',
                                        style: TextStyle(),
                                      ),
                                      TextSpan(
                                        text: '',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(
                                                  context)
                                              .primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Poppins',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 4.0, 0.0, 0.0),
                                  child: Text(
                                    '${channel.title}',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 0.0),
                                child: GetEventStatusWidget(channelEvent.status),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
  }

  List<Widget> CreateEventList(Map<ResponseChannel, List<ResponseChannelEvent>> channelEvents) {
    List<Widget> widgets = [];
    channelEvents.forEach((channel, events) {
      events.forEach((event) {
        widgets.add(CreateEventWidget(channel, event));
      });
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          actions: const [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'Proximos eventos',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Poppins',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ...CreateEventList(upcomingChannelEvents),
                    ].divide(const SizedBox(height: 12.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
