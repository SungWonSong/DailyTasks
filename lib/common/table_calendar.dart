import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:dailytask/firebase/firebase_user.dart';

// StatefulWidget을 선언합니다.
class tableCalendarScreen extends StatefulWidget {
  const tableCalendarScreen({Key? key}) : super(key: key);

  @override
  _tableCalendarScreenState createState() => _tableCalendarScreenState();
}

// 상태 관리 클래스를 생성합니다.
class _tableCalendarScreenState extends State<tableCalendarScreen> {
  // focusedDay를 위한 상태 변수를 선언합니다.
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    // print('current user: ${userProvider.user?.email}');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${userProvider.user?.email}',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          ElevatedButton.icon(
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              onPressed: () async {
                await userProvider.signOut();
              })
        ],
      ),
      body: TableCalendar(
        locale: 'ko_KR',
        firstDay: DateTime.utc(1980, 1, 16),
        lastDay: DateTime.utc(2050, 3, 14),
        focusedDay: _focusedDay,
        // 상태 변수를 사용합니다.
        // 선택된 날짜나 사용자의 상호작용에 따라 변경될 수 있는 다른 속성들도 관리할 수 있습니다.
        // 예를 들어, onDaySelected 콜백을 사용하여 사용자가 날짜를 선택했을 때의 동작을 정의할 수 있습니다.
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            // 사용자가 새로운 날짜를 선택할 때마다 상태를 업데이트합니다.
            _focusedDay = focusedDay;
          });
        },
      ),
    );
  }
}