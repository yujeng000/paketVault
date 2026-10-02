// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_evidence.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDeliveryEvidenceCollection on Isar {
  IsarCollection<DeliveryEvidence> get deliveryEvidences => this.collection();
}

const DeliveryEvidenceSchema = CollectionSchema(
  name: r'DeliveryEvidence',
  id: -706198516382369534,
  properties: {
    r'catatan': PropertySchema(id: 0, name: r'catatan', type: IsarType.string),
    r'gpsAkurasi': PropertySchema(
      id: 1,
      name: r'gpsAkurasi',
      type: IsarType.double,
    ),
    r'latitude': PropertySchema(
      id: 2,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'longitude': PropertySchema(
      id: 3,
      name: r'longitude',
      type: IsarType.double,
    ),
    r'namaPemilik': PropertySchema(
      id: 4,
      name: r'namaPemilik',
      type: IsarType.string,
    ),
    r'namaPenerima': PropertySchema(
      id: 5,
      name: r'namaPenerima',
      type: IsarType.string,
    ),
    r'nomorHp': PropertySchema(id: 6, name: r'nomorHp', type: IsarType.string),
    r'resi': PropertySchema(id: 7, name: r'resi', type: IsarType.string),
    r'supabaseId': PropertySchema(
      id: 8,
      name: r'supabaseId',
      type: IsarType.string,
    ),
    r'syncStatusValue': PropertySchema(
      id: 9,
      name: r'syncStatusValue',
      type: IsarType.long,
    ),
    r'waktu': PropertySchema(id: 10, name: r'waktu', type: IsarType.dateTime),
  },

  estimateSize: _deliveryEvidenceEstimateSize,
  serialize: _deliveryEvidenceSerialize,
  deserialize: _deliveryEvidenceDeserialize,
  deserializeProp: _deliveryEvidenceDeserializeProp,
  idName: r'id',
  indexes: {
    r'resi': IndexSchema(
      id: -6741155358265643362,
      name: r'resi',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'resi',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'waktu': IndexSchema(
      id: -4204409312096578441,
      name: r'waktu',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'waktu',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _deliveryEvidenceGetId,
  getLinks: _deliveryEvidenceGetLinks,
  attach: _deliveryEvidenceAttach,
  version: '3.3.2',
);

int _deliveryEvidenceEstimateSize(
  DeliveryEvidence object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.catatan;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.namaPemilik;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.namaPenerima;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nomorHp;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.resi.length * 3;
  {
    final value = object.supabaseId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _deliveryEvidenceSerialize(
  DeliveryEvidence object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.catatan);
  writer.writeDouble(offsets[1], object.gpsAkurasi);
  writer.writeDouble(offsets[2], object.latitude);
  writer.writeDouble(offsets[3], object.longitude);
  writer.writeString(offsets[4], object.namaPemilik);
  writer.writeString(offsets[5], object.namaPenerima);
  writer.writeString(offsets[6], object.nomorHp);
  writer.writeString(offsets[7], object.resi);
  writer.writeString(offsets[8], object.supabaseId);
  writer.writeLong(offsets[9], object.syncStatusValue);
  writer.writeDateTime(offsets[10], object.waktu);
}

DeliveryEvidence _deliveryEvidenceDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DeliveryEvidence();
  object.catatan = reader.readStringOrNull(offsets[0]);
  object.gpsAkurasi = reader.readDoubleOrNull(offsets[1]);
  object.id = id;
  object.latitude = reader.readDoubleOrNull(offsets[2]);
  object.longitude = reader.readDoubleOrNull(offsets[3]);
  object.namaPemilik = reader.readStringOrNull(offsets[4]);
  object.namaPenerima = reader.readStringOrNull(offsets[5]);
  object.nomorHp = reader.readStringOrNull(offsets[6]);
  object.resi = reader.readString(offsets[7]);
  object.supabaseId = reader.readStringOrNull(offsets[8]);
  object.syncStatusValue = reader.readLong(offsets[9]);
  object.waktu = reader.readDateTime(offsets[10]);
  return object;
}

P _deliveryEvidenceDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _deliveryEvidenceGetId(DeliveryEvidence object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _deliveryEvidenceGetLinks(DeliveryEvidence object) {
  return [];
}

void _deliveryEvidenceAttach(
  IsarCollection<dynamic> col,
  Id id,
  DeliveryEvidence object,
) {
  object.id = id;
}

extension DeliveryEvidenceByIndex on IsarCollection<DeliveryEvidence> {
  Future<DeliveryEvidence?> getByResi(String resi) {
    return getByIndex(r'resi', [resi]);
  }

  DeliveryEvidence? getByResiSync(String resi) {
    return getByIndexSync(r'resi', [resi]);
  }

  Future<bool> deleteByResi(String resi) {
    return deleteByIndex(r'resi', [resi]);
  }

  bool deleteByResiSync(String resi) {
    return deleteByIndexSync(r'resi', [resi]);
  }

  Future<List<DeliveryEvidence?>> getAllByResi(List<String> resiValues) {
    final values = resiValues.map((e) => [e]).toList();
    return getAllByIndex(r'resi', values);
  }

  List<DeliveryEvidence?> getAllByResiSync(List<String> resiValues) {
    final values = resiValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'resi', values);
  }

  Future<int> deleteAllByResi(List<String> resiValues) {
    final values = resiValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'resi', values);
  }

  int deleteAllByResiSync(List<String> resiValues) {
    final values = resiValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'resi', values);
  }

  Future<Id> putByResi(DeliveryEvidence object) {
    return putByIndex(r'resi', object);
  }

  Id putByResiSync(DeliveryEvidence object, {bool saveLinks = true}) {
    return putByIndexSync(r'resi', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByResi(List<DeliveryEvidence> objects) {
    return putAllByIndex(r'resi', objects);
  }

  List<Id> putAllByResiSync(
    List<DeliveryEvidence> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'resi', objects, saveLinks: saveLinks);
  }
}

extension DeliveryEvidenceQueryWhereSort
    on QueryBuilder<DeliveryEvidence, DeliveryEvidence, QWhere> {
  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterWhere> anyWaktu() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'waktu'),
      );
    });
  }
}

