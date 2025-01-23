import 'package:apitemplate/Apiservice.dart';
import 'package:apitemplate/model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
 
  
  

  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   Future <List<Album>>? future;
   AlbumApiService albumApiService=AlbumApiService();
   void method(){
    setState(() {
      future=albumApiService.getALbums();
    });
   }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(future: future, builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.none) {
            return Text("Click Button to load albums");
          }

         else  if (snapshot.connectionState==ConnectionState.waiting|| snapshot.connectionState==ConnectionState.active) {
            return const CircularProgressIndicator();
          }else{
            if (snapshot.hasError) {
              print("error");
              return Text("Error ${snapshot.error}");
            }else{
              return ListView.builder(  itemCount: snapshot.data?.length??0,itemBuilder: (context, index) {
                final album= snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(child: Text(album.id.toString()),
                ),
                title: Text(album.title),
                trailing: Text(album.userId.toString()),
                );
              },);

            }
          }
        },),
      ),
      floatingActionButton: FloatingActionButton(onPressed: method, tooltip: 'Fetch Albums', child: const Icon(Icons.add),),
    );
  }
}
