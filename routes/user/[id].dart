import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  
  return switch(context.request.method){
    HttpMethod.put => _updateUserInfo(id, context),
    HttpMethod.delete => _deleteUserInfo(id),
    _ => Future.value(Response.json(body: {'This is a default response'})),
  };
}

Future<Response> _updateUserInfo(String id, RequestContext context) async{
  return Future.value(Response.json(
    body: {
      'message' : 'User info in updated for id: $id',
    },
  ),);
}

Future<Response> _deleteUserInfo(String id) async{
  return Future.value(Response.json(
    body: {
      'message' : 'User is deleted for id: $id',
    },
  ),);
}
