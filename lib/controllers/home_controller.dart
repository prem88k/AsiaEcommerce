
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pocketuse/model/CategorieWiseProductPackage/HomePageCategoriWiseProducts.dart';
 import 'package:pocketuse/model/CategoryModel.dart';
import 'package:pocketuse/model/FeaturedBanner.dart';
import 'package:pocketuse/model/SliderObj.dart';
import 'package:pocketuse/repository/category_repository.dart';
import 'package:pocketuse/repository/homepage_categoriwise_product_repository.dart';
import 'package:pocketuse/repository/homepage_featured_banner_repository.dart';
import 'package:pocketuse/repository/homepage_sliders_repository.dart';

class HomeController extends ControllerMVC {
  List<CategoryModel> categories = <CategoryModel>[];
  List<SliderObj> SliderList = <SliderObj>[];
  List<FeaturedBanner> featuredBanners = <FeaturedBanner>[];
  List<HomePageCategoriWiseProducts> homeCategorieWiseProduct = <HomePageCategoriWiseProducts>[];

  HomeController() {
//    listenForCategories();
//    listenForSlider();
//    listenForfeaturedBanners();
  }

  void listenForCategories() async {
    final Stream<CategoryModel> stream = await getCategories();
    stream.listen((CategoryModel _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForSlider() async {
    final Stream<SliderObj> stream = await getsliders();
    stream.listen((SliderObj _slider) {
      setState(() => SliderList.add(_slider));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForfeaturedBanners() async {
    final Stream<FeaturedBanner> stream = await getfeatured_banners();
    stream.listen((FeaturedBanner _fbanner) {
      setState(() => featuredBanners.add(_fbanner));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForCategorieWiseProducts() async {
    final Stream<HomePageCategoriWiseProducts> stream = await gethome_page_categories();
    stream.listen((HomePageCategoriWiseProducts _fbanner) {
      setState(() => homeCategorieWiseProduct.add(_fbanner));
    }, onError: (a) {}, onDone: () {
      print(homeCategorieWiseProduct.length.toString()+" ooooo");
      print(homeCategorieWiseProduct.toString()+" ooooo");
    });
  }


  Future<void> refreshHome() async {
    categories = <CategoryModel>[];
    SliderList = <SliderObj>[];
    featuredBanners = <FeaturedBanner>[];
    homeCategorieWiseProduct = <HomePageCategoriWiseProducts>[];

    listenForCategories();
    listenForSlider();
    listenForfeaturedBanners();
//    listenForCategorieWiseProducts();

  }
}
