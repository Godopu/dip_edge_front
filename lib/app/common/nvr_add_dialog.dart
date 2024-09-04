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
      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.9),
      elevation: 5,
      content: SizedBox(
        width: 1000,
        height: 620,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // header
              children: [
                Text(
                  'Network Video Recorder (NVR) Registration',
                  style: TextStyle(
                    fontSize: 26,
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
            const SizedBox(height: defaultPadding),
            Expanded(child: _renderForm(context)),
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
      mainAxisAlignment: MainAxisAlignment.center,
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
                style: const TextStyle(color: Colors.white),
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
        const SizedBox(height: defaultPadding * 2),
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
                style: const TextStyle(color: Colors.white),
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
        const SizedBox(height: defaultPadding * 2),
        Align(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              'https://supabase.godopu.com/storage/v1/object/sign/dip_assets/nvr-logo.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJkaXBfYXNzZXRzL252ci1sb2dvLmpwZyIsImlhdCI6MTcyNTQyNjUxMiwiZXhwIjoxNzI2MDMxMzEyfQ.6dR1tdy3TcAQuCKh5-R0mtUaDGW9n9CCtpN5jIwzT5U&t=2024-09-04T05%3A08%3A32.371Z',
              width: 500,
            ),
          ),
        ),
        const SizedBox(height: defaultPadding * 2),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // Process data
                String name = _nameController.text;
                bool status = _status;
                String addr = _addrController.text;

                // Do something with the data, e.g., send it to a server
                await _makeConfirmDialog(context);
                await supabase.rpc('insert_dip_nvr');

                // Close the dialog
                Navigator.pop(context);
              }
            },
            child: const Text('Submit', style: TextStyle(fontSize: 20)),
          ),
        ),
      ],
    ),
  );
}

Future<bool> _makeConfirmDialog(BuildContext context) async {
  var confirmKey = GlobalKey();
  var result = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Are you sure to register this NVR?',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            CustomProgress(key: confirmKey),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              (confirmKey.currentState as _CustomProgressState).confirm();
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(context).pop(true);
              });
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  );
  return result as bool;
}

class CustomProgress extends StatefulWidget {
  const CustomProgress({super.key});

  @override
  State<CustomProgress> createState() => _CustomProgressState();
}

class _CustomProgressState extends State<CustomProgress> {
  bool isConfirm = false;
  void confirm() {
    setState(() {
      isConfirm = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 10,
      width: isConfirm ? 250 : 0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Colors.green, Colors.blue],
        ),
      ),
      duration: const Duration(seconds: 1),
    );
  }
}
