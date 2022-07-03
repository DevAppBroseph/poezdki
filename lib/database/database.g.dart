// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class UserData extends DataClass implements Insertable<UserData> {
  final int? id;
  final String? login;
  final String? password;
  final String? token;
  final String? name;
  final String? surname;
  final String? gender;
  final int? dob;
  UserData(
      {this.id,
      this.login,
      this.password,
      this.token,
      this.name,
      this.surname,
      this.gender,
      this.dob});
  factory UserData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return UserData(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      login: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}login']),
      password: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}password']),
      token: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}token']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      surname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}surname']),
      gender: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gender']),
      dob: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dob']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    if (!nullToAbsent || login != null) {
      map['login'] = Variable<String?>(login);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String?>(password);
    }
    if (!nullToAbsent || token != null) {
      map['token'] = Variable<String?>(token);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String?>(name);
    }
    if (!nullToAbsent || surname != null) {
      map['surname'] = Variable<String?>(surname);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String?>(gender);
    }
    if (!nullToAbsent || dob != null) {
      map['dob'] = Variable<int?>(dob);
    }
    return map;
  }

  UserCompanion toCompanion(bool nullToAbsent) {
    return UserCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      login:
          login == null && nullToAbsent ? const Value.absent() : Value(login),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      token:
          token == null && nullToAbsent ? const Value.absent() : Value(token),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      surname: surname == null && nullToAbsent
          ? const Value.absent()
          : Value(surname),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      dob: dob == null && nullToAbsent ? const Value.absent() : Value(dob),
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserData(
      id: serializer.fromJson<int?>(json['id']),
      login: serializer.fromJson<String?>(json['login']),
      password: serializer.fromJson<String?>(json['password']),
      token: serializer.fromJson<String?>(json['token']),
      name: serializer.fromJson<String?>(json['name']),
      surname: serializer.fromJson<String?>(json['surname']),
      gender: serializer.fromJson<String?>(json['gender']),
      dob: serializer.fromJson<int?>(json['dob']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'login': serializer.toJson<String?>(login),
      'password': serializer.toJson<String?>(password),
      'token': serializer.toJson<String?>(token),
      'name': serializer.toJson<String?>(name),
      'surname': serializer.toJson<String?>(surname),
      'gender': serializer.toJson<String?>(gender),
      'dob': serializer.toJson<int?>(dob),
    };
  }

  UserData copyWith(
          {int? id,
          String? login,
          String? password,
          String? token,
          String? name,
          String? surname,
          String? gender,
          int? dob}) =>
      UserData(
        id: id ?? this.id,
        login: login ?? this.login,
        password: password ?? this.password,
        token: token ?? this.token,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        gender: gender ?? this.gender,
        dob: dob ?? this.dob,
      );
  @override
  String toString() {
    return (StringBuffer('UserData(')
          ..write('id: $id, ')
          ..write('login: $login, ')
          ..write('password: $password, ')
          ..write('token: $token, ')
          ..write('name: $name, ')
          ..write('surname: $surname, ')
          ..write('gender: $gender, ')
          ..write('dob: $dob')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, login, password, token, name, surname, gender, dob);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserData &&
          other.id == this.id &&
          other.login == this.login &&
          other.password == this.password &&
          other.token == this.token &&
          other.name == this.name &&
          other.surname == this.surname &&
          other.gender == this.gender &&
          other.dob == this.dob);
}

