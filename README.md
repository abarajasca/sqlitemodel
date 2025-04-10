## Sqlitemodel

Is a library to handle a model repository for SQLite.

## Features

- Light library, providing a generic class to handle all CRUD operations and queries for SQLite.
- A memory database class is provided to implement unit and integration testing.

## Getting started

1. Download library in your repository path
  [sqlitemodel library](http://google.com)

2. Add library reference in pubspec.yaml file:
```yaml
dependencies:
  sqlitemodel:
    path: ../sqlitemodel/
```

3. Update pub get.



## Usage

1. Create a model.
```dart
import 'package:flutter/material.dart';
import 'package:sqlitemodel/model/model_base.dart';

class Category extends ModelBase {
  final int? id;
  final String name;
  final int color;

  static const TABLE_NAME = 'categories';

  Category({this.id,required this.name,required this.color});

  // Convert a entity into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color
    };
  }

  // Implement toString to make it easier to see information about
  // each portfolio when using the print statement.
  @override
  String toString() {
    return 'Category{id: $id, name: $name, color: $color}';
  }

  @override
  int? getId(){
    return id;
  }

  @override
  dynamic create(Map<String, dynamic> map) {
    return Category(id: map['id'] != null ? map['id'] : null, name: map['name'], color: map['color']);
  }

  @override
  static dynamic getDummyReference() {
    return Category(id: 1, name: 'dummy',color: Colors.blue.value);
  }

  @override
  String getTableName(){
    return TABLE_NAME;
  }

}
```

2. Create a model provider using SqLiteDatabase
```dart
var categories = ModelProvider<Category>(databaseProvider:SqLiteDatabase(), model: Category.getDummyReference());
```

3. Use model provider to execute operations in the database table.
```dart
await categories.insert(Category(
        name: 'Category 1',
        color: 4280391411)        
    );

var firstCategory = (await categories.getAll()).first;
print(firstCategory);
```

Example query to get all categories used in notes:

```dart
var categoriesUsed = (await categories.rawQuery(
              'select distinct( id_category ) as idCategory from notes'))
          .map((item) {
        return item['idCategory'] as int;
      }).toList();
```

#### Adding notes table using a link to categories.

```dart
import 'package:sqlitemodel/model/model_base.dart';

import 'category.dart';

class Note extends ModelBase {
  late int? id;
  final int idCategory;
  late String title;
  late String body;
  late String created_at;
  late String updated_at;
  late Category _category;

  static const TABLE_NAME = 'notes';

  Note(
      {this.id,
        required this.title,
        required this.body,
        required this.created_at,
        required this.updated_at,
        required this.idCategory});

  // Convert a Entity into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'created_at': created_at,
      'updated_at': updated_at,
      'id_category': idCategory,
    };
  }

  // Implement toString to make it easier to see information about
  // each portfolio when using the print statement.
  @override
  String toString() {
    return 'Note{id: $id, title: $title, body: $body, created_at: $created_at, created_at: $created_at, id_category: $idCategory}';
  }

  @override
  int? getId() {
    return id;
  }

  @override
  dynamic create(Map<String, dynamic> map) {
    return Note(
        id: map['id'] != null ? map['id'] : null,
        title: map['title'],
        body: map['body'] ?? '',
        created_at: map['created_at'] ?? '',
        updated_at: map['updated_at'] ?? '',
        idCategory: map['id_category']);
  }

  @override
  static dynamic getDummyReference() {
    return Note(id: 1, title: 'dummy', body: '', created_at: '',updated_at: '', idCategory: 1);
  }

  @override
  String getTableName() {
    return TABLE_NAME;
  }

  Category get category {
    return _category;
  }

  void set category(Category category){
    _category = category;
  }

}

```

Fetch data example:
```dart
  Future<List<Selectable>> fetchData() async {
    if (refreshData) {
      List<Category> categories = (await Store.categories.getAll());
      dataModel =
          (await Store.notes.getAll()).map<Selectable<Note>>((Note note) {
        return Selectable(model: note, isSelected: false);
      }).toList();
      dataModel.forEach((item) {
        item.model.category = categories
            .firstWhere((element) => element.id == item.model.idCategory);
      });
      refreshData = false;
    }
    sort_data();
    return dataModel;
  }
```

## Additional information

Review full implementation of this library in [Abc Notes App](https://github.com/abarajasca/abc_notes).