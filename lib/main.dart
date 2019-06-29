import 'package:flutter/material.dart';
import 'models.dart';
import 'package:ui_challenge/task_row.dart';
import 'animated_list.dart';
import 'animated_fab.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final double _imageHeight = 300.0;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel listModel;
  bool showOnlyCompleted = false;

  @override
  void initState() {
    super.initState();

    listModel = ListModel(_listKey, tasks);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildTimeline(),
          _buildImage(width),
          _buildTopHeader(),
          _buildProfileRow(),
          _buildBottomPart(),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _buildImage(width) {
    return ClipPath(
      clipper: DialogonalClipper(),
      child: Image.asset(
        'images/birds.jpg',
        fit: BoxFit.cover,
        width: width,
        height: _imageHeight,
        colorBlendMode: BlendMode.srcOver,
        color: Color.fromARGB(120, 20, 10, 40),
      ),
    );
  }

  Widget _buildTopHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.menu, size: 32, color: Colors.white),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text("Timeline",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  )),
            ),
          ),
          Icon(Icons.linear_scale, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildProfileRow() {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: _imageHeight / 2.5),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            minRadius: 28,
            maxRadius: 28,
            backgroundImage: AssetImage('images/avatar.jpg'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Ryan Barnes",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "Product designer",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.85),
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: _imageHeight),
        _buildMyTasksHeader(),
        _buildTasksList(),
      ],
    );
  }

  Widget _buildMyTasksHeader() {
    return Padding(
      padding: EdgeInsets.only(left: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('My Tasks', style: TextStyle(fontSize: 34)),
          Text('FEBRUARY 8, 2015',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    return Expanded(
      child: AnimatedList(
        initialItemCount: tasks.length,
        key: _listKey,
        itemBuilder: (context, index, animation) {
          return TaskRow(
            task: listModel[index],
            animation: animation,
          );
        },
      ),
    );
  }

  Widget _buildTimeline() {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 32,
      child: Container(
        width: 1.0,
        color: Colors.grey[100],
      ),
    );
  }

  Widget _buildFab() {
    return Positioned(
      top: _imageHeight - 100,
      right: -40,
      child: AnimatedFab(
        onClick: _changeFilterState,
      ),
    );
  }

  void _changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;

    tasks.where((task) => !task.completed).forEach((task) {
      if (showOnlyCompleted) {
        listModel.removeAt(listModel.indexOf(task));
      } else {
        listModel.insert(tasks.indexOf(task), task);
      }
    });
  }
}

class DialogonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 60.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
