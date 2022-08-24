import 'package:flutter/material.dart';
import 'package:la_vie/presentation/common/common_widgets.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // int index = 0;

  bool flag0 = true;
  bool flag1 = false;
  bool flag2 = false;

  Color setColorOnFlag(bool flag) {
    if (flag) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  // Color setColor(int index) {
  //   switch (index) {
  //     case 0:
  //       return Colors.green;
  //     case 1:
  //       return Colors.green;
  //     case 2:
  //       return Colors.green;
  //     default:
  //       return Colors.grey;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: setColorOnFlag(flag0),
          ),
          onPressed: () {
            setState(() {
              flag0 = true;
              flag1 = false;
              flag2 = false;
            });
          },
          child: const Text("button1"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: setColorOnFlag(flag1),
          ),
          onPressed: () {
            setState(() {
              flag0 = false;
              flag1 = true;
              flag2 = false;
            });
          },
          child: const Text("button2"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: setColorOnFlag(flag2),
          ),
          onPressed: () {
            setState(() {
              flag0 = false;
              flag1 = false;
              flag2 = true;
            });
          },
          child: const Text("button3"),
        ),
        const Center(
          child: Text("white"),
        ),
        Center(
          child: CommonWidgets.getBrandName(),
        )
      ],
    );
  }
}
