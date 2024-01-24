import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple,
                  Colors.red,
                  Colors.orange,
                  Colors.amber,
                  Colors.blue,
                  Colors.green,
                  Colors.lightBlue,
                  Colors.lightGreen,
                  Colors.pink,
                  Colors.teal,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context)
                      .iconTheme
                      .color
                      ?.withRed(255)
                      .withGreen(255)
                      .withBlue(255)
                      .withAlpha(255),
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  'Cooking Up!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home_max,
              size: 30,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Home',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onTap: () => onSelectScreen('home'),
          ),
          ListTile(
            leading: Icon(
              Icons.filter_alt,
              size: 30,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onTap: () => onSelectScreen('filters'),
          ),
        ],
      ),
    );
  }
}
