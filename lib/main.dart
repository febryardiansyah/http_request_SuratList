import 'package:flutter/material.dart';
import 'package:http_request2/data_model.dart';
import 'package:http_request2/data_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DataProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeSweet(),
      ),
    );
  }
}
class HomeSweet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Http Request V2'),),
      body: RefreshIndicator(
        onRefresh: ()=>
          Provider.of<DataProvider>(context, listen: false).getData(),
        child: FutureBuilder(
          future: Provider.of<DataProvider>(context, listen: false).getData(),
          builder: (context, x){
            if(x.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<DataProvider>(
              builder: (context,data,_){
                return ListView.builder(
                    itemCount: data.dataModel.length,
                    itemBuilder:(context, i){
                      return Card(
                        child: ListTile(
                          onTap: (){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>SecondRoute(todo: data.dataModel[i],)));
                          },
                          leading: Text(data.dataModel[i].nomor),
                          title: Text(data.dataModel[i].nama),
                          subtitle: Text("Type :\t ${data.dataModel[i].type}"),
                        ),
                      );
                    }
                );
              },
            );
          },
        ),
      )
    );
  }
}
class SecondRoute extends StatelessWidget {
  final DataModel todo;

  const SecondRoute({Key key, @required this.todo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(todo.nama),),
      body: RefreshIndicator(
        onRefresh: ()=> Provider.of<DataProvider>(context,listen: false).getData(),
        color: Colors.red,
        child: FutureBuilder(
          future: Provider.of<DataProvider>(context,listen: false).getData(),
          builder: (context, y){
            if(y.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<DataProvider>(
              builder: (context,data,_){
                return Center(
                  child: Text(todo.keterangan),
                );
              },
            );
          },
        ),
      ),
    );
  }
}



