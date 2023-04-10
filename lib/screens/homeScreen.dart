import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'my_note.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteController nc = Get.put(NoteController());
    Widget getNoteList() {
      return Obx(
            () => nc.notes.isEmpty ? Center(child: Image.asset('assets/note.jpg'), ) :
        ListView.builder(
            itemCount: nc.notes.length,
            itemBuilder: (context, index) =>
                Card(
                  child: ListTile(
                      title: Text(nc.notes[index].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500)),
                      leading: Text(
                        "${index + 1}.",
                        style: const TextStyle(fontSize: 15),
                      ),
                      trailing: Wrap(children: < Widget > [
                        IconButton(
                            icon: const Icon(Icons.create),
                            onPressed: () =>
                                Get.to(MyNote(index: index))),
                        IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Delete Note',
                                  middleText: nc.notes[index].title,
                                  onCancel: () => Get.back(),
                                  confirmTextColor: Colors.white,
                                  onConfirm: () {
                                    nc.notes.removeAt(index);
                                    Get.back();
                                  });
                            })
                      ])),
                )
        ),
      );
    }
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: const Text('King Todo App'),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Get.to(const MyNote());
              },
            ),
            body: Padding(
                padding: const EdgeInsets.all(5),
                child: getNoteList())));
  }
}

