import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/leave_provider.dart';
import '../../providers/teacher_provider.dart';
import '../../widgets/selectable_teacher_tile.dart';

class AddLeaveScreen extends StatefulWidget {
  const AddLeaveScreen({super.key});

  @override
  State<AddLeaveScreen> createState() =>
      _AddLeaveScreenState();
}

class _AddLeaveScreenState
    extends State<AddLeaveScreen> {

  final TextEditingController reasonController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TeacherProvider>().loadTeachers();
    });
  }

  @override
  Widget build(BuildContext context) {

    final teacherProvider =
        context.watch<TeacherProvider>();

    final leaveProvider =
        context.watch<LeaveProvider>();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Add Leave"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(

              decoration: const InputDecoration(
                hintText: "Search Teacher",
                prefixIcon: Icon(Icons.search),
              ),

              onChanged: teacherProvider.search,

            ),

            const SizedBox(height: 20),

            Expanded(

              child: ListView.builder(

                itemCount:
                    teacherProvider
                        .filteredTeachers
                        .length,

                itemBuilder: (context, index) {

                  final teacher =
                      teacherProvider
                          .filteredTeachers[index];

                  return SelectableTeacherTile(

                    teacher:teacher,
                    selected:
                    leaveProvider.selectedTeacher?.id ==
                    teacher.id,

                    onTap: () {

                      leaveProvider
                          .selectTeacher(teacher);

                    },

                  );

                },

              ),

            ),

            if (leaveProvider.selectedTeacher != null)

              ListTile(

                leading: const Icon(Icons.person),

                title: Text(
                  leaveProvider
                      .selectedTeacher!
                      .name,
                ),

                subtitle:
                    const Text("Selected Teacher"),

              ),

            ListTile(

              leading:
                  const Icon(Icons.calendar_today),

              title: Text(

                "${leaveProvider.selectedDate.day}/"
                "${leaveProvider.selectedDate.month}/"
                "${leaveProvider.selectedDate.year}",

              ),

              trailing: IconButton(

                icon: const Icon(Icons.edit_calendar),

                onPressed: () async {

                  final date =
                      await showDatePicker(

                    context: context,

                    initialDate:
                        leaveProvider.selectedDate,

                    firstDate:
                        DateTime.now(),

                    lastDate:
                        DateTime(2035),

                  );

                  if (date != null) {

                    leaveProvider.setDate(date);

                  }

                },

              ),

            ),

            TextField(

              controller: reasonController,

              decoration: const InputDecoration(
                labelText: "Reason",
              ),

              onChanged:
                  leaveProvider.setReason,

            ),

            const SizedBox(height: 20),

            SizedBox(

              width: double.infinity,

              child: FilledButton(

                onPressed:
                    leaveProvider.isSaving
                        ? null
                        : () async {

                            final success =
                                await leaveProvider
                                    .saveLeave();

                            if (!context.mounted) return;

                            if (success) {

                              ScaffoldMessenger.of(
                                      context)
                                  .showSnackBar(

                                const SnackBar(
                                  content: Text(
                                    "Leave Added",
                                  ),
                                ),

                              );

                              Navigator.pop(
                                  context);

                            } else {

                              ScaffoldMessenger.of(
                                      context)
                                  .showSnackBar(

                                const SnackBar(
                                  content: Text(
                                    "Unable to add leave",
                                  ),
                                ),

                              );

                            }

                          },

                child: leaveProvider.isSaving

                    ? const CircularProgressIndicator()

                    : const Text("SAVE LEAVE"),

              ),

            )

          ],

        ),

      ),

    );
  }
}