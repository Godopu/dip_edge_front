import 'package:dip_edge_front/app/pages/home/controller/common.dart';
import 'package:dip_edge_front/const.dart';
import 'package:flutter/material.dart';

var colors = [
  [Colors.orange, Colors.pink],
  [Colors.purple, Colors.blue],
  [Colors.green.withAlpha(100), Colors.green],
];

Future<String?> makeNVRAddDialog(
  BuildContext context,
) async {
  var result = await showDialog(
    builder: (context) => AlertDialog(
      // title: const Text('Title'),
      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
      elevation: 5,
      content: SizedBox(
        width: 1000,
        height: 660,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // header
              children: [
                Text(
                  'Network Video Recorder (NVR) Registration',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
            _renderForm(context),
          ],
        ),
      ),
    ),
    context: context,
  );

  return result;
}

Widget _makeRichText(BuildContext context, String key, String value) {
  return RichText(
    text: TextSpan(
      text: key,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Colors.white,
            fontSize: 22,
          ),
      children: [
        TextSpan(
          text: value,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.white,
                // fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
        ),
      ],
    ),
  );
}

Widget _renderForm(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _status = false;
  final _addrController = TextEditingController();

  return Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Text(
              "Name",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'NVR 이름을 입력하세요.',
                  fillColor: Colors.black,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Text(
              "NVR Address",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: TextFormField(
                controller: _addrController,
                decoration: const InputDecoration(
                  labelText: 'NVR 주소를 입력하세요.',
                  fillColor: Colors.black,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 32.0),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              // Process data
              String name = _nameController.text;
              bool status = _status;
              String addr = _addrController.text;

              // Do something with the data, e.g., send it to a server
              await supabase.rpc('insert_dip_nvr');

              // Close the dialog
              Navigator.pop(context);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    ),
  );
}
