// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$thumbnailHash() => r'e1f1aacef918808420e00d08146612a45bcb2984';

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

typedef ThumbnailRef = AutoDisposeFutureProviderRef<ImageWithAspectRatio>;

/// See also [thumbnail].
@ProviderFor(thumbnail)
const thumbnailProvider = ThumbnailFamily();

/// See also [thumbnail].
class ThumbnailFamily extends Family<AsyncValue<ImageWithAspectRatio>> {
  /// See also [thumbnail].
  const ThumbnailFamily();

  /// See also [thumbnail].
  ThumbnailProvider call({
    required ThumbnailRequest request,
  }) {
    return ThumbnailProvider(
      request: request,
    );
  }

  @override
  ThumbnailProvider getProviderOverride(
    covariant ThumbnailProvider provider,
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
  String? get name => r'thumbnailProvider';
}

/// See also [thumbnail].
class ThumbnailProvider
    extends AutoDisposeFutureProvider<ImageWithAspectRatio> {
  /// See also [thumbnail].
  ThumbnailProvider({
    required this.request,
  }) : super.internal(
          (ref) => thumbnail(
            ref,
            request: request,
          ),
          from: thumbnailProvider,
          name: r'thumbnailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$thumbnailHash,
          dependencies: ThumbnailFamily._dependencies,
          allTransitiveDependencies: ThumbnailFamily._allTransitiveDependencies,
        );

  final ThumbnailRequest request;

  @override
  bool operator ==(Object other) {
    return other is ThumbnailProvider && other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
