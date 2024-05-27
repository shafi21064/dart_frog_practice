import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async{
  return switch (context.request.method){
  HttpMethod.get => _userList(),
  HttpMethod.post => _createUser(context),
  _ => Future.value(Response(body: 'This is default'))
  };
}


Future<Response> _userList(){
return Future.value(Response.json(
  body: [
    {'name' : 'shadikul', 'lastName' : 'shafi'},
    {'name' : 'najmul', 'lastName' : 'hauda'},
    {'name' : 'sohan', 'lastName' : 'rahman'},
  ],
),);
}

Future<Response> _createUser(RequestContext context) async{
  final json = (await context.request.json()) as Map<String,dynamic>;
  final name = json['name'];
  final lastName = json['lastName'];
  return Response.json(body: {
    'message' : 'Saved',
    'user' : {
      'name' : name,
      'lastName' : lastName,
    },
  },);
}
