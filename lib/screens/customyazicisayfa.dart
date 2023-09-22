import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_image_renderer/pdf_image_renderer.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as img;

class YaziciSafa extends StatelessWidget {
  YaziciSafa({Key? key}) : super(key: key);
  final listResult = <BluetoothInfo>[].obs;
  List<int> bytes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yazıcı Sayfası"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left)),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.grey,
              child: Obx(
                () => ListView(
                  children: [
                    ...listResult.asMap().entries.map(
                          (e) => ListTile(
                            leading: const Icon(Icons.bluetooth),
                            title: Text(e.value.name),
                            subtitle: Text(e.value.macAdress),
                            onTap: () async {
                              await PrintBluetoothThermal.connect(
                                  macPrinterAddress: e.value.macAdress);
                            },
                          ),
                        )
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  listResult.value =
                      await PrintBluetoothThermal.pairedBluetooths;
                },
                child: const Text("Yazıcıları Tara")),
            ElevatedButton(
                onPressed: () async {
                  final isConnected =
                      await PrintBluetoothThermal.connectionStatus;
                  if (!isConnected) {
                    Get.defaultDialog(
                        title: "Yazıcı Bağlı Değil",
                        middleText: "Yazıcıyı Bağlayınız",
                        backgroundColor:
                            const Color.fromARGB(255, 110, 57, 57));
                  } else {
                    String optionprinttype = "80 mm";

                    final profile = await CapabilityProfile.load();
                    //burada generator sınıfı ile yazıcıya gönderilecek verileri oluşturuyoruz
                    final generator = Generator(
                        optionprinttype == "58 mm"
                            ? PaperSize.mm58
                            : PaperSize.mm80,
                        profile);
                    bytes += generator.reset();

                    final ImagePicker picker = ImagePicker();
                    final XFile? photo = await picker.pickImage(
                        imageQuality: 100, source: ImageSource.gallery);

                    if (photo == null) return;
                    var data = await photo.readAsBytes();
                    final image = img.decodeImage(data);
                    var imagee = img.copyResize(image!, width: 600);
                    bytes += generator.image(imagee);
                    List<int> ticket = bytes;
                    await PrintBluetoothThermal.writeBytes(ticket);
                    return;
                  }
                },
                child: const Text("Yazıcı Testi")),
            ElevatedButton(
                onPressed: () async {
                  // Initialize the renderer
                  String optionprinttype = "80 mm";

                  final profile = await CapabilityProfile.load();
                  final generator = Generator(
                      optionprinttype == "58 mm"
                          ? PaperSize.mm58
                          : PaperSize.mm80,
                      profile);

                  var result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                      allowMultiple: false);
                  final pdf = PdfImageRendererPdf(path: result!.paths[0]!);

                  await pdf.open();

                  await pdf.openPage(pageIndex: 0);
                  final size = await pdf.getPageSize(pageIndex: 0);

                  final imge = await pdf.renderPage(
                    pageIndex: 0,
                    x: 0,
                    y: 0,
                    width: size
                        .width, // you can pass a custom size here to crop the image
                    height: size
                        .height, // you can pass a custom size here to crop the image
                    scale:
                        3, // increase the scale for better quality (e.g. for zooming)
                    background: Colors.white,
                  );

                  //turn imge's Uint8List type into Image
                  final image = img.decodeImage(imge!);
                  var imagee = img.copyResize(image!, width: 600);

                  bytes += generator.reset();
                  bytes += generator.image(imagee);
                  bytes += generator.feed(5);
                  List<int> ticket = bytes;
                  await PrintBluetoothThermal.writeBytes(ticket);
                  return;
                },
                child: const Text("Test PDF"))
          ],
        ),
      ),
    );
  }
}
