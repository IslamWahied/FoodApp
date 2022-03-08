// @dart=2.9
abstract class UploadProductsState {}

class UploadProductsInitState extends UploadProductsState {}

class UploadProductsRemoveUploadImageState extends UploadProductsState {}

class UploadProductsCameraUploadImageState extends UploadProductsState {}

class UploadProductsGalleryUploadImageState extends UploadProductsState {}

class UploadProductsSelectCategoryState extends UploadProductsState {}

class UploadProductsAddCategoryState extends UploadProductsState {}

class UploadProductsCantAddCategoryState extends UploadProductsState {}
class onChangeTypeItemIdState extends UploadProductsState {}
class RefreshState extends UploadProductsState {}
