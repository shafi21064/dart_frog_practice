import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:orm/generator_helper.dart';
import 'package:orm/orm.dart';
import 'package:practice/src/generated/prisma_client/client.dart';
import 'package:practice/src/generated/prisma_client/prisma.dart';

Future<Response> onRequest(RequestContext context) async{
  return switch (context.request.method){
  HttpMethod.get => _userList(),
  HttpMethod.post => _createUser(context),
  _ => Future.value(Response(body: 'This is default'))
  };
}

///Get user
Future<Response> _userList() async{

  /// Instance of Prisma clint
  final prisma = PrismaClient(datasources: {
  'db': 'mysql://root:12345678@localhost:3306/mydb?schema=public',
},);

final users = (await prisma.user.findMany()).toList();

return Future.value(Response.json(
  body: users,
),);
}

////Create user
Future<Response> _createUser(RequestContext context) async{
  final json = (await context.request.json()) as Map<String,dynamic>;
  final name = json['name'] as String?;
  final lastName = json['lastName'] as String?; 

  if(name == null || lastName == null){
    return Response.json(
      body: {
        'message' : 'please add name and lastname both',
      },
      statusCode: HttpStatus.badRequest,
    );
  }

/// Instance of Prisma clint
  final prisma = PrismaClient(datasources: {
  'db': 'mysql://root:12345678@localhost:3306/mydb?schema=public',
},);

/// Create user query
final user = await prisma.user.create(
  data: PrismaUnion.$1(UserCreateInput(
    name: name,
    lastName: lastName,
  ),),
);


  return Response.json(body: {
    'message' : 'Saved',
    'user' : user,
  },);
}
