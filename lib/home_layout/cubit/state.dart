// @dart=2.9

abstract class HomeState {}
class HomeInitialState extends HomeState {}


// Home Layout

class HomeChangeBottmNavState extends HomeState {}
class HomeChangeThemeState extends HomeState {}


// Home Prand

class HomePrandIndexState extends HomeState {}
class HomeGetPrandFeedState extends HomeState {}


class HomeGetCategoryFeedState extends HomeState {}


// Cart Screen
class HomeAddCartItemState extends HomeState {}

class HomeGetTotalToCartItemsState extends HomeState {}

class HomeQuantityPlusState extends HomeState {}
class HomeQuantityMinesState extends HomeState {}

class HomeRemoveCartItemState extends HomeState {}
class HomeRemoveCartsState extends HomeState {}

// WishList Screen

class HomeAddWishListItemState extends HomeState {}
class HomeRemoveWishListItemState extends HomeState {}
class HomeRemoveWishListsState extends HomeState {}

// UserInfo
class UserInfoSuccessState extends HomeState {}
class UserInfoErrorState extends HomeState {}
class UserInfoGalleryImageState extends HomeState {}


// Search Screen
class HomeSearchState extends HomeState {}

// Login Screen

class HomeHiddenPasswordState extends HomeState {}
class HomeNotHiddenPasswordState extends HomeState {}

class LoginLoadingState extends HomeState {}
class LoginSuccessState extends HomeState {}
class LoginErrorState extends HomeState {}

// SignUp Screen

class HomeRemoveImageState extends HomeState {}
class HomeCameraImageState extends HomeState {}
class HomeGalleryImageState extends HomeState {}


class SignUpLoadingState extends HomeState {}
class SignUpSuccessState extends HomeState {}
class SignUpErrorState extends HomeState {}

// Landing Page

class GoogleSignInLoadingState extends HomeState {}
class GoogleSignInSuccessState extends HomeState {}
class GoogleSignInErrorState extends HomeState {}



// Upload Product
class HomeRemoveUploadImageState extends HomeState {}
class HomeCameraUploadImageState extends HomeState {}
class HomeGalleryUploadImageState extends HomeState {}

class HomeSelectCategoryState extends HomeState {}
class HomeSelectBrandState extends HomeState {}