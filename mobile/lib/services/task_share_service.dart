import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../models/task_item.dart';

class TaskShareService {
  Future<void> shareAssignedTasks({
    required BuildContext context,
    required List<TaskItem> tasks,
    required bool asPdf,
  }) async {
    if (tasks.isEmpty) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('There are no assigned tasks to share.')),
      );
      return;
    }

    try {
      if (asPdf) {
        final pdfPath = await _createPdf(tasks);
        await SharePlus.instance.share(
          ShareParams(
            files: [XFile(pdfPath)],
            subject: 'Assigned Tasks',
            text: 'Assigned tasks for today',
          ),
        );
      } else {
        final message = _buildTextSummary(tasks);
        await SharePlus.instance.share(
          ShareParams(text: message, subject: 'Assigned Tasks'),
        );
      }
    } catch (_) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sharing failed. Please try again in a moment.'),
        ),
      );
    }
  }

  Future<String> _createPdf(List<TaskItem> tasks) async {
    final pdf = pw.Document();
    final timestamp = DateTime.now().toLocal().toString();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Text(
              'Assigned Tasks Summary',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Text('Generated: $timestamp'),
            pw.SizedBox(height: 16),
            ...tasks.asMap().entries.expand((entry) {
              final index = entry.key + 1;
              final task = entry.value;

              return [
                pw.Text(
                  '$index. ${task.task.subject}',
                  style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 4),
                pw.Text('Class: ${task.task.classroom}'),
                pw.Text('Period: ${task.task.period}'),
                pw.Text('Absent Teacher: ${task.absentTeacher.name}'),
                pw.Text('Assigned Teacher: ${task.assignedTeacher?.name ?? 'Pending'}'),
                pw.SizedBox(height: 8),
              ];
            }),
          ];
        },
      ),
    );

    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/assigned_tasks_${DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(await pdf.save());

    return file.path;
  }

  String _buildTextSummary(List<TaskItem> tasks) {
    final buffer = StringBuffer();
    buffer.writeln('Assigned Tasks Summary');
    buffer.writeln('');

    for (final task in tasks) {
      buffer.writeln('Class: ${task.task.classroom}');
      buffer.writeln('Subject: ${task.task.subject}');
      buffer.writeln('Period: ${task.task.period}');
      buffer.writeln('Absent Teacher: ${task.absentTeacher.name}');
      buffer.writeln('Assigned Teacher: ${task.assignedTeacher?.name ?? 'Pending'}');
      buffer.writeln('');
    }

    return buffer.toString();
  }
}
