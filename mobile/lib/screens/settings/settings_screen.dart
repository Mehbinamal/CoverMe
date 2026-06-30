import 'package:flutter/material.dart';

import 'about_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [

          ListTile(
            leading: const Icon(Icons.upload_file),
            title: const Text("Re-import Timetable"),
            subtitle: const Text(
              "Replace the existing timetable with a new CSV",
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Coming in the next update.",
                  ),
                ),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
            title: const Text("Reset Database"),
            subtitle: const Text(
              "Delete all leaves and tasks",
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showResetDialog(context);
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About CoverMe"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AboutScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  static void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Reset Database"),
        content: const Text(
          "This will remove all leaves and generated tasks. Teachers and timetable will be kept.\n\nContinue?",
        ),
        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),

          FilledButton(
            onPressed: () async {

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Reset functionality will be added next.",
                  ),
                ),
              );
            },
            child: const Text("Reset"),
          ),
        ],
      ),
    );
  }
}