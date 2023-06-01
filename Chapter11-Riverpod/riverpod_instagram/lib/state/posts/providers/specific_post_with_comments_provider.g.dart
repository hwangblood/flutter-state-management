// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specific_post_with_comments_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$specificPostWithCommentsHash() =>
    r'fcd4f9620e7cc770dbf71b61f0b3a076cd144cff';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef SpecificPostWithCommentsRef
    = AutoDisposeStreamProviderRef<PostWithComments>;

/// See also [specificPostWithComments].
@ProviderFor(specificPostWithComments)
const specificPostWithCommentsProvider = SpecificPostWithCommentsFamily();

/// See also [specificPostWithComments].
class SpecificPostWithCommentsFamily
    extends Family<AsyncValue<PostWithComments>> {
  /// See also [specificPostWithComments].
  const SpecificPostWithCommentsFamily();

  /// See also [specificPostWithComments].
  SpecificPostWithCommentsProvider call({
    required RequestForPostAndComments request,
  }) {
    return SpecificPostWithCommentsProvider(
      request: request,
    );
  }

  @override
  SpecificPostWithCommentsProvider getProviderOverride(
    covariant SpecificPostWithCommentsProvider provider,
  ) {
    return call(
      request: provider.request,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'specificPostWithCommentsProvider';
}

/// See also [specificPostWithComments].
class SpecificPostWithCommentsProvider
    extends AutoDisposeStreamProvider<PostWithComments> {
  /// See also [specificPostWithComments].
  SpecificPostWithCommentsProvider({
    required this.request,
  }) : super.internal(
          (ref) => specificPostWithComments(
            ref,
            request: request,
          ),
          from: specificPostWithCommentsProvider,
          name: r'specificPostWithCommentsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$specificPostWithCommentsHash,
          dependencies: SpecificPostWithCommentsFamily._dependencies,
          allTransitiveDependencies:
              SpecificPostWithCommentsFamily._allTransitiveDependencies,
        );

  final RequestForPostAndComments request;

  @override
  bool operator ==(Object other) {
    return other is SpecificPostWithCommentsProvider &&
        other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
