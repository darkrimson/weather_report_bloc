import 'package:flutter/material.dart';
import 'package:weather_report_bloc/ui/pages/add_city_page.dart';

import 'widgets.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarWidget({
    super.key,
    required this.title,
  });
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      title: LocationText(text: title),
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddCityPage()));
            })
      ],
    );
  }
}
