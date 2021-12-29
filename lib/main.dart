import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Encryption(),
    );
  }
}

class Encryption extends StatefulWidget {
  const Encryption({Key? key}) : super(key: key);

  @override
  _EncryptionState createState() => _EncryptionState();
}

class _EncryptionState extends State<Encryption> {
  String encryptedData = '';
  String decryptedData = '';

  static const encryptionChannel = MethodChannel('encryption/decryption');

  Future<void> encryption(String encrypted, String key) async {
    try {
      var result = await encryptionChannel
          .invokeMethod('encrypt', {'data': encrypted, 'key': key});
      // print('RETURNED FROM PLATFORM');
      // print(result);
      setState(() {
        encryptedData = result;
      });
    } on PlatformException catch (e) {
      print('${e.message}');
    }
  }

  Future<void> decryption(String encrypted, String key) async {
    try {
      var result = await encryptionChannel.invokeMethod('decrypt', {
        'data': encrypted,
        'key': key,
      });
      //  print('RETURNED FROM PLATFORM');
      // print(result);
      setState(() {
        decryptedData = result;
      });
    } on PlatformException catch (e) {
      print('${e.message}');
    }
  }

  // Future<void> getEncryption(String encrypted, String key) async {
  //
  //   try {
  //     encrypted = await encryptionChannel.invokeMethod('encrypt');
  //   } catch (e) {
  //     print(e);
  //   }
  //
  //   print(encryptedData);
  // }


  // Future<void> getDecryption() async {
  //   String? value;
  //   try {
  //     value = await encryptionChannel.invokeMethod('decrypt');
  //   } catch (e) {
  //     print(e);
  //   }
  //
  //   print(decryptedData);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Encryption and Decryption'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {

                     encryption('SeemaSenthilKumar', 'sssghshbgfhshdws');
                  },
                  child: const Text('Encryption')),
              const SizedBox(
                height: 10,
              ),
              Text(encryptedData),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {

                     decryption(encryptedData, 'sssghshbgfhshdws');
                  },
                  child: const Text('Decryption')),
              const SizedBox(
                height: 10,
              ),
              Text(decryptedData),
            ],
          ),
        ));
  }
}
// class DataModels{
//   String? name;
//   int? age;
//   DataModels({this.name, this.age});
//   // var dataModel = DataModels(age: 22, name: 'seema');
// }
