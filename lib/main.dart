import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Навігація у Flutter',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/details': (context) => DetailsScreen(),
        '/final': (context) => FinalScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}

// ----- HomeScreen -----
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Перейти на DetailsScreen (push/pop)'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Введіть текст'),
            ),
            ElevatedButton(
              child: Text('Відправити'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: _controller.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ----- DetailsScreen -----
class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final TextEditingController _detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String? receivedText = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text('DetailsScreen'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (receivedText != null)
              Text('Отриманий текст: $receivedText'),
            ElevatedButton(
              child: Text('Повернутися'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _detailsController,
              decoration: InputDecoration(labelText: 'Введіть додатковий текст'),
            ),
            ElevatedButton(
              child: Text('Далі'),
              onPressed: () {
                final combinedText = [
                  if (receivedText?.isNotEmpty == true) receivedText,
                  if (_detailsController.text.isNotEmpty) _detailsController.text,
                ].join(' + ');

                Navigator.pushNamed(
                  context,
                  '/final',
                  arguments: combinedText.isNotEmpty ? combinedText : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ----- FinalScreen -----
class FinalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String? combinedText = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text('FinalScreen'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          combinedText ?? 'Немає тексту',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// ----- SettingsScreen -----
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          'Тут будуть налаштування',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
