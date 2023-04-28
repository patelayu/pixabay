import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/apihelpers.dart';
import '../model/models.dart';
import 'global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pixabay Lite ",style: TextStyle(color: Colors.black)),

        backgroundColor: Color(0xffB1907F),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CupertinoSearchTextField(
                  controller: searchController,
                  onSubmitted: (val) {
                    setState(() {
                      Global.search = val;
                    });
                  },
                  placeholder: "Search",
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(10),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Photos",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: FutureBuilder(
                future: ApiHelpers.apiHelpers.fetchPixaBayData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error is : ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    List<Provider>? data = snapshot.data;
                    return (data != null)
                        ? GridView.builder(
                        itemCount: data.length,
                        padding: const EdgeInsets.all(10),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 200,
                        ),
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                "SecondPage",
                                arguments: data[i].image,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    data[i].image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        })
                        : const Center(
                      child: Text("No Any data found..."),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xff483C32),
    );
  }
}