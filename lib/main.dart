import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Combined Animated Widgets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CombinedWidgets(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CombinedWidgets extends StatefulWidget {
  const CombinedWidgets({Key? key}) : super(key: key);

  @override
  State<CombinedWidgets> createState() => _CombinedWidgetsState();
}

class _CombinedWidgetsState extends State<CombinedWidgets>
    with TickerProviderStateMixin {
  // State and methods for Widget 12: AnimatedIcon
  bool _isPlay = false;
  late AnimationController _animatedIconController;

  // State and methods for Widget 13: AnimatedList
  final List<String> _animatedListItems = [];
  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();

  void _addAnimatedListItem() {
    _animatedListItems.insert(0, "Item ${_animatedListItems.length + 1}");
    _animatedListKey.currentState!.insertItem(
      0,
      duration: const Duration(seconds: 1),
    );
  }

  void _removeAnimatedListItem(int index) {
    _animatedListKey.currentState!.removeItem(
      index,
      (_, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: const Card(
            margin: EdgeInsets.all(10),
            color: Colors.red,
            child: ListTile(
              title: Text(
                "Deleted",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 300),
    );
    _animatedListItems.removeAt(index);
  }

  Widget _buildAnimatedListItem(
      BuildContext context, int index, Animation<double> animation) {
    return SizeTransition(
      key: UniqueKey(),
      sizeFactor: animation,
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.orangeAccent,
        child: ListTile(
          title: Text(
            _animatedListItems[index],
            style: const TextStyle(fontSize: 24),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _removeAnimatedListItem(index);
            },
          ),
        ),
      ),
    );
  }

  // State and methods for Widget 14: AnimatedModalBarrier
  bool _isPressed = false;
  late Widget _animatedModalBarrier;
  late AnimationController _modalBarrierAnimationController;
  late Animation<Color?> _modalBarrierColorAnimation;

  // State and methods for Widget 15: AnimatedOpacity
  double _opacityLevel = 1.0;

  // State and methods for Widget 16: AnimatedPadding
  double _padValue = 0.0;

  // State and methods for Widget 17: AnimatedPhysicalModel
  bool _isFlat = true;

  // State and methods for Widget 18: AnimatedPositioned
  bool _isSelected = false;

  // State and methods for Widget 19: AnimatedRotation
  double _turns = 0.0;

  // State and methods for Widget 20: AnimatedSize
  double _logoSize = 100;

  // State and methods for Widget 21: AnimatedSwitcher
  int _count = 0;

  @override
  void initState() {
    super.initState();

    // Initialization for Widget 12: AnimatedIcon
    _animatedIconController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Initialization for Widget 14: AnimatedModalBarrier
    ColorTween _colorTween = ColorTween(
      begin: Colors.orangeAccent.withOpacity(0.5),
      end: Colors.blueGrey.withOpacity(0.5),
    );

    _modalBarrierAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _modalBarrierColorAnimation =
        _colorTween.animate(_modalBarrierAnimationController);

    _animatedModalBarrier = AnimatedModalBarrier(
      color: _modalBarrierColorAnimation,
      dismissible: true,
    );
  }

  @override
  void dispose() {
    _animatedIconController.dispose();
    _modalBarrierAnimationController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlay == false) {
        _animatedIconController.forward();
        _isPlay = true;
      } else {
        _animatedIconController.reverse();
        _isPlay = false;
      }
    });
  }

  void _showAnimatedModalBarrier() {
    setState(() {
      _isPressed = true;
    });
    _modalBarrierAnimationController.reset();
    _modalBarrierAnimationController.forward();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isPressed = false;
      });
    });
  }

  void _fadeLogo() {
    setState(() => _opacityLevel = _opacityLevel == 0 ? 1.0 : 0.0);
  }

  void _changePadding() {
    setState(() {
      _padValue = _padValue == 0.0 ? 100.0 : 0.0;
    });
  }

  void _toggleElevation() {
    setState(() {
      _isFlat = !_isFlat;
    });
  }

  void _togglePosition() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  void _rotateLogo() {
    setState(() => _turns += 1 / 4);
  }

  void _toggleLogoSize() {
    setState(() {
      _logoSize = _logoSize == 100 ? 300 : 100;
    });
  }

  void _incrementCount() {
    setState(() {
      _count += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Combined Animated Widgets'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Widget 12: AnimatedIcon Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _togglePlayPause,
              child: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: _animatedIconController,
                size: 100,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Widget 13: AnimatedList Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: AnimatedList(
                // Removed the <String> type argument
                key: _animatedListKey,
                initialItemCount: _animatedListItems.length,
                itemBuilder: _buildAnimatedListItem,
              ),
            ),
            ElevatedButton(
              onPressed: _addAnimatedListItem,
              child: const Text('Add Item'),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Widget 14: AnimatedModalBarrier Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100.0,
              width: 250.0,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                    ),
                    child: const Text('Widget 14: Press'),
                    onPressed: _showAnimatedModalBarrier,
                  ),
                  if (_isPressed) _animatedModalBarrier,
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Widget 15: AnimatedOpacity Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AnimatedOpacity(
                    opacity: _opacityLevel,
                    duration: const Duration(seconds: 2),
                    child: const FlutterLogo(
                      size: 50,
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Widget 15: Fade Logo'),
                    onPressed: () {
                      setState(
                        () => _opacityLevel = _opacityLevel == 0 ? 1.0 : 0.0,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Widget 16: AnimatedPadding Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                  ),
                  child: const Text('Widget 16: Change padding'),
                  onPressed: () {
                    setState(() {
                      _padValue = _padValue == 0.0 ? 100.0 : 0.0;
                    });
                  },
                ),
                Text('Padding = $_padValue'),
                AnimatedPadding(
                  padding: EdgeInsets.all(_padValue),
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeInOut,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    color: Colors.orangeAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Widget 17: AnimatedPhysicalModel Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AnimatedPhysicalModel(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    elevation: _isFlat ? 0 : 6.0,
                    shape: BoxShape.rectangle,
                    shadowColor: Colors.black,
                    color: Colors.white,
                    child: const SizedBox(
                      height: 120.0,
                      width: 120.0,
                      child: Icon(Icons.android_outlined),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Widget 17: Click'),
                    onPressed: () {
                      setState(() {
                        _isFlat = !_isFlat;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Widget 18: AnimatedPositioned Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              height: 350, // Adjusted height to match the provided code
              child: Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    width: _isSelected ? 200.0 : 50.0,
                    height: _isSelected ? 50.0 : 200.0,
                    top: _isSelected ? 50.0 : 150.0,
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSelected = !_isSelected;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Widget 19: AnimatedRotation Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: AnimatedRotation(
                      turns: _turns,
                      duration: const Duration(seconds: 1),
                      child: const FlutterLogo(
                        size: 100,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Widget 19: Rotate Logo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                    ),
                    onPressed: () {
                      setState(() => _turns += 1 / 4);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Widget 20: AnimatedSize Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  _logoSize = _logoSize == 300 ? 100 : 300;
                });
              },
              child: Container(
                color: Colors.white,
                child: AnimatedSize(
                  curve: Curves.easeIn,
                  duration: const Duration(seconds: 1),
                  child: FlutterLogo(size: _logoSize),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Widget 21: AnimatedSwitcher Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      '$_count',
                      style: const TextStyle(fontSize: 40),
                      key: ValueKey(_count),
                    ),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Widget 21: Add'),
                    onPressed: () {
                      setState(() {
                        _count += 1;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
