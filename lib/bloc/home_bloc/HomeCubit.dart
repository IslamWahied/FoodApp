// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:elomda/bloc/home_bloc/HomeState.dart';
import 'package:elomda/bloc/login_bloc/loginCubit.dart';
import 'package:elomda/models/category/SupCategory.dart';
import 'package:elomda/models/category/additionsModel.dart';
import 'package:elomda/models/category/categoryModel.dart';


import 'package:elomda/models/category/itemModel.dart';
import 'package:elomda/models/favourit/favouritModel.dart';
import 'package:elomda/models/order/orderModel.dart';
import 'package:elomda/models/project/projectModel.dart';
import 'package:elomda/models/user/user_model.dart';

import 'package:elomda/modules/Order/Admin/canceledOrder.dart';
import 'package:elomda/modules/Order/Admin/PreparedOrder.dart';
import 'package:elomda/modules/Order/Admin/doneOrder.dart';
import 'package:elomda/modules/Order/Admin/newOrders.dart';
import 'package:elomda/modules/adminBackLayerOpations/sendNotifacation.dart';

import 'package:elomda/modules/cart/cart_screen.dart';
import 'package:elomda/modules/category/subCategoryScreen.dart';
import 'package:elomda/modules/favourite/feeds_screen.dart';
import 'package:elomda/modules/home/home_screen.dart';
import 'package:elomda/modules/item/items.dart';
import 'package:elomda/modules/login/login_screen.dart';
import 'package:elomda/modules/search/search_screen.dart';
import 'package:elomda/modules/user_info/user_info_screen.dart';
import 'package:elomda/shared/Global.dart';
import 'package:elomda/shared/components/Componant.dart';
import 'package:elomda/shared/network/local/helper.dart';
import 'package:elomda/shared/network/local/shared_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart' as sd;
import 'package:rounded_loading_button/rounded_loading_button.dart';



class HomeCubit extends Cubit<HomeScreenState> {
  HomeCubit() : super(HomeScreenStateInitState());

  TextEditingController sendMessageTextControl = TextEditingController();
  TextEditingController titleTextControl = TextEditingController();
  TextEditingController txtUpdateCustomerBalance = TextEditingController();
  FocusNode sendMessageNode = FocusNode();

  bool isShowBackLayer = true;
  bool isValidSendNotiBottom = false;
  int currentIndex = 0;
  List adminScreens = [
    const NewOrderScreen(),
    const PreparedOrderScreen(),
    const DoneOrderScreen(),
    const CancelOrderScreen(),
    User_Info(),
    const SendNotifacationScreen()

  ];

