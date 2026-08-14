import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_assessment/features/tutor/models/student_result_summary.dart';

class StudentResultCard extends StatelessWidget {
  final StudentResultSummary result;
  final VoidCallback onTap;

  const StudentResultCard({
    super.key,
    required this.result,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final assessmentResult = result.result;

    return Card(
      child: InkWell(
        onTap: result.isGraded ? onTap : null,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22.r,
                    child: Text(result.firstName.substring(0, 1).toUpperCase()),
                  ),

                  SizedBox(width: 12.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result.fullName,
                          style: theme.textTheme.titleSmall,
                        ),

                        SizedBox(height: 3.h),

                        Text(
                          result.studentNumber,
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),

                  _StatusBadge(submitted: result.isGraded),
                ],
              ),

              if (assessmentResult != null) ...[
                SizedBox(height: 16.h),

                const Divider(),

                SizedBox(height: 12.h),

                Row(
                  children: [
                    _ResultStat(
                      label: 'Score',
                      value:
                          '${assessmentResult.score}/${assessmentResult.totalMarks}',
                    ),

                    _ResultStat(
                      label: 'Percentage',
                      value: '${assessmentResult.percentage.round()}%',
                    ),

                    _ResultStat(
                      label: 'Correct',
                      value: '${assessmentResult.correctAnswers}',
                    ),

                    Icon(Icons.chevron_right_rounded, size: 22.sp),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultStat extends StatelessWidget {
  final String label;
  final String value;

  const _ResultStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: theme.textTheme.titleSmall),
          SizedBox(height: 2.h),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool submitted;

  const _StatusBadge({required this.submitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
      child: Text(
        submitted ? 'Submitted' : 'Not submitted',
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
