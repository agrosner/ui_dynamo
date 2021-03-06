import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dynamo/media_utils.dart';
import 'package:ui_dynamo/mediaquery/device_size_plugin.dart';
import 'package:ui_dynamo/mediaquery/device_sizes.dart';
import 'package:ui_dynamo/ui/page_wrapper.dart';

class MediaChooserButton extends StatelessWidget {
  final Function(DeviceInfo) deviceSelected;
  final DeviceInfo selectedDevice;

  const MediaChooserButton({
    Key key,
    @required this.deviceSelected,
    @required this.selectedDevice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceName =
        deviceDisplay(context, selectedDevice, shortName: context.isMobile);
    final deviceSizes = context.watch<DeviceSizesPlugin>();
    return PopupMenuButton(
      tooltip: 'Choose Preview Window Size',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!context.isWatch) Text(deviceName),
            SizedBox(
              width: 8,
            ),
            Icon(
              selectedDevice.iconForCategory,
              color: Theme.of(context).iconTheme.color,
            ),
          ],
        ),
      ),
      onSelected: deviceSelected,
      itemBuilder: (BuildContext context) => deviceSizes.devices
          .map(
            (key) => buildDeviceOption(context, key, selectedDevice),
          )
          .toList(),
    );
  }

  PopupMenuItem<DeviceInfo> buildDeviceOption(
      BuildContext context, DeviceInfo deviceInfo, DeviceInfo selectedDevice) {
    final useWrap = context.isWatch;

    Widget child;
    final text = Text(
      deviceDisplay(context, deviceInfo),
      style: TextStyle(fontSize: 12.0),
    );
    final children = [
      Icon(deviceInfo.iconForCategory),
      SizedBox(
        width: 15,
      ),
      if (!useWrap)
        Flexible(
          child: text,
        ),
      if (useWrap) text,
    ];
    if (useWrap) {
      child = Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 8.0,
        children: children,
      );
    } else {
      child = Row(
        children: children,
      );
    }
    return CheckedPopupMenuItem(
      checked: selectedDevice == deviceInfo,
      value: deviceInfo,
      child: child,
    );
  }
}
