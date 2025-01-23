import 'dart:convert';

class Album{
  int id;
  int userId;
  String title;

  Album({
    required this.id,required this.title, required this.userId
  });
factory Album.fromMap(Map<String,dynamic> map){
  return Album(
    id: map['id'].toInt()??0,
    userId: map['userId']?.toInt()??0,
    title: map['title']??'',
  );

}

Map<String,dynamic> toMap(){
  return {
    'id':id,
    'userId':userId,
    'title':title,
    
  };
}

String toJson()=> json.encode(toMap());

factory Album.fromJson(String source)=>Album.fromMap(json.decode(source));

}