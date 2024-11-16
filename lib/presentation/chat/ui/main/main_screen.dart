
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/presentation/chat/bloc/auth/auth_cubit.dart';
import 'package:health_management/presentation/chat/bloc/pages/page_cubit.dart';
import 'package:health_management/presentation/chat/bloc/user/user_cubit.dart';
import 'package:health_management/presentation/chat/ui/main/calls/call_list_page.dart';
import 'package:health_management/presentation/chat/ui/main/home/general/home_page.dart';
import 'package:health_management/presentation/chat/ui/main/profile_settings/my_profile_page.dart';
import 'package:health_management/presentation/chat/ui/main/status/status_page.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = 'main';
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  // didChangeAppLifecycleState is a method provided by the Flutter framework that is called whenever the lifecycle state of the application changes.
  // this code updates the user's online status in response to changes in the lifecycle state of the application.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        context.read<UserCubit>().setUserStateStatus(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        context.read<UserCubit>().setUserStateStatus(false);
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, int>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.backgroundColor,
          body: SafeArea(
            child: Stack(
              children: [buildContent(state), customBottomBarNavigation()],
            ),
          ),
        );
      },
    );
  }

  Widget buildContent(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const HomePages();
      case 1:
        return const CallListPage();
      case 2:
        return const StatusPage();
      case 3:
        return FutureBuilder<String>(
          future: context.read<AuthCubit>().getCurrentUserId(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return ProfilePage(
                  uid: snapshot.data!,
                );
              }
            }
          },
        );
      default:
        return const HomePages();
    }
  }

  String buildTextAppBar(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return "Home";
      case 1:
        return "Calls";
      case 2:
        return "Status";
      case 3:
        return "Settings";
      default:
        return "Home";
    }
  }

  Widget customBottomBarNavigation() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 65,
        margin: const EdgeInsets.only(right: 12, left: 12, bottom: 15),
        decoration: BoxDecoration(
            color: AppColor.backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: AppColor.accentColor.withOpacity(0.4), blurRadius: 5)
            ]),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomBottomNavigationItem(
              index: 0,
              icons: CupertinoIcons.home,
              text: "Home",
            ),
            CustomBottomNavigationItem(
              index: 1,
              icons: Icons.history,
              text: "Calls",
            ),
            CustomBottomNavigationItem(
              index: 2,
              icons: CupertinoIcons.circle_grid_3x3_fill,
              text: "Status",
            ),
            CustomBottomNavigationItem(
              index: 3,
              icons: CupertinoIcons.settings,
              text: "Settings",
            )
          ],
        ),
      ),
    );
  }
}

class CustomBottomNavigationItem extends StatelessWidget {
  final int index;
  final IconData icons;
  final String text;

  const CustomBottomNavigationItem({
    super.key,
    required this.index,
    required this.icons,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, int>(
      builder: (context, currentIndex) {
        return GestureDetector(
          onTap: () {
            context.read<PageCubit>().setPage(index);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icons,
                size: 24,
                color: currentIndex == index
                    ? AppColor.itemBottomNavigationSelectedColor
                    : AppColor.itemBottomNavigationColor,
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: currentIndex == index
                    ? TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColor.itemBottomNavigationSelectedColor)
                    : const TextStyle(fontSize: 11),
              ),
            ],
          ),
        );
      },
    );
  }
}
