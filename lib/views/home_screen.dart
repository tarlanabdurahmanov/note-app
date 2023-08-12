import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noteapp/database/note_database.dart';
import 'package:noteapp/utils/app_colors.dart';
import 'package:noteapp/utils/app_constants.dart';
import 'package:noteapp/utils/custom_font_size.dart';
import 'package:noteapp/utils/size.dart';
import 'package:noteapp/utils/text.dart';
import 'package:noteapp/views/editor_screen.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  List<int> selectedNoteIds = [];
  List<Map<String, dynamic>> notesData = [];

  Future<List<Map<String, dynamic>>> readDatabase() async {
    try {
      NotesDatabase notesDb = NotesDatabase();
      await notesDb.initDatabase();
      List<Map> notesList = await notesDb.getAllNotes();
      await notesDb.closeDatabase();
      notesData = List<Map<String, dynamic>>.from(notesList);
      notesData.sort((a, b) => (a['title']).compareTo(b['title']));
      return notesData;
    } catch (e) {
      return [];
    }
  }

  Future<void> deleteNote(int id) async {
    NotesDatabase notesDb = NotesDatabase();
    await notesDb.initDatabase();
    await notesDb.deleteNote(id);
    // readDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            return const EditorScreen();
          })).then((value) {
            readDatabase();
            setState(() {});
          });
        },
        tooltip: 'Add Note',
        elevation: 5,
        backgroundColor: AppColors.blackColor,
        child: SvgPicture.asset(AppConstants.addSvg),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: defaultText(
          "Notes",
          fontSize: 43.csp,
          fontWeight: FontWeight.w600,
        ),
        titleSpacing: 24.w,
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
                icon: SvgPicture.asset(AppConstants.searchSvg),
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
                onPressed: () {},
                icon: SvgPicture.asset(AppConstants.infoSvg),
              ),
            ),
          ),
          defaultSizedBox(width: 25.w),
        ],
      ),
      body: FutureBuilder(
        future: readDatabase(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
              itemBuilder: (BuildContext context, int index) {
                return _item(
                  index: index,
                  id: snapshot.data![index]['id'],
                  bg: Color(int.parse(snapshot.data![index]['color'])),
                  title: snapshot.data![index]['title'],
                );
              },
            );
          } else if (snapshot.hasError) {
            return CircularProgressIndicator();
          }
          return Container();
        },
      ),
    );
  }

  Widget _item({
    required int index,
    required int id,
    required Color bg,
    required String title,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return EditorScreen(
            isUpdate: true,
            id: id,
          );
        })).then((value) {
          readDatabase();
          setState(() {});
        });
      },
      child: SwipeableTile(
        color: Colors.transparent,
        swipeThreshold: 0.6,
        direction: SwipeDirection.endToStart,
        isElevated: false,
        onSwiped: (_) {
          deleteNote(id);
        },
        backgroundBuilder: (
          _,
          SwipeDirection direction,
          AnimationController progress,
        ) {
          return AnimatedBuilder(
            animation: progress,
            builder: (context, child) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
                margin: EdgeInsets.only(bottom: 15.h),
                decoration: BoxDecoration(
                  color: AppColors.redColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.delete,
                  size: 40.w,
                  color: AppColors.whiteColor,
                ),
              );
            },
          );
        },
        key: UniqueKey(),
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
          margin: EdgeInsets.only(bottom: 15.h),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: defaultText(
            title,
            fontSize: 18.csp,
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
          ),
        ),
      ),
    );
  }

  Column _emptyNote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppConstants.homeEmptyPng,
        ),
        Center(
          child: defaultText(
            "Create your first note !",
            fontSize: 20.csp,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
