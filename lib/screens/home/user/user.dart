import 'package:flutter/material.dart';
import 'package:qms/screens/home/user/que_list_page.dart';

import '../../../components/appbar/appbar.dart';
import '../../../services/auth.dart';
import '../../../utils/colors_for_app.dart';
import '../../wrapper.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: MyColors.primaryColor,
        appBar: AppBar(
          backgroundColor: Colors.black38,
          elevation: 0.0,
          actions: <Widget>[

            TextButton.icon(
                onPressed: () async {
                  await AuthService().signOut();
                  Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>Wrapper())) ;
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                label: const Text("Logout", style: TextStyle(color: Colors.white),)
            )
          ],

          flexibleSpace: Container(),

          bottom: TabBar(

            indicatorColor: MyColors.customOrange,
            indicatorWeight: 4,
            tabs: [
              Tab(icon: Icon(Icons.label_important_outlined), text: 'Counter 1',),
              Tab(icon: Icon(Icons.label_important_outlined), text: 'Counter 2',),
              Tab(icon: Icon(Icons.label_important_outlined), text: 'Counter 3',),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            //MaterialPageBuilder(builder: (context) => personalProfile());
            QueListPage(),
            QueListPage(),
            QueListPage(),

          ],
        ),
      ),
    );
  }
}
