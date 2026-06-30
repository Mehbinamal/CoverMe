import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/leave_provider.dart';
import '../../widgets/leave_card.dart';
import 'add_leave_screen.dart';
import 'package:intl/intl.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LeaveProvider>().loadLeaves(date: DateTime.now(),);
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<LeaveProvider>();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Leaves"),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddLeaveScreen(),
            ),
          );

          provider.loadLeaves(date: provider.selectedDate,);

        },
      ),

      body: Column(
        children: [

          Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              leading: const Icon(
                Icons.calendar_month,
              ),

              title: Text(
                DateFormat(
                  'dd MMM yyyy',
                ).format(
                  provider.selectedDate,
                ),
              ),

              trailing: const Icon(
                Icons.arrow_drop_down,
              ),

              onTap: () async {

                final picked =
                    await showDatePicker(

                  context: context,

                  initialDate:
                      provider.selectedDate,

                  firstDate:
                      DateTime.now(),

                  lastDate:
                      DateTime(2035),

                );

                if (picked != null) {

                  provider.loadLeaves(
                    date: picked,
                  );

                }

              },

            ),
          ),

          Expanded(

            child: provider.leaves.isEmpty

                ? const Center(
                    child: Text(
                      "No leaves for this date.",
                    ),
                  )

                : ListView.builder(

                    itemCount:
                        provider.leaves.length,

                    itemBuilder:
                        (context,index){

                      final item =
                          provider.leaves[index];

                      return LeaveCard(

                        leave: item.leave,

                        teacher: item.teacher,

                        onDelete: () async {

                          await provider.delete(
                            item.leave,
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