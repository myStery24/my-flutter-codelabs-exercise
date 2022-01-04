/*
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sharing_codelab/pages/dashboard_page.dart';

import 'create_trip_page.dart';
import 'join_trip_page.dart';

/// Modified to display bottom navigation bar
/// https://youtu.be/TX2x41h47fE
class TripListPage extends StatefulWidget {
  const TripListPage({Key? key}) : super(key: key);

  @override
  State<TripListPage> createState() => _TripListPageState();
}

class _TripListPageState extends State<TripListPage> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  /// Navigation Bar Screens
  final screens = [
    DashboardPage(),/// Previously TripListPage
    CreateTripPage(),
    JoinTripPage(),
  ];

  /// Navigation Bar Icons
  final items = <Widget>[
    Icon(Icons.home, size: 30),
    Icon(Icons.add, size: 30),
    Icon(Icons.groups, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: screens[index],
            bottomNavigationBar: buildBottomNavigationBar(),
          ),
        ),
      ),
    );
  }

  /// Animated Curved Navigation Bar
  Widget buildBottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(color: Colors.white),
      ),
      child: CurvedNavigationBar(
        key: navigationKey,
        color: Colors.green,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.green,
        height: 60,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        index: index,
        items: items,
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}
