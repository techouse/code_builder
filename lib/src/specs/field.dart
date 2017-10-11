// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.specs.field;

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../mixins/annotations.dart';
import '../mixins/dartdoc.dart';
import '../visitors.dart';
import 'annotation.dart';
import 'code.dart';
import 'reference.dart';
import 'type_reference.dart';

part 'field.g.dart';

@immutable
abstract class Field extends Object
    with HasAnnotations, HasDartDocs
    implements Built<Field, FieldBuilder>, Reference, Spec {
  factory Field([void updates(FieldBuilder b)]) = _$Field;

  Field._();

  @override
  BuiltList<Annotation> get annotations;

  @override
  BuiltList<String> get docs;

  /// Field assignment, if any.
  @nullable
  Code get assignment;

  /// Whether this field should be prefixed with `static`.
  ///
  /// This is only valid within classes.
  bool get static;

  /// Name of the field.
  String get name;

  @nullable
  Reference get type;

  FieldModifier get modifier;

  @override
  String get symbol => name;

  @override
  String get url => null;

  @override
  R accept<R>(
    SpecVisitor<R> visitor, [
    R context,
  ]) =>
      visitor.visitField(this, context);

  @override
  TypeReference toType() => throw new UnsupportedError('');
}

enum FieldModifier {
  var$,
  final$,
  constant,
}

abstract class FieldBuilder extends Object
    with HasAnnotationsBuilder, HasDartDocsBuilder
    implements Builder<Field, FieldBuilder> {
  factory FieldBuilder() = _$FieldBuilder;

  FieldBuilder._();

  @override
  ListBuilder<Annotation> annotations = new ListBuilder<Annotation>();

  @override
  ListBuilder<String> docs = new ListBuilder<String>();

  /// Field assignment, if any.
  Code assignment;

  /// Whether this field should be prefixed with `static`.
  ///
  /// This is only valid within classes.
  bool static = false;

  /// Name of the field.
  String name;

  Reference type;

  FieldModifier modifier = FieldModifier.var$;
}