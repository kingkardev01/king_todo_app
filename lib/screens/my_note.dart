import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model.dart';
import 'controller.dart';

class MyNote extends StatelessWidget {
  final int? index;
  const MyNote({
     this.index,
  });
  @override
  Widget build(BuildContext context) {
    final NoteController nc = Get.find();
    String text = "";
    text = index == null ? " " : nc.notes[index!].title;
    TextEditingController textEditingController =  TextEditingController(text: text);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: index == null ? const Text('Create a New Note ') : const Text('Update note'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: < Widget > [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        autofocus: true,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Create a new note!!',
                          labelText: ' My Note',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black87),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        style: const TextStyle(fontSize: 20),
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: < Widget > [
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('Cancel'),
                            // color: Colors.red,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (index == null) {
                                nc.notes.add(Note(title: textEditingController.text));
                              } else {
                                var updatenote = nc.notes[index!];
                                updatenote.title = textEditingController.text;
                                nc.notes[index!] = updatenote;
                              }
                              Get.back();
                            },
                            child: index == null ? const Text('Add') : const Text('Update'),
                            // color: Colors.green,
                          )
                        ])
                  ],
                ),
              ),
            )));
  }
}