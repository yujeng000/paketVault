// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_photo.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDeliveryPhotoCollection on Isar {
  IsarCollection<DeliveryPhoto> get deliveryPhotos => this.collection();
}

const DeliveryPhotoSchema = CollectionSchema(
  name: r'DeliveryPhoto',
  id: -7424682081113993668,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'evidenceId': PropertySchema(
      id: 1,
      name: r'evidenceId',
      type: IsarType.long,
    ),
    r'evidenceResi': PropertySchema(
      id: 2,
      name: r'evidenceResi',
      type: IsarType.string,
    ),
    r'localPath': PropertySchema(
      id: 3,
      name: r'localPath',
      type: IsarType.string,
    ),
    r'photoTypeValue': PropertySchema(
      id: 4,
      name: r'photoTypeValue',
      type: IsarType.long,
    ),
    r'supabaseStoragePath': PropertySchema(
      id: 5,
      name: r'supabaseStoragePath',
      type: IsarType.string,
    ),
  },

  estimateSize: _deliveryPhotoEstimateSize,
  serialize: _deliveryPhotoSerialize,
  deserialize: _deliveryPhotoDeserialize,
  deserializeProp: _deliveryPhotoDeserializeProp,
  idName: r'id',
  indexes: {
    r'evidenceId': IndexSchema(
      id: -6687577171979035414,
      name: r'evidenceId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'evidenceId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'evidenceResi': IndexSchema(
      id: 3890127274289192891,
      name: r'evidenceResi',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'evidenceResi',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _deliveryPhotoGetId,
  getLinks: _deliveryPhotoGetLinks,
  attach: _deliveryPhotoAttach,
  version: '3.3.2',
);

int _deliveryPhotoEstimateSize(
  DeliveryPhoto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.evidenceResi.length * 3;
  bytesCount += 3 + object.localPath.length * 3;
  {
    final value = object.supabaseStoragePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _deliveryPhotoSerialize(
  DeliveryPhoto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeLong(offsets[1], object.evidenceId);
  writer.writeString(offsets[2], object.evidenceResi);
  writer.writeString(offsets[3], object.localPath);
  writer.writeLong(offsets[4], object.photoTypeValue);
  writer.writeString(offsets[5], object.supabaseStoragePath);
}

DeliveryPhoto _deliveryPhotoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DeliveryPhoto();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.evidenceId = reader.readLong(offsets[1]);
  object.evidenceResi = reader.readString(offsets[2]);
  object.id = id;
  object.localPath = reader.readString(offsets[3]);
  object.photoTypeValue = reader.readLong(offsets[4]);
  object.supabaseStoragePath = reader.readStringOrNull(offsets[5]);
  return object;
}

P _deliveryPhotoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _deliveryPhotoGetId(DeliveryPhoto object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _deliveryPhotoGetLinks(DeliveryPhoto object) {
  return [];
}

void _deliveryPhotoAttach(
  IsarCollection<dynamic> col,
  Id id,
  DeliveryPhoto object,
) {
  object.id = id;
}

extension DeliveryPhotoQueryWhereSort
    on QueryBuilder<DeliveryPhoto, DeliveryPhoto, QWhere> {
  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterWhere> anyEvidenceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'evidenceId'),
      );
    });
  }
}

