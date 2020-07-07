import 'package:grpc/grpc.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';
import 'package:synchronized/synchronized.dart';

import 'package:qiita_2020_server/src/generated/user.pb.dart';
import 'package:qiita_2020_server/src/generated/user.pbgrpc.dart';
import 'package:qiita_2020_server/src/generated/google/protobuf/empty.pb.dart';

class Hoge {
  String userId;
  DateTime expireTime;
}

final users = Set<String>();
final sessions = HashMap<String, Hoge>();

class AccountService extends AccountServiceBase {
  @override
  Future<UserData> createAccount(ServiceCall call, Empty request) async {
    final userData = UserData()..userId = Uuid().v4();
    users.add(userData.userId);
    return userData;
  }

  @override
  Future<SessionData> login(ServiceCall call, UserData userData) async {
    print('Login Request: ${userData.userId}');

    if (!users.contains(userData.userId)) {
      print('Login failed: ${userData.userId}');
      return null;
    }

    final sessionId = Uuid().v4();
    final tomorrow = DateTime.now().add(Duration(days: 1));
    await Lock().synchronized(() async {
      sessions[sessionId] = Hoge()
        ..userId = userData.userId
        ..expireTime = tomorrow;
    });
    print('Login succeeded: ${userData.userId}');
    return SessionData()..sessionId = sessionId;
  }

  String generateSha256(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }
}

Future<void> main() async {
  final server = Server([AccountService()]);
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');
}
