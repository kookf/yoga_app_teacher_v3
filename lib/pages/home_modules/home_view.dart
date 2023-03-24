import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/colors.dart';
import '../../services/address.dart';
import 'home_controller.dart';
import 'notice_page.dart';


class HomeView extends GetView{


  @override
  final HomeController controller = Get.put(HomeController());

   HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColor.themeColor,
      //   title: Text('MeMo Yoga',style: TextStyle(color: AppColor.themeTextColor),),
      // ),
      body: GetBuilder<HomeController>(builder: (_){
        return Column(
          children: [
            Container(
                height: MediaQuery.of(context).padding.top+kToolbarHeight,
                width: Get.width,
                decoration: const BoxDecoration(
                  image:DecorationImage(image: AssetImage('images/appbar_bg.png',),
                    fit: BoxFit.fill,
                  ),
                ),
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.only(top: 25),
                  child: const Text('MeMO Yoga',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                )
            ),
            Expanded(child:ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 25,right: 25,top: 15),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    image:DecorationImage(
                      image: ExactAssetImage('images/ic_home_bg.png'),
                      fit: BoxFit.cover,
                    ),

                  ),
                  height: 600,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        // color: Colors.red,
                        margin: const EdgeInsets.only(left: 15,right: 15,top: 0),
                        child: Swiper(itemCount: controller.homeIndexModel?.data?.banner?.length??3,
                          autoplay: false,
                          pagination: SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.white,
                                  activeColor: AppColor.themeTextColor
                              )
                          ),
                          itemBuilder: (BuildContext context,int index){
                            return  Container(
                              // color: Colors.red,
                              padding: const EdgeInsets.all(15),
                              child: CachedNetworkImage(
                                imageUrl: '${Address.homeHost}${controller.homeIndexModel?.data?.banner?[index].coverUrl}',
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                fit: BoxFit.contain,
                              ),
                            );
                          },),
                      ),
                      const SizedBox(height: 5,),
                      Center(
                        child: Text('最新公告',style: TextStyle(color: AppColor.themeTextColor,fontSize: 20,
                            fontWeight: FontWeight.w600),),
                      ),
                      const SizedBox(height: 5,),

                      Container(
                        height: 300,
                        margin: const EdgeInsets.only(left: 25,right: 25,top: 0),
                        child: CustomScrollView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          slivers: [
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5,right: 5),
                                child: Image.asset('images/home_banner1.png'),
                              ),
                            ),
                            SliverList(delegate: _mySliverChildBuildList())
                          ],
                        ),
                      )
                    ],
                  ),

                ),
                Container(
                  margin: const EdgeInsets.only(left: 25,right: 25,top: 15),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  height: 200,
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      Text('聯絡我們',style: TextStyle(fontSize: 19,
                          color: AppColor.themeTextColor,fontWeight: FontWeight.w700),),
                      const SizedBox(height: 10,),

                      Image.asset('images/ic_location.png'),
                      const SizedBox(height: 10,),

                      Container(
                        child: Text('地址:${controller.homeIndexModel?.data?.site?.address}',style: TextStyle(color: AppColor.themeTextColor),),
                      ),
                      Container(
                        child: Text('Tel: ${controller.homeIndexModel?.data?.site?.tel}',style: TextStyle(color: AppColor.themeTextColor),),
                      ),
                      Container(
                        child: Text('郵箱: ${controller.homeIndexModel?.data?.site?.mail}',style: TextStyle(color: AppColor.themeTextColor),),
                      ),

               //        Text('''
               // 地址:${controller.homeIndexModel?.data?.site?.address}
               // Tel: ${controller.homeIndexModel?.data?.site?.tel}
               // 郵箱: ${controller.homeIndexModel?.data?.site?.mail}
               //  ''',style: TextStyle(color: AppColor.themeTextColor),),

                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),),
          ],
        );
      })
    );
  }
  SliverChildBuilderDelegate _mySliverChildBuildList(){
    return SliverChildBuilderDelegate((context, index) {
      return GestureDetector(
        onTap: (){
          Get.to(NoticePage(controller.homeIndexModel!.data!.notice![index].id!));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                    child: Text('${controller.homeIndexModel?.data?.notice?[index].title}',style: TextStyle(fontWeight: FontWeight.w600,
                      color: AppColor.themeTextColor),),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  child: Text('10/30/2023',style: TextStyle(fontWeight: FontWeight.w600,
                      color: AppColor.themeTextColor),),
                ),

              ],
            ),
            Container(
              color: Colors.black,
              height: 0.5,
            )
          ],
        ),
      );
    },childCount: controller.homeIndexModel?.data?.notice?.length??0);
  }
}