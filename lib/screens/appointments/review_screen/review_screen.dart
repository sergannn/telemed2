import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'widgets/listcameronwilliam_item_widget.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AppointmentsReviewScreen extends StatefulWidget {
  const AppointmentsReviewScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsReviewScreen> createState() => _AppointmentsReviewScreenState();
}

class _AppointmentsReviewScreenState extends State<AppointmentsReviewScreen> with SingleTickerProviderStateMixin {
 
   TabController? tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = tabController = TabController(length: 6, vsync: this);
    
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bool isDark =Theme.of(context).brightness==Brightness.dark;
    return Scaffold(
       body:SafeArea(
          child:
           SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: size.width,
                    margin: getMargin(
                      top: 26,
                    ),
                    child: Padding(
                      padding: getPadding(
                        left: 24,
                        right: 24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                             const BkBtn(),
                           
                            HorizontalSpace(width: 20),
                              Text(
                                "Reviews",
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
                       Container(
                        
                          padding: getPadding(all: 10),
                          height: getVerticalSize(44),
                          width: getHorizontalSize(44),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorConstant.blueA400.withOpacity(0.1),
                            
                      
                          ),
                          child: CommonImageView(
                            imagePath:ImageConstant.filter,
                          ),
                      
                        ),
                    
                        ],
                      ),
                    ),
                  ),
                ),
               VerticalSpace(height: 20),
               SizedBox(
              height: getVerticalSize(36),
              child: TabBar(
                controller: tabController,
                tabs:const [
                  Tab(text: '☆ All', 
                  ),
                 
                  Tab(text: '☆ 1',
                 
                  ),
                 
                  Tab(text: '☆ 2',
                
                  ),
                 
                  Tab(text: '☆ 3', ),
                 
                  Tab(text: '☆ 4',
                 
                  ),
                 
                  Tab(text: '☆ 5',
                
                  ),
                 
                ],
                isScrollable: true,
                padding: getPadding(
                  left: 20,
                  right: 20
                ),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: ColorConstant.blueA400
                ),
                unselectedLabelColor: ColorConstant.blueA400,
                unselectedLabelStyle: TextStyle(
                  fontSize: getFontSize(16),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Source Sans Pro'
                ),
                labelColor: Colors.white,
                labelStyle: TextStyle(
                  fontSize: getFontSize(16),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Source Sans Pro'
                ),
                ),
            ),
                    
            SizedBox(
              height:size.height-getVerticalSize(240),
              child: TabBarView(
                controller: tabController,

                children: [
                 ListView.builder(
                    padding: getPadding(
                   left: 20,
                   top: 24,
                   right: 20,
                 ),
                   physics: const BouncingScrollPhysics(),
                   shrinkWrap: true,
                   itemCount: 5,
                   itemBuilder: (context, index) {
                     return const ListcameronwilliamItemWidget();
                   },
                 ),
                 
                 ListView.builder(
                    padding: getPadding(
                   left: 10,
                   top: 24,
                   right: 10,
                 ),
                   physics: const BouncingScrollPhysics(),
                   shrinkWrap: true,
                   itemCount: 5,
                   itemBuilder: (context, index) {
                     return const ListcameronwilliamItemWidget();
                   },
                 ),
                 
                 ListView.builder(
                    padding: getPadding(
                   left: 10,
                   top: 24,
                   right: 10,
                 ),
                   physics: const BouncingScrollPhysics(),
                   shrinkWrap: true,
                   itemCount: 5,
                   itemBuilder: (context, index) {
                     return const ListcameronwilliamItemWidget();
                   },
                 ),
                 
                 ListView.builder(
                    padding: getPadding(
                   left: 10,
                   top: 24,
                   right: 10,
                 ),
                   physics: const BouncingScrollPhysics(),
                   shrinkWrap: true,
                   itemCount: 5,
                   itemBuilder: (context, index) {
                     return const ListcameronwilliamItemWidget();
                   },
                 ),
                 
                 ListView.builder(
                    padding: getPadding(
                   left: 10,
                   top: 24,
                   right: 10,
                 ),
                   physics: const BouncingScrollPhysics(),
                   shrinkWrap: true,
                   itemCount: 5,
                   itemBuilder: (context, index) {
                     return const ListcameronwilliamItemWidget();
                   },
                 ),
                 
                 ListView.builder(
                    padding: getPadding(
                   left: 10,
                   top: 24,
                   right: 10,
                 ),
                   physics: const BouncingScrollPhysics(),
                   shrinkWrap: true,
                   itemCount: 5,
                   itemBuilder: (context, index) {
                     return const ListcameronwilliamItemWidget();
                   },
                 ),
                 
                 
                 
                   ],
              ),
            ),
         

                CustomButton(isDark:isDark,
                  width: size.width,
                  text: "Back",
                  margin: getMargin(
                    left: 10,
                  
                    right: 10,
                    bottom: 20,
                  ),
                  prefixWidget: Padding(
                    padding:getPadding(left: 8,
                    right: 8),
                    child: Icon(Icons.arrow_back_rounded,
                    color: ColorConstant.blueA400,
                    size: 18,
                    ),
                  ),
                  variant: ButtonVariant.OutlineBlueA400,
                  alignment: Alignment.center,
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
