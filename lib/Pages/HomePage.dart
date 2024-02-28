import 'dart:convert';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:pocketuse/Providers/CartCountProvider.dart';
import 'package:pocketuse/Utils/Api_constant.dart';
import 'package:pocketuse/Utils/Consts.dart';
import 'package:pocketuse/Utils/MyPreferenceManager.dart';
import 'package:pocketuse/elements/CircularLoadingWidget.dart';
import 'package:pocketuse/elements/SearchWidget.dart';
import 'package:pocketuse/gokartPages/pages/home_page_component/best_deal.dart';
import 'package:pocketuse/gokartPages/pages/home_page_component/block_buster_deal.dart';
import 'package:pocketuse/gokartPages/pages/home_page_component/category_grid.dart';
import 'package:pocketuse/gokartPages/pages/home_page_component/featured_brands.dart';
import 'package:pocketuse/model/CategorieWiseProductPackage/HomePageCategoriWiseProducts.dart';
import 'package:pocketuse/model/CategoryModel.dart';
import 'package:pocketuse/model/CommanModal.dart';
import 'package:pocketuse/model/CommanModalWithObj.dart';
import 'package:pocketuse/model/FeaturedBanner.dart';
import 'package:pocketuse/model/GlobleDataResponse.dart';
import 'package:pocketuse/model/HomeBestSaleItem.dart';
import 'package:pocketuse/model/ProductListArgument.dart';
import 'package:pocketuse/model/Productlist_route_argument.dart';
import 'package:pocketuse/model/SliderObj.dart';
import 'package:pocketuse/widgets/CommonWidget.dart';
import 'package:pocketuse/widgets/ShoppingCartButtonWidget.dart';
import 'package:pocketuse/widgets/SideMenu.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'AllProductsPage.dart';
import 'MyCartListPage.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/HomePage';

  @override
  HomePageState createState() {
    return HomePageState();
  }

}

class HomePageState extends State<HomePage>{
  DateTime currentBackPressTime;
  List<SliderObj> SliderList = <SliderObj>[];
  List Sliderimages = [];
  List<CategoryModel> categories = <CategoryModel>[];
  List<FeaturedBanner> featuredBanners = <FeaturedBanner>[];
  List<HomeBestSaleItem> homeBestSaleItems = <HomeBestSaleItem>[];
  List<HomePageCategoriWiseProducts> _HomePageCategoriWiseProducts = <HomePageCategoriWiseProducts>[];

  String featuredBannersTitle = "";
  String featuredBannersSubTitle = "";
  String footer_html_txt = "";

  @override
  void initState() {
    super.initState();
    getSlider();
    getCategories();
    getfeatured_banners();
    getCategoryProductList();
    getHomeBestSaleItem();
    getAppGloble();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
//        title: CommonWidget.getActionBarTitleText(
//            Consts.app_name ),
        titleSpacing: 0,
        title: Image(image: AssetImage("assets/images/logosmall.png",),width: 70,height: 55,),
        flexibleSpace: CommonWidget.ActionBarBg(),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.  white,
              size: 24,
            ),
            onPressed: () {
              Navigator.of(context).push(SearchModal(categories));
            },
          ),
//          IconButton(
//            icon: Icon(
//              Icons.notifications,
//              color: Colors.  white,
//              size: 24,
//            ),
//            onPressed: () {},
//          ),
          ShoppingCartButtonWidget()
