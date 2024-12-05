
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/config/agora_config.dart';
import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/presentation/chat/bloc/call/call_cubit.dart';

import '../../../../../../domain/chat/models/call_model.dart';

class CallingPage extends StatefulWidget {
  static const routeName = 'call-pickup';

  final String channelId;
  final CallModel call;
  final bool isGroupChat;

  const CallingPage(
      {super.key,
      required this.channelId,
      required this.call,
      required this.isGroupChat});

  @override
  State<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage> {
  AgoraClient? client;
  int? _remoteUid;
  bool _localUserJoined = false;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await [Permission.microphone, Permission.camera].request();
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appId,
        channelName: widget.channelId,
        tempToken: AgoraConfig.token,
        tempRtmToken: AgoraConfig.token,
      ),
    );
    await client!.initialize();

    client!.engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await client!.engine
        .setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await client!.engine.enableVideo();
    await client!.engine.startPreview();

    try {
      client!.engine.joinChannel(
          token: AgoraConfig.token,
          channelId: 'channelName',
          uid: 0,
          options: const ChannelMediaOptions());
    } catch (e) {
      debugPrint("join channel: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await client!.engine.leaveChannel();
    await client!.engine.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: client == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: _remoteVideo(),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: _localUserJoined
                          ? AgoraVideoViewer(client: client!)
                          : const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  AgoraVideoButtons(
                      client: client!,
                      disconnectButtonChild: GestureDetector(
                        onTap: () async {
                          await client!.engine.leaveChannel();
                          if (!mounted) return;
                          context.read<CallCubit>().endCall(
                                callerId: widget.call.callerId,
                                receiverId: widget.call.receiverId,
                              );
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColor.red,
                          radius: 25,
                          child: Icon(Icons.call_end,
                              color: AppColor.primaryColor),
                        ),
                      )),
                ],
              ),
            ),
    );
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: client!.engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: widget.channelId),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
