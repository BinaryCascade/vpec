import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/teacher_model.dart';
import '../../../ui/widgets/loading_indicator.dart';
import '../../widgets/teacher_card/teacher_card.dart';
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
            .copyWith(color: Theme.of(context).textTheme.subtitle1!.color),
      ),
      onChanged: (value) {
        Provider.of<TeachersLogic>(context, listen: false).search(value);
      },
    );
  }
}

class BuildChips extends StatelessWidget {
  const BuildChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 4.0,
            children: [
              InputChip(
                backgroundColor: Theme.of(context).primaryColor,
                label: const Text('Фамилия'),
                selectedColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                selected: Provider.of<TeachersLogic>(context, listen: true)
                        .currentMode ==
                    SearchMode.familyName,
                onPressed: () =>
                    Provider.of<TeachersLogic>(context, listen: false)
                        .setMode(SearchMode.familyName),
              ),
              InputChip(
                backgroundColor: Theme.of(context).primaryColor,
                label: const Text('Имя'),
                selectedColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                selected: Provider.of<TeachersLogic>(context, listen: true)
                        .currentMode ==
                    SearchMode.firstName,
                onPressed: () =>
                    Provider.of<TeachersLogic>(context, listen: false)
                        .setMode(SearchMode.firstName),
              ),
              InputChip(
                backgroundColor: Theme.of(context).primaryColor,
                label: const Text('Отчество'),
                selectedColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                selected: Provider.of<TeachersLogic>(context, listen: true)
                        .currentMode ==
                    SearchMode.secondaryName,
                onPressed: () =>
                    Provider.of<TeachersLogic>(context, listen: false)
                        .setMode(SearchMode.secondaryName),
              ),
              InputChip(
                backgroundColor: Theme.of(context).primaryColor,
                label: const Text('Предметы'),
                selectedColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                selected: Provider.of<TeachersLogic>(context, listen: true)
                        .currentMode ==
                    SearchMode.lesson,
                onPressed: () =>
                    Provider.of<TeachersLogic>(context, listen: false)
                        .setMode(SearchMode.lesson),
              ),
              InputChip(
                backgroundColor: Theme.of(context).primaryColor,
                label: const Text('Кабинеты'),
                selectedColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                selected: Provider.of<TeachersLogic>(context, listen: true)
                        .currentMode ==
                    SearchMode.cabinet,
                onPressed: () =>
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
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) return const LoadingIndicator();
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return TeacherCard(
                  teacher: TeacherModel.fromMap(
                      snapshot.data!.docs[index].data(),
                      snapshot.data!.docs[index].id),
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
        onPressed: () => TeachersLogicEditMode().openAddNewDialog(context));
  }
}

class AddNewTeacherDialogUI extends StatefulWidget {
  const AddNewTeacherDialogUI({Key? key}) : super(key: key);

  @override
  _AddNewTeacherDialogUIState createState() => _AddNewTeacherDialogUIState();
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
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: familyName,
            textInputAction: TextInputAction.next,
            style: Theme.of(context).textTheme.headline3,
            decoration: const InputDecoration(labelText: 'Фамилия'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: firstName,
            textInputAction: TextInputAction.next,
            style: Theme.of(context).textTheme.headline3,
            decoration: const InputDecoration(labelText: 'Имя'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: secondaryName,
            textInputAction: TextInputAction.next,
            style: Theme.of(context).textTheme.headline3,
            decoration: const InputDecoration(labelText: 'Отчество'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: lessons,
            textInputAction: TextInputAction.next,
            style: Theme.of(context).textTheme.headline3,
            decoration: const InputDecoration(labelText: 'Занятия'),
          ),
        ),
        TextFormField(
          controller: cabinet,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: const InputDecoration(labelText: 'Кабинет'),
        ),
        ButtonBar(
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
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
                child: const Text('Добавить')),
          ],
        )
      ],
    );
  }
}

class SearchButton extends StatefulWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  _SearchButtonState createState() => _SearchButtonState();
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
                : Icons.search_outlined));
      },
    );
  }
}
