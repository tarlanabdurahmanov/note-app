import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noteapp/database/note_database.dart';
import 'package:noteapp/models/note.dart';
import 'package:noteapp/utils/app_colors.dart';
import 'package:noteapp/utils/app_constants.dart';
import 'package:noteapp/utils/size.dart';

class EditorScreen extends StatefulWidget {
  final bool isUpdate;
  final int id;
  const EditorScreen({
    super.key,
    this.isUpdate = false,
    this.id = 0,
  });

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final lightColors = [
    Colors.amber.shade300,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100,
    Colors.purpleAccent,
    Colors.greenAccent.shade400,
    Colors.cyanAccent,
  ];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      getNote();
    }
  }

  Future<void> getNote() async {
    NotesDatabase notesDb = NotesDatabase();
    await notesDb.initDatabase();
    Note note = await notesDb.getNotes(widget.id);
    if (note != null) {
      titleController.text = note.title;
      bodyController.text = note.content;
      noteColor = note.color;
    }
  }

  String noteColor = '';

  Future<void> _insertNote(Note note) async {
    NotesDatabase notesDb = NotesDatabase();
    await notesDb.initDatabase();
    await notesDb.insertNote(note);
    await notesDb.closeDatabase();
  }

  void saveNote() async {
    if (titleController.text.isEmpty) {
      if (bodyController.text.isEmpty) {
        Navigator.pop(context);
        return;
      } else {
        String title = bodyController.text.split('\n')[0];
        if (title.length > 31) {
          title = title.substring(0, 31);
        }
        setState(() {
          titleController.text = title;
        });
      }
    }
    Color bg = lightColors[Random().nextInt(8)];
    // Save New note
    if (!widget.isUpdate) {
      Note noteObj = Note(
        title: titleController.text,
        content: bodyController.text,
        color: bg.value.toString(),
        createdAt: DateTime.now().toString(),
      );
      try {
        await _insertNote(noteObj);
      } catch (e) {
        print('Error inserting row');
      } finally {
        Navigator.pop(context);
        return;
      }
    } else {
      Note noteObj = Note(
        id: widget.id,
        title: titleController.text,
        content: bodyController.text,
        color: noteColor,
        createdAt: DateTime.now().toString(),
      );
      try {
        await _insertNote(noteObj);
      } catch (e) {
        print('Error inserting row');
      } finally {
        Navigator.pop(context);
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        saveNote();
        return true;
      },
      child: Center(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            titleSpacing: 24.w,
            leading: Center(
              child: Ink(
                height: 40.h,
                width: 40.h,
                decoration: ShapeDecoration(
                  color: AppColors.black2Color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                child: IconButton(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  disabledColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashRadius: 20,
                  onPressed: () => saveNote(),
                  icon: SvgPicture.asset(AppConstants.chevronLeft),
                ),
              ),
            ),
            actions: [
              Center(
                child: Ink(
                  height: 40.h,
                  width: 40.h,
                  decoration: ShapeDecoration(
                    color: AppColors.black2Color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  child: IconButton(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    disabledColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashRadius: 20,
                    onPressed: () {},
                    icon: SvgPicture.asset(AppConstants.visibility),
                  ),
                ),
              ),
              defaultSizedBox(width: 21.w),
              Center(
                child: Ink(
                  height: 40.h,
                  width: 40.h,
                  decoration: ShapeDecoration(
                    color: AppColors.black2Color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  child: IconButton(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    disabledColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashRadius: 20,
                    onPressed: () => saveNote(),
                    icon: SvgPicture.asset(AppConstants.save),
                  ),
                ),
              ),
              defaultSizedBox(width: 25.w),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: null,
                      autofocus: true,
                      controller: titleController,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration.collapsed(
                        hintText: "Title",
                        hintStyle: TextStyle(
                          color: AppColors.whiteColor,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    defaultSizedBox(height: 20.h),
                    TextFormField(
                      controller: bodyController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration.collapsed(
                        hintText: "Type something...",
                        hintStyle: TextStyle(
                          color: AppColors.whiteColor,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20.0,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
