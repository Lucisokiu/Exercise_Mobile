import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../api/feed.dart';
import '../../../model/feed.dart';
import '../../../utils/token.dart';
import '../../appbar/appbar.dart';
import '../../login/LoginSreen.dart';
import '../widget/FeedCart.dart';


class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<FeedModel> listFeed = [];
  int? CurrentUser;
  void getFeed() async {
    List<FeedModel>? result = await getAllPost();
    if (mounted) {
      if (result != null) {
        setState(() {
          listFeed = result;
        });
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      }
    }
  }

  void getCurentUser() async {
    int? id = await getIdUser();
    if (mounted) {
      setState(() {
        CurrentUser = id;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurentUser();
    getFeed();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              pinned: false,
              floating: true,
              snap: true,
              expandedHeight: 10.h,
              flexibleSpace: const MyAppBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        SizedBox(height: 2.h),
                        CardFeed(
                          feed: listFeed[index],
                          CurrentUser: CurrentUser!,
                        ),
                      ],
                    );
                  } else {
                    return CardFeed(
                      feed: listFeed[index],
                      CurrentUser: CurrentUser!,
                    );
                  }
                },
                childCount: listFeed.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
