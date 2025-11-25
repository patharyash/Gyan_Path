import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GreetingHeaderWidget extends StatelessWidget {
  const GreetingHeaderWidget({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${months[now.month - 1]} ${now.day}, ${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getGreeting(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                        ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    _getFormattedDate(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
              // Stack(
              //   alignment: Alignment.center,
              //   children: [
              //     CircleAvatar(
              //       radius: 7.w,
              //       backgroundColor:
              //           AppTheme.lightTheme.colorScheme.primaryContainer.withOpacity(0.3),
              //     ),
              //     CircleAvatar(
              //       radius: 5.w,
              //       backgroundColor:
              //           AppTheme.lightTheme.colorScheme.primaryContainer.withOpacity(0.6),
              //     ),
              //     CircleAvatar(
              //       radius: 4.w,
              //       backgroundColor: AppTheme.lightTheme.colorScheme.primaryContainer,
              //       child: IconButton(
              //         onPressed: () {
              //           showDialog(
              //             context: context,
              //             builder: (BuildContext context) {
              //               return AlertDialog(
              //                 title: Text('Logout'),
              //                 content: Text('Are you sure you want to logout?'),
              //                 actions: <Widget>[
              //                   TextButton(
              //                     child: Text('Cancel'),
              //                     onPressed: () {
              //                       Navigator.of(context).pop();
              //                     },
              //                   ),
              //                   TextButton(
              //                     child: Text('Logout'),
              //                     onPressed: () {
              //                       Navigator.of(context).pop(); // Dismiss the dialog
              //                       Navigator.pushReplacement(
              //                         context,
              //                         MaterialPageRoute(builder: (context) => Login()),
              //                       );
              //                     },
              //                   ),
              //                 ],
              //               );
              //             },
              //           );
              //         },
              //         icon: Icon(
              //           Icons.logout,
              //           size: 5.w,
              //           color: Colors.white,
              //         ),
              //         tooltip: 'Logout',
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
          SizedBox(height: 0.5.h),
          Divider(),
        ],
      ),
    );
  }
}
