//
//  Generated code. Do not modify.
//  source: types.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use requestDescriptor instead')
const Request$json = {
  '1': 'Request',
  '2': [
    {'1': 'command', '3': 1, '4': 1, '5': 9, '10': 'command'},
  ],
  '9': [
    {'1': 2, '2': 3},
  ],
};

/// Descriptor for `Request`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestDescriptor = $convert.base64Decode(
    'CgdSZXF1ZXN0EhgKB2NvbW1hbmQYASABKAlSB2NvbW1hbmRKBAgCEAM=');

@$core.Deprecated('Use responseDescriptor instead')
const Response$json = {
  '1': 'Response',
  '9': [
    {'1': 1, '2': 2},
    {'1': 2, '2': 3},
  ],
};

/// Descriptor for `Response`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseDescriptor = $convert.base64Decode(
    'CghSZXNwb25zZUoECAEQAkoECAIQAw==');

@$core.Deprecated('Use errorDescriptor instead')
const Error$json = {
  '1': 'Error',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 13, '10': 'code'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `Error`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorDescriptor = $convert.base64Decode(
    'CgVFcnJvchISCgRjb2RlGAEgASgNUgRjb2RlEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use addressDescriptor instead')
const Address$json = {
  '1': 'Address',
  '2': [
    {'1': 'twin', '3': 1, '4': 1, '5': 13, '10': 'twin'},
    {'1': 'connection', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'connection', '17': true},
  ],
  '8': [
    {'1': '_connection'},
  ],
};

/// Descriptor for `Address`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressDescriptor = $convert.base64Decode(
    'CgdBZGRyZXNzEhIKBHR3aW4YASABKA1SBHR3aW4SIwoKY29ubmVjdGlvbhgCIAEoCUgAUgpjb2'
    '5uZWN0aW9uiAEBQg0KC19jb25uZWN0aW9u');

@$core.Deprecated('Use pingDescriptor instead')
const Ping$json = {
  '1': 'Ping',
};

/// Descriptor for `Ping`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pingDescriptor = $convert.base64Decode(
    'CgRQaW5n');

@$core.Deprecated('Use pongDescriptor instead')
const Pong$json = {
  '1': 'Pong',
};

/// Descriptor for `Pong`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pongDescriptor = $convert.base64Decode(
    'CgRQb25n');

@$core.Deprecated('Use envelopeDescriptor instead')
const Envelope$json = {
  '1': 'Envelope',
  '2': [
    {'1': 'uid', '3': 1, '4': 1, '5': 9, '10': 'uid'},
    {'1': 'tags', '3': 2, '4': 1, '5': 9, '9': 2, '10': 'tags', '17': true},
    {'1': 'timestamp', '3': 3, '4': 1, '5': 4, '10': 'timestamp'},
    {'1': 'expiration', '3': 4, '4': 1, '5': 4, '10': 'expiration'},
    {'1': 'source', '3': 5, '4': 1, '5': 11, '6': '.Address', '10': 'source'},
    {'1': 'destination', '3': 6, '4': 1, '5': 11, '6': '.Address', '10': 'destination'},
    {'1': 'request', '3': 7, '4': 1, '5': 11, '6': '.Request', '9': 0, '10': 'request'},
    {'1': 'response', '3': 8, '4': 1, '5': 11, '6': '.Response', '9': 0, '10': 'response'},
    {'1': 'error', '3': 12, '4': 1, '5': 11, '6': '.Error', '9': 0, '10': 'error'},
    {'1': 'ping', '3': 15, '4': 1, '5': 11, '6': '.Ping', '9': 0, '10': 'ping'},
    {'1': 'pong', '3': 16, '4': 1, '5': 11, '6': '.Pong', '9': 0, '10': 'pong'},
    {'1': 'signature', '3': 9, '4': 1, '5': 12, '9': 3, '10': 'signature', '17': true},
    {'1': 'schema', '3': 10, '4': 1, '5': 9, '9': 4, '10': 'schema', '17': true},
    {'1': 'federation', '3': 11, '4': 1, '5': 9, '9': 5, '10': 'federation', '17': true},
    {'1': 'plain', '3': 13, '4': 1, '5': 12, '9': 1, '10': 'plain'},
    {'1': 'cipher', '3': 14, '4': 1, '5': 12, '9': 1, '10': 'cipher'},
    {'1': 'relays', '3': 17, '4': 3, '5': 9, '10': 'relays'},
  ],
  '8': [
    {'1': 'message'},
    {'1': 'payload'},
    {'1': '_tags'},
    {'1': '_signature'},
    {'1': '_schema'},
    {'1': '_federation'},
  ],
};

/// Descriptor for `Envelope`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List envelopeDescriptor = $convert.base64Decode(
    'CghFbnZlbG9wZRIQCgN1aWQYASABKAlSA3VpZBIXCgR0YWdzGAIgASgJSAJSBHRhZ3OIAQESHA'
    'oJdGltZXN0YW1wGAMgASgEUgl0aW1lc3RhbXASHgoKZXhwaXJhdGlvbhgEIAEoBFIKZXhwaXJh'
    'dGlvbhIgCgZzb3VyY2UYBSABKAsyCC5BZGRyZXNzUgZzb3VyY2USKgoLZGVzdGluYXRpb24YBi'
    'ABKAsyCC5BZGRyZXNzUgtkZXN0aW5hdGlvbhIkCgdyZXF1ZXN0GAcgASgLMgguUmVxdWVzdEgA'
    'UgdyZXF1ZXN0EicKCHJlc3BvbnNlGAggASgLMgkuUmVzcG9uc2VIAFIIcmVzcG9uc2USHgoFZX'
    'Jyb3IYDCABKAsyBi5FcnJvckgAUgVlcnJvchIbCgRwaW5nGA8gASgLMgUuUGluZ0gAUgRwaW5n'
    'EhsKBHBvbmcYECABKAsyBS5Qb25nSABSBHBvbmcSIQoJc2lnbmF0dXJlGAkgASgMSANSCXNpZ2'
    '5hdHVyZYgBARIbCgZzY2hlbWEYCiABKAlIBFIGc2NoZW1hiAEBEiMKCmZlZGVyYXRpb24YCyAB'
    'KAlIBVIKZmVkZXJhdGlvbogBARIWCgVwbGFpbhgNIAEoDEgBUgVwbGFpbhIYCgZjaXBoZXIYDi'
    'ABKAxIAVIGY2lwaGVyEhYKBnJlbGF5cxgRIAMoCVIGcmVsYXlzQgkKB21lc3NhZ2VCCQoHcGF5'
    'bG9hZEIHCgVfdGFnc0IMCgpfc2lnbmF0dXJlQgkKB19zY2hlbWFCDQoLX2ZlZGVyYXRpb24=');

