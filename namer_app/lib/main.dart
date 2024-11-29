import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}
//

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //상태관리를 위해서 쓰는 .. ()
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 92, 154, 211)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
    print('favorites : ${favorites.length}');
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    //appbars
    return Scaffold(
      // 위젯 하나의 화면을 구성하는 기본 골격을 만들어줌 ..웹바
      body: Center(
        child: Column(
          //세로로 쌓은 용도의 위젯
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text('A random idea!!!!!!!!:'),
            BigCard(pair: pair),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  //잉크웰 리팩트
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                  // icon: Icon(Icons.favorite),
                  icon: Icon(Icons.apple_outlined),
                  label: Text('LIKE!'),
                ),
                OutlinedButton(
                  //잉크웰 리팩트
                  onPressed: () {
                    appState.getNext();
                    //print('button pressed!');
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ], //배열
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20), //fromLTRB
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}

//레이아웃을 p잡아주는 위젯 (컬럼 등등...-세로로 쌓아줌 )
//화면에 보여지는