extension DeliveryEvidenceQueryWhere
    on QueryBuilder<DeliveryEvidence, DeliveryEvidence, QWhereClause> {
  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterWhereClause>
  idNotEqualTo(Id id) {
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

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterWhereClause> idBetween(
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

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterWhereClause>
  resiEqualTo(String resi) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'resi', value: [resi]),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterWhereClause>
  resiNotEqualTo(String resi) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'resi',
                lower: [],
                upper: [resi],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'resi',
                lower: [resi],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'resi',
                lower: [resi],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'resi',
                lower: [],
                upper: [resi],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterWhereClause>
  waktuEqualTo(DateTime waktu) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'waktu', value: [waktu]),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterWhereClause>
  waktuNotEqualTo(DateTime waktu) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waktu',
                lower: [],
                upper: [waktu],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waktu',
                lower: [waktu],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waktu',
                lower: [waktu],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waktu',
                lower: [],
                upper: [waktu],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterWhereClause>
  waktuGreaterThan(DateTime waktu, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'waktu',
          lower: [waktu],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterWhereClause>
  waktuLessThan(DateTime waktu, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'waktu',
          lower: [],
          upper: [waktu],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterWhereClause>
  waktuBetween(
    DateTime lowerWaktu,
    DateTime upperWaktu, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'waktu',
          lower: [lowerWaktu],
          includeLower: includeLower,
          upper: [upperWaktu],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension DeliveryEvidenceQueryFilter
    on QueryBuilder<DeliveryEvidence, DeliveryEvidence, QFilterCondition> {
  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  catatanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'catatan'),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  catatanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'catatan'),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  catatanEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'catatan',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  catatanGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'catatan',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  catatanLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'catatan',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  catatanBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'catatan',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  catatanStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'catatan',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  catatanEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'catatan',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  catatanContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'catatan',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  catatanMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'catatan',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  catatanIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'catatan', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  catatanIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'catatan', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  gpsAkurasiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'gpsAkurasi'),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  gpsAkurasiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'gpsAkurasi'),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  gpsAkurasiEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'gpsAkurasi',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  gpsAkurasiGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'gpsAkurasi',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  gpsAkurasiLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'gpsAkurasi',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  gpsAkurasiBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'gpsAkurasi',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
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

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
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

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  idBetween(
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

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  latitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'latitude'),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  latitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'latitude'),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  latitudeEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'latitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  latitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'latitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  latitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'latitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  latitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'latitude',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  longitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'longitude'),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  longitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'longitude'),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  longitudeEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'longitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  longitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'longitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  longitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'longitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  longitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'longitude',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPemilikIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'namaPemilik'),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPemilikIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'namaPemilik'),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPemilikEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'namaPemilik',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPemilikGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'namaPemilik',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPemilikLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'namaPemilik',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPemilikBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'namaPemilik',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPemilikStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'namaPemilik',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPemilikEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'namaPemilik',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPemilikContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'namaPemilik',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPemilikMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'namaPemilik',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPemilikIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'namaPemilik', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPemilikIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'namaPemilik', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPenerimaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'namaPenerima'),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPenerimaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'namaPenerima'),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPenerimaEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'namaPenerima',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPenerimaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'namaPenerima',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPenerimaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'namaPenerima',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPenerimaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'namaPenerima',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPenerimaStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'namaPenerima',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPenerimaEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'namaPenerima',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPenerimaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'namaPenerima',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPenerimaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'namaPenerima',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPenerimaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'namaPenerima', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  namaPenerimaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'namaPenerima', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  nomorHpIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'nomorHp'),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  nomorHpIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'nomorHp'),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  nomorHpEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'nomorHp',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  nomorHpGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'nomorHp',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  nomorHpLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'nomorHp',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  nomorHpBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'nomorHp',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  nomorHpStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'nomorHp',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  nomorHpEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'nomorHp',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  nomorHpContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'nomorHp',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  nomorHpMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'nomorHp',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  nomorHpIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nomorHp', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  nomorHpIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nomorHp', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  resiEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'resi',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  resiGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'resi',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  resiLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'resi',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  resiBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'resi',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  resiStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'resi',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  resiEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'resi',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  resiContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'resi',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  resiMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'resi',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  resiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'resi', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  resiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'resi', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  supabaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'supabaseId'),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  supabaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'supabaseId'),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  supabaseIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'supabaseId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  supabaseIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'supabaseId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  supabaseIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'supabaseId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  supabaseIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'supabaseId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  supabaseIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'supabaseId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  supabaseIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'supabaseId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  supabaseIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'supabaseId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  supabaseIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'supabaseId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  supabaseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'supabaseId', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  supabaseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'supabaseId', value: ''),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  syncStatusValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'syncStatusValue', value: value),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  syncStatusValueGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'syncStatusValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  syncStatusValueLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'syncStatusValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  syncStatusValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'syncStatusValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  waktuEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'waktu', value: value),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  waktuGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'waktu',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  waktuLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'waktu',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterFilterCondition>
  waktuBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'waktu',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension DeliveryEvidenceQueryObject
    on QueryBuilder<DeliveryEvidence, DeliveryEvidence, QFilterCondition> {}

