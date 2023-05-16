import 'package:flutter/material.dart';
import '../helper/api_helper.dart';
import '../helper/db_helper.dart';
import '../moduls/api_models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quote App",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: DBHelpers.dbHelpers.fetchAllData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error : ${snapshot.hasError}"),
            );
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>>? data = snapshot.data;

            return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          "${data![i]["quoteContent"]}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Divider(
                        indent: 5,
                        endIndent: 5,
                        thickness: 5,
                        color: Colors.greenAccent,
                      ),
                    ],
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add,color: Colors.white,),backgroundColor: Colors.black,
        onPressed: () async {
          Quote? quote = await QuoteAPIHelper.quoteAPIHelper.fetchQuoteData();

          if (quote != null) {
            DBHelpers.dbHelpers.insertData(data: quote);

            setState(() {});
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Data Not found ....."),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
      ),
    );
  }
}