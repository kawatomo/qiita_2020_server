///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'google/protobuf/empty.pb.dart' as $0;
import 'user.pb.dart' as $1;
export 'user.pb.dart';

class AccountServiceClient extends $grpc.Client {
  static final _$createAccount = $grpc.ClientMethod<$0.Empty, $1.LoginData>(
      '/user.AccountService/CreateAccount',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.LoginData.fromBuffer(value));
  static final _$login = $grpc.ClientMethod<$1.LoginData, $1.SessionData>(
      '/user.AccountService/Login',
      ($1.LoginData value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.SessionData.fromBuffer(value));
  static final _$update = $grpc.ClientMethod<$1.UpdateData, $1.SessionData>(
      '/user.AccountService/Update',
      ($1.UpdateData value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.SessionData.fromBuffer(value));

  AccountServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$1.LoginData> createAccount($0.Empty request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createAccount, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.SessionData> login($1.LoginData request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$login, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.SessionData> update($1.UpdateData request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$update, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class AccountServiceBase extends $grpc.Service {
  $core.String get $name => 'user.AccountService';

  AccountServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.LoginData>(
        'CreateAccount',
        createAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.LoginData value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.LoginData, $1.SessionData>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.LoginData.fromBuffer(value),
        ($1.SessionData value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateData, $1.SessionData>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.UpdateData.fromBuffer(value),
        ($1.SessionData value) => value.writeToBuffer()));
  }

  $async.Future<$1.LoginData> createAccount_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return createAccount(call, await request);
  }

  $async.Future<$1.SessionData> login_Pre(
      $grpc.ServiceCall call, $async.Future<$1.LoginData> request) async {
    return login(call, await request);
  }

  $async.Future<$1.SessionData> update_Pre(
      $grpc.ServiceCall call, $async.Future<$1.UpdateData> request) async {
    return update(call, await request);
  }

  $async.Future<$1.LoginData> createAccount(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.SessionData> login(
      $grpc.ServiceCall call, $1.LoginData request);
  $async.Future<$1.SessionData> update(
      $grpc.ServiceCall call, $1.UpdateData request);
}
