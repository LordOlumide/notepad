import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<DummyData> data = const [
    DummyData(),
    DummyData(),
    DummyData(),
    DummyData(),
    DummyData(),
    DummyData(),
    DummyData(),
    DummyData(),
    DummyData(),
    DummyData(),
  ];

  final int noOfInitiallyVisible = 3;

  late bool seeMoreButtonIsVisible;
  late int noOfItemsDisplayed;

  @override
  void initState() {
    super.initState();
    seeMoreButtonIsVisible = data.length >= noOfInitiallyVisible ? true : false;
    noOfItemsDisplayed = data.length >= noOfInitiallyVisible
        ? noOfInitiallyVisible
        : data.length;
  }

  increaseNoOfVisible() {
    setState(() {
      noOfItemsDisplayed = data.length >= noOfItemsDisplayed + 3
          ? noOfItemsDisplayed + 3
          : data.length;
    });
    print(noOfItemsDisplayed);
  }

  adjustSeeMoreVisibility() {
    setState(() {
      seeMoreButtonIsVisible = noOfItemsDisplayed == data.length ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              for (int i = 0; i < noOfItemsDisplayed; i++)
                ListTile(
                  title: Text('$i: ${data[i].name}'),
                  subtitle: Text(data[i].message),
                ),
              seeMoreButtonIsVisible
                  ? TextButton(
                      onPressed: () {
                        increaseNoOfVisible();
                        adjustSeeMoreVisibility();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'See more',
                            style: TextStyle(color: Colors.blue),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}

class DummyData {
  final String name;
  final String message;

  const DummyData({
    this.name = 'King Kong',
    this.message = 'I will beat up Godzilla',
  });
}
