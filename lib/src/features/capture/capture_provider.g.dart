// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CaptureState)
const captureStateProvider = CaptureStateProvider._();

final class CaptureStateProvider
    extends $NotifierProvider<CaptureState, String> {
  const CaptureStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'captureStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$captureStateHash();

  @$internal
  @override
  CaptureState create() => CaptureState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$captureStateHash() => r'2b0777665fb9c659ec7c6d965b20093f746cbddd';

abstract class _$CaptureState extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
