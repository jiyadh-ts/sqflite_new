import 'package:flutter/material.dart';
import 'package:sqflite_new/controller/homescreen-controller.dart';

class Screenone extends StatefulWidget {
  const Screenone({super.key});

  @override
  State<Screenone> createState() => _ScreenoneState();
}

class _ScreenoneState extends State<Screenone> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController designationcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Function to load employee data
  Future<void> loadData() async {
    await HomescreenController().getEmployee();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adding padding for better layout
        child: Column(
          children: [
            const Text(
              "Add employee",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: namecontroller,
              decoration: InputDecoration(
                labelText: 'Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: designationcontroller,
              decoration: InputDecoration(
                labelText: 'Designation',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  await HomescreenController.addEmployee(
                      name: namecontroller.text,
                      designation: designationcontroller.text);
                  await loadData();
                  setState(() {
                    namecontroller.clear();
                    designationcontroller.clear();
                  });
                },
                child: const Text("Submit")),
            const SizedBox(height: 20),
            Expanded(
              child: HomescreenController.myDataList == null
                  ? const Center(child: Text("No data"))
                  : HomescreenController.myDataList.isEmpty
                      ? const Center(child: Text("No employees added"))
                      : ListView.builder(
                          itemCount: HomescreenController.myDataList.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(
                                HomescreenController.myDataList[index]["name"]),
                            subtitle: Text(HomescreenController
                                .myDataList[index]["designation"]),
                            trailing: ElevatedButton(
                              onPressed: () async {
                                // Perform the delete operation
                                await HomescreenController.deleteEmployee(
                                    id: HomescreenController.myDataList[index]
                                        ["id"]);

                                // Reload the data to reflect the changes in the UI
                                await loadData();

                                // Optionally clear input fields, only if necessary
                                setState(() {
                                  namecontroller.clear();
                                  designationcontroller.clear();
                                });
                              },
                              child: const Text("Delete"),
                            ),
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }
}
