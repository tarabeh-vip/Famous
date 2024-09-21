import 'package:flutter/material.dart';
import '../service/api_service.dart';
import 'details_screen.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade200,
      appBar: AppBar(title: Text('Famous Persons'),backgroundColor: Colors.indigo.shade200,),
      body: FutureBuilder<List<dynamic>>(
        future: ApiService().fetchFamousPersons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final famousPersons = snapshot.data!;
            return ListView.builder(
              itemCount: famousPersons.length,
              itemBuilder: (context, index) {
                final person = famousPersons[index];
                return Card(
                  color: Colors.indigo,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        person['name'] ?? 'Unknown',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(id: person['id'].toString()),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
