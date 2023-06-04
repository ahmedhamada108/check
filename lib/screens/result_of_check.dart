import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/models/doctor.dart';

import '../widgets/doctor_card.dart';

class ResultOfCheck extends StatefulWidget {
  final List<VezzetaDoctors> doctors;

  const ResultOfCheck({super.key, required this.doctors});
  @override
  State<ResultOfCheck> createState() => _ResultOfCheckState();
}

class _ResultOfCheckState extends State<ResultOfCheck> {
  String diseaseName = "";
  String diseaseDescription = "";
  String username = "";
  final Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();
  getResultInfo() async {
    SharedPreferences prefs = await sharedPrefs;
    setState(() {
      diseaseName = prefs.getString("disease name")!;
      diseaseDescription = prefs.getString("disease description")!;
      username = prefs.getString("User Name")!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResultInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //app bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //name of user
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello,',
                        style: TextStyle(
                            color: Colors.blue[500],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        username,
                        style: TextStyle(
                            color: Colors.blueAccent[200],
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ],
                  ),

                  //profile pic of user
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.person,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            //card-->disease name &image&disease description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    //picture

                    //disease name & disease description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            diseaseName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            diseaseDescription,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            //doctor list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Specialist Doctors',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue.withOpacity(.9),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            // show doctors list here
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 5),
                itemBuilder: (context, index) => DoctorCard(
                  doctorImagePath: widget.doctors[index].doctorImage!,
                  doctorName: widget.doctors[index].doctorName!,
                  doctorAddress: widget.doctors[index].address!,
                  doctorProfession: widget.doctors[index].doctorDescription!,
                  doctorCost: widget.doctors[index].doctorFee!,
                ),
                itemCount: widget.doctors.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
