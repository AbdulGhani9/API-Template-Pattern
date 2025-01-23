import 'dart:convert';

import 'package:apitemplate/model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class ApiService{
  final BASE_URl= "https://jsonplaceholder.typicode.com/";
  String get API_URL;
  String get url => BASE_URl+API_URL;


fetch({String endPoint =""}) async{
  var uri= Uri.parse(url+endPoint);
  var response= await get(uri);
  if(response.isSuccess){
    return jsonDecode(response.body);
  }else{
    throw Exception('Failed to fetch data ${response.statusCode} - ${response.body}');
  }
}
}
class AlbumApiService extends ApiService{
  @override
  // TODO: implement API_URL
  String get API_URL => '/albums';
  Future<List<Album>> getALbums() async{
    final List albums= await fetch();
    return albums.map((map)=> Album.fromMap(map)).toList();
  }

  Future<Album> getAlbums() async{
    var albums= await fetch();
    return Album.fromMap(albums.first);
  }
  
}

extension StatusCodes on Response{
  bool get isSuccess => statusCode >=200 && statusCode<300;
}