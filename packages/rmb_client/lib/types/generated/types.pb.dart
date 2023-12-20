//
//  Generated code. Do not modify.
//  source: types.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

/// A Request annotate this message as a request message
/// with proper command
class Request extends $pb.GeneratedMessage {
  factory Request({
    $core.String? command,
  }) {
    final $result = create();
    if (command != null) {
      $result.command = command;
    }
    return $result;
  }
  Request._() : super();
  factory Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Request', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'command')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Request clone() => Request()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Request copyWith(void Function(Request) updates) => super.copyWith((message) => updates(message as Request)) as Request;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Request create() => Request._();
  Request createEmptyInstance() => create();
  static $pb.PbList<Request> createRepeated() => $pb.PbList<Request>();
  @$core.pragma('dart2js:noInline')
  static Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Request>(create);
  static Request? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get command => $_getSZ(0);
  @$pb.TagNumber(1)
  set command($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCommand() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommand() => clearField(1);
}

/// A Response annotate this message as a response message
class Response extends $pb.GeneratedMessage {
  factory Response() => create();
  Response._() : super();
  factory Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Response', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Response clone() => Response()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Response copyWith(void Function(Response) updates) => super.copyWith((message) => updates(message as Response)) as Response;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Response create() => Response._();
  Response createEmptyInstance() => create();
  static $pb.PbList<Response> createRepeated() => $pb.PbList<Response>();
  @$core.pragma('dart2js:noInline')
  static Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Response>(create);
  static Response? _defaultInstance;
}

/// A Error annotiate this message as an error message
class Error extends $pb.GeneratedMessage {
  factory Error({
    $core.int? code,
    $core.String? message,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  Error._() : super();
  factory Error.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Error.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Error', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'code', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Error clone() => Error()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Error copyWith(void Function(Error) updates) => super.copyWith((message) => updates(message as Error)) as Error;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Error create() => Error._();
  Error createEmptyInstance() => create();
  static $pb.PbList<Error> createRepeated() => $pb.PbList<Error>();
  @$core.pragma('dart2js:noInline')
  static Error getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Error>(create);
  static Error? _defaultInstance;

  /// error code (app specific)
  @$pb.TagNumber(1)
  $core.int get code => $_getIZ(0);
  @$pb.TagNumber(1)
  set code($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  /// error message
  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class Address extends $pb.GeneratedMessage {
  factory Address({
    $core.int? twin,
    $core.String? connection,
  }) {
    final $result = create();
    if (twin != null) {
      $result.twin = twin;
    }
    if (connection != null) {
      $result.connection = connection;
    }
    return $result;
  }
  Address._() : super();
  factory Address.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Address.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Address', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'twin', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'connection')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Address clone() => Address()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Address copyWith(void Function(Address) updates) => super.copyWith((message) => updates(message as Address)) as Address;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Address create() => Address._();
  Address createEmptyInstance() => create();
  static $pb.PbList<Address> createRepeated() => $pb.PbList<Address>();
  @$core.pragma('dart2js:noInline')
  static Address getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Address>(create);
  static Address? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get twin => $_getIZ(0);
  @$pb.TagNumber(1)
  set twin($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTwin() => $_has(0);
  @$pb.TagNumber(1)
  void clearTwin() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get connection => $_getSZ(1);
  @$pb.TagNumber(2)
  set connection($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasConnection() => $_has(1);
  @$pb.TagNumber(2)
  void clearConnection() => clearField(2);
}

/// an app level ping pong
/// in case you are using javascript
/// and cant send ping messages
/// when sending Pings, both signature
/// and destination are ignored
class Ping extends $pb.GeneratedMessage {
  factory Ping() => create();
  Ping._() : super();
  factory Ping.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Ping.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Ping', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Ping clone() => Ping()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Ping copyWith(void Function(Ping) updates) => super.copyWith((message) => updates(message as Ping)) as Ping;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Ping create() => Ping._();
  Ping createEmptyInstance() => create();
  static $pb.PbList<Ping> createRepeated() => $pb.PbList<Ping>();
  @$core.pragma('dart2js:noInline')
  static Ping getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Ping>(create);
  static Ping? _defaultInstance;
}

/// if the relay received an envelope ping,
/// an envelope pong will be sent back to the
/// client
class Pong extends $pb.GeneratedMessage {
  factory Pong() => create();
  Pong._() : super();
  factory Pong.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Pong.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Pong', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Pong clone() => Pong()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Pong copyWith(void Function(Pong) updates) => super.copyWith((message) => updates(message as Pong)) as Pong;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Pong create() => Pong._();
  Pong createEmptyInstance() => create();
  static $pb.PbList<Pong> createRepeated() => $pb.PbList<Pong>();
  @$core.pragma('dart2js:noInline')
  static Pong getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Pong>(create);
  static Pong? _defaultInstance;
}

enum Envelope_Message {
  request, 
  response, 
  error, 
  ping, 
  pong, 
  notSet
}

enum Envelope_Payload {
  plain, 
  cipher, 
  notSet
}

class Envelope extends $pb.GeneratedMessage {
  factory Envelope({
    $core.String? uid,
    $core.String? tags,
    $fixnum.Int64? timestamp,
    $fixnum.Int64? expiration,
    Address? source,
    Address? destination,
    Request? request,
    Response? response,
    $core.List<$core.int>? signature,
    $core.String? schema,
    $core.String? federation,
    Error? error,
    $core.List<$core.int>? plain,
    $core.List<$core.int>? cipher,
    Ping? ping,
    Pong? pong,
  }) {
    final $result = create();
    if (uid != null) {
      $result.uid = uid;
    }
    if (tags != null) {
      $result.tags = tags;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (expiration != null) {
      $result.expiration = expiration;
    }
    if (source != null) {
      $result.source = source;
    }
    if (destination != null) {
      $result.destination = destination;
    }
    if (request != null) {
      $result.request = request;
    }
    if (response != null) {
      $result.response = response;
    }
    if (signature != null) {
      $result.signature = signature;
    }
    if (schema != null) {
      $result.schema = schema;
    }
    if (federation != null) {
      $result.federation = federation;
    }
    if (error != null) {
      $result.error = error;
    }
    if (plain != null) {
      $result.plain = plain;
    }
    if (cipher != null) {
      $result.cipher = cipher;
    }
    if (ping != null) {
      $result.ping = ping;
    }
    if (pong != null) {
      $result.pong = pong;
    }
    return $result;
  }
  Envelope._() : super();
  factory Envelope.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Envelope.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Envelope_Message> _Envelope_MessageByTag = {
    7 : Envelope_Message.request,
    8 : Envelope_Message.response,
    12 : Envelope_Message.error,
    15 : Envelope_Message.ping,
    16 : Envelope_Message.pong,
    0 : Envelope_Message.notSet
  };
  static const $core.Map<$core.int, Envelope_Payload> _Envelope_PayloadByTag = {
    13 : Envelope_Payload.plain,
    14 : Envelope_Payload.cipher,
    0 : Envelope_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Envelope', createEmptyInstance: create)
    ..oo(0, [7, 8, 12, 15, 16])
    ..oo(1, [13, 14])
    ..aOS(1, _omitFieldNames ? '' : 'uid')
    ..aOS(2, _omitFieldNames ? '' : 'tags')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'expiration', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<Address>(5, _omitFieldNames ? '' : 'source', subBuilder: Address.create)
    ..aOM<Address>(6, _omitFieldNames ? '' : 'destination', subBuilder: Address.create)
    ..aOM<Request>(7, _omitFieldNames ? '' : 'request', subBuilder: Request.create)
    ..aOM<Response>(8, _omitFieldNames ? '' : 'response', subBuilder: Response.create)
    ..a<$core.List<$core.int>>(9, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..aOS(10, _omitFieldNames ? '' : 'schema')
    ..aOS(11, _omitFieldNames ? '' : 'federation')
    ..aOM<Error>(12, _omitFieldNames ? '' : 'error', subBuilder: Error.create)
    ..a<$core.List<$core.int>>(13, _omitFieldNames ? '' : 'plain', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(14, _omitFieldNames ? '' : 'cipher', $pb.PbFieldType.OY)
    ..aOM<Ping>(15, _omitFieldNames ? '' : 'ping', subBuilder: Ping.create)
    ..aOM<Pong>(16, _omitFieldNames ? '' : 'pong', subBuilder: Pong.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Envelope clone() => Envelope()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Envelope copyWith(void Function(Envelope) updates) => super.copyWith((message) => updates(message as Envelope)) as Envelope;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Envelope create() => Envelope._();
  Envelope createEmptyInstance() => create();
  static $pb.PbList<Envelope> createRepeated() => $pb.PbList<Envelope>();
  @$core.pragma('dart2js:noInline')
  static Envelope getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Envelope>(create);
  static Envelope? _defaultInstance;

  Envelope_Message whichMessage() => _Envelope_MessageByTag[$_whichOneof(0)]!;
  void clearMessage() => clearField($_whichOneof(0));

  Envelope_Payload whichPayload() => _Envelope_PayloadByTag[$_whichOneof(1)]!;
  void clearPayload() => clearField($_whichOneof(1));

  /// uid is auto generated by rmb.
  @$pb.TagNumber(1)
  $core.String get uid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUid() => clearField(1);

  /// client specific tags
  @$pb.TagNumber(2)
  $core.String get tags => $_getSZ(1);
  @$pb.TagNumber(2)
  set tags($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTags() => $_has(1);
  @$pb.TagNumber(2)
  void clearTags() => clearField(2);

  /// timestamp of sending the envlope
  @$pb.TagNumber(3)
  $fixnum.Int64 get timestamp => $_getI64(2);
  @$pb.TagNumber(3)
  set timestamp($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);

  /// message TTL from the time of send
  @$pb.TagNumber(4)
  $fixnum.Int64 get expiration => $_getI64(3);
  @$pb.TagNumber(4)
  set expiration($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpiration() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiration() => clearField(4);

  /// sender id
  @$pb.TagNumber(5)
  Address get source => $_getN(4);
  @$pb.TagNumber(5)
  set source(Address v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasSource() => $_has(4);
  @$pb.TagNumber(5)
  void clearSource() => clearField(5);
  @$pb.TagNumber(5)
  Address ensureSource() => $_ensure(4);

  /// destination of the envlope
  @$pb.TagNumber(6)
  Address get destination => $_getN(5);
  @$pb.TagNumber(6)
  set destination(Address v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasDestination() => $_has(5);
  @$pb.TagNumber(6)
  void clearDestination() => clearField(6);
  @$pb.TagNumber(6)
  Address ensureDestination() => $_ensure(5);

  @$pb.TagNumber(7)
  Request get request => $_getN(6);
  @$pb.TagNumber(7)
  set request(Request v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasRequest() => $_has(6);
  @$pb.TagNumber(7)
  void clearRequest() => clearField(7);
  @$pb.TagNumber(7)
  Request ensureRequest() => $_ensure(6);

  @$pb.TagNumber(8)
  Response get response => $_getN(7);
  @$pb.TagNumber(8)
  set response(Response v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasResponse() => $_has(7);
  @$pb.TagNumber(8)
  void clearResponse() => clearField(8);
  @$pb.TagNumber(8)
  Response ensureResponse() => $_ensure(7);

  /// signature
  @$pb.TagNumber(9)
  $core.List<$core.int> get signature => $_getN(8);
  @$pb.TagNumber(9)
  set signature($core.List<$core.int> v) { $_setBytes(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSignature() => $_has(8);
  @$pb.TagNumber(9)
  void clearSignature() => clearField(9);

  /// schema of the payload of either the request or the resposne message.
  @$pb.TagNumber(10)
  $core.String get schema => $_getSZ(9);
  @$pb.TagNumber(10)
  set schema($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasSchema() => $_has(9);
  @$pb.TagNumber(10)
  void clearSchema() => clearField(10);

  /// a federation url (domain)
  /// if not provided the relay assumes it's a local twin
  /// but if provided it can be checked against the relay
  /// domain, and hence decided if message need federation
  /// or local.
  @$pb.TagNumber(11)
  $core.String get federation => $_getSZ(10);
  @$pb.TagNumber(11)
  set federation($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasFederation() => $_has(10);
  @$pb.TagNumber(11)
  void clearFederation() => clearField(11);

  @$pb.TagNumber(12)
  Error get error => $_getN(11);
  @$pb.TagNumber(12)
  set error(Error v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasError() => $_has(11);
  @$pb.TagNumber(12)
  void clearError() => clearField(12);
  @$pb.TagNumber(12)
  Error ensureError() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.List<$core.int> get plain => $_getN(12);
  @$pb.TagNumber(13)
  set plain($core.List<$core.int> v) { $_setBytes(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasPlain() => $_has(12);
  @$pb.TagNumber(13)
  void clearPlain() => clearField(13);

  @$pb.TagNumber(14)
  $core.List<$core.int> get cipher => $_getN(13);
  @$pb.TagNumber(14)
  set cipher($core.List<$core.int> v) { $_setBytes(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCipher() => $_has(13);
  @$pb.TagNumber(14)
  void clearCipher() => clearField(14);

  @$pb.TagNumber(15)
  Ping get ping => $_getN(14);
  @$pb.TagNumber(15)
  set ping(Ping v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasPing() => $_has(14);
  @$pb.TagNumber(15)
  void clearPing() => clearField(15);
  @$pb.TagNumber(15)
  Ping ensurePing() => $_ensure(14);

  @$pb.TagNumber(16)
  Pong get pong => $_getN(15);
  @$pb.TagNumber(16)
  set pong(Pong v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasPong() => $_has(15);
  @$pb.TagNumber(16)
  void clearPong() => clearField(16);
  @$pb.TagNumber(16)
  Pong ensurePong() => $_ensure(15);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
