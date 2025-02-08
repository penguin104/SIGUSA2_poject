import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Operation SIGUSA APP",
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: 100,
                  height: 100,
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        //TODO:前進の命令
                      },
                      onLongPress: () {
                        // TODO:長押しの処理
                      },
                      child: Icon(
                        size: 40,
                        Icons.north,
                      )),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 100,
                  height: 100,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        //TODO:左回転の命令
                      },
                      onLongPress: () {
                        // TODO:長押しの処理
                      },
                      child: Icon(
                        size: 40,
                        Icons.west,
                      )),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        //TODO:アクションの命令
                      },
                      onLongPress: () {
                        // TODO:長押しの処理
                      },
                      child: Icon(
                        size: 40,
                        Icons.ac_unit_outlined,
                      )),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        //TODO:右回転の命令
                      },
                      onLongPress: () {
                        // TODO:長押しの処理
                      },
                      child: Icon(
                        size: 40,
                        Icons.east,
                      )),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: 100,
                  height: 100,
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        //TODO:後退の命令
                      },
                      onLongPress: () {
                        // TODO:長押しの処理
                      },
                      child: Icon(
                        Icons.south,
                        size: 40,
                      )),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 100,
                  height: 100,
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
      ),
    );
  }
}