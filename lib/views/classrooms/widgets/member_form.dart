import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/ultils/validation.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/views/widgets/button/custom_icon_button.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:education_helper/views/widgets/form/custom_date_field.dart';
import 'package:education_helper/views/widgets/form/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class MemberForm extends StatefulWidget {
  final Function(Member member) onConfirm;
  final Function() addWithCSV;
  final Member? initMember;
  const MemberForm({
    required this.onConfirm,
    required this.addWithCSV,
    Key? key,
    this.initMember,
  }) : super(key: key);

  @override
  _MemberFormState createState() => _MemberFormState();
}

class _MemberFormState extends State<MemberForm> {
  final _form = GlobalKey<FormState>();
  bool isFemale = false;
  String firstname = '';
  String lastname = '';
  String gender = 'male';
  String phoneNumber = '';
  String email = '';
  String dateBirthDay = '';

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return GestureDetector(
      onTap: context.disableKeyBoard,
      child: Padding(
        padding: media.viewInsets,
        child: Container(
          height: context.mediaSize.height * .6,
          padding: const EdgeInsets.symmetric(horizontal: 27.0, vertical: 30.0),
          decoration: const BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
          ),
          child: Form(
            key: _form,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Add User',
                          style: TextStyle(
                              color: kBlackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                      IconButton(
                          icon: const Icon(FontAwesome5Solid.file_csv),
                          iconSize: SPACING.XXL.size,
                          tooltip: 'ADDS WITH CSV',
                          splashRadius: 2.0,
                          color: kPrimaryColor,
                          onPressed: widget.addWithCSV)
                    ]),
                Expanded(
                  child: NormalScroll(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(children: [
                            Flexible(
                                child: KTextField(
                                    iconData: MaterialCommunityIcons
                                        .format_text_variant,
                                    hintText: 'First',
                                    onChange: (value) => firstname = value,
                                    validation: isNotEmpty)),
                            SPACING.M.horizontal,
                            Flexible(
                                child: KTextField(
                                    iconData: MaterialCommunityIcons
                                        .format_text_variant,
                                    hintText: 'Last',
                                    onChange: (value) => lastname = value,
                                    validation: isNotEmpty))
                          ]),
                          Row(children: [
                            Expanded(
                                flex: 3,
                                child: KDateField(
                                    hintText: 'Date birth',
                                    onChange: (String date) =>
                                        dateBirthDay = date)),
                            Flexible(
                                child: Row(children: [
                              Checkbox(
                                  value: isFemale,
                                  activeColor: kSecondaryColor,
                                  side: const BorderSide(
                                      color: kBlackColor, width: 2.0),
                                  onChanged: (value) {
                                    setState(() => isFemale = !isFemale);
                                    gender = isFemale ? 'female' : 'male';
                                  }),
                              const Icon(MaterialCommunityIcons.gender_female,
                                  color: kPrimaryColor, size: 32.0)
                            ]))
                          ]),
                          KTextField(
                              iconData: Feather.phone_call,
                              hintText: 'Phone',
                              onChange: (value) => phoneNumber = value,
                              keyboardType: TextInputType.number,
                              validation: (value) =>
                                  isPhone(value, allowNull: true)),
                          KTextField(
                              iconData: Feather.mail,
                              hintText: 'Email',
                              onChange: (value) => email = value,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              validation: (value) =>
                                  isEmail(value, allowNull: true)),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    KIconButton(
                        icon: const Icon(AntDesign.adduser, color: kBlackColor),
                        backgroundColor: kPlaceholderDarkColor,
                        sideColor: kPlaceholderDarkColor,
                        text: 'Confirm',
                        textStyle: const TextStyle(color: kBlackColor),
                        padding: const EdgeInsets.only(left: 20.0, right: 60.0),
                        onPressed: confirmAddMember),
                    KTextButton(
                        width: 150.0,
                        text: 'Cancle',
                        isOutline: true,
                        color: kBlackColor,
                        backgroudColor: kWhiteColor,
                        onPressed: context.goBack)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void confirmAddMember() {
    context.disableKeyBoard();
    if (_form.currentState?.validate() ?? false) {
      widget.onConfirm(Member(
          uid: '',
          firstName: firstname,
          lastName: lastname,
          gender: gender,
          phoneNumber: phoneNumber,
          mail: email,
          birth: dateBirthDay));
    }
  }
}