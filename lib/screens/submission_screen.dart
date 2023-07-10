import 'package:dio/dio.dart' as dio;
import 'package:fcm_thesis_publish/services/shared_pref_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/upload_file.dart';

class SubmissionScreen extends HookConsumerWidget {
  List<String> batchDropDownItem = <String>[
    'Batch-01',
    'Batch-02',
    'Batch-03',
    'Batch-04',
    'Batch-05',
    'Batch-06',
    'Batch-07',
    'Batch-08',
    'Batch-09',
    'Batch-10',
  ];

  List<String> deptDropDownItem = <String>[
    'CSE',
    'EEE',
    'CE',
  ];

  SubmissionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deptDropDownValue = useState('CSE');
    final batchDropDownValue = useState('Batch-01');
    final uploadCoverImg = useState<PlatformFile?>(null);
    final uploadPdf = useState<PlatformFile?>(null);
    final thesisNameCtrl = useTextEditingController();
    final teamFristName = useTextEditingController();
    final teamSecondName = useTextEditingController();
    final teamThirdName = useTextEditingController();
    final teamForthName = useTextEditingController();
    final superVisorName = useTextEditingController();

    final dioInstance = ref.watch(dioClientProvider);

    final isLoading = useState(false); // Hook to track loading state
    final error = useState<String?>(null);

    Future<void> uploadAndPostFiles() async {
      isLoading.value = true;
      error.value = null;

      try {
        // Upload first file

        final firstFile = dio.FormData.fromMap({
          'file': dio.MultipartFile.fromBytes(uploadCoverImg.value!.bytes ?? [],
              filename: uploadCoverImg.value!.name),
        });
        final firstResponse =
            await dioInstance.post('/uploads', data: firstFile);
        final fristUrl = firstResponse.data['url'];

        // Upload second file

        final secondFile = dio.FormData.fromMap({
          'file': dio.MultipartFile.fromBytes(uploadPdf.value!.bytes ?? [],
              filename: uploadPdf.value!.name),
        });
        final secondResponse =
            await dioInstance.post('/uploads', data: secondFile);
        final thsisUrl = secondResponse.data['url'];

        final postData = {
          "thesesName": thesisNameCtrl.text,
          "batch": batchDropDownValue.value,
          "department": deptDropDownValue.value,
          "teammateFirstName": teamFristName.text,
          "teammateSecondName": teamSecondName.text,
          "teammateThirdName": teamThirdName.text,
          "teammateFourthName": teamForthName.text,
          "superVisorName": superVisorName.text,
          "coverPage": fristUrl,
          "pdf": thsisUrl
        };

        // Make post request with file URLs
        // final postData = {'firstUrl': firstUrl, 'secondUrl': secondUrl};
        final postResponse =
            await dioInstance.post('/submission', data: postData);

        debugPrint(postResponse.data.toString());
        Get.back();

        // Handle post response
        // ...
        // Your code to handle the post response here
      } catch (e) {
        // Handle exceptions
        // ...
        // Your code to handle exceptions here
        error.value = 'Error occurred during file upload: $e';
        print('Exception occurred: $e');
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Submit Thesis Paper',
            style: GoogleFonts.ubuntu(color: Colors.black)),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
            color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // thesis title
              Text(
                'Thesis Name',
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              STPTextWidget(
                name: "enter thesis name",
                controller: thesisNameCtrl,
              ),
              const SizedBox(height: 10),

              // batch
              Text(
                'Select Batch',
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              // batch select
              DropdownButtonFormField<String>(
                hint: const Text('Select Batch'),
                dropdownColor: Colors.blueGrey.shade200,
                isExpanded: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: batchDropDownItem.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: GoogleFonts.ubuntu()),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  batchDropDownValue.value = newValue!;
                },
                value: batchDropDownValue.value,
              ),
              const SizedBox(height: 10),

              // department
              Text(
                'Select Department',
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              // department select
              DropdownButtonFormField<String>(
                hint: const Text('Select Department'),
                dropdownColor: Colors.blueGrey.shade200,
                isExpanded: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: deptDropDownItem.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: GoogleFonts.ubuntu()),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  deptDropDownValue.value = newValue!;
                },
                value: deptDropDownValue.value,
              ),
              const SizedBox(height: 10),

              // team mates name
              Text(
                'Team Mates Name',
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              STPTextWidget(
                name: "first name",
                controller: teamFristName,
              ),
              const SizedBox(height: 10),
              STPTextWidget(
                name: "second name",
                controller: teamSecondName,
              ),
              const SizedBox(height: 10),
              STPTextWidget(
                name: "third name",
                controller: teamThirdName,
              ),
              const SizedBox(height: 10),
              STPTextWidget(
                name: "fourth name",
                controller: teamForthName,
              ),
              const SizedBox(height: 10),

              // supervisor name
              Text(
                'Supervisor Name',
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              STPTextWidget(
                name: "enter supervisor's name",
                controller: superVisorName,
              ),
              const SizedBox(height: 10),

              // upload Cover Page
              UploadFileWidget(
                title: 'Upload Cover page',
                file: uploadCoverImg,
              ),
              const SizedBox(height: 10),
              // upload pdf
              UploadFileWidget(
                title: 'Upload PDF',
                file: uploadPdf,
              ),
              const SizedBox(height: 20),

              // submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                  ),
                  onPressed: () async {
                    if (uploadPdf.value == null ||
                        uploadCoverImg.value == null) {
                      Get.showSnackbar(const GetSnackBar(
                        messageText: Text("PLEASE UPLOAD COVER AND THEIS FILE"),
                      ));
                      return;
                    }
                    debugPrint(uploadPdf.value!.toString());
                    debugPrint(uploadCoverImg.value!.toString());
                    uploadAndPostFiles();
                    // uploadCoverImg.value?.path;
                    // Get.to(const MainNavBarScreen());
                  },
                  child: Text('Submit', style: GoogleFonts.ubuntu()),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      )),
    );
  }
}

class STPTextWidget extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  const STPTextWidget({
    super.key,
    required this.name,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText: name,
          hintStyle: GoogleFonts.ubuntu()),
    );
  }
}
