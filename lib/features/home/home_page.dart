import 'package:flutter/material.dart';
import 'package:reqres/networks/dio/repo/auth_repo.dart';
import 'package:reqres/networks/models/home_details_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<HomeDetailsModel?> fetchData() async {
    final AuthRepo authRepo = AuthRepo();
    final response = await authRepo.homeResponse();

    return response;
  }

  HomeDetailsModel home = HomeDetailsModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
          future: fetchData(), // Specify the future to be awaited.
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("loading"),
              );
            }
            if (snapshot.hasData) {
              final homeDetails = snapshot.data;
              return ListView.builder(
                itemCount: homeDetails?.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final homeData = homeDetails?.data?[index];
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber,
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: ClipOval(
                            child: Image.network(
                              "${homeData?.avatar ?? ''}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "${homeData?.firstName ?? ''}  ${homeData?.lastName ?? ''}"),
                              Text("${homeData?.email ?? ''}"),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              // Handle the case when data is null
              return Center(
                child: Text('No data available'),
              );
            }

            // Handle the case when the data is available.
          }),
    );
  }
}
