import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:localcommunity/blocs/issue_detail_bloc.dart';
import 'package:localcommunity/models/issue.dart';
import 'package:localcommunity/screens/add_issue/add_issue.dart';
import 'package:localcommunity/services/auth_service.dart';
import 'package:localcommunity/utils/constants.dart';
import 'package:localcommunity/utils/size_config.dart';
import 'package:localcommunity/widgets/image_view.dart';
import 'package:localcommunity/widgets/tab_bar.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class IssueDetailsPage extends StatefulWidget {
  final IssueModel gotIssue;
  const IssueDetailsPage({Key? key, required this.gotIssue}) : super(key: key);

  @override
  State<IssueDetailsPage> createState() => _IssueDetailsPageState();
}

class _IssueDetailsPageState extends State<IssueDetailsPage> {
  // File
  @override
  void initState() {
    if (widget.gotIssue.files!.isNotEmpty) super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(AuthService().currentUserId);
    final issueDetailBloc =
        Provider.of<IssueDetailBlocAndMapViewBloc>(context, listen: false);
    issueDetailBloc.getLocationFromLatLng(widget.gotIssue);
    issueDetailBloc.calculateDistance(context, widget.gotIssue.location!['lat'],
        widget.gotIssue.location!['lng']);
    final isMe = widget.gotIssue.posterId == AuthService().currentUserId;
    return StreamBuilder<IssueModel>(
        stream: widget.gotIssue.ref!
            .snapshots()
            .map((event) => IssueModel.fromJson(event)),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Scaffold(body: progressIndicator(color: kPrimaryColor));
          final issue = snapshot.data!;
          return Scaffold(
            bottomNavigationBar:
                isMe && widget.gotIssue.status == 'addressed' ||
                        widget.gotIssue.status == 'fixed'
                    ? buildMyIssueBottom(issue)
                    : !isMe && widget.gotIssue.status == 'new'
                        ? buildOtherBottom(issue)
                        : Container().w0(context).h0(context),
            appBar: _buildAppbar(context),
            body: _buildBody(issue),
          );
        });
  }

  Widget buildOtherBottom(IssueModel issue) {
    return bottomNavBtn(
      title: issue.status == 'new' ? "Flag as fixed!" : "Awaiting fix!",
      onpress: () => issue.ref!.update({'status': 'addressed'}),
      color: kPrimaryColor,
      isDeal: issue.status == 'fixed',
    );
  }

  Widget buildMyIssueBottom(IssueModel issue) {
    return bottomNavBtn(
      title: issue.status == "addressed" ? "Fix Confirmed!" : "Issue Fixed!",
      onpress: () => issue.ref!.update({'status': 'fixed'}),
      color: issue.status == "addressed" ? kPrimaryColor : kGreenColor,
      isDeal: issue.status == 'fixed',
    );
  }

  Widget _buildBody(IssueModel issue) {
    final date = DateFormat('d MMM, y').format(issue.timeStamp!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: imageView(url: issue.image!, radius: 50),
          title: issue.issueName!
              .firstLetterUpperCase()
              .text
              .medium
              .size(gw(16))
              .make(),
        ),
        "Date created $date".text.coolGray400.make().pOnly(top: gh(15)),
        "At ${widget.gotIssue.locationDesc}"
            .text
            .color(kPrimaryColor)
            .make()
            .pOnly(top: gh(15)),
        issue.posterId == AuthService().currentUserId
            ? Container()
            : Consumer<IssueDetailBlocAndMapViewBloc>(
                builder: (context, issueDetailBloc, __) {
                return "${issueDetailBloc.distance.toStringAsFixed(0)}m Away"
                    .text
                    .color(issueDetailBloc.distance < 300
                        ? kGreenColor
                        : kSecondryColor.withOpacity(.5))
                    .medium
                    .make()
                    .pOnly(top: gh(15));
              }),
        issue.image!.isEmpty ? Container() : Divider().py12(),
        issue.image!.isEmpty ? Container() : horizontalImageView(issue.image!),
        issue.files!.isEmpty
            ? Container()
            : Row(
                children: List.generate(
                  issue.files!.length,
                  (index) => AddIssuePage().buildFileCard(context,
                      isEdit: true, path: issue.files![index]),
                ),
              ).pOnly(top: gh(12)),
        issue.issueDescription!.isEmpty ? Container() : Divider().py12(),
        issue.issueDescription!
            .firstLetterUpperCase()
            .text
            .make()
            .pOnly(bottom: gh(16)),
      ],
    ).px16().pOnly(top: gh(16), bottom: gh(22)).safeArea().scrollVertical();
  }

  AppBar _buildAppbar(BuildContext context) {
    final issueDetailBloc =
        Provider.of<IssueDetailBlocAndMapViewBloc>(context, listen: false);
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          context.pop();
          issueDetailBloc.issueLocation = '';
        },
        icon: Icon(Icons.arrow_back, color: kPrimaryTextColor),
      ),
      title: widget.gotIssue.posterName!
          .firstLetterUpperCase()
          .text
          .fontFamily("poppins")
          .medium
          .xl
          .color(kPrimaryColor)
          .make(),
      actions: [
        widget.gotIssue.status!
            .firstLetterUpperCase()
            .text
            .coolGray500
            .make()
            .p16(),
      ],
    );
  }
}
