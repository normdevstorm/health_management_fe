
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/app/utils/extensions/more_extensions.dart';
import 'package:health_management/presentation/chat/bloc/call/call_cubit.dart';

import '../../../../../../domain/chat/models/call_model.dart';

class CallPickupPage extends StatelessWidget {
  final Widget scaffold;

  const CallPickupPage({super.key, required this.scaffold});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CallModel>(
      stream: context.read<CallCubit>().callStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          CallModel call = snapshot.data!;
          print('call receiving: $call');

          // we receive incoming call
          if (!call.hasDialled) {
            return Scaffold(
              backgroundColor: AppColor.primaryColor,
              body: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Incoming Call',
                      style: context.titleLarge!
                          .copyWith(color: AppColor.blue, fontSize: 30),
                    ),
                    const SizedBox(height: 40),
                    CircleAvatar(
                      backgroundImage: NetworkImage(call.callerPic),
                      radius: 60,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      call.callerName,
                      style: context.headlineMedium!
                          .copyWith(color: AppColor.blue),
                    ),
                    const SizedBox(height: 70),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<CallCubit>().endCall(
                                  callerId: call.callId,
                                  receiverId: call.receiverId,
                                );
                            Navigator.pop(context);
                          },
                          icon: Icon(CupertinoIcons.phone_down_fill,
                              color: AppColor.red, size: 40),
                        ),
                        const SizedBox(width: 55),
                        IconButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, CallingPage.routeName,
                            //     arguments: CallingPage(
                            //         channelId: call.callId,
                            //         call: call,
                            //         isGroupChat: false));
                          },
                          icon: Icon(
                            CupertinoIcons.phone_fill,
                            color: AppColor.green,
                            size: 40,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        }
        return scaffold;
      },
    );
  }
}
