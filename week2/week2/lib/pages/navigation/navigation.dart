import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../main.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPage = 0;

  final _screens = [
    const MyHomePage(title: 'Flutter Demo Home Page')
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: _screens[currentPage],
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          decoration: BoxDecoration(
            color: Colors.black87.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                iconSize: 36,
                icon: Icon(currentPage == 0
                    ? PhosphorIconsFill.house
                    : PhosphorIconsThin.house),
                color: Colors.white,
                onPressed: () {
                  print("Home");
                  setState(() {
                    currentPage = 0;
                  });
                },
              ),
              IconButton(
                iconSize: 36,
                icon: Icon(currentPage == 1
                    ? PhosphorIconsFill.bellSimpleRinging
                    : PhosphorIconsThin.bellSimpleRinging),
                color: Colors.white,
                onPressed: () {
                  print("Chat");
                  setState(() {
                    currentPage = 0;
                  });
                },
              ),
              IconButton(
                iconSize: 36,
                icon: Icon(currentPage == 2
                    ? PhosphorIconsFill.mapPinLine
                    : PhosphorIconsLight.mapPinLine),
                color: Colors.white,
                onPressed: () {
                  print("Location");
                  setState(() {
                    currentPage = 0;
                  });
                },
              ),
              IconButton(
                iconSize: 36,
                icon: Icon(currentPage == 3
                    ? PhosphorIconsFill.userCircle
                    : PhosphorIconsThin.userCircle),
                color: Colors.white,
                onPressed: () {
                  print("Profile");
                  setState(() {
                    currentPage = 0;
                  });
                },
              ),
            ],
          ),
        ));
  }
}