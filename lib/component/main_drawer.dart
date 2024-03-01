import 'package:flutter/material.dart';
import 'package:inflearn_cf_mise/constant/regions.dart';

typedef OnRegionSelected = void Function(String region);

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onRegionSelected, required this.selectedRegion, required this.darkColor, required this.lightColor});
  final OnRegionSelected onRegionSelected;
  final String selectedRegion;
  final Color darkColor;
  final Color lightColor;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              '지역선택',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ...regions.map((e) => ListTile(  //cascade operator
            title: Text(
              e,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            onTap: () {
              onRegionSelected(e);
            },
            tileColor: Colors.white,
            selectedTileColor: lightColor,
            selectedColor: Colors.black,
            selected: e == selectedRegion,
          )),
        ],
      ),
    );
  }
}
