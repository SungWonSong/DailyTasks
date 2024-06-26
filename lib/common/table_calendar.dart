import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:dailytask/firebase/firebase_user.dart';
import 'package:dailytask/firebase/firebase_firestore.dart';
import 'package:dailytask/common/daily_todo.dart';

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
  DateTime _selectedDay = DateTime.now();
  DateTime? selectedDate;
  List<DailyTodo> todos = [];

  Future<void> onAddOrUpdateTap({required String? email}) async {
    TextEditingController taskController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('추가하기'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            // MainAxisSize.min => 해당 축의 크기를 자식들이 차지하는 공간에 맞추도록 한다
            children: [
              TextField(
                controller: taskController,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () async {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100)
                );
                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
                child: Text('날짜 선택하기'),
              ),
              if (selectedDate != null)
                Text('선택된 날짜: ${selectedDate.toString().split(' ')[0]}'),
            ],
          ),
          actions: [
            TextButton(onPressed: () =>
                Navigator.of(context).pop()
              , child: Text("Cancel"),),
            TextButton(onPressed: () async {
              if (selectedDate != null) {
                DailyTodo newTodo = DailyTodo(
                  id: '',
                  task: taskController.text,
                  date: selectedDate!,
                  email: email!,
                );
                newTodo = await DataInFireStore.addEntryWithAutogeneratedId(
                    "mydata", newTodo);
                setState(() {
                  todos.add(newTodo);
                });
                Navigator.of(context).pop();
              } else {
                print("날짜를 선택해주세요.");
              }
            },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

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
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
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
        focusedDay: _focusedDay,
        firstDay: DateTime.utc(1980, 1, 16),
        lastDay: DateTime.utc(2050, 3, 14),
        selectedDayPredicate: (DateTime day) {
          return isSameDay(_selectedDay, day);
        },
        // 상태 변수를 사용합니다.
        // 선택된 날짜나 사용자의 상호작용에 따라 변경될 수 있는 다른 속성들도 관리할 수 있습니다.
        // 예를 들어, onDaySelected 콜백을 사용하여 사용자가 날짜를 선택했을 때의 동작을 정의할 수 있습니다.
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            // 사용자가 새로운 날짜를 선택할 때마다 상태를 업데이트합니다.
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            onAddOrUpdateTap(email: userProvider.user?.email ?? ''),
      ),
    );
  }
}

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