class UserCompanion extends UpdateCompanion<UserData> {
  final Value<int?> id;
  final Value<String?> login;
  final Value<String?> password;
  final Value<String?> token;
  final Value<String?> name;
  final Value<String?> surname;
  final Value<String?> gender;
  final Value<int?> dob;
  const UserCompanion({
    this.id = const Value.absent(),
    this.login = const Value.absent(),
    this.password = const Value.absent(),
    this.token = const Value.absent(),
    this.name = const Value.absent(),
    this.surname = const Value.absent(),
    this.gender = const Value.absent(),
    this.dob = const Value.absent(),
  });
  UserCompanion.insert({
    this.id = const Value.absent(),
    this.login = const Value.absent(),
    this.password = const Value.absent(),
    this.token = const Value.absent(),
    this.name = const Value.absent(),
    this.surname = const Value.absent(),
    this.gender = const Value.absent(),
    this.dob = const Value.absent(),
  });
  static Insertable<UserData> custom({
    Expression<int?>? id,
    Expression<String?>? login,
    Expression<String?>? password,
    Expression<String?>? token,
    Expression<String?>? name,
    Expression<String?>? surname,
    Expression<String?>? gender,
    Expression<int?>? dob,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (login != null) 'login': login,
      if (password != null) 'password': password,
      if (token != null) 'token': token,
      if (name != null) 'name': name,
      if (surname != null) 'surname': surname,
      if (gender != null) 'gender': gender,
      if (dob != null) 'dob': dob,
    });
  }

  UserCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? login,
      Value<String?>? password,
      Value<String?>? token,
      Value<String?>? name,
      Value<String?>? surname,
      Value<String?>? gender,
      Value<int?>? dob}) {
    return UserCompanion(
      id: id ?? this.id,
      login: login ?? this.login,
      password: password ?? this.password,
      token: token ?? this.token,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (login.present) {
      map['login'] = Variable<String?>(login.value);
    }
    if (password.present) {
      map['password'] = Variable<String?>(password.value);
    }
    if (token.present) {
      map['token'] = Variable<String?>(token.value);
    }
    if (name.present) {
      map['name'] = Variable<String?>(name.value);
    }
    if (surname.present) {
      map['surname'] = Variable<String?>(surname.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String?>(gender.value);
    }
    if (dob.present) {
      map['dob'] = Variable<int?>(dob.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCompanion(')
          ..write('id: $id, ')
          ..write('login: $login, ')
          ..write('password: $password, ')
          ..write('token: $token, ')
          ..write('name: $name, ')
          ..write('surname: $surname, ')
          ..write('gender: $gender, ')
          ..write('dob: $dob')
          ..write(')'))
        .toString();
  }
}

class $UserTable extends User with TableInfo<$UserTable, UserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _loginMeta = const VerificationMeta('login');
  @override
  late final GeneratedColumn<String?> login = GeneratedColumn<String?>(
      'login', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  @override
  late final GeneratedColumn<String?> password = GeneratedColumn<String?>(
      'password', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String?> token = GeneratedColumn<String?>(
      'token', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _surnameMeta = const VerificationMeta('surname');
  @override
  late final GeneratedColumn<String?> surname = GeneratedColumn<String?>(
      'surname', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String?> gender = GeneratedColumn<String?>(
      'gender', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _dobMeta = const VerificationMeta('dob');
  @override
  late final GeneratedColumn<int?> dob = GeneratedColumn<int?>(
      'dob', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, login, password, token, name, surname, gender, dob];
  @override
  String get aliasedName => _alias ?? 'user';
  @override
  String get actualTableName => 'user';
  @override
  VerificationContext validateIntegrity(Insertable<UserData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('login')) {
      context.handle(
          _loginMeta, login.isAcceptableOrUnknown(data['login']!, _loginMeta));
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    }
    if (data.containsKey('token')) {
      context.handle(
          _tokenMeta, token.isAcceptableOrUnknown(data['token']!, _tokenMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('surname')) {
      context.handle(_surnameMeta,
          surname.isAcceptableOrUnknown(data['surname']!, _surnameMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('dob')) {
      context.handle(
          _dobMeta, dob.isAcceptableOrUnknown(data['dob']!, _dobMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return UserData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UserTable createAlias(String alias) {
    return $UserTable(attachedDatabase, alias);
  }
}

class CarData extends DataClass implements Insertable<CarData> {
  final int id;
  final int? ownerId;
  final String? mark;
  CarData({required this.id, this.ownerId, this.mark});
  factory CarData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CarData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      ownerId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}owner_id']),
      mark: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}mark']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || ownerId != null) {
      map['owner_id'] = Variable<int?>(ownerId);
    }
    if (!nullToAbsent || mark != null) {
      map['mark'] = Variable<String?>(mark);
    }
    return map;
  }

  CarCompanion toCompanion(bool nullToAbsent) {
    return CarCompanion(
      id: Value(id),
      ownerId: ownerId == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerId),
      mark: mark == null && nullToAbsent ? const Value.absent() : Value(mark),
    );
  }

  factory CarData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CarData(
      id: serializer.fromJson<int>(json['id']),
      ownerId: serializer.fromJson<int?>(json['ownerId']),
      mark: serializer.fromJson<String?>(json['mark']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ownerId': serializer.toJson<int?>(ownerId),
      'mark': serializer.toJson<String?>(mark),
    };
  }

  CarData copyWith({int? id, int? ownerId, String? mark}) => CarData(
        id: id ?? this.id,
        ownerId: ownerId ?? this.ownerId,
        mark: mark ?? this.mark,
      );
  @override
  String toString() {
    return (StringBuffer('CarData(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('mark: $mark')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ownerId, mark);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CarData &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.mark == this.mark);
}

class CarCompanion extends UpdateCompanion<CarData> {
  final Value<int> id;
  final Value<int?> ownerId;
  final Value<String?> mark;
  const CarCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.mark = const Value.absent(),
  });
  CarCompanion.insert({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.mark = const Value.absent(),
  });
  static Insertable<CarData> custom({
    Expression<int>? id,
    Expression<int?>? ownerId,
    Expression<String?>? mark,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (mark != null) 'mark': mark,
    });
  }

  CarCompanion copyWith(
      {Value<int>? id, Value<int?>? ownerId, Value<String?>? mark}) {
    return CarCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      mark: mark ?? this.mark,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<int?>(ownerId.value);
    }
    if (mark.present) {
      map['mark'] = Variable<String?>(mark.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CarCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('mark: $mark')
          ..write(')'))
        .toString();
  }
}

class $CarTable extends Car with TableInfo<$CarTable, CarData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CarTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _ownerIdMeta = const VerificationMeta('ownerId');
  @override
  late final GeneratedColumn<int?> ownerId = GeneratedColumn<int?>(
      'owner_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _markMeta = const VerificationMeta('mark');
  @override
  late final GeneratedColumn<String?> mark = GeneratedColumn<String?>(
      'mark', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, ownerId, mark];
  @override
  String get aliasedName => _alias ?? 'car';
  @override
  String get actualTableName => 'car';
  @override
  VerificationContext validateIntegrity(Insertable<CarData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('owner_id')) {
      context.handle(_ownerIdMeta,
          ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta));
    }
    if (data.containsKey('mark')) {
      context.handle(
          _markMeta, mark.isAcceptableOrUnknown(data['mark']!, _markMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CarData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CarData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CarTable createAlias(String alias) {
    return $CarTable(attachedDatabase, alias);
  }
}

class BalanceData extends DataClass implements Insertable<BalanceData> {
  final int id;
  final int ownerId;
  final double? balance;
  final double? points;
  BalanceData(
      {required this.id, required this.ownerId, this.balance, this.points});
  factory BalanceData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return BalanceData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      ownerId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}owner_id'])!,
      balance: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}balance']),
      points: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}points']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['owner_id'] = Variable<int>(ownerId);
    if (!nullToAbsent || balance != null) {
      map['balance'] = Variable<double?>(balance);
    }
    if (!nullToAbsent || points != null) {
      map['points'] = Variable<double?>(points);
    }
    return map;
  }

  BalanceCompanion toCompanion(bool nullToAbsent) {
    return BalanceCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      balance: balance == null && nullToAbsent
          ? const Value.absent()
          : Value(balance),
      points:
          points == null && nullToAbsent ? const Value.absent() : Value(points),
    );
  }

  factory BalanceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BalanceData(
      id: serializer.fromJson<int>(json['id']),
      ownerId: serializer.fromJson<int>(json['ownerId']),
      balance: serializer.fromJson<double?>(json['balance']),
      points: serializer.fromJson<double?>(json['points']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ownerId': serializer.toJson<int>(ownerId),
      'balance': serializer.toJson<double?>(balance),
      'points': serializer.toJson<double?>(points),
    };
  }

  BalanceData copyWith(
          {int? id, int? ownerId, double? balance, double? points}) =>
      BalanceData(
        id: id ?? this.id,
        ownerId: ownerId ?? this.ownerId,
        balance: balance ?? this.balance,
        points: points ?? this.points,
      );
  @override
  String toString() {
    return (StringBuffer('BalanceData(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('balance: $balance, ')
          ..write('points: $points')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ownerId, balance, points);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BalanceData &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.balance == this.balance &&
          other.points == this.points);
}

class BalanceCompanion extends UpdateCompanion<BalanceData> {
  final Value<int> id;
  final Value<int> ownerId;
  final Value<double?> balance;
  final Value<double?> points;
  const BalanceCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.balance = const Value.absent(),
    this.points = const Value.absent(),
  });
  BalanceCompanion.insert({
    this.id = const Value.absent(),
    required int ownerId,
    this.balance = const Value.absent(),
    this.points = const Value.absent(),
  }) : ownerId = Value(ownerId);
  static Insertable<BalanceData> custom({
    Expression<int>? id,
    Expression<int>? ownerId,
    Expression<double?>? balance,
    Expression<double?>? points,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (balance != null) 'balance': balance,
      if (points != null) 'points': points,
    });
  }

  BalanceCompanion copyWith(
      {Value<int>? id,
      Value<int>? ownerId,
      Value<double?>? balance,
      Value<double?>? points}) {
    return BalanceCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      balance: balance ?? this.balance,
      points: points ?? this.points,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<int>(ownerId.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double?>(balance.value);
    }
    if (points.present) {
      map['points'] = Variable<double?>(points.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BalanceCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('balance: $balance, ')
          ..write('points: $points')
          ..write(')'))
        .toString();
  }
}

class $BalanceTable extends Balance with TableInfo<$BalanceTable, BalanceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BalanceTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _ownerIdMeta = const VerificationMeta('ownerId');
  @override
  late final GeneratedColumn<int?> ownerId = GeneratedColumn<int?>(
      'owner_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _balanceMeta = const VerificationMeta('balance');
  @override
  late final GeneratedColumn<double?> balance = GeneratedColumn<double?>(
      'balance', aliasedName, true,
      type: const RealType(), requiredDuringInsert: false);
  final VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<double?> points = GeneratedColumn<double?>(
      'points', aliasedName, true,
      type: const RealType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, ownerId, balance, points];
  @override
  String get aliasedName => _alias ?? 'balance';
  @override
  String get actualTableName => 'balance';
  @override
  VerificationContext validateIntegrity(Insertable<BalanceData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('owner_id')) {
      context.handle(_ownerIdMeta,
          ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta));
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(_balanceMeta,
          balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta));
    }
    if (data.containsKey('points')) {
      context.handle(_pointsMeta,
          points.isAcceptableOrUnknown(data['points']!, _pointsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BalanceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return BalanceData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $BalanceTable createAlias(String alias) {
    return $BalanceTable(attachedDatabase, alias);
  }
}

class RideData extends DataClass implements Insertable<RideData> {
  final int? id;
  final int? owner;
  final String? ownerName;
  final String? type;
  final String? from;
  final String? waypoint;
  final String? to;
  final DateTime? date;
  final DateTime? time;
  final String? car;
  final bool? isPackageTransfer;
  final bool? isTwoBackSeat;
  final bool? isBagadgeTransfer;
  final bool? isChildSeat;
  final bool? isCondition;
  final bool? isSmoking;
  final bool? isPetTransfer;
  final bool? isPickUpFromHome;
  final double? price;
  final int? passanger1;
  final int? passanger2;
  final int? passanger3;
  final int? passanger4;
  RideData(
      {this.id,
      this.owner,
      this.ownerName,
      this.type,
      this.from,
      this.waypoint,
      this.to,
      this.date,
      this.time,
      this.car,
      this.isPackageTransfer,
      this.isTwoBackSeat,
      this.isBagadgeTransfer,
      this.isChildSeat,
      this.isCondition,
      this.isSmoking,
      this.isPetTransfer,
      this.isPickUpFromHome,
      this.price,
      this.passanger1,
      this.passanger2,
      this.passanger3,
      this.passanger4});
  factory RideData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return RideData(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      owner: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}owner']),
      ownerName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}owner_name']),
      type: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type']),
      from: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}from']),
      waypoint: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}waypoint']),
      to: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}to']),
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date']),
      time: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time']),
      car: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}car']),
      isPackageTransfer: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}is_package_transfer']),
      isTwoBackSeat: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_two_back_seat']),
      isBagadgeTransfer: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}is_bagadge_transfer']),
      isChildSeat: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_child_seat']),
      isCondition: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_condition']),
      isSmoking: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_smoking']),
      isPetTransfer: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_pet_transfer']),
      isPickUpFromHome: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}is_pick_up_from_home']),
      price: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}price']),
      passanger1: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}passanger1']),
      passanger2: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}passanger2']),
      passanger3: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}passanger3']),
      passanger4: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}passanger4']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    if (!nullToAbsent || owner != null) {
      map['owner'] = Variable<int?>(owner);
    }
    if (!nullToAbsent || ownerName != null) {
      map['owner_name'] = Variable<String?>(ownerName);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String?>(type);
    }
    if (!nullToAbsent || from != null) {
      map['from'] = Variable<String?>(from);
    }
    if (!nullToAbsent || waypoint != null) {
      map['waypoint'] = Variable<String?>(waypoint);
    }
    if (!nullToAbsent || to != null) {
      map['to'] = Variable<String?>(to);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime?>(date);
    }
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<DateTime?>(time);
    }
    if (!nullToAbsent || car != null) {
      map['car'] = Variable<String?>(car);
    }
    if (!nullToAbsent || isPackageTransfer != null) {
      map['is_package_transfer'] = Variable<bool?>(isPackageTransfer);
    }
    if (!nullToAbsent || isTwoBackSeat != null) {
      map['is_two_back_seat'] = Variable<bool?>(isTwoBackSeat);
    }
    if (!nullToAbsent || isBagadgeTransfer != null) {
      map['is_bagadge_transfer'] = Variable<bool?>(isBagadgeTransfer);
    }
    if (!nullToAbsent || isChildSeat != null) {
      map['is_child_seat'] = Variable<bool?>(isChildSeat);
    }
    if (!nullToAbsent || isCondition != null) {
      map['is_condition'] = Variable<bool?>(isCondition);
    }
    if (!nullToAbsent || isSmoking != null) {
      map['is_smoking'] = Variable<bool?>(isSmoking);
    }
    if (!nullToAbsent || isPetTransfer != null) {
      map['is_pet_transfer'] = Variable<bool?>(isPetTransfer);
    }
    if (!nullToAbsent || isPickUpFromHome != null) {
      map['is_pick_up_from_home'] = Variable<bool?>(isPickUpFromHome);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double?>(price);
    }
    if (!nullToAbsent || passanger1 != null) {
      map['passanger1'] = Variable<int?>(passanger1);
    }
    if (!nullToAbsent || passanger2 != null) {
      map['passanger2'] = Variable<int?>(passanger2);
    }
    if (!nullToAbsent || passanger3 != null) {
      map['passanger3'] = Variable<int?>(passanger3);
    }
    if (!nullToAbsent || passanger4 != null) {
      map['passanger4'] = Variable<int?>(passanger4);
    }
    return map;
  }

  RideCompanion toCompanion(bool nullToAbsent) {
    return RideCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      owner:
          owner == null && nullToAbsent ? const Value.absent() : Value(owner),
      ownerName: ownerName == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerName),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      from: from == null && nullToAbsent ? const Value.absent() : Value(from),
      waypoint: waypoint == null && nullToAbsent
          ? const Value.absent()
          : Value(waypoint),
      to: to == null && nullToAbsent ? const Value.absent() : Value(to),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
      car: car == null && nullToAbsent ? const Value.absent() : Value(car),
      isPackageTransfer: isPackageTransfer == null && nullToAbsent
          ? const Value.absent()
          : Value(isPackageTransfer),
      isTwoBackSeat: isTwoBackSeat == null && nullToAbsent
          ? const Value.absent()
          : Value(isTwoBackSeat),
      isBagadgeTransfer: isBagadgeTransfer == null && nullToAbsent
          ? const Value.absent()
          : Value(isBagadgeTransfer),
      isChildSeat: isChildSeat == null && nullToAbsent
          ? const Value.absent()
          : Value(isChildSeat),
      isCondition: isCondition == null && nullToAbsent
          ? const Value.absent()
          : Value(isCondition),
      isSmoking: isSmoking == null && nullToAbsent
          ? const Value.absent()
          : Value(isSmoking),
      isPetTransfer: isPetTransfer == null && nullToAbsent
          ? const Value.absent()
          : Value(isPetTransfer),
      isPickUpFromHome: isPickUpFromHome == null && nullToAbsent
          ? const Value.absent()
          : Value(isPickUpFromHome),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      passanger1: passanger1 == null && nullToAbsent
          ? const Value.absent()
          : Value(passanger1),
      passanger2: passanger2 == null && nullToAbsent
          ? const Value.absent()
          : Value(passanger2),
      passanger3: passanger3 == null && nullToAbsent
          ? const Value.absent()
          : Value(passanger3),
      passanger4: passanger4 == null && nullToAbsent
          ? const Value.absent()
          : Value(passanger4),
    );
  }

  factory RideData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RideData(
      id: serializer.fromJson<int?>(json['id']),
      owner: serializer.fromJson<int?>(json['owner']),
      ownerName: serializer.fromJson<String?>(json['ownerName']),
      type: serializer.fromJson<String?>(json['type']),
      from: serializer.fromJson<String?>(json['from']),
      waypoint: serializer.fromJson<String?>(json['waypoint']),
      to: serializer.fromJson<String?>(json['to']),
      date: serializer.fromJson<DateTime?>(json['date']),
      time: serializer.fromJson<DateTime?>(json['time']),
      car: serializer.fromJson<String?>(json['car']),
      isPackageTransfer: serializer.fromJson<bool?>(json['isPackageTransfer']),
      isTwoBackSeat: serializer.fromJson<bool?>(json['isTwoBackSeat']),
      isBagadgeTransfer: serializer.fromJson<bool?>(json['isBagadgeTransfer']),
      isChildSeat: serializer.fromJson<bool?>(json['isChildSeat']),
      isCondition: serializer.fromJson<bool?>(json['isCondition']),
      isSmoking: serializer.fromJson<bool?>(json['isSmoking']),
      isPetTransfer: serializer.fromJson<bool?>(json['isPetTransfer']),
      isPickUpFromHome: serializer.fromJson<bool?>(json['isPickUpFromHome']),
      price: serializer.fromJson<double?>(json['price']),
      passanger1: serializer.fromJson<int?>(json['passanger1']),
      passanger2: serializer.fromJson<int?>(json['passanger2']),
      passanger3: serializer.fromJson<int?>(json['passanger3']),
      passanger4: serializer.fromJson<int?>(json['passanger4']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'owner': serializer.toJson<int?>(owner),
      'ownerName': serializer.toJson<String?>(ownerName),
      'type': serializer.toJson<String?>(type),
      'from': serializer.toJson<String?>(from),
      'waypoint': serializer.toJson<String?>(waypoint),
      'to': serializer.toJson<String?>(to),
      'date': serializer.toJson<DateTime?>(date),
      'time': serializer.toJson<DateTime?>(time),
      'car': serializer.toJson<String?>(car),
      'isPackageTransfer': serializer.toJson<bool?>(isPackageTransfer),
      'isTwoBackSeat': serializer.toJson<bool?>(isTwoBackSeat),
      'isBagadgeTransfer': serializer.toJson<bool?>(isBagadgeTransfer),
      'isChildSeat': serializer.toJson<bool?>(isChildSeat),
      'isCondition': serializer.toJson<bool?>(isCondition),
      'isSmoking': serializer.toJson<bool?>(isSmoking),
      'isPetTransfer': serializer.toJson<bool?>(isPetTransfer),
      'isPickUpFromHome': serializer.toJson<bool?>(isPickUpFromHome),
      'price': serializer.toJson<double?>(price),
      'passanger1': serializer.toJson<int?>(passanger1),
      'passanger2': serializer.toJson<int?>(passanger2),
      'passanger3': serializer.toJson<int?>(passanger3),
      'passanger4': serializer.toJson<int?>(passanger4),
    };
  }

  RideData copyWith(
          {int? id,
          int? owner,
          String? ownerName,
          String? type,
          String? from,
          String? waypoint,
          String? to,
          DateTime? date,
          DateTime? time,
          String? car,
          bool? isPackageTransfer,
          bool? isTwoBackSeat,
          bool? isBagadgeTransfer,
          bool? isChildSeat,
          bool? isCondition,
          bool? isSmoking,
          bool? isPetTransfer,
          bool? isPickUpFromHome,
          double? price,
          int? passanger1,
          int? passanger2,
          int? passanger3,
          int? passanger4}) =>
      RideData(
        id: id ?? this.id,
        owner: owner ?? this.owner,
        ownerName: ownerName ?? this.ownerName,
        type: type ?? this.type,
        from: from ?? this.from,
        waypoint: waypoint ?? this.waypoint,
        to: to ?? this.to,
        date: date ?? this.date,
        time: time ?? this.time,
        car: car ?? this.car,
        isPackageTransfer: isPackageTransfer ?? this.isPackageTransfer,
        isTwoBackSeat: isTwoBackSeat ?? this.isTwoBackSeat,
        isBagadgeTransfer: isBagadgeTransfer ?? this.isBagadgeTransfer,
        isChildSeat: isChildSeat ?? this.isChildSeat,
        isCondition: isCondition ?? this.isCondition,
        isSmoking: isSmoking ?? this.isSmoking,
        isPetTransfer: isPetTransfer ?? this.isPetTransfer,
        isPickUpFromHome: isPickUpFromHome ?? this.isPickUpFromHome,
        price: price ?? this.price,
        passanger1: passanger1 ?? this.passanger1,
        passanger2: passanger2 ?? this.passanger2,
        passanger3: passanger3 ?? this.passanger3,
        passanger4: passanger4 ?? this.passanger4,
      );
  @override
  String toString() {
    return (StringBuffer('RideData(')
          ..write('id: $id, ')
          ..write('owner: $owner, ')
          ..write('ownerName: $ownerName, ')
          ..write('type: $type, ')
          ..write('from: $from, ')
          ..write('waypoint: $waypoint, ')
          ..write('to: $to, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('car: $car, ')
          ..write('isPackageTransfer: $isPackageTransfer, ')
          ..write('isTwoBackSeat: $isTwoBackSeat, ')
          ..write('isBagadgeTransfer: $isBagadgeTransfer, ')
          ..write('isChildSeat: $isChildSeat, ')
          ..write('isCondition: $isCondition, ')
          ..write('isSmoking: $isSmoking, ')
          ..write('isPetTransfer: $isPetTransfer, ')
          ..write('isPickUpFromHome: $isPickUpFromHome, ')
          ..write('price: $price, ')
          ..write('passanger1: $passanger1, ')
          ..write('passanger2: $passanger2, ')
          ..write('passanger3: $passanger3, ')
          ..write('passanger4: $passanger4')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        owner,
        ownerName,
        type,
        from,
        waypoint,
        to,
        date,
        time,
        car,
        isPackageTransfer,
        isTwoBackSeat,
        isBagadgeTransfer,
        isChildSeat,
        isCondition,
        isSmoking,
        isPetTransfer,
        isPickUpFromHome,
        price,
        passanger1,
        passanger2,
        passanger3,
        passanger4
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RideData &&
          other.id == this.id &&
          other.owner == this.owner &&
          other.ownerName == this.ownerName &&
          other.type == this.type &&
          other.from == this.from &&
          other.waypoint == this.waypoint &&
          other.to == this.to &&
          other.date == this.date &&
          other.time == this.time &&
          other.car == this.car &&
          other.isPackageTransfer == this.isPackageTransfer &&
          other.isTwoBackSeat == this.isTwoBackSeat &&
          other.isBagadgeTransfer == this.isBagadgeTransfer &&
          other.isChildSeat == this.isChildSeat &&
          other.isCondition == this.isCondition &&
          other.isSmoking == this.isSmoking &&
          other.isPetTransfer == this.isPetTransfer &&
          other.isPickUpFromHome == this.isPickUpFromHome &&
          other.price == this.price &&
          other.passanger1 == this.passanger1 &&
          other.passanger2 == this.passanger2 &&
          other.passanger3 == this.passanger3 &&
          other.passanger4 == this.passanger4);
}

class RideCompanion extends UpdateCompanion<RideData> {
  final Value<int?> id;
  final Value<int?> owner;
  final Value<String?> ownerName;
  final Value<String?> type;
  final Value<String?> from;
  final Value<String?> waypoint;
  final Value<String?> to;
  final Value<DateTime?> date;
  final Value<DateTime?> time;
  final Value<String?> car;
  final Value<bool?> isPackageTransfer;
  final Value<bool?> isTwoBackSeat;
  final Value<bool?> isBagadgeTransfer;
  final Value<bool?> isChildSeat;
  final Value<bool?> isCondition;
  final Value<bool?> isSmoking;
  final Value<bool?> isPetTransfer;
  final Value<bool?> isPickUpFromHome;
  final Value<double?> price;
  final Value<int?> passanger1;
  final Value<int?> passanger2;
  final Value<int?> passanger3;
  final Value<int?> passanger4;
  const RideCompanion({
    this.id = const Value.absent(),
    this.owner = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.type = const Value.absent(),
    this.from = const Value.absent(),
    this.waypoint = const Value.absent(),
    this.to = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.car = const Value.absent(),
    this.isPackageTransfer = const Value.absent(),
    this.isTwoBackSeat = const Value.absent(),
    this.isBagadgeTransfer = const Value.absent(),
    this.isChildSeat = const Value.absent(),
    this.isCondition = const Value.absent(),
    this.isSmoking = const Value.absent(),
    this.isPetTransfer = const Value.absent(),
    this.isPickUpFromHome = const Value.absent(),
    this.price = const Value.absent(),
    this.passanger1 = const Value.absent(),
    this.passanger2 = const Value.absent(),
    this.passanger3 = const Value.absent(),
    this.passanger4 = const Value.absent(),
  });
  RideCompanion.insert({
    this.id = const Value.absent(),
    this.owner = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.type = const Value.absent(),
    this.from = const Value.absent(),
    this.waypoint = const Value.absent(),
    this.to = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.car = const Value.absent(),
    this.isPackageTransfer = const Value.absent(),
    this.isTwoBackSeat = const Value.absent(),
    this.isBagadgeTransfer = const Value.absent(),
    this.isChildSeat = const Value.absent(),
    this.isCondition = const Value.absent(),
    this.isSmoking = const Value.absent(),
    this.isPetTransfer = const Value.absent(),
    this.isPickUpFromHome = const Value.absent(),
    this.price = const Value.absent(),
    this.passanger1 = const Value.absent(),
    this.passanger2 = const Value.absent(),
    this.passanger3 = const Value.absent(),
    this.passanger4 = const Value.absent(),
  });
  static Insertable<RideData> custom({
    Expression<int?>? id,
    Expression<int?>? owner,
    Expression<String?>? ownerName,
    Expression<String?>? type,
    Expression<String?>? from,
    Expression<String?>? waypoint,
    Expression<String?>? to,
    Expression<DateTime?>? date,
    Expression<DateTime?>? time,
    Expression<String?>? car,
    Expression<bool?>? isPackageTransfer,
    Expression<bool?>? isTwoBackSeat,
    Expression<bool?>? isBagadgeTransfer,
    Expression<bool?>? isChildSeat,
    Expression<bool?>? isCondition,
    Expression<bool?>? isSmoking,
    Expression<bool?>? isPetTransfer,
    Expression<bool?>? isPickUpFromHome,
    Expression<double?>? price,
    Expression<int?>? passanger1,
    Expression<int?>? passanger2,
    Expression<int?>? passanger3,
    Expression<int?>? passanger4,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (owner != null) 'owner': owner,
      if (ownerName != null) 'owner_name': ownerName,
      if (type != null) 'type': type,
      if (from != null) 'from': from,
      if (waypoint != null) 'waypoint': waypoint,
      if (to != null) 'to': to,
      if (date != null) 'date': date,
      if (time != null) 'time': time,
      if (car != null) 'car': car,
      if (isPackageTransfer != null) 'is_package_transfer': isPackageTransfer,
      if (isTwoBackSeat != null) 'is_two_back_seat': isTwoBackSeat,
      if (isBagadgeTransfer != null) 'is_bagadge_transfer': isBagadgeTransfer,
      if (isChildSeat != null) 'is_child_seat': isChildSeat,
      if (isCondition != null) 'is_condition': isCondition,
      if (isSmoking != null) 'is_smoking': isSmoking,
      if (isPetTransfer != null) 'is_pet_transfer': isPetTransfer,
      if (isPickUpFromHome != null) 'is_pick_up_from_home': isPickUpFromHome,
      if (price != null) 'price': price,
      if (passanger1 != null) 'passanger1': passanger1,
      if (passanger2 != null) 'passanger2': passanger2,
      if (passanger3 != null) 'passanger3': passanger3,
      if (passanger4 != null) 'passanger4': passanger4,
    });
  }

  RideCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? owner,
      Value<String?>? ownerName,
      Value<String?>? type,
      Value<String?>? from,
      Value<String?>? waypoint,
      Value<String?>? to,
      Value<DateTime?>? date,
      Value<DateTime?>? time,
      Value<String?>? car,
      Value<bool?>? isPackageTransfer,
      Value<bool?>? isTwoBackSeat,
      Value<bool?>? isBagadgeTransfer,
      Value<bool?>? isChildSeat,
      Value<bool?>? isCondition,
      Value<bool?>? isSmoking,
      Value<bool?>? isPetTransfer,
      Value<bool?>? isPickUpFromHome,
      Value<double?>? price,
      Value<int?>? passanger1,
      Value<int?>? passanger2,
      Value<int?>? passanger3,
      Value<int?>? passanger4}) {
    return RideCompanion(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      ownerName: ownerName ?? this.ownerName,
      type: type ?? this.type,
      from: from ?? this.from,
      waypoint: waypoint ?? this.waypoint,
      to: to ?? this.to,
      date: date ?? this.date,
      time: time ?? this.time,
      car: car ?? this.car,
      isPackageTransfer: isPackageTransfer ?? this.isPackageTransfer,
      isTwoBackSeat: isTwoBackSeat ?? this.isTwoBackSeat,
      isBagadgeTransfer: isBagadgeTransfer ?? this.isBagadgeTransfer,
      isChildSeat: isChildSeat ?? this.isChildSeat,
      isCondition: isCondition ?? this.isCondition,
      isSmoking: isSmoking ?? this.isSmoking,
      isPetTransfer: isPetTransfer ?? this.isPetTransfer,
      isPickUpFromHome: isPickUpFromHome ?? this.isPickUpFromHome,
      price: price ?? this.price,
      passanger1: passanger1 ?? this.passanger1,
      passanger2: passanger2 ?? this.passanger2,
      passanger3: passanger3 ?? this.passanger3,
      passanger4: passanger4 ?? this.passanger4,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (owner.present) {
      map['owner'] = Variable<int?>(owner.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String?>(ownerName.value);
    }
    if (type.present) {
      map['type'] = Variable<String?>(type.value);
    }
    if (from.present) {
      map['from'] = Variable<String?>(from.value);
    }
    if (waypoint.present) {
      map['waypoint'] = Variable<String?>(waypoint.value);
    }
    if (to.present) {
      map['to'] = Variable<String?>(to.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime?>(date.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime?>(time.value);
    }
    if (car.present) {
      map['car'] = Variable<String?>(car.value);
    }
    if (isPackageTransfer.present) {
      map['is_package_transfer'] = Variable<bool?>(isPackageTransfer.value);
    }
    if (isTwoBackSeat.present) {
      map['is_two_back_seat'] = Variable<bool?>(isTwoBackSeat.value);
    }
    if (isBagadgeTransfer.present) {
      map['is_bagadge_transfer'] = Variable<bool?>(isBagadgeTransfer.value);
    }
    if (isChildSeat.present) {
      map['is_child_seat'] = Variable<bool?>(isChildSeat.value);
    }
    if (isCondition.present) {
      map['is_condition'] = Variable<bool?>(isCondition.value);
    }
    if (isSmoking.present) {
      map['is_smoking'] = Variable<bool?>(isSmoking.value);
    }
    if (isPetTransfer.present) {
      map['is_pet_transfer'] = Variable<bool?>(isPetTransfer.value);
    }
    if (isPickUpFromHome.present) {
      map['is_pick_up_from_home'] = Variable<bool?>(isPickUpFromHome.value);
    }
    if (price.present) {
      map['price'] = Variable<double?>(price.value);
    }
    if (passanger1.present) {
      map['passanger1'] = Variable<int?>(passanger1.value);
    }
    if (passanger2.present) {
      map['passanger2'] = Variable<int?>(passanger2.value);
    }
    if (passanger3.present) {
      map['passanger3'] = Variable<int?>(passanger3.value);
    }
    if (passanger4.present) {
      map['passanger4'] = Variable<int?>(passanger4.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RideCompanion(')
          ..write('id: $id, ')
          ..write('owner: $owner, ')
          ..write('ownerName: $ownerName, ')
          ..write('type: $type, ')
          ..write('from: $from, ')
          ..write('waypoint: $waypoint, ')
          ..write('to: $to, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('car: $car, ')
          ..write('isPackageTransfer: $isPackageTransfer, ')
          ..write('isTwoBackSeat: $isTwoBackSeat, ')
          ..write('isBagadgeTransfer: $isBagadgeTransfer, ')
          ..write('isChildSeat: $isChildSeat, ')
          ..write('isCondition: $isCondition, ')
          ..write('isSmoking: $isSmoking, ')
          ..write('isPetTransfer: $isPetTransfer, ')
          ..write('isPickUpFromHome: $isPickUpFromHome, ')
          ..write('price: $price, ')
          ..write('passanger1: $passanger1, ')
          ..write('passanger2: $passanger2, ')
          ..write('passanger3: $passanger3, ')
          ..write('passanger4: $passanger4')
          ..write(')'))
        .toString();
  }
}

class $RideTable extends Ride with TableInfo<$RideTable, RideData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RideTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _ownerMeta = const VerificationMeta('owner');
  @override
  late final GeneratedColumn<int?> owner = GeneratedColumn<int?>(
      'owner', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _ownerNameMeta = const VerificationMeta('ownerName');
  @override
  late final GeneratedColumn<String?> ownerName = GeneratedColumn<String?>(
      'owner_name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String?> type = GeneratedColumn<String?>(
      'type', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _fromMeta = const VerificationMeta('from');
  @override
  late final GeneratedColumn<String?> from = GeneratedColumn<String?>(
      'from', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _waypointMeta = const VerificationMeta('waypoint');
  @override
  late final GeneratedColumn<String?> waypoint = GeneratedColumn<String?>(
      'waypoint', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _toMeta = const VerificationMeta('to');
  @override
  late final GeneratedColumn<String?> to = GeneratedColumn<String?>(
      'to', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime?> time = GeneratedColumn<DateTime?>(
      'time', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _carMeta = const VerificationMeta('car');
  @override
  late final GeneratedColumn<String?> car = GeneratedColumn<String?>(
      'car', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _isPackageTransferMeta =
      const VerificationMeta('isPackageTransfer');
  @override
  late final GeneratedColumn<bool?> isPackageTransfer = GeneratedColumn<bool?>(
      'is_package_transfer', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_package_transfer IN (0, 1))');
  final VerificationMeta _isTwoBackSeatMeta =
      const VerificationMeta('isTwoBackSeat');
  @override
  late final GeneratedColumn<bool?> isTwoBackSeat = GeneratedColumn<bool?>(
      'is_two_back_seat', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_two_back_seat IN (0, 1))');
  final VerificationMeta _isBagadgeTransferMeta =
      const VerificationMeta('isBagadgeTransfer');
  @override
  late final GeneratedColumn<bool?> isBagadgeTransfer = GeneratedColumn<bool?>(
      'is_bagadge_transfer', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_bagadge_transfer IN (0, 1))');
  final VerificationMeta _isChildSeatMeta =
      const VerificationMeta('isChildSeat');
  @override
  late final GeneratedColumn<bool?> isChildSeat = GeneratedColumn<bool?>(
      'is_child_seat', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_child_seat IN (0, 1))');
  final VerificationMeta _isConditionMeta =
      const VerificationMeta('isCondition');
  @override
  late final GeneratedColumn<bool?> isCondition = GeneratedColumn<bool?>(
      'is_condition', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_condition IN (0, 1))');
  final VerificationMeta _isSmokingMeta = const VerificationMeta('isSmoking');
  @override
  late final GeneratedColumn<bool?> isSmoking = GeneratedColumn<bool?>(
      'is_smoking', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_smoking IN (0, 1))');
  final VerificationMeta _isPetTransferMeta =
      const VerificationMeta('isPetTransfer');
  @override
  late final GeneratedColumn<bool?> isPetTransfer = GeneratedColumn<bool?>(
      'is_pet_transfer', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_pet_transfer IN (0, 1))');
  final VerificationMeta _isPickUpFromHomeMeta =
      const VerificationMeta('isPickUpFromHome');
  @override
  late final GeneratedColumn<bool?> isPickUpFromHome = GeneratedColumn<bool?>(
      'is_pick_up_from_home', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_pick_up_from_home IN (0, 1))');
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double?> price = GeneratedColumn<double?>(
      'price', aliasedName, true,
      type: const RealType(), requiredDuringInsert: false);
  final VerificationMeta _passanger1Meta = const VerificationMeta('passanger1');
  @override
  late final GeneratedColumn<int?> passanger1 = GeneratedColumn<int?>(
      'passanger1', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _passanger2Meta = const VerificationMeta('passanger2');
  @override
  late final GeneratedColumn<int?> passanger2 = GeneratedColumn<int?>(
      'passanger2', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _passanger3Meta = const VerificationMeta('passanger3');
  @override
  late final GeneratedColumn<int?> passanger3 = GeneratedColumn<int?>(
      'passanger3', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _passanger4Meta = const VerificationMeta('passanger4');
  @override
  late final GeneratedColumn<int?> passanger4 = GeneratedColumn<int?>(
      'passanger4', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        owner,
        ownerName,
        type,
        from,
        waypoint,
        to,
        date,
        time,
        car,
        isPackageTransfer,
        isTwoBackSeat,
        isBagadgeTransfer,
        isChildSeat,
        isCondition,
        isSmoking,
        isPetTransfer,
        isPickUpFromHome,
        price,
        passanger1,
        passanger2,
        passanger3,
        passanger4
      ];
  @override
  String get aliasedName => _alias ?? 'ride';
  @override
  String get actualTableName => 'ride';
  @override
  VerificationContext validateIntegrity(Insertable<RideData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('owner')) {
      context.handle(
          _ownerMeta, owner.isAcceptableOrUnknown(data['owner']!, _ownerMeta));
    }
    if (data.containsKey('owner_name')) {
      context.handle(_ownerNameMeta,
          ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('from')) {
      context.handle(
          _fromMeta, from.isAcceptableOrUnknown(data['from']!, _fromMeta));
    }
    if (data.containsKey('waypoint')) {
      context.handle(_waypointMeta,
          waypoint.isAcceptableOrUnknown(data['waypoint']!, _waypointMeta));
    }
    if (data.containsKey('to')) {
      context.handle(_toMeta, to.isAcceptableOrUnknown(data['to']!, _toMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    }
    if (data.containsKey('car')) {
      context.handle(
          _carMeta, car.isAcceptableOrUnknown(data['car']!, _carMeta));
    }
    if (data.containsKey('is_package_transfer')) {
      context.handle(
          _isPackageTransferMeta,
          isPackageTransfer.isAcceptableOrUnknown(
              data['is_package_transfer']!, _isPackageTransferMeta));
    }
    if (data.containsKey('is_two_back_seat')) {
      context.handle(
          _isTwoBackSeatMeta,
          isTwoBackSeat.isAcceptableOrUnknown(
              data['is_two_back_seat']!, _isTwoBackSeatMeta));
    }
    if (data.containsKey('is_bagadge_transfer')) {
      context.handle(
          _isBagadgeTransferMeta,
          isBagadgeTransfer.isAcceptableOrUnknown(
              data['is_bagadge_transfer']!, _isBagadgeTransferMeta));
    }
    if (data.containsKey('is_child_seat')) {
      context.handle(
          _isChildSeatMeta,
          isChildSeat.isAcceptableOrUnknown(
              data['is_child_seat']!, _isChildSeatMeta));
    }
    if (data.containsKey('is_condition')) {
      context.handle(
          _isConditionMeta,
          isCondition.isAcceptableOrUnknown(
              data['is_condition']!, _isConditionMeta));
    }
    if (data.containsKey('is_smoking')) {
      context.handle(_isSmokingMeta,
          isSmoking.isAcceptableOrUnknown(data['is_smoking']!, _isSmokingMeta));
    }
    if (data.containsKey('is_pet_transfer')) {
      context.handle(
          _isPetTransferMeta,
          isPetTransfer.isAcceptableOrUnknown(
              data['is_pet_transfer']!, _isPetTransferMeta));
    }
    if (data.containsKey('is_pick_up_from_home')) {
      context.handle(
          _isPickUpFromHomeMeta,
          isPickUpFromHome.isAcceptableOrUnknown(
              data['is_pick_up_from_home']!, _isPickUpFromHomeMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    }
    if (data.containsKey('passanger1')) {
      context.handle(
          _passanger1Meta,
          passanger1.isAcceptableOrUnknown(
              data['passanger1']!, _passanger1Meta));
    }
    if (data.containsKey('passanger2')) {
      context.handle(
          _passanger2Meta,
          passanger2.isAcceptableOrUnknown(
              data['passanger2']!, _passanger2Meta));
    }
    if (data.containsKey('passanger3')) {
      context.handle(
          _passanger3Meta,
          passanger3.isAcceptableOrUnknown(
              data['passanger3']!, _passanger3Meta));
    }
    if (data.containsKey('passanger4')) {
      context.handle(
          _passanger4Meta,
          passanger4.isAcceptableOrUnknown(
              data['passanger4']!, _passanger4Meta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RideData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return RideData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $RideTable createAlias(String alias) {
    return $RideTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UserTable user = $UserTable(this);
  late final $CarTable car = $CarTable(this);
  late final $BalanceTable balance = $BalanceTable(this);
  late final $RideTable ride = $RideTable(this);
  late final UserDao userDao = UserDao(this as MyDatabase);
  late final CarDao carDao = CarDao(this as MyDatabase);
  late final BalanceDao balanceDao = BalanceDao(this as MyDatabase);
  late final RideDao rideDao = RideDao(this as MyDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [user, car, balance, ride];
}
