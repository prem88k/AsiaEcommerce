import 'package:flutter/material.dart';
import 'package:pocketuse/model/route_argument.dart';
import 'package:pocketuse/Pages/razorPaymentDemo.dart';

import 'Pages/AbountPocketusePage.dart';
import 'Pages/AddAddressPage.dart';
import 'Pages/AllCategoriesPage.dart';
import 'Pages/AllProductsPage.dart';
import 'Pages/AllSubCategoriesPage.dart';
import 'Pages/HomePage.dart';
import 'Pages/ImageZoomPage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/MyAccountPage.dart';
import 'Pages/MyAddressListPage.dart';
import 'Pages/MyCartListPage.dart';
import 'Pages/NeedHelpPage.dart';
import 'Pages/OrderDetaiPage.dart';
import 'Pages/OrderSummaryPage.dart';
import 'Pages/OtpVerificationPage.dart';
import 'Pages/PrivacyPolicyPage.dart';
import 'Pages/ProfileEditPage.dart';
import 'Pages/RegistrationPage.dart';
import 'Pages/MyOrdersPage.dart';
import 'Pages/ProductDetailPage.dart';
import 'Pages/ReturnPolicyPage.dart';
import 'Pages/SellerPolicyPage.dart';
import 'Pages/SplashPage.dart';
import 'Pages/TermsOfUsePage.dart';
import 'Pages/WishListPage.dart';
import 'Utils/Api_constant.dart';
import 'elements/SortingBottomSheetDialog.dart';
import 'gokartPages/main.dart';
import 'gokartPages/pages/spashscreen.dart';
import 'model/AddressListObj.dart';
import 'model/ProductListArgument.dart';
import 'model/Productlist_route_argument.dart';
import 'model/addressListArgument.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(builder: (_) => SplashPage());

//        case SplashScreen.routeName:
//        return MaterialPageRoute(builder: (_) => SplashScreen());

      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => HomePage());

      case RegistrationPage.routeName:
        return MaterialPageRoute(builder: (_) => RegistrationPage(routeArgument: args as RouteArgument));

      case LoginPage.routeName:
        return MaterialPageRoute(builder: (_) => LoginPage(routeArgument: args as RouteArgument));

      case OtpVerificationPage.routeName:
        return MaterialPageRoute(builder: (_) => OtpVerificationPage(routeArgument: args as RouteArgument));

      case AllCategoriesPage.routeName:
        return MaterialPageRoute(builder: (_) => AllCategoriesPage());

      case AllProductsPage.routeName:
        return MaterialPageRoute(builder: (_) => AllProductsPage(productlistall_argument: args as ProductListArgument,
//        return MaterialPageRoute(builder: (_) => AllProductsPage(productlist_route_argument: args as Productlist_route_argument,
//            title: args as String
        ));

      case WishListPage.routeName:
        return MaterialPageRoute(builder: (_) => WishListPage());

      case MyCartListPage.routeName:
        return MaterialPageRoute(builder: (_) => MyCartListPage());

      case OrderSummaryPage.routeName:
        return MaterialPageRoute(builder: (_) => OrderSummaryPage());

      case AllSubCategoriesPage.routeName:
        return MaterialPageRoute(
            builder: (_) =>
                AllSubCategoriesPage(routeArgument: args as RouteArgument));

      case ProductDetailPage.routeName:
        return MaterialPageRoute(
            builder: (_) =>
                ProductDetailPage(routeArgument: args as RouteArgument));

     case OrderDetaiPage.routeName:
            return MaterialPageRoute(
                builder: (_) =>
                    OrderDetaiPage(routeArgument: args as RouteArgument));

      case ImageZoomPage.routeName:
            return MaterialPageRoute(
                builder: (_) =>
                    ImageZoomPage(routeArgument: args as RouteArgument));

      case NeedHelpPage.routeName:
        return MaterialPageRoute(builder: (_) => NeedHelpPage());

      case MyOrdersPage.routeName:
        return MaterialPageRoute(builder: (_) => MyOrdersPage());

      case MyAccountPage.routeName:
        return MaterialPageRoute(builder: (_) => MyAccountPage());

      case AbountPocketusePage.routeName:
        return MaterialPageRoute(builder: (_) => AbountPocketusePage());

      case PrivacyPolicyPage.routeName:
        return MaterialPageRoute(builder: (_) => PrivacyPolicyPage());

      case TermsOfUsePage.routeName:
        return MaterialPageRoute(builder: (_) => TermsOfUsePage());

      case ReturnPolicyPage.routeName:
      return MaterialPageRoute(builder: (_) => ReturnPolicyPage());

      case SellerPolicyPage.routeName:
      return MaterialPageRoute(builder: (_) => SellerPolicyPage());

      case MyOrdersPage.routeName:
        return MaterialPageRoute(builder: (_) => MyOrdersPage());

      case MyAddressListPage.routeName:
        return MaterialPageRoute(builder: (_) => MyAddressListPage(addresslistargs: args as addressListArgument));

      case ProfileEditPage.routeName:
        return MaterialPageRoute(builder: (_) => ProfileEditPage());

      case AddAddressPage.routeName:
        return MaterialPageRoute(builder: (_) => AddAddressPage(addressListObj: args as AddressListObj));

      case razorPaymentDemo.routeName:
        return MaterialPageRoute(builder: (_) => razorPaymentDemo());

        case MyHomePage.routeName:
        return MaterialPageRoute(builder: (_) => MyHomePage());

    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(Api_constant.ERROR),
        ),
        body: Center(
          child: Text(Api_constant.ERROR),
        ),
      );
    });
  }
}
