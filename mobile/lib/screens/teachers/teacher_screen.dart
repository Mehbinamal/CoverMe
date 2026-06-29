import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/teacher_provider.dart';
import '../../widgets/teacher_card.dart';
import 'teacher_details_screen.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() =>
      _TeacherScreenState();
}

class _TeacherScreenState
    extends State<TeacherScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      context
          .read<TeacherProvider>()
          .loadTeachers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<TeacherProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Teachers"),
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search teacher...",
                prefixIcon:
                    Icon(Icons.search),
              ),
              onChanged: provider.search,
            ),
          ),

          Expanded(
            child: provider.isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount:
                        provider.filteredTeachers
                            .length,
                    itemBuilder:
                        (context, index) {
                      final teacher =
                          provider
                                  .filteredTeachers[
                              index];

                      return TeacherCard(
                        teacher: teacher,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  TeacherDetailsScreen(
                                teacher:
                                    teacher,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}