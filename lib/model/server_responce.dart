import 'dart:convert';

class ResponceServerData {
  final bool success;
  final String? status;

  ResponceServerData({required this.success, this.status});

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'status': status,
    };
  }

  factory ResponceServerData.fromMap(Map<String, dynamic> map) {
    return ResponceServerData(
      success: map['success'] ?? false,
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponceServerData.fromJson(String source) =>
      ResponceServerData.fromMap(json.decode(source));
}

class ResponceAuth {
  final String token;
  final int id;
  final String? error;

  ResponceAuth(this.token, this.id, this.error);

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'id': id,
      'error': error,
    };
  }

  factory ResponceAuth.fromMap(Map<String, dynamic> map) {
    return ResponceAuth(
      map['token'] ?? '',
      map['id']?.toInt() ?? 0,
      map['error'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponceAuth.fromJson(String source) =>
      ResponceAuth.fromMap(json.decode(source));
}