extension DeliveryEvidenceQueryLinks
    on QueryBuilder<DeliveryEvidence, DeliveryEvidence, QFilterCondition> {}

extension DeliveryEvidenceQuerySortBy
    on QueryBuilder<DeliveryEvidence, DeliveryEvidence, QSortBy> {
  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortByCatatan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'catatan', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortByCatatanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'catatan', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortByGpsAkurasi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsAkurasi', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortByGpsAkurasiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsAkurasi', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortByNamaPemilik() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaPemilik', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortByNamaPemilikDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaPemilik', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortByNamaPenerima() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaPenerima', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortByNamaPenerimaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaPenerima', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortByNomorHp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomorHp', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortByNomorHpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomorHp', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy> sortByResi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resi', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortByResiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resi', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortBySupabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortBySupabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortBySyncStatusValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatusValue', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortBySyncStatusValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatusValue', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy> sortByWaktu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waktu', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  sortByWaktuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waktu', Sort.desc);
    });
  }
}

extension DeliveryEvidenceQuerySortThenBy
    on QueryBuilder<DeliveryEvidence, DeliveryEvidence, QSortThenBy> {
  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByCatatan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'catatan', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByCatatanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'catatan', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByGpsAkurasi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsAkurasi', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByGpsAkurasiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsAkurasi', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByNamaPemilik() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaPemilik', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByNamaPemilikDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaPemilik', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByNamaPenerima() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaPenerima', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByNamaPenerimaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaPenerima', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByNomorHp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomorHp', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByNomorHpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomorHp', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy> thenByResi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resi', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByResiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resi', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenBySupabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenBySupabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenBySyncStatusValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatusValue', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenBySyncStatusValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatusValue', Sort.desc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy> thenByWaktu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waktu', Sort.asc);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QAfterSortBy>
  thenByWaktuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waktu', Sort.desc);
    });
  }
}

