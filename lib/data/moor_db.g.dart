// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_db.dart';

// ignore_for_file: type=lint
class $BlogPostsTable extends BlogPosts
    with TableInfo<$BlogPostsTable, BlogPost> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlogPostsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 80),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, content, date];
  @override
  String get aliasedName => _alias ?? 'blog_posts';
  @override
  String get actualTableName => 'blog_posts';
  @override
  VerificationContext validateIntegrity(Insertable<BlogPost> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BlogPost map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BlogPost(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date']),
    );
  }

  @override
  $BlogPostsTable createAlias(String alias) {
    return $BlogPostsTable(attachedDatabase, alias);
  }
}

class BlogPost extends DataClass implements Insertable<BlogPost> {
  final int id;
  final String name;
  final String? content;
  final DateTime? date;
  const BlogPost(
      {required this.id, required this.name, this.content, this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    return map;
  }

  BlogPostsCompanion toCompanion(bool nullToAbsent) {
    return BlogPostsCompanion(
      id: Value(id),
      name: Value(name),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  factory BlogPost.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BlogPost(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      content: serializer.fromJson<String?>(json['content']),
      date: serializer.fromJson<DateTime?>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'content': serializer.toJson<String?>(content),
      'date': serializer.toJson<DateTime?>(date),
    };
  }

  BlogPost copyWith(
          {int? id,
          String? name,
          Value<String?> content = const Value.absent(),
          Value<DateTime?> date = const Value.absent()}) =>
      BlogPost(
        id: id ?? this.id,
        name: name ?? this.name,
        content: content.present ? content.value : this.content,
        date: date.present ? date.value : this.date,
      );
  @override
  String toString() {
    return (StringBuffer('BlogPost(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('content: $content, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, content, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BlogPost &&
          other.id == this.id &&
          other.name == this.name &&
          other.content == this.content &&
          other.date == this.date);
}

class BlogPostsCompanion extends UpdateCompanion<BlogPost> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> content;
  final Value<DateTime?> date;
  const BlogPostsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.content = const Value.absent(),
    this.date = const Value.absent(),
  });
  BlogPostsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.content = const Value.absent(),
    this.date = const Value.absent(),
  }) : name = Value(name);
  static Insertable<BlogPost> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? content,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (content != null) 'content': content,
      if (date != null) 'date': date,
    });
  }

  BlogPostsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? content,
      Value<DateTime?>? date}) {
    return BlogPostsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlogPostsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('content: $content, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

abstract class _$BlogDb extends GeneratedDatabase {
  _$BlogDb(QueryExecutor e) : super(e);
  late final $BlogPostsTable blogPosts = $BlogPostsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [blogPosts];
}
