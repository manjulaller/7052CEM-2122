import 'dart:io';

import 'package:file_icon/file_icon.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localcommunity/blocs/add_issue_bloc.dart';
import 'package:localcommunity/blocs/issue_detail_bloc.dart';
import 'package:localcommunity/services/database_service.dart';
import 'package:localcommunity/utils/constants.dart';
import 'package:localcommunity/utils/size_config.dart';
import 'package:localcommunity/widgets/image_view.dart';
import 'package:localcommunity/widgets/tab_bar.dart';
import 'package:provider/provider.dart';

import 'package:velocity_x/velocity_x.dart';

class AddIssuePage extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();
  static final _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final AddIssueBloc addIssueBloc =
        Provider.of<AddIssueBloc>(context, listen: false);
    addIssueBloc.pickedImage = '';
    return Consumer<AddIssueBloc>(builder: (context, bloc, __) {
      return bloc.addLoading
          ? Scaffold(
              body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                progressIndicator(color: kPrimaryColor),
                gh(14).heightBox,
                "Adding Issue. Please wait...".text.xl.makeCentered(),
              ],
            ))
          : Scaffold(
              persistentFooterButtons: _buildButtons(context),
              appBar: _buildAppBar(context),
              body: _buidBody(context),
              bottomNavigationBar: bottomNavBtn(
                  title: "Add Issue",
                  onpress: () {
                    if (_formKey.currentState!.validate()) {
                      _databaseService.createIssue(context);
                    }
                  }),
            ).onTap(() => FocusScope.of(context).unfocus());
    });
  }

  List<Widget> _buildButtons(BuildContext context) {
    final addIssueBloc =
        Provider.of<IssueDetailBlocAndMapViewBloc>(context, listen: false);
    return [
      VxBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.attach_file_rounded,
                size: gw(15), color: kSecondryColor),
            "Attachments".text.make(),
          ],
        ).px16(),
      )
          .width(gw(140))
          .height(gh(50))
          .coolGray100
          .rounded
          .make()
          .onInkTap(() => addIssueBloc.pickFiles()),
    ];
  }

  Widget _buidBody(BuildContext context) {
    final AddIssueBloc addIssueBloc =
        Provider.of<AddIssueBloc>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Consumer<AddIssueBloc>(builder: (context, addIssueBloc, __) {
            return ((addIssueBloc.pickedImage.isNotEmpty
                    ? Image.file(File(addIssueBloc.pickedImage),
                            fit: BoxFit.cover)
                        .box
                        .width(gw(100))
                        .height(gh(100))
                        .make()
                        .cornerRadius(gw(60))
                    : VxCircle(
                        backgroundColor: Colors.transparent,
                        border:
                            Border.all(color: kSecondryColor.withOpacity(.6)),
                        child:
                            Icon(CupertinoIcons.camera, color: kSecondryColor),
                        radius: gw(100),
                      ))
                .onInkTap(
              () => showPickerOptions(
                context,
                onCameraPress: () {
                  context.pop();
                  addIssueBloc.pickImage(ImageSource.camera);
                },
                onGalleryPress: () {
                  context.pop();
                  addIssueBloc.pickImage(ImageSource.gallery);
                },
              ),
            )).pOnly(bottom: gh(20));
          }),
          TextFormField(
            controller: addIssueBloc.nameC,
            validator: validation,
            decoration: InputDecoration(hintText: "Issue Name"),
          ),
          TextFormField(
            controller: addIssueBloc.locationC,
            validator: validation,
            decoration: InputDecoration(hintText: "Location description.."),
          ).pOnly(top: gh(20)),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: addIssueBloc.issueC,
            validator: validation,
            maxLines: null,
            decoration: InputDecoration(
                hintText: "Issue description...", border: InputBorder.none),
          ).py20(),
          Consumer<IssueDetailBlocAndMapViewBloc>(
            builder: (_, issueBloc, __) {
              return issueBloc.files.isEmpty
                  ? Container()
                  : Row(
                      children: List.generate(
                          issueBloc.files.length,
                          (index) => buildFileCard(context,
                              file: issueBloc.files[index])),
                    );
            },
          )
        ],
      ).px24().pOnly(top: gh(19), bottom: gh(12)).scrollVertical(),
    );
  }

  Widget buildFileCard(BuildContext context,
      {PlatformFile? file, bool isEdit = false, String? path}) {
    final addIssueBloc =
        Provider.of<IssueDetailBlocAndMapViewBloc>(context, listen: false);
    return VxBox(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VxBox(
                      child: FileIcon(
                          isEdit ? path!.split('/').last : file!.name,
                          size: gw(50)))
                  .width(gh(70))
                  .height(gh(75))
                  .customRounded(BorderRadius.only(
                    bottomLeft: Radius.circular(gw(10)),
                    bottomRight: Radius.circular(gw(10)),
                    topLeft: Radius.circular(gw(10)),
                  ))
                  .white
                  .border(color: kSecondryColor.withOpacity(.2))
                  .outerShadowSm
                  .make()
                  .pOnly(top: gh(10)),
              (isEdit ? path!.split('/').last : file!.name)
                  .text
                  .medium
                  .xl
                  .ellipsis
                  .make()
                  .px16()
                  .pOnly(top: gh(20), bottom: gh(isEdit ? 25 : 10)),
              isEdit ? Container() : Divider(indent: 20, endIndent: 20),
              isEdit
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "File Size:"
                            .text
                            .size(gw(13))
                            .medium
                            .make()
                            .pOnly(top: gh(10)),
                        formatBytes((file!.size), 0).text.coolGray400.make()
                      ],
                    ).px24().pOnly(bottom: gh(18))
            ],
          ).pOnly(top: gh(isEdit ? 20 : 50)).centered(),
          isEdit
              ? Container()
              : Positioned(
                  top: gh(5),
                  right: gw(5),
                  child: IconButton(
                    onPressed: () =>
                        addIssueBloc.deleteSingleFileLocallly(file!),
                    icon: Icon(CupertinoIcons.delete),
                  ),
                ),
        ],
      ),
    )
        .width(gw(250))
        // .height(gw(250))
        .color(whiteColor)
        .outerShadowSm
        .border(color: kSecondryColor.withOpacity(.5))
        .rounded
        .make()
        .pOnly(right: gw(10));
  }

  static AppBar _buildAppBar(BuildContext context) {
    final AddIssueBloc addIssueBloc =
        Provider.of<AddIssueBloc>(context, listen: false);
    final filesBloc =
        Provider.of<IssueDetailBlocAndMapViewBloc>(context, listen: false);
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.pop();
          addIssueBloc.pickedImage = '';
          addIssueBloc.issueC.clear();
          addIssueBloc.nameC.clear();
          filesBloc.files.clear();
        },
        icon: Icon(Icons.arrow_back, color: kPrimaryTextColor),
      ),
      title: "Add Issue".text.fontFamily('Poppins').medium.xl.make(),
    );
  }

  String? validation(String? val) =>
      val!.isEmpty ? "This field cannot be empty" : null;
}
