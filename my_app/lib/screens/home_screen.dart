import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_app/screens/signin_screen.dart';
import 'package:my_app/viewmodels/home_vm.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

class HomeScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeViewModel);
    //please fix line 20-22
    return ref.listen<HomeViewModel>(
      homeViewModel,
      (context, vm) {
        if (vm.success) {}
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Tap to see a song',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 40,
              ),
              AvatarGlow(
                endRadius: 200.0,
                animate: vm.isRecognizing,
                child: GestureDetector(
                  onTap: () => vm.startRecognizing(),
                  child: Material(
                    shape: CircleBorder(),
                    elevation: 8,
                    child: Container(
                      padding: EdgeInsets.all(40),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFF089af8)),
                      child: Image.asset('assets/images/music.png',
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // child: ElevatedButton(
          //   child: Text("Logout"),
          //   onPressed: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => SignInScreen()));
          //   },
          // ),
        ),
      ),
    );
  }
}
