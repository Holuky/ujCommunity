import 'package:flutter/material.dart';

// 파이어베이스
import 'package:firebase_core/firebase_core.dart';
import 'package:unjeong/Chat/chatClass.dart';
import 'External/firebase_options.dart';

// 채팅방
import 'package:unjeong/Chat/chatRoom.dart';
import 'package:unjeong/Chat/ChatRoomList.dart';

// 게시물
import 'Board/SalesBoard.dart';
import 'Board/CreateBoard.dart';

// 로그인 관련
import 'Authentication/LoginPage.dart';
import 'Authentication/SignUpPage.dart';
import 'Profile/MainProfilePage.dart';

// 프로바이더
import 'package:provider/provider.dart';
import 'Providers/PageProvider.dart';

// 메인 화면
import 'MainPage/MainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // options: DefaultFirebaseOptions.currentPlatform
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'UJHS',
          home: MyHomeWidget(),
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey.shade50,
            primaryColor: Colors.blue,
            fontFamily: 'NotoSansKR',

          )
      ),
    );
  }
}


//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////


class MyHomeWidget extends StatefulWidget {
  const MyHomeWidget({super.key});

  @override
  State<MyHomeWidget> createState() => _MyHomeWidgetState();
}

class _MyHomeWidgetState extends State<MyHomeWidget> with SingleTickerProviderStateMixin {

  final _pages = [
    MainPage(),
    ChatRoomList(),
    salesBoard(),
    Placeholder(),
    LoginPage(),
  ];

  final _navigatorKeyList = List.generate(5, (index) => GlobalKey<NavigatorState>());
  late double mWidth;

  @override
  Widget build(BuildContext context) {
    PageProvider _selectedPageProvider = Provider.of<PageProvider>(context);
    int currentIdx = 0;

    // get
    TabBar _tabBar() {
      return TabBar(
        isScrollable: false,
        indicatorPadding: const EdgeInsets.only(bottom: 74),
        dividerColor: Colors.blue,
        automaticIndicatorColorAdjustment: true,
        onTap: (index) =>
            () {
          //_selectedPageProvider.setPageIdx(index);
        },


        tabs: [
          Tab(
              icon: Icon(Icons.home,
              color: Colors.lightBlueAccent.shade200,),
              text: 'Home',
          ),

          Tab(
              icon: Icon(Icons.chat,
                color: Colors.lightBlueAccent.shade200,),
              text: 'Chat'
          ),

          Tab(
            icon: Icon(Icons.add,
              color: Colors.lightBlueAccent.shade200,),
            text: 'Create',
          ),

          Tab(
              icon: Icon(Icons.search,
                color: Colors.lightBlueAccent.shade200,),
              text: 'serch'
          ),

          Tab(
            icon: Icon(Icons.person,
              color: Colors.lightBlueAccent.shade200,),
            text: 'profile',
          ),

        ],
      );
    }

    return WillPopScope(
      onWillPop: null,
      child: DefaultTabController(
        animationDuration: Duration.zero,
        length: 5,
        child: Scaffold(
          body: TabBarView(
            children: _pages.map(
                  (page) {
                    currentIdx = _pages.indexOf(page);
                return CustomNavigator(
                  page: page,
                  navigatorKey: _navigatorKeyList[currentIdx],
                );
              },
            ).toList(),
          ),
          bottomNavigationBar: PreferredSize(
              preferredSize: _tabBar().preferredSize,
              child: ColoredBox(
                color: Colors.white,
                child: _tabBar(),
              )
          ),
        ),
      ),
    );
  }


  // 참고 : https://thuthi.tistory.com/entry/Flutter-BottomNavigationBar-%EC%9C%A0%EC%A7%80%ED%95%98%EB%8A%94-%EB%B0%A9%EB%B2%95-%EC%B4%9D-%EC%A0%95%EB%A6%AC

  /*
appBar: AppBar(
                title: Text("제목없음"),
                centerTitle: true,
                elevation: 0.0,
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.bar_chart)
                  )
                ]
              ),
                drawer: Drawer(
                  child: ListView(
                    children: [

                    ]
                  )
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.end, // 아래부터 위로 정렬

                  children: [
                    Expanded(
                        child: Container(
                          color: Colors.white,
                          child: page,
                        )
                    ),

                    SafeArea(child : BottomNavigationBar(

                      type: BottomNavigationBarType.fixed, // 배경 색 변경을 위한 네비게이션 바 설정
                      backgroundColor: Colors.lightGreen,
                      selectedItemColor: Colors.black,
                      unselectedItemColor: Colors.white,

                      items: [
                        setBottomNavigationBarItem('Home', Icon(Icons.home)),
                        setBottomNavigationBarItem('Chat', Icon(Icons.chat)),
                        setBottomNavigationBarItem('Create', Icon(Icons.add)),
                        setBottomNavigationBarItem('Search', Icon(Icons.search)),
                        setBottomNavigationBarItem('Profile', Icon(Icons.person)),
                      ], // 선택한 아이콘의 인덱스로 지정한다.
                      onTap: (index) {
                          _selectedPageProvider.setPageIdx(index);
                      },
                      currentIndex: _selectedPageProvider.pageIdx,
                    ),
                  )

                ],
              ),
            );

*/


  BottomNavigationBarItem setBottomNavigationBarItem(String label, Icon icon)
  {
    return BottomNavigationBarItem(
        label: label,
        icon: icon
    );
  }
}

class CustomNavigator extends StatefulWidget {
  final Widget page;
  final Key navigatorKey;
  const CustomNavigator({Key? key, required this.page, required this.navigatorKey}) : super(key: key);

  @override
  State<CustomNavigator> createState() => _CustomNavigatorState();
}

class _CustomNavigatorState extends State<CustomNavigator> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (_) => MaterialPageRoute(builder: (context) => widget.page),
    );
  }
}
