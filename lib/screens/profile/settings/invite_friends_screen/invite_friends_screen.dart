import 'package:doctorq/data_files/friends_list.dart';
import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'widgets/listdarrellsteward_item_widget.dart';
import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';

class ProfileSettingsInviteFriendsScreen extends StatelessWidget {
  const ProfileSettingsInviteFriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: size.width,
              margin: getMargin(
                top: 20,
              ),
              child: Padding(
                padding: getPadding(
                  left: 24,
                  right: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BkBtn(),
                    HorizontalSpace(width: 20),
                    Text(
                      "Invite Friends",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: getFontSize(
                          26,
                        ),
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VerticalSpace(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    padding: getPadding(
                      left: 24,
                      right: 24,
                      bottom: 30,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: friendsList.length,
                    itemBuilder: (context, index) {
                      return ListdarrellstewardItemWidget(index: index);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