  List userScreens = [
    const HomeScreen(),
    const FavouriteScreen(),
    SearchScreen(),
    const OrderScreen(isShowNavBar: false),
    User_Info(),

  ];
  convertDateFormat(String date) {
    if (date != null) {
      try {
        String dateAfterFormat =
        sd.DateFormat("dd/MM/yyyy").format(DateTime.parse(date));
        // String today = sd.DateFormat("dd / MM / yyyy").format(DateTime(
        //     DateTime.now().year, DateTime.now().month, DateTime.now().day));
        // String yesterday = sd.DateFormat("dd / MM / yyyy").format(DateTime(
        //     DateTime.now().year, DateTime.now().month, DateTime.now().day - 1));

        // if (dateAfterFormat == yesterday) {
        //   return 'Yesterday';
        // } else if (dateAfterFormat == today) {
        //   return 'Today';
        // } else {
          return dateAfterFormat;
        // }
      } catch (e) {
        return '';
      }
    } else {
      return '';
    }
  }
  RoundedLoadingButtonController loginUpdateCustomerBalance = RoundedLoadingButtonController();
  void modalBottomSheetMenu(context){
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return Container(
            height: 400.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:   BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        TextFormField(
textDirection: TextDirection.rtl,
                          textAlign: TextAlign.end,
                            controller: txtUpdateCustomerBalance,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                           emit(SearchSubCategoryState());
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]')),
                          ],
                          decoration:   InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            labelText: 'المبلغ',
                            alignLabelWithHint: true,

                          ),

                        ),

                        SizedBox(
                          width: 200,
                          height: 100,
                          child: RoundedLoadingButton(
                              height: 60,
                              controller: loginUpdateCustomerBalance,
                              successColor: Colors.green,
                              color:txtUpdateCustomerBalance.text != null &&  txtUpdateCustomerBalance.text.trim() != '' ? Colors.blue : Colors.grey[500],
                              disabledColor: Colors.grey,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'تاكيد',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              animateOnTap: false,
                              onPressed: () {

                                if (txtUpdateCustomerBalance.text != null &&  txtUpdateCustomerBalance.text.trim() != '' ) {
                                   updateCustomerBalance(context: context);
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                )),
          );
        }
    );
  }


  void updateCustomerBalance({BuildContext context}){
    Navigator.pop(context);
    UserModel model =  listUser.firstWhere((element) => element.mobile == selectedUserId);
   double newBalance =   model.currentBalance +   double.parse(txtUpdateCustomerBalance.text);
     model.currentBalance = newBalance;

    FirebaseFirestore.instance.collection('User').doc(selectedUserId).update(model.toMap()).then((value) {

      sendNotificationToUserByToken(
        userToken: listUser.firstWhere((element) => element.mobile == selectedUserId).fireBaseToken,
        messageBody: 'تم اضافة ${double.parse(txtUpdateCustomerBalance.text)} جنية الي حسابك رصيد حسابك الان  ${newBalance} ',
        messageTitle: ' اضافة ${txtUpdateCustomerBalance.text +' ' + ' جنية '}في المحفظة '
      );

      txtUpdateCustomerBalance.clear();

    }).catchError((e){
      if (kDebugMode) {
        print(e);

      }
    });

  }
