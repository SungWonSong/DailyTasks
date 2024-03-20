import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dailytask/firebase/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dailytask/firebase/firebase_user.dart';
import 'package:dailytask/user/view/authenticationScreen.dart';
import 'package:dailytask/user/view/homeScreen.dart';
import 'package:dailytask/common/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// firebase 기본 코드 (필수코드)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('ko_KR', null);
  runApp(MyApp());
}

// * binding : 우리가 어떤 파일을 실행했을때 해당 파일이 자동적으로 특정 애플리케이션과 연결 및 실행됨
//   ensureInitialized : 초기상태 보장, 앱 바인딩 초기화되었는지 확인
//   종류 : WidgetsFlutterBinding( 애플리케이션 UI 렌더링 가능 ) vs ServiceBinding(Flutter 서비에서 대한 바인딩 실시)
// */

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
        home: Consumer<UserProvider>(
          builder: (context, user, child) => user.status == Status.authenticated
              ? homeScreen()
              : authenticationScreen(),
        ),
      ),
    );
  }
}






