import 'package:example/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/src/provider.dart';
import 'package:ui_dynamo/mediaquery/override_media_query_plugin.dart';
import 'package:ui_dynamo/ui_dynamo.dart';

DynamoPage buildToastPage() => DynamoPage.list(
      title: 'Toasts',
      icon: Icon(Icons.check_circle),
      children: (context) {
        final currentMediaQuery =
            context.read<OverrideMediaQueryProvider>().currentMediaQuery;
        final isLight =
            currentMediaQuery.platformBrightness == Brightness.light;
        final successPropGroup = PropGroup('Success', '');
        final errorPropGroup = PropGroup('Error', 'e');
        final warningPropGroup = PropGroup('Warning', 'w');
        return [
          Organization.container(
            title: Text('Toast'),
            children: <Widget>[
              StyledText.body(Text(
                  'Toast is used to display messages to the user in the UI')),
            ],
          ),
          Organization.container(
            title: Text('Success Toast'),
            cardBackgroundColor: isLight ? Colors.grey : Colors.green,
            children: [
              SizedBox(
                height: 16,
              ),
              AppToast(
                onClose: context.actions.onPressed('Close Toast'),
                message: context.props
                    .text('Message', 'Success!', group: successPropGroup),
                toastMode: context.props.valueSelector(
                  'Mode',
                  PropValues<ToastMode>(
                    selectedValue: ToastMode.Success,
                    values: ToastMode.values,
                  ),
                  group: successPropGroup,
                ),
              ),
            ],
          ),
          Organization.container(
            title: Text('Error Toast'),
            cardBackgroundColor: isLight ? Colors.grey : Colors.red,
            children: [
              AppToast(
                onClose: context.actions.onPressed('Close Toast 2'),
                message: context.props.text(
                    'Message', 'Failure to reach network.',
                    group: errorPropGroup),
                toastMode: context.props.radios(
                  'Toast Mode 2',
                  PropValues<ToastMode>(
                    selectedValue: ToastMode.Error,
                    values: ToastMode.values,
                  ),
                  group: errorPropGroup,
                ),
              ),
            ],
          ),
          Organization.container(
            title: Text('Warning Toast'),
            cardBackgroundColor: isLight ? Colors.grey : Colors.red,
            children: [
              AppToast(
                onClose: context.actions.onPressed('Close Toast 2'),
                message: context.props.text(
                    'Message', 'There might be an issue with that.',
                    group: warningPropGroup),
                toastMode: context.props.radios(
                  'Toast Mode 2',
                  PropValues<ToastMode>(
                    selectedValue: ToastMode.Warning,
                    values: ToastMode.values,
                  ),
                  group: warningPropGroup,
                ),
              ),
            ],
          ),
          Organization.presentation(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StyledText.body(
              Text(
                  "Toast is a powerful widget that displays a status notification in the UI."),
            ),
          )),
          PropTable(
            items: [
              PropTableItem(
                  name: 'Message',
                  description: 'Displays a message for this toast'),
              PropTableItem(
                name: 'Mode',
                description: 'Displays a different UI mode',
                defaultValue: ToastMode.Success.toString(),
              ),
              PropTableItem(
                name: 'OnClose',
                description: 'Closes the Toast before the scheduled timeout',
                defaultValue: 'null',
              ),
            ],
          ),
        ];
      },
    );