String selectedTab  = !Global.isAdmin? 'الرئيسية' : 'طلبات جديدة';
  void changeCurrentIndex(int value) {

    if(Global.isAdmin){
      if(value == 0){
          selectedTab = 'طلبات جديدة';
      }
      else if(value == 1){
        selectedTab = 'تحت التجهيز';
      }
      else if(value == 2){
        selectedTab = 'تم التسليم';
      }
      else if(value == 3){
        selectedTab = 'الاوردرات السابقة';
      }
    }
    else{

      if(value == 0){
        selectedTab = 'القائمة الرئيسية';
      }
      else if(value == 1){
        selectedTab = 'المفضل';
      }
      else if(value == 2){
        selectedTab = 'بحث';
      }
      else if(value == 3){
        selectedTab = 'الطلبات';
      }
      else if(value == 4){
        selectedTab = 'الاعدادات';
      }
    }


    currentIndex = value;

    emit(SearchSubCategoryState());
  }

  // Change Theme Mode

  bool isDarkTheme = false;


  String selectedUserId = '';

  static HomeCubit get(context) => BlocProvider.of(context);
  int selectedCategoryId = 0;
  int selectedSubCategoryId = 0;
  int selectedItemId = 0;

  List<String> departMentList = [
    'برمجه',
    'IT'
  ];

  List foodCategoryList = [
    {
      'imagePath': 'assets/pizza.svg',
      'name': 'Pizza',
    },
    {
      'imagePath': 'assets/sea-food.svg',
      'name': 'Seafood',
    },
    {
      'imagePath': 'assets/coke.svg',
      'name': 'Soft Drinks',
    },
    {
      'imagePath': 'assets/pizza.svg',
      'name': 'Pizza',
    },
  ];

  List<CategoryModel> listCategory = [];
  List<SubCategory> listSubCategory = [];
  List<SubCategory> listSubCategorySearch = [];
  List<ItemModel> listItems = [];
  List<ItemModel> popularFoodList = [];
  List<ItemModel> listItemsSearch = [];
  List<ItemModel> listFeedsSearch = [];
  List<ItemModel> listOrder = [];
  List<AdditionsModel> listAdditions = [];

  TextEditingController txtSubCategoryControl = TextEditingController();
  TextEditingController txtItemControl = TextEditingController();
  TextEditingController txtFavouriteControl = TextEditingController();
  List<OrderModel> listAllOrders = [];


 String getTotalCustomerOrdersPrice(){
   double total = 0;
   listAllOrders.where((element) => element.userMobile == selectedUserId).forEach((element2) {

     total += element2.totalPrice - element2.totalDiscountPrice;
   });
    return total.toString();
  }

  getOrders() async {
    FirebaseFirestore.instance.collection('Orders').doc(Global.mobile).collection('orderList')
        .snapshots()
        .listen((event) {


      listAllOrders = event.docs.map((x) => OrderModel.fromJson(x.data())).toList();
      // listAllOrders.forEach((element) {print(element.toJson());});
      emit(SelectCategoryState());
    });
  }
  String getTotalPriceForItem({int index}) {
    double price = 0;
    try{
      for (var element in listOrder[index].additionsList) {
        price = price + element.price;
      }
      price = price + listOrder[index].price;
      price = price * listOrder[index].orderCount;
    }
    catch(e){
      price = 0;
    }

    emit(SelectCategoryState());
    return price.toString();
  }
  String  getTotalAddaitonlPriceForItem({int index}){
    double price = 0;


    for (var element in listOrder[index].additionsList) {
      price = price +element.price;
    }

    price = price * listOrder[index].orderCount;
    emit(SelectCategoryState());
    return price.toString();

  }


  sendOrder(context) {
   try{
     if (listOrder.isNotEmpty) {
       double totalAdditionalPrice = 0;
       double totalDiscountPrice = 0;
       double orderPrice = 0;
       double totalPrice = 0;


       for (var element1 in listOrder) {
         for (var element2 in element1.additionsList) {
           totalAdditionalPrice = totalAdditionalPrice + element2.price;
         }
         totalDiscountPrice = totalDiscountPrice + (element1.price - element1.oldPrice);
         orderPrice = element1.price;
         totalPrice =  element1.price + totalDiscountPrice + totalAdditionalPrice;


       }
       var orderId = 1;
       if(listAllOrders.isNotEmpty){
         orderId = listAllOrders.length + 1;
       }
       var model = OrderModel(
         orderId:orderId ,

         userMobile: Global.mobile,
         adminMobile: listUser[0].mobile ,
         createdDate: DateTime.now().toString(),
         listItemModel: listOrder,
         totalAdditionalPrice:totalAdditionalPrice,
         totalDiscountPrice:totalDiscountPrice,
         totalPrice:totalPrice,
         userName: Global.userName,
         departMent: Global.departMent??'Programmer',
         orderPrice: orderPrice,
         orderState: 'New',

         isDeleted: 0,

       );


       FirebaseFirestore.instance.collection('Orders').doc(Global.mobile).
       collection('orderList').doc(orderId.toString())
           .update(model.toJson()).then((value){
       }).catchError((onError){
         FirebaseFirestore.instance.collection('Orders').doc(Global.mobile).
         collection('orderList').doc(orderId.toString())
             .set(model.toJson()).then((value) {
         }).catchError(onError);
       });
       // Send Notification For Admin

       print( listUser[0].fireBaseToken);
       sendNotificationToUserByToken(
           messageBody: '${Global.userName} تم ارسال طلب جديد من  ',
           messageTitle: 'طلب جديد',
           userToken:  listUser[0].fireBaseToken
       );
       listOrder = [];
       emit(SelectCategoryState());
     }
   }
   catch(e){
     print(e);
   }


  }


  updateOrderState({OrderModel orderModel}){
    FirebaseFirestore.instance.collection('Orders').doc(Global.mobile).
    collection('orderList').doc(orderModel.orderId.toString())
        .update(orderModel.toJson()).then((value){
    }).catchError((onError){
      FirebaseFirestore.instance.collection('Orders').doc(Global.mobile).
      collection('orderList').doc(orderModel.orderId.toString())
          .set(orderModel.toJson()).then((value) {
      }).catchError(onError);
    });
  }


  getTotalPrice(){
  double orderPrice = 0;
  // for (var element in listOrder) {
  //   orderPrice += element.price;
  //   for (var element in element.additionsList) {
  //     orderPrice += element.price;
  //   }
  //   return orderPrice.toString();
  // }


  for (var element in listOrder) {
    for( int i = 0 ; i < element.orderCount; i++ ) {
      orderPrice += element.price;
      for (var element2 in element.additionsList) {
        orderPrice += element2.price;

      }
    }

  }

  return orderPrice.toString();

  }

 addNewItemToCartFromItemScreen({itemId,orderCount}){
    var newList = listItemsSearch.firstWhere((element) => element.itemId == itemId);
    var model = ItemModel(
      orderCount:orderCount ,
      oldPrice:newList.oldPrice ,
      itemTitle:newList.itemTitle ,
      itemId: newList.itemId,
      isPopular: newList.isPopular,
      isDiscount:newList.isDiscount ,
      isDeleted: newList.isDeleted,
      isAvailable: newList.isAvailable,
      image:newList.image ,
      description:newList.description ,
      createdDate:newList.createdDate ,
      categoryTitle: newList.categoryTitle,
      categoryId:newList.categoryId ,
      additionsList: listOfSelectedAdditions.toList(),
      price:newList.price ,
        supCategoryId:newList.supCategoryId,

      supCategoryTitle:newList.supCategoryTitle ,
      userMobile:newList.userMobile ,
      userName: newList.userName
    );
    listOrder.add(model);
    listOfSelectedAdditions = [];
   emit(SearchSubCategoryState());
 }

  addNewItemToCartFromHomeScreen({itemId,orderCount}){
    var newList = popularFoodList.firstWhere((element) => element.itemId == itemId);
    var model = ItemModel(
        orderCount:orderCount ,
        isFavourite:newList.isFavourite ,
        orderState: 'New',
        oldPrice:newList.oldPrice ,
        itemTitle:newList.itemTitle ,
        itemId: newList.itemId,
        isPopular: newList.isPopular,
        isDiscount:newList.isDiscount ,
        isDeleted: newList.isDeleted,
        isAvailable: newList.isAvailable,
        image:newList.image ,
        description:newList.description ,
        createdDate:newList.createdDate ,
        categoryTitle: newList.categoryTitle,
        categoryId:newList.categoryId ,
        additionsList: listOfSelectedAdditions.toList(),
        price:newList.price ,
        supCategoryId:newList.supCategoryId,
        supCategoryTitle:newList.supCategoryTitle ,
        userMobile:newList.userMobile ,
        userName: newList.userName
    );
    listOrder.add(model);
    listOfSelectedAdditions = [];
    emit(SearchSubCategoryState());
  }

  addNewItemToCartFromFeedsScreen({itemId,orderCount}){
    var newList = listFeedsSearch.firstWhere((element) => element.itemId == itemId);
    var model = ItemModel(
        orderCount:orderCount ,
        isFavourite:newList.isFavourite ,
        orderState: 'New',
        oldPrice:newList.oldPrice ,
        itemTitle:newList.itemTitle ,
        itemId: newList.itemId,
        isPopular: newList.isPopular,
        isDiscount:newList.isDiscount ,
        isDeleted: newList.isDeleted,
        isAvailable: newList.isAvailable,
        image:newList.image ,
        description:newList.description ,
        createdDate:newList.createdDate ,
        categoryTitle: newList.categoryTitle,
        categoryId:newList.categoryId ,
        additionsList: listOfSelectedAdditions.toList(),
        price:newList.price ,
        supCategoryId:newList.supCategoryId,

        supCategoryTitle:newList.supCategoryTitle ,
        userMobile:newList.userMobile ,
        userName: newList.userName
    );

    listOrder.add(model);
    listOfSelectedAdditions = [];
    emit(SearchSubCategoryState());
  }




  getCategory() async {
    FirebaseFirestore.instance.collection('Category').snapshots().listen((event) {
    listCategory = event.docs.map((x) => CategoryModel.fromJson(x.data())).toList();
    emit(SelectCategoryState());
  });
  }


  getSubCategory() async {
    FirebaseFirestore.instance.collection('SubCategory').snapshots().listen((event) {
      listSubCategory = event.docs.map((x) => SubCategory.fromJson(x.data())).toList();
      emit(SelectCategoryState());
    });
  }

  getFavourite() async {
    FirebaseFirestore.instance.collection('Favourite').doc(Global.mobile).collection('ItemModel').snapshots().listen((event) {
      listFavourite = event.docs.map((x) => FavouritModel.fromJson(x.data())).toList();

      emit(SelectCategoryState());
    });
  }







  getItems() async {
    FirebaseFirestore.instance.collection('Items').snapshots().listen((event) {
      listItems = event.docs.map((x) => ItemModel.fromJson(x.data())).toList();
      listFeedsSearch = listItems;
      popularFoodList = listItems.where((element) => element.isPopular).toList();
      // listItems.forEach((element) {print(element.toJson());});
      emit(SelectCategoryState());
    });
  }
 List<AdditionsModel> listOfSelectedAdditions = [];
  getAdditions() async {
    FirebaseFirestore.instance.collection('Additions').snapshots().listen((event) {

      listAdditions = event.docs.map((x) => AdditionsModel.fromJson(x.data())).toList();
      emit(SelectCategoryState());

    });
  }


  List<FavouritModel> listFavourite = [];
  changeItemFavouriteState({bool isFavourite = false, int itemId})
  {


    FavouritModel model =  FavouritModel(
        isFavourit: !isFavourite,
        ItemId: itemId,
        UesrMobile: Global.mobile
    );



    FirebaseFirestore.instance.collection('Favourite').doc(Global.mobile).collection('ItemModel').doc(itemId.toString()).update(model.toMap()).then((value){


    }).catchError((onError){



      FirebaseFirestore.instance.collection('Favourite')
          .doc(Global.mobile).collection('ItemModel').doc(itemId.toString()).set(model.toMap()).then((value) {




      }).catchError(onError);



    });




  }



  selectCategory(categoryId,context) async {
selectedSubCategoryId = 0;
selectedItemId = 0;
    selectedCategoryId = categoryId;

    listSubCategorySearch = listSubCategory.where((element) => element.categoryId == categoryId).toList();

    if(listSubCategorySearch.isNotEmpty){
      navigateTo(context,   subCategoryScreen(categoryTitle: listCategory.firstWhere((element) => element.categoryId == selectedCategoryId).categoryTitle,));
    }
    else{
      EasyLoading.showError('لا يوجد بيانات');
    }


    emit(SelectCategoryState());

  }

  selectSubCategory({supCategoryId,context}) async {


    selectedItemId = 0;
    selectedSubCategoryId = supCategoryId;


    listItemsSearch = listItems.where((element) => element.supCategoryId == supCategoryId).toList();
    emit(SelectCategoryState());
    if(listItemsSearch.isNotEmpty){
      txtSubCategoryControl.clear();
      listSubCategorySearch = listSubCategory.where((element) => element.categoryId == selectedCategoryId).toList();
      navigateTo(context,ItemsScreen(subcategoryTitle:listItems.firstWhere((element) => element.supCategoryId == supCategoryId).supCategoryTitle??''));
    }
    else{
      EasyLoading.showError('لا يوجد بيانات');
    }


    emit(SelectCategoryState());
  }

  searchInSupCategory(String value){
  
    if(value.trim() != ''){
      listSubCategorySearch = listSubCategory.where((element) =>   element.categoryId == selectedCategoryId   &&
          element.subCategoryTitle.toLowerCase().contains(value.toLowerCase())).toList();
    }
    else{
      listSubCategorySearch = listSubCategory.where((element) => element.categoryId == selectedCategoryId).toList();
    }

    emit(SearchSubCategoryState());
  }
  searchInItems(String value){
    if(value.trim() != ''){
      listItemsSearch = listItems.where((element) =>   element.supCategoryId == selectedSubCategoryId  &&
          element.itemTitle.toLowerCase().contains(value.toLowerCase())).toList();
    }
    else{
      listItemsSearch = listItems.where((element) => element.supCategoryId == selectedSubCategoryId).toList();
    }
    emit(SearchSubCategoryState());
  }
  searchInFeeds(String value){
    if(value.trim() != ''){
      listFeedsSearch = listItems.where((element) =>   element.itemTitle.toLowerCase().contains(value.toLowerCase())).toList();
    }
    else{
      listFeedsSearch = listItems.toList();
    }
    emit(SearchSubCategoryState());
  }

  sendNotifacation(){


    Dio dio;
    dio = Dio(BaseOptions(
        baseUrl: '',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAARcAtNzU:APA91bGKDZmMAXkV3mRi_5_BvnLmaxm2rZHF7JBskZcIIkbVx34kfjzoNB-iocOI4sI4uR8Bcg0WV1B84BJ_VHWzi7gPAlC943DuTIaQOswi3upbld6tqEdO4R732LzWqaIpluYNkM_w',
        }));
    var data = {
      "notification": {"body": "this is a body","title": "this is a title"}, "priority": "high", "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "id": "1", "status": "done"}, "to": Global.fireBaseToken
    };
    dio.post('https://fcm.googleapis.com/fcm/send', data: data).then((value) {

      print(value.data());
    });




  }

   sendNotificationToUserByToken({String messageTitle ,String messageBody,String userToken }){

    // print(messageTitle);
    // print(messageBody);
    // print(userToken);

    Dio dio;
    dio = Dio(BaseOptions(
        baseUrl: '',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAARcAtNzU:APA91bGKDZmMAXkV3mRi_5_BvnLmaxm2rZHF7JBskZcIIkbVx34kfjzoNB-iocOI4sI4uR8Bcg0WV1B84BJ_VHWzi7gPAlC943DuTIaQOswi3upbld6tqEdO4R732LzWqaIpluYNkM_w',
        }));
    var data = {
      "notification": {"body":messageBody ,"title": messageTitle}, "priority": "high", "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "id": "1", "status": "done"}, "to": userToken
    };
    dio.post('https://fcm.googleapis.com/fcm/send', data: data).then((value) {

      print(value.data());
    }).catchError((onError){
      print(onError);
    });
  }

  sendNotificationForAllUser(context) async {
    for (var element in  listUser)  {
      await    sendNotificationToUserByToken(messageTitle:titleTextControl.text,messageBody:sendMessageTextControl.text,userToken: element.fireBaseToken);
    }

    sendMessageTextControl.clear();
    titleTextControl.clear();
    emit(SelectCategoryState());

  }

  RoundedLoadingButtonController sendNotifactionBtnController = RoundedLoadingButtonController();
  RoundedLoadingButtonController callBtnController = RoundedLoadingButtonController();

  List ingredients = [
    {
      'imagePath': 'assets/tomato.png',
    },
    {
      'imagePath': 'assets/onion.png',
    },
    {
      'imagePath': 'assets/tomato.png',
    },
    {
      'imagePath': 'assets/onion.png',
    },
    {
      'imagePath': 'assets/tomato.png',
    },
    {
      'imagePath': 'assets/onion.png',
    },
  ];

  List<UserModel> listUser = [];

  getUsers() async {
    FirebaseFirestore.instance.collection('User').snapshots().listen((event) {
      listUser = event.docs.map((x) => UserModel.fromJson(x.data())).toList();

      emit(SelectCategoryState());
    }).onError((handleError) {
      print(handleError);
    });
  }
  logOut(context)
  async {
    await CachHelper.SetData(key: 'mobile', value: '');
    await CachHelper.SetData(key: 'isUserLogin', value: false);
    await CachHelper.SetData(key: 'isAdmin', value: false);
    await CachHelper.SetData(key: 'imageUrl', value: '');
    await CachHelper.SetData(key: 'userName', value: '');
    await CachHelper.SetData(key: 'departmentId', value: 0);
    currentIndex = 0;
    NavigatToAndReplace(context, const LoginScreen());
  }
}
