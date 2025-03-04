import 'package:flutter/material.dart';
import 'package:justice_link/features/medical_updates/widgets/file_pick_button.dart';
import 'package:justice_link/features/medical_updates/widgets/open_file.dart';

class RequiredDocuments extends StatefulWidget {
  final String title;

  const RequiredDocuments({Key? key, required this.title}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RequiredDocumentsState createState() => _RequiredDocumentsState();
}

class _RequiredDocumentsState extends State<RequiredDocuments> {
  late String pickedFilePath = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 329,
      height: 78,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(9, 3, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                MyElevatedButton(
                  onFilePicked: (filePath) {
                    setState(() {
                      pickedFilePath = filePath;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: const Text(
                    '+ Add File ',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    height: 34,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF004D14), Color(0xFF098904)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewFile(filePath: pickedFilePath),
                          ),
                        );
                      },
                      child: const Text(
                        'View Files ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
