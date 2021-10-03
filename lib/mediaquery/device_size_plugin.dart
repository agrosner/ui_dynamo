import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dynamo/mediaquery/device_sizes.dart';
import 'package:ui_dynamo/plugins/plugin.dart';

/// Provides the [DeviceInfo] to UIDynamo.
/// Use this plugin to add more of your own.
class DeviceSizesPlugin extends ChangeNotifier {
  final List<DeviceInfo> _devices;

  /// Retrieves [DeviceSizesPlugin] from the [BuildContext]
  factory DeviceSizesPlugin.of(BuildContext context) =>
      Provider.of<DeviceSizesPlugin>(context);

  DeviceSizesPlugin(Iterable<DeviceInfo> extraDevices, bool useDefaults)
      : this._devices = useDefaults
            ? [...deviceSizes]
            : [DeviceSizes.viewPort, ...extraDevices] {
    if (useDefaults) {
      _devices.addAll(extraDevices);
    }
  }

  List<DeviceInfo> get devices => _devices;
}

DynamoPlugin deviceSizesPlugin(
        {Iterable<DeviceInfo> extraDevices = const [],
        bool useDefaults = true}) =>
    DynamoPlugin<DeviceSizesPlugin>(
      provider: ChangeNotifierProvider(
          create: (context) => DeviceSizesPlugin(extraDevices, useDefaults)),
    );
