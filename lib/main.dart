import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '足し算アプリ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AdditionPage(title: '二つの数値の足し算'),
    );
  }
}

// ----------------------------------------------------
// 状態を持つウィジェット (StatefulWidget)
// ----------------------------------------------------
class AdditionPage extends StatefulWidget {
  const AdditionPage({super.key, required this.title});
  final String title;

  @override
  State<AdditionPage> createState() => _AdditionPageState();
}

// ----------------------------------------------------
// 状態（State）とロジックを管理するクラス
// ----------------------------------------------------
class _AdditionPageState extends State<AdditionPage> {
  // ① テキストフィールドの値を管理するためのコントローラー
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  // ② 合計値を保持する変数
  double _sum = 0.0;

  // ③ テキストフィールドの値が変わったときに合計を計算するメソッド
  void _calculateSum() {
    // 状態を更新するために setState を呼び出す
    setState(() {
      // コントローラーから文字列の値を取得し、double型に変換
      // パース（解析）に失敗した場合は 0.0 を使用
      final double num1 = double.tryParse(_controller1.text) ?? 0.0;
      final double num2 = double.tryParse(_controller2.text) ?? 0.0;

      _sum = num1 + num2;
    });
  }

  // ④ ウィジェットが破棄されるときにコントローラーも破棄
  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // テキストフィールドを横いっぱいに広げる
          children: <Widget>[
            // ⑤ 最初のテキストフィールド
            TextField(
              controller: _controller1,
              keyboardType: const TextInputType.numberWithOptions(decimal: true), // 数値入力キーボードを表示
              decoration: const InputDecoration(
                labelText: '数値 1',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _calculateSum(), // テキストが変更されるたびに計算を実行
            ),
            const SizedBox(height: 16.0),

            // ⑥ 二つ目のテキストフィールド
            TextField(
              controller: _controller2,
              keyboardType: const TextInputType.numberWithOptions(decimal: true), // 数値入力キーボードを表示
              decoration: const InputDecoration(
                labelText: '数値 2',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _calculateSum(), // テキストが変更されるたびに計算を実行
            ),
            const SizedBox(height: 32.0),

            // ⑦ 結果表示
            Text(
              '合計: $_sum',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}