import 'package:grpc/grpc.dart';
import 'dart:collection';
import 'package:uuid/uuid.dart';
import 'package:synchronized/synchronized.dart';

import 'package:qiita_2020_server/src/generated/user.pb.dart';
import 'package:qiita_2020_server/src/generated/user.pbgrpc.dart';
import 'package:qiita_2020_server/src/generated/google/protobuf/empty.pb.dart';

final users = Set<String>();
final sessions = HashMap<String, LoginData>();
final points = HashMap<String, int>();

class AccountService extends AccountServiceBase {
  @override
  Future<LoginData> createAccount(ServiceCall call, Empty request) async {
    final userData = LoginData()..userId = Uuid().v4();
    if (users.contains(userData.userId)) {
      print('Login failed: ${userData.userId}');
      return createAccount(call, request);
    }
    points[userData.userId] = 0;
    return userData;
  }

  @override
  Future<SessionData> login(ServiceCall call, LoginData loginData) async {
    print('Login Request: ${loginData.userId}');

    if (!users.contains(loginData.userId)) {
      print('Login failed: ${loginData.userId}');
      return null;
    }

    final sessionId = Uuid().v4();
    await Lock().synchronized(() async {
      sessions[sessionId] = loginData;
    });
    print('Login succeeded: ${loginData.userId}');
    return SessionData()..sessionId = sessionId;
  }

  @override
  Future<SessionData> update(ServiceCall call, UpdateData updateData) async {
    print('Update Request: ${updateData.sessionId} ${updateData.point}');

    if (!sessions.containsKey(updateData.sessionId)) {
      print('Update failed: ${updateData.sessionId}');
      return null;
    }

    final sessionId = Uuid().v4();
    await Lock().synchronized(() async {
      final loginData = sessions.remove(updateData.sessionId);
      points[loginData.userId] += updateData.point;
      sessions[sessionId] = loginData;
      print('Update succeeded: ${loginData.userId}');
    });
    return SessionData()..sessionId = sessionId;
  }
}

Future<void> main() async {
  final server = Server([AccountService()]);
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');
}
