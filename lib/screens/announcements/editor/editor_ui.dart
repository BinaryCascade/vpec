import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../theme.dart';
import '../../settings/settings_logic.dart';
import 'editor_logic.dart';

class EditorHeader extends StatelessWidget {
  const EditorHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        'Новое объявление',
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ImagePreview extends StatelessWidget {
  const ImagePreview({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: CachedNetworkImage(imageUrl: imagePath),
    );
  }
}

class UploadAttachmentButton extends StatelessWidget {
  const UploadAttachmentButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EditorLogic>(
      builder: (context, logic, _) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: context.palette.levelTwoSurface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: context.palette.outsideBorderColor,
            ),
          ),
          child: Material(
            type: MaterialType.transparency,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: logic.pickImage,
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.attachment_outlined,
                            color: context.palette.accentColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Прикрепить картинку',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: context.palette.accentColor,
                            ),
                          ),
                        ],
                      ),
                      if (logic.photoUploadProgress != null)
                        LinearProgressIndicator(
                          value: logic.photoUploadProgress,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TitleEditorField extends StatefulWidget {
  const TitleEditorField({Key? key}) : super(key: key);

  @override
  State<TitleEditorField> createState() => _TitleEditorFieldState();
}

class _TitleEditorFieldState extends State<TitleEditorField> {
  bool _isEmpty = true;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);

    super.initState();
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasPrimaryFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          curve: Curves.easeOut,
          foregroundDecoration: BoxDecoration(
            color: _isEmpty ? null : context.palette.levelOneSurface,
          ),
          decoration: const BoxDecoration(),
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.centerLeft,
          height: 24,
          width: _isEmpty ? 34 : 0,
          duration: const Duration(milliseconds: 300),
          child: Icon(
            Icons.edit_outlined,
            color: _isFocused
                ? context.palette.accentColor
                : context.palette.mediumEmphasis,
          ),
        ),
        Flexible(
          child: TextField(
            minLines: 1,
            maxLines: 3,
            controller: context.read<EditorLogic>().announcementTitleController,
            focusNode: _focusNode,
            onChanged: (text) {
              context
                  .read<EditorLogic>()
                  .checkAndUpdatePublishButtonActiveStatus();
              setState(() {
                _isEmpty = text.isEmpty;
              });
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            style: Theme.of(context).textTheme.headline4,
            decoration: const InputDecoration(
              isCollapsed: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              hintText: 'Введите заголовок..',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class BodyEditorField extends StatefulWidget {
  const BodyEditorField({Key? key}) : super(key: key);

  @override
  State<BodyEditorField> createState() => _BodyEditorFieldState();
}

class _BodyEditorFieldState extends State<BodyEditorField> {
  bool _isEmpty = true;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);

    super.initState();
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasPrimaryFocus);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        context.read<EditorLogic>().announcementBodyController;

    return Row(
      children: [
        AnimatedContainer(
          curve: Curves.easeOut,
          foregroundDecoration: BoxDecoration(
            color: _isEmpty ? null : context.palette.levelOneSurface,
          ),
          decoration: const BoxDecoration(),
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.centerLeft,
          height: 24,
          width: _isEmpty ? 34 : 0,
          duration: const Duration(milliseconds: 300),
          child: Icon(
            Icons.edit_outlined,
            color: _isFocused
                ? context.palette.accentColor
                : context.palette.mediumEmphasis,
          ),
        ),
        Flexible(
          child: TextField(
            maxLines: null,
            controller: controller,
            focusNode: _focusNode,
            onChanged: (text) {
              context
                  .read<EditorLogic>()
                  .checkAndUpdatePublishButtonActiveStatus();
              setState(() {
                _isEmpty = text.isEmpty;
              });
            },
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              hintText: 'Введите сообщение..',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: context.palette.mediumEmphasis),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class AuthorName extends StatelessWidget {
  const AuthorName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () async {
          await SettingsLogic.changeName(context);
          context.read<EditorLogic>().checkAndUpdatePublishButtonActiveStatus();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 7, right: 15.0, bottom: 13),
          child: ValueListenableBuilder(
            valueListenable:
                Hive.box('settings').listenable(keys: ['username']),
            builder: (context, Box box, child) {
              String userName = box.get(
                'username',
                defaultValue: 'Имя не указано',
              );
              String field =
                  userName.isEmpty ? 'Нажмите, чтобы задать имя' : userName;

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    field,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: userName.isEmpty
                              ? context.palette.highEmphasis
                              : context.palette.mediumEmphasis,
                        ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.edit_outlined,
                    color: userName.isEmpty
                        ? context.palette.highEmphasis
                        : context.palette.mediumEmphasis,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class EditorUI extends StatelessWidget {
  const EditorUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EditorLogic>(
      builder: (context, logic, _) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: context.palette.levelOneSurface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: context.palette.outsideBorderColor),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                logic.photoUrl == null
                    ? const UploadAttachmentButton()
                    : ImagePreview(imagePath: logic.photoUrl!),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: const [
                      SizedBox(height: 8),
                      TitleEditorField(),
                      BodyEditorField(),
                    ],
                  ),
                ),
                const AuthorName(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class VisibilityPicker extends StatelessWidget {
  const VisibilityPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EditorLogic>(
      builder: (context, logic, _) {
        return Column(
          children: [
            Text(
              'Выберите видимость:',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            CheckboxListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              checkColor: context.palette.backgroundSurface,
              activeColor: context.palette.accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: logic.publishFor['students'],
              title: Text(
                'Студентам',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w600,
                ),
              ),
              onChanged: (value) {
                logic.updateCheckbox('students', value ?? false);
              },
            ),
            CheckboxListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              checkColor: context.palette.backgroundSurface,
              activeColor: context.palette.accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: logic.publishFor['parents'],
              title: Text(
                'Родителям',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w600,
                ),
              ),
              onChanged: (value) {
                logic.updateCheckbox('parents', value ?? false);
              },
            ),
            CheckboxListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              checkColor: context.palette.backgroundSurface,
              activeColor: context.palette.accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: logic.publishFor['teachers'],
              title: Text(
                'Преподавателям',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w600,
                ),
              ),
              onChanged: (value) {
                logic.updateCheckbox('teachers', value ?? false);
              },
            ),
            CheckboxListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              checkColor: context.palette.backgroundSurface,
              activeColor: context.palette.accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: logic.publishFor['admins'],
              title: Text(
                'Администрации',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w600,
                ),
              ),
              onChanged: (value) {
                logic.updateCheckbox('admins', value ?? false);
              },
            ),
          ],
        );
      },
    );
  }
}

class DialogButtons extends StatelessWidget {
  const DialogButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              context.read<EditorLogic>().cleanUp();
              Navigator.pop(context);
            },
            child: const Text('Закрыть'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: context.watch<EditorLogic>().publishButtonActive
                ? () async {
                    await context.read<EditorLogic>().publishAnnouncement();
                    Navigator.pop(context);
                  }
                : null,
            child: const Text('Опубликовать'),
          ),
        ),
      ],
    );
  }
}
