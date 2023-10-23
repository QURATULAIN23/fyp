import 'package:flutter/material.dart';

Widget popUpMenu()
{
  
  return PopupMenuButton<int>(
    onSelected: (value){print(value);},
    itemBuilder: (BuildContext context)=> <PopupMenuEntry<int>>[
      const PopupMenuItem(
        child: Text('20'),
        value: 20,
      ),
      const PopupMenuItem(
        child: Text('30'),
        value: 30,
      )
    ],
  );
}