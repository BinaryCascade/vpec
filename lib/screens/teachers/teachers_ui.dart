import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/teacher_model.dart';
import '/widgets/loading_indicator.dart';
import '../../theme.dart';
import 'teacher_card/teacher_card.dart';
import 'teachers_logic.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      textInputAction: TextInputAction.search,
      style: Theme.of(context).textTheme.headline3,
      decoration: InputDecoration(
        hintText:
            Provider.of<TeachersLogic>(context, listen: true).visibleTextMode,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintStyle: Theme.of(context)
            .textTheme
            .headline3!
            .copyWith(color: context.palette.mediumEmphasis),
      ),
      onChanged: (value) {
        Provider.of<TeachersLogic>(context, listen: false).search(value);
      },
    );
  }
}

class FilterChips extends StatelessWidget {
  const FilterChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.palette.levelOneSurface,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 4.0,
            children: [
              ChoiceChip(
                backgroundColor: context.palette.levelTwoSurface,
                label: const Text('Фамилия'),
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: context.watch<TeachersLogic>().currentMode ==
                          SearchMode.familyName
                      ? context.palette.backgroundSurface
                      : context.palette.highEmphasis,
                ),
                selectedColor: context.palette.accentColor,
                selected: context.watch<TeachersLogic>().currentMode ==
                    SearchMode.familyName,
                onSelected: (_) =>
                    Provider.of<TeachersLogic>(context, listen: false)
                        .setMode(SearchMode.familyName),
              ),
              ChoiceChip(
                backgroundColor: context.palette.levelTwoSurface,
                label: const Text('Имя'),
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: context.watch<TeachersLogic>().currentMode ==
                          SearchMode.firstName
                      ? context.palette.backgroundSurface
                      : context.palette.highEmphasis,
                ),
                selectedColor: context.palette.accentColor,
                selected: context.watch<TeachersLogic>().currentMode ==
                    SearchMode.firstName,
                onSelected: (_) =>
                    Provider.of<TeachersLogic>(context, listen: false)
                        .setMode(SearchMode.firstName),
              ),
              ChoiceChip(
                backgroundColor: context.palette.levelTwoSurface,
                label: const Text('Отчество'),
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: context.watch<TeachersLogic>().currentMode ==
                          SearchMode.secondaryName
                      ? context.palette.backgroundSurface
                      : context.palette.highEmphasis,
                ),
                selectedColor: context.palette.accentColor,
                selected: context.watch<TeachersLogic>().currentMode ==
                    SearchMode.secondaryName,
                onSelected: (_) =>
                    Provider.of<TeachersLogic>(context, listen: false)
                        .setMode(SearchMode.secondaryName),
              ),
              ChoiceChip(
                backgroundColor: context.palette.levelTwoSurface,
                label: const Text('Предметы'),
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: context.watch<TeachersLogic>().currentMode ==
                          SearchMode.lesson
                      ? context.palette.backgroundSurface
                      : context.palette.highEmphasis,
                ),
                selectedColor: context.palette.accentColor,
                selected: context.watch<TeachersLogic>().currentMode ==
                    SearchMode.lesson,
                onSelected: (_) =>
                    Provider.of<TeachersLogic>(context, listen: false)
                        .setMode(SearchMode.lesson),
              ),
              ChoiceChip(
                backgroundColor: context.palette.levelTwoSurface,
                label: const Text('Кабинеты'),
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: context.watch<TeachersLogic>().currentMode ==
                          SearchMode.cabinet
                      ? context.palette.backgroundSurface
                      : context.palette.highEmphasis,
                ),
                selectedColor: context.palette.accentColor,
                selected: context.watch<TeachersLogic>().currentMode ==
                    SearchMode.cabinet,
                onSelected: (_) =>
                    Provider.of<TeachersLogic>(context, listen: false)
                        .setMode(SearchMode.cabinet),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildTeachersList extends StatelessWidget {
  const BuildTeachersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: Provider.of<TeachersLogic>(context, listen: true).stream,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (!snapshot.hasData) return const LoadingIndicator();

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return TeacherCard(
                  teacher: TeacherModel.fromMap(
                    snapshot.data!.docs[index].data(),
                    snapshot.data!.docs[index].id,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class EditModeFAB extends StatelessWidget {
  const EditModeFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.add_outlined,
        size: 24.0,
      ),
      onPressed: () => TeachersLogicEditMode().openAddNewDialog(context),
    );
  }
}

class AddNewTeacherDialogUI extends StatefulWidget {
  const AddNewTeacherDialogUI({Key? key}) : super(key: key);

  @override
  State<AddNewTeacherDialogUI> createState() => _AddNewTeacherDialogUIState();
}

class _AddNewTeacherDialogUIState extends State<AddNewTeacherDialogUI> {
  TextEditingController firstName = TextEditingController();
  TextEditingController familyName = TextEditingController();
  TextEditingController secondaryName = TextEditingController();
  TextEditingController cabinet = TextEditingController();
  TextEditingController lessons = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: familyName,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: const InputDecoration(labelText: 'Фамилия'),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: firstName,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: const InputDecoration(labelText: 'Имя'),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: secondaryName,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: const InputDecoration(labelText: 'Отчество'),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: lessons,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: const InputDecoration(labelText: 'Занятия'),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: cabinet,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: const InputDecoration(labelText: 'Кабинет'),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Отмена'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  TeachersLogicEditMode().addNewTeacher(TeacherModel(
                    firstName: firstName.text,
                    familyName: familyName.text,
                    secondaryName: secondaryName.text,
                    cabinet: cabinet.text,
                    lesson: lessons.text,
                  ));
                  Navigator.pop(context);
                },
                child: const Text('Добавить'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SearchButton extends StatefulWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TeachersLogic>(
      builder: (BuildContext context, value, Widget? child) {
        return IconButton(
          onPressed: () => value.toggleSearch(),
          icon: Icon(value.isSearchMode
              ? Icons.close_outlined
              : Icons.search_outlined),
        );
      },
    );
  }
}
