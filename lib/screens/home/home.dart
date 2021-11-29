import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:localcommunity/blocs/add_issue_bloc.dart';
import 'package:localcommunity/blocs/issue_detail_bloc.dart';
import 'package:localcommunity/models/issue.dart';

import 'package:localcommunity/screens/add_issue/add_issue.dart';
import 'package:localcommunity/screens/home/map_view.dart';
import 'package:localcommunity/screens/issue_detail/issue_detail.dart';
import 'package:localcommunity/screens/login/email_login/email_login.dart';

import 'package:localcommunity/services/auth_service.dart';
import 'package:localcommunity/utils/constants.dart';
import 'package:localcommunity/utils/size_config.dart';
import 'package:localcommunity/widgets/image_view.dart';
import 'package:localcommunity/widgets/tab_bar.dart';
import 'package:provider/provider.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool showFab = true;
  @override
  void initState() {
    final addIssueBloc = Provider.of<AddIssueBloc>(context, listen: false);
    addIssueBloc.getMyCurrentLocation(context);
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() => setState(
          () => _tabController!.index == 2 ? showFab = false : showFab = true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StreamBuilder<List<IssueModel>>(
        stream: firestore.collection('issues').snapshots().map(
            (event) => event.docs.map((e) => IssueModel.fromJson(e)).toList()),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Scaffold(body: progressIndicator(color: kPrimaryColor));
          if (snapshot.hasError)
            return snapshot.error.toString().text.makeCentered();
          final issues = snapshot.data!;
          return Scaffold(
            appBar: _buildAppBar(context),
            body: _buildBody(context, issues),
            floatingActionButton: showFab ? _floatingButton(context) : null,
          );
        });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      bottom: customTabBar(
        controller: _tabController,
        tabs: [
          Tab(text: "All Issues"),
          Tab(text: "My Issues"),
          Tab(text: "Nearby Me"),
        ],
      ),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            auth.signOut();
            navigateAndReplace(
                context, LoginWithEmailPage(isComingFromAuth: false));
          },
          icon: Icon(Icons.logout, color: kPrimaryColor),
        )
      ],
      title: "Local Community HUB".text.fontFamily("poppins").medium.xl.make(),
    );
  }

  Widget _floatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => customNavigatorPushSlideRight(context, AddIssuePage()),
      child: Icon(Icons.add),
      backgroundColor: kPrimaryColor,
      // label: "Add Issue".text.medium.xl.make(),
    );
  }

  Widget _buildBody(BuildContext context, List<IssueModel> issues) {
    return TabBarView(
      controller: _tabController,
      children: [
        _builaOtherIssues(context, issues),
        _builaMyIssues(context, issues),
        MapView(allIssues: issues)
      ],
    );
  }
}

Widget _builaOtherIssues(BuildContext context, List<IssueModel> issues) {
  final otherIssues = issues
      .where((issue) =>
          issue.posterId != AuthService().currentUserId &&
          issue.status == 'new')
      .toList();
  return otherIssues.isEmpty
      ? "No issues found!".text.xl.makeCentered()
      : ListView.separated(
          itemBuilder: (_, i) => buildIssueTile(context, otherIssues[i]).py12(),
          separatorBuilder: (_, i) => Divider(),
          itemCount: otherIssues.length,
        ).pOnly(top: gh(10)).px16().expand();
}

Widget _builaMyIssues(BuildContext context, List<IssueModel> issues) {
  final myIssues = issues
      .where((issue) => issue.posterId == AuthService().currentUserId)
      .toList();
  return myIssues.isEmpty
      ? "No issues found!".text.xl.makeCentered()
      : ListView.separated(
          itemBuilder: (_, i) => buildMyIssueTile(context, myIssues[i]).py12(),
          separatorBuilder: (_, i) => Divider(),
          itemCount: myIssues.length,
        ).pOnly(top: gh(10)).px16();
}

Widget buildMyIssueTile(BuildContext context, IssueModel issue) {
  final date = DateFormat("MMM d, y").format(issue.timeStamp!);
  return ListTile(
    onTap: () => customNavigatorPushSlideRight(
        context, IssueDetailsPage(gotIssue: issue)),
    leading: imageView(url: issue.image!, radius: 60),
    contentPadding: EdgeInsets.zero,
    title: issue.issueName!.firstLetterUpperCase().text.medium.ellipsis.make(),
    subtitle: issue.locationDesc!
        .firstLetterUpperCase()
        .text
        .ellipsis
        .make()
        .pOnly(top: gh(8)),
    trailing: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (issue.status == 'new'
                ? "New"
                : issue.status == 'addressed'
                    ? 'Fix Confirmed'
                    : "Issue Fixed")
            .text
            .medium
            .color(issue.status == 'fixed' ? kGreenColor : kPrimaryColor)
            .make()
            .onInkTap(() {
          issue.status == 'new'
              // ignore: unnecessary_statements
              ? null
              : issue.ref!.update({'status': 'fixed'});
        }),
        date.text.coolGray500.make(),
      ],
    ),
  );
}

Widget buildIssueTile(BuildContext context, IssueModel issue) {
  final date = DateFormat("MMM d, y").format(issue.timeStamp!);

  return ListTile(
    onTap: () => customNavigatorPushSlideRight(
        context, IssueDetailsPage(gotIssue: issue)),
    leading: imageView(url: issue.image!, radius: 60),
    contentPadding: EdgeInsets.zero,
    title: issue.issueName!.firstLetterUpperCase().text.medium.ellipsis.make(),
    subtitle: issue.locationDesc!
        .firstLetterUpperCase()
        .text
        .ellipsis
        .make()
        .pOnly(top: gh(8)),
    trailing: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        "Flag As Fixed"
            .text
            .medium
            .color(issue.status == 'fixed' ? kGreenColor : kPrimaryColor)
            .make()
            .onInkTap(() {
          issue.ref!.update({'status': "addressed"});
          context.showToast(
              msg:
                  "Your request to fix this issue has been sent to the issue owner");
        }),
        Consumer<IssueDetailBlocAndMapViewBloc>(
            builder: (context, issueBloc, __) {
          return date.text.coolGray500.make();
        }),
      ],
    ),
  );
}