extension DeliveryPhotoQueryWhere
    on QueryBuilder<DeliveryPhoto, DeliveryPhoto, QWhereClause> {
  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterWhereClause>
  evidenceIdEqualTo(int evidenceId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'evidenceId', value: [evidenceId]),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterWhereClause>
  evidenceIdNotEqualTo(int evidenceId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'evidenceId',
                lower: [],
                upper: [evidenceId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'evidenceId',
                lower: [evidenceId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'evidenceId',
                lower: [evidenceId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'evidenceId',
                lower: [],
                upper: [evidenceId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterWhereClause>
  evidenceIdGreaterThan(int evidenceId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'evidenceId',
          lower: [evidenceId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterWhereClause>
  evidenceIdLessThan(int evidenceId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'evidenceId',
          lower: [],
          upper: [evidenceId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterWhereClause>
  evidenceIdBetween(
    int lowerEvidenceId,
    int upperEvidenceId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'evidenceId',
          lower: [lowerEvidenceId],
          includeLower: includeLower,
          upper: [upperEvidenceId],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterWhereClause>
  evidenceResiEqualTo(String evidenceResi) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'evidenceResi',
          value: [evidenceResi],
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterWhereClause>
  evidenceResiNotEqualTo(String evidenceResi) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'evidenceResi',
                lower: [],
                upper: [evidenceResi],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'evidenceResi',
                lower: [evidenceResi],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'evidenceResi',
                lower: [evidenceResi],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'evidenceResi',
                lower: [],
                upper: [evidenceResi],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension DeliveryPhotoQueryFilter
    on QueryBuilder<DeliveryPhoto, DeliveryPhoto, QFilterCondition> {
  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  evidenceIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'evidenceId', value: value),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  evidenceIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'evidenceId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  evidenceIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'evidenceId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  evidenceIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'evidenceId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  evidenceResiEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'evidenceResi',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  evidenceResiGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'evidenceResi',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  evidenceResiLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'evidenceResi',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  evidenceResiBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'evidenceResi',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  evidenceResiStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'evidenceResi',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  evidenceResiEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'evidenceResi',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  evidenceResiContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'evidenceResi',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  evidenceResiMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'evidenceResi',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  evidenceResiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'evidenceResi', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  evidenceResiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'evidenceResi', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  localPathEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'localPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  localPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'localPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  localPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'localPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  localPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'localPath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  localPathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'localPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  localPathEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'localPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  localPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'localPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  localPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'localPath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  localPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'localPath', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  localPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'localPath', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  photoTypeValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'photoTypeValue', value: value),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  photoTypeValueGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'photoTypeValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  photoTypeValueLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'photoTypeValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  photoTypeValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'photoTypeValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  supabaseStoragePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'supabaseStoragePath'),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  supabaseStoragePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'supabaseStoragePath'),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  supabaseStoragePathEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'supabaseStoragePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  supabaseStoragePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'supabaseStoragePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  supabaseStoragePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'supabaseStoragePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  supabaseStoragePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'supabaseStoragePath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  supabaseStoragePathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'supabaseStoragePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  supabaseStoragePathEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'supabaseStoragePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  supabaseStoragePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'supabaseStoragePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  supabaseStoragePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'supabaseStoragePath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  supabaseStoragePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'supabaseStoragePath', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterFilterCondition>
  supabaseStoragePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'supabaseStoragePath',
          value: '',
        ),
      );
    });
  }
}

extension DeliveryPhotoQueryObject
    on QueryBuilder<DeliveryPhoto, DeliveryPhoto, QFilterCondition> {}

extension DeliveryPhotoQueryLinks
    on QueryBuilder<DeliveryPhoto, DeliveryPhoto, QFilterCondition> {}

extension DeliveryPhotoQuerySortBy
    on QueryBuilder<DeliveryPhoto, DeliveryPhoto, QSortBy> {
  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy> sortByEvidenceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evidenceId', Sort.asc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  sortByEvidenceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evidenceId', Sort.desc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  sortByEvidenceResi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evidenceResi', Sort.asc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  sortByEvidenceResiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evidenceResi', Sort.desc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy> sortByLocalPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localPath', Sort.asc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  sortByLocalPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localPath', Sort.desc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  sortByPhotoTypeValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoTypeValue', Sort.asc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  sortByPhotoTypeValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoTypeValue', Sort.desc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  sortBySupabaseStoragePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseStoragePath', Sort.asc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  sortBySupabaseStoragePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseStoragePath', Sort.desc);
    });
  }
}

extension DeliveryPhotoQuerySortThenBy
    on QueryBuilder<DeliveryPhoto, DeliveryPhoto, QSortThenBy> {
  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy> thenByEvidenceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evidenceId', Sort.asc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  thenByEvidenceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evidenceId', Sort.desc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  thenByEvidenceResi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evidenceResi', Sort.asc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  thenByEvidenceResiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evidenceResi', Sort.desc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy> thenByLocalPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localPath', Sort.asc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  thenByLocalPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localPath', Sort.desc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  thenByPhotoTypeValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoTypeValue', Sort.asc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  thenByPhotoTypeValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoTypeValue', Sort.desc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  thenBySupabaseStoragePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseStoragePath', Sort.asc);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QAfterSortBy>
  thenBySupabaseStoragePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseStoragePath', Sort.desc);
    });
  }
}

extension DeliveryPhotoQueryWhereDistinct
    on QueryBuilder<DeliveryPhoto, DeliveryPhoto, QDistinct> {
  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QDistinct> distinctByEvidenceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'evidenceId');
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QDistinct> distinctByEvidenceResi({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'evidenceResi', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QDistinct> distinctByLocalPath({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QDistinct>
  distinctByPhotoTypeValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoTypeValue');
    });
  }

  QueryBuilder<DeliveryPhoto, DeliveryPhoto, QDistinct>
  distinctBySupabaseStoragePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'supabaseStoragePath',
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension DeliveryPhotoQueryProperty
    on QueryBuilder<DeliveryPhoto, DeliveryPhoto, QQueryProperty> {
  QueryBuilder<DeliveryPhoto, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DeliveryPhoto, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<DeliveryPhoto, int, QQueryOperations> evidenceIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'evidenceId');
    });
  }

  QueryBuilder<DeliveryPhoto, String, QQueryOperations> evidenceResiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'evidenceResi');
    });
  }

  QueryBuilder<DeliveryPhoto, String, QQueryOperations> localPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localPath');
    });
  }

  QueryBuilder<DeliveryPhoto, int, QQueryOperations> photoTypeValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoTypeValue');
    });
  }

  QueryBuilder<DeliveryPhoto, String?, QQueryOperations>
  supabaseStoragePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supabaseStoragePath');
    });
  }
}