extension DeliveryEvidenceQueryWhereDistinct
    on QueryBuilder<DeliveryEvidence, DeliveryEvidence, QDistinct> {
  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QDistinct>
  distinctByCatatan({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'catatan', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QDistinct>
  distinctByGpsAkurasi() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gpsAkurasi');
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QDistinct>
  distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QDistinct>
  distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QDistinct>
  distinctByNamaPemilik({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'namaPemilik', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QDistinct>
  distinctByNamaPenerima({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'namaPenerima', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QDistinct>
  distinctByNomorHp({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomorHp', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QDistinct> distinctByResi({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'resi', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QDistinct>
  distinctBySupabaseId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supabaseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QDistinct>
  distinctBySyncStatusValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatusValue');
    });
  }

  QueryBuilder<DeliveryEvidence, DeliveryEvidence, QDistinct>
  distinctByWaktu() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waktu');
    });
  }
}

extension DeliveryEvidenceQueryProperty
    on QueryBuilder<DeliveryEvidence, DeliveryEvidence, QQueryProperty> {
  QueryBuilder<DeliveryEvidence, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DeliveryEvidence, String?, QQueryOperations> catatanProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'catatan');
    });
  }

  QueryBuilder<DeliveryEvidence, double?, QQueryOperations>
  gpsAkurasiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gpsAkurasi');
    });
  }

  QueryBuilder<DeliveryEvidence, double?, QQueryOperations> latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<DeliveryEvidence, double?, QQueryOperations>
  longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<DeliveryEvidence, String?, QQueryOperations>
  namaPemilikProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'namaPemilik');
    });
  }

  QueryBuilder<DeliveryEvidence, String?, QQueryOperations>
  namaPenerimaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'namaPenerima');
    });
  }

  QueryBuilder<DeliveryEvidence, String?, QQueryOperations> nomorHpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomorHp');
    });
  }

  QueryBuilder<DeliveryEvidence, String, QQueryOperations> resiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'resi');
    });
  }

  QueryBuilder<DeliveryEvidence, String?, QQueryOperations>
  supabaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supabaseId');
    });
  }

  QueryBuilder<DeliveryEvidence, int, QQueryOperations>
  syncStatusValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatusValue');
    });
  }

  QueryBuilder<DeliveryEvidence, DateTime, QQueryOperations> waktuProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waktu');
    });
  }
}
