import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:untitled1/blocs/switch_bloc.bloc/switch_event.dart';
import 'package:untitled1/blocs/switch_bloc.bloc/switch_state.dart';
import 'package:untitled1/dio/dio.dart';

import 'package:untitled1/screens/History.dart';
import 'package:untitled1/screens/edit_my_account.dart';

import '../blocs/switch_bloc.bloc/switch_bloc.dart';
import 'Home.dart';

class SettingDrawer extends StatefulWidget {
  SettingDrawer({Key? key}) : super(key: key);

  @override
  State<SettingDrawer> createState() => _SettingDrawerState();
}

class _SettingDrawerState extends State<SettingDrawer> {
  String userName = "";
  String userEmail = "";
  String userImage = "";

  getUserInfo() async {
    SharedPreferences prefs = await sharedPrefs;
    setState(() {
      userName = prefs.getString("User Name")!;
      userEmail = prefs.getString("User Email")!;
      userImage = prefs.getString("User Image")!;
    });

    print(userImage);
    print(userName);
    print(userEmail);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    //  Icon(Icons.person_2_outlined,size: 30,),
                    //  "https://placehold.co/80x80?text=user+image"
                    radius: 20,
                    // backgroundImage: NetworkImage(userImage),
                    child: CachedNetworkImage(
                      imageUrl: userImage,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              
                          ),
                        ),
                      ),
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),

                    // child: CachedNetworkImage(
                    //   imageUrl: userImage,
                    //   placeholder: (context, url) => new CircularProgressIndicator(),
                    //   errorWidget: (context, url, error) => new Icon(Icons.error),
                    // ),
                  ),
                  accountName: Text(userName),
                  accountEmail: Text(userEmail)),
              ListTile(
                title: const Text("Edit My Acount"),
                leading: const Icon(
                  Icons.person_2_outlined,
                  color: Colors.cyan,
                ),
                onTap: () => onItemPressed(context, index: 0),
              ),
              ListTile(
                title: const Text("History tap"),
                leading: const Icon(
                  Icons.history,
                  color: Colors.cyan,
                ),
                onTap: () async{
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => History(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Language"),
                leading: const Icon(
                  Icons.language_outlined,
                  color: Colors.cyan,
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text("Theme"),
                leading: BlocBuilder<SwitchBloc, SwitchState>(
                  builder: (context, state) {
                    return Switch(
                      value: state.switchValue,
                      onChanged: (newValue) {
                        newValue
                            ? context.read<SwitchBloc>().add(SwitchOnEvent())
                            : context.read<SwitchBloc>().add(SwitchOffEvent());
                      },
                    );
                    // );
                  },
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text("Logout"),
                leading: const Icon(
                  Icons.logout_sharp,
                  color: Colors.cyan,
                ),
                onTap: () {
                  // getPatientHistory(context);
                  logout(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const EditMyAccount()));
        break;
      default:
        Navigator.pop(context);
        break;
    }
  }
}
