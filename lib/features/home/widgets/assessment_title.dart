import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_assessment/app/theme/app_text_styles.dart';

class AssessmentTitle extends StatelessWidget {
  final String title;
  const AssessmentTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.title.copyWith(fontSize: 18.sp)),
        Spacer(),
        InkWell(onTap: () {}, child: Text('View all')),
      ],
    );
  }
}
