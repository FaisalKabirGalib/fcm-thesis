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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deptDropDownValue = useState('CSE');
    final batchDropDownValue = useState('Batch-01');
    final uploadCoverImg = useState<PlatformFile?>(null);
    final uploadPdf = useState<PlatformFile?>(null);
    final thesisNameCtrl = useTextEditingController();
    final batchCtl = useTextEditingController();
    final teamFristName = useTextEditingController();
    final teamSecondName = useTextEditingController();
    final teamThirdName = useTextEditingController();
    final teamForthName = useTextEditingController();
    final superVisorName = useTextEditingController();

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
                    primary: Colors.blue.shade900,
                  ),
                  onPressed: () {
                    debugPrint(uploadPdf.value!.name);
                    debugPrint(uploadCoverImg.value!.name);
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