//          IconButton(
//            icon: Icon(
//              Icons.shopping_cart,
//              color: Colors.white,
//              size: 24,
//            ),
//            onPressed: () {
//              Navigator.of(context).pushNamed(MyCartListPage.routeName);
//            },
//          )
        ],
      ),
      drawer: MainDrawer(context),
      body: WillPopScope(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            // Slider Code Start Here
            // Slider Code Start Here
            SliderList .isEmpty ? Container() :
            Container(
              child: Container(
                height: 160.0,
                child: Carousel(
                  images: Sliderimages,
                  dotSize: 4.0,
                  dotSpacing: 15.0,
                  dotColor: Colors.grey[200],
                  dotIncreasedColor: Colors.blue[700],
                  indicatorBgPadding: 5.0,
                  dotBgColor: Colors.purple.withOpacity(0.0),
                  boxFit: BoxFit.fill,
                  animationCurve: Curves.fastOutSlowIn,
                  onImageTap: (i){
                    Navigator.of(context).pushNamed(AllProductsPage.routeName,
                        arguments: new ProductListArgument(title : "",
                            productlist_route_argument: new Productlist_route_argument(user_id: Consts.current_userid, term: '', sort:'' ,
                                category:  SliderList[i].id, subcategory: 0, childcategory: 0, page: 0, paginate: 0)));
                  },
                ),
              ),
            ),
            // Slider Code End Here

            SizedBox(
              height: 5.0,
            ),

            // Category Grid Start Here
//            categories.isEmpty ? CircularLoadingWidget(height: 100) :
            CategoryGrid(categories),

            // Category Grid End Here

            SizedBox(
              height: 5.0,
            ),

            Divider(
              height: 1.0,
            ),


            // Best Deal Grid Start Here
            homeBestSaleItems.isEmpty ? Container() :  BestDealGrid(homeBestSaleItems),
            // Best Deal Grid End Here

            homeBestSaleItems.isEmpty ? Container() :
            Column(
              children: [
                SizedBox(
                  height: 3.8,
                ),

                Divider(
                  height: 1.0,
                ),

                SizedBox(
                  height: 8.0,
//              height: 8.0,
                ),
              ],
            ),

            // Featured Brand Slider Start Here
//            featuredBanners.isEmpty ? CircularLoadingWidget(height: 100) :
            FeaturedBrandSlider(featuredBanners, featuredBannersTitle, featuredBannersSubTitle),
            // Featured Brand Slider End Here


            _HomePageCategoriWiseProducts.isEmpty ? Container() : Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _HomePageCategoriWiseProducts.length,
                  itemBuilder: (context, index) {
                    return _HomePageCategoriWiseProducts[index].products.length > 0 ? Column(
                      children: [
                        SizedBox(
                          height: 6.0,
                        ),

                        Divider(
                          height: 1.0,
                        ),

                        SizedBox(
                          height: 6.0,
                        ),
                        // Block Buster Deals Start Here
                        BlockBusterDeals(_HomePageCategoriWiseProducts[index]),
                      ],
                    ) : Container();
                  },
                ),
              ],
            ),
            // Block Buster Deals End Here

            SizedBox(
              height: 6.0,
            ),

            Divider(
              height: 1.0,
            ),

            Padding(padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
              child:  Html(
                  data: footer_html_txt),),

            SizedBox(height: 20.0),
          ],
        ),
        onWillPop: onWillPop,
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return Future.value(false);
    }
    exit(0);
    return Future.value(true);
  }

  Future<List<SliderObj>> getSlider() async {
    var url =
    Uri.https(GlobalConfiguration().getString('url'), '/api/front/sliders');

    print('url $url');

    var response = await http.get(url);

    if (response.statusCode == 200) {
//      getCategories();

      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);
      var data = userMap["data"];

      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (CommanModal_obj.status) {
        List<Object> resultList = data;

        List<SliderObj> myContributionList = new List(resultList.length);

        for (int i = 0; i < resultList.length; i++) {
          Object obj = resultList[i];
          SliderObj g = new SliderObj.fromJsonMap(obj);
          myContributionList[i] = g;
          Sliderimages.add(Image.network(
            g.image,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return CommonWidget.getloadingBulder(loadingProgress);
            },
          ));
        }

        setState(() {
          SliderList.addAll(myContributionList);
        });
      } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);

        return new List<SliderObj>();
      }
    } else {
//      getCategories();

//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);

      return new List<SliderObj>();
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    var url = Uri.https(
        GlobalConfiguration().getString('url'), '/api/front/category_list');
    print('url $url');

    var response = await http.get(url);

    if (response.statusCode == 200) {
//      getfeatured_banners();

      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);
      var data = userMap["data"];

      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (CommanModal_obj.status) {
        List<Object> resultList = data;

        List<CategoryModel> mycategoriesList = new List(resultList.length);

        for (int i = 0; i < resultList.length; i++) {
          Object obj = resultList[i];
          CategoryModel g = new CategoryModel.fromJsonMap(obj);
          mycategoriesList[i] = g;
        }

        setState(() {
          categories.addAll(mycategoriesList);
        });
      } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);

        return new List<CategoryModel>();
      }
    } else {
//      getfeatured_banners();
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);

      return new List<CategoryModel>();
    }
  }

  Future<List<FeaturedBanner>> getfeatured_banners() async {
    var url = Uri.https(
        GlobalConfiguration().getString('url'), '/api/front/featured-banners');
    print('url $url');

    var response = await http.get(url);

    if (response.statusCode == 200) {
//      getCategoryProductList();

      String response_json_str = response.body;
      print("FeaturedBanner================= " +
          response_json_str +
          "..............");
      Map userMap = jsonDecode(response_json_str);
      var data = userMap["data"];

      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (CommanModal_obj.status) {
        List<Object> resultList = data;

        List<FeaturedBanner> myFeaturedBanner = new List(resultList.length);

        for (int i = 0; i < resultList.length; i++) {
          Object obj = resultList[i];
          FeaturedBanner g = new FeaturedBanner.fromJsonMap(obj);
          myFeaturedBanner[i] = g;
        }

        setState(() {
          featuredBannersTitle = userMap.containsKey("title")
              ? userMap["title"]
              : "Featured Brands";
          featuredBannersSubTitle = userMap.containsKey("sub-title")
              ? userMap["sub-title"]
              : "Sponsored";

          featuredBanners.addAll(myFeaturedBanner);
        });
      } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);

        return new List<FeaturedBanner>();
      }
    } else {
//      getCategoryProductList();

//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);

      return new List<FeaturedBanner>();
    }
  }

  Future<List<HomePageCategoriWiseProducts>> getCategoryProductList() async {
    var url = Uri.https(GlobalConfiguration().getString('url'),
        '/api/front/home_page_categories/');

    print('url getCategoryProductList $url');

    var response = await http.get(url);

    if (response.statusCode == 200) {
//      getHomeBestSaleItem();

      String response_json_str = response.body;
      print('getCategoryProductList response ' +
          response_json_str +
          "..............");
      Map userMapp = jsonDecode(response_json_str);
      var _data = userMapp["data"];

      var CommanModal_obj =
      new CommanModal.fromJsonMap(userMapp) as CommanModal;

      if (CommanModal_obj.status) {
        try {
          List<Object> _resultList = _data;
          List<HomePageCategoriWiseProducts> homeCategoryWiseProductList =
          new List(_resultList.length);

          for (int i = 0; i < _resultList.length; i++) {
            Object obj = _resultList[i];
            HomePageCategoriWiseProducts g =
            new HomePageCategoriWiseProducts.fromJsonMap(obj);
            homeCategoryWiseProductList[i] = g;
          }
          print('homeCategoryWiseProductList response ' +
              homeCategoryWiseProductList.length.toString() +
              "..............");

          setState(() {
            _HomePageCategoriWiseProducts.addAll(homeCategoryWiseProductList);
          });
        } catch (e) {
          print(e + "eroorrrrrrr");
          return null;
        }
      } else {
        print("error " + CommanModal_obj.error.toString());
        return null;

//        Toast.show(Api_constant.something_went_wrong, context,
//            gravity: Toast.CENTER);
      }
    } else {
//      getHomeBestSaleItem();
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);
      print("error " + Api_constant.something_went_wrong);

      return null;
    }
  }

  Future<List<HomeBestSaleItem>> getHomeBestSaleItem() async {
    var url = Uri.https(GlobalConfiguration().getString('url'),
        '/api/front/banners?type=TopSmall');

    print('url $url');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);
      var data = userMap["data"];

      var CommanModal_obj = new CommanModal.fromJsonMap(userMap) as CommanModal;
      if (CommanModal_obj.status) {
        List<Object> resultList = data;

        List<HomeBestSaleItem> myFeaturedBanner = new List(resultList.length);

        for (int i = 0; i < resultList.length; i++) {
          Object obj = resultList[i];
          HomeBestSaleItem g = new HomeBestSaleItem.fromJsonMap(obj);
          myFeaturedBanner[i] = g;
        }

        setState(() {
          homeBestSaleItems.addAll(myFeaturedBanner);
        });
      } else {
//        Toast.show(Api_constant.no_record_found, context,
//            gravity: Toast.CENTER);

        return new List<HomeBestSaleItem>();
      }
    } else {
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);

      return new List<HomeBestSaleItem>();
    }
  }

  Future<List<HomeBestSaleItem>> getAppGloble() async {
    var url = Uri.https(
        GlobalConfiguration().getString('url'), '/api/front/globaldata');

    print('url $url');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      String response_json_str = response.body;
      print(response_json_str + "..............");
      Map userMap = jsonDecode(response_json_str);
      var data = userMap["data"];

      var CommanModal_obj =
      new CommanModalWithObj.fromJson(userMap) as CommanModalWithObj;

      if (CommanModal_obj.status) {
        var g = new GlobleDataResponse.fromJsonMap(CommanModal_obj.data)
        as GlobleDataResponse;
        setState(() {
          footer_html_txt = CommonWidget.replaceNullWithEmpty(g.footer);
        });
      } else {}
    } else {
//    Toast.show(Api_constant.something_went_wrong, context,
//        gravity: Toast.CENTER);
    }
  }
}
