import 'package:flutter/material.dart';
import 'package:flutter_post_desktop_app/calculate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController myController = TextEditingController();
  List<PostsList> allPosts = [];
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  _postCreator(value, index, allPostsList) {
    // State refresher
    setState(() {
      // checks if text field has any text
      // if yes it returns the value
      //else it just ignores it
      if (value.length > 0) {
        PostsList post = PostsList(index, value, 0);
        allPosts.add(post);
        myController.clear();
      } else {
        return;
      }
    });
  }

//like incrementor
  likesFunction(likes, index) {
    //state refresher
    setState(() {
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // This method is rerun every time setState is called, for instance as done
    // by the _postCreator method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Post Comment',
              style: TextStyle(fontSize: 50, fontFamily: 'san-sarif'),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(200, 50, 200, 50),
                child: TextField(
                  maxLines: 3,
                  controller: myController,
                )),
            //Floating button that adds the post.
            FloatingActionButton(
              onPressed: (() =>
                  _postCreator(myController.text, allPosts.length, allPosts)),
              backgroundColor: Colors.blue,
              tooltip: 'Add Post',
              child: const Icon(Icons.post_add_sharp),
            ),
            Expanded(
              child: postsModel(
                allPosts,
                _postCreator,
                likesFunction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget postsModel(postArray, postAddFunction, likesFunction) {
  var post = postArray;
  //var postAdd = postAddFunction;
  var likesCall = likesFunction;
  int likeConter = postArray;
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: post.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(2),
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Expanded(
              child: Row(children: [
                Text(post[index][index]),
                IconButton(
                  icon: const Icon(Icons.add_alarm),
                  onPressed: () {
                    likesCall[index][index + 1];
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('$likeConter'),
                  ),
                ),
              ]),
            ),
          ),
        ),
      );
    },
  );
}
