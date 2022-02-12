// // @dart=2.9
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:glccoffe/bloc/SocialCubit/states.dart';
// import 'package:glccoffe/model/social_app/message_model.dart';
// import 'package:glccoffe/model/social_app/post_model.dart';
// import 'package:glccoffe/model/social_app/social_user_model.dart';
//
//
//
//
//
// class SocialCubit extends Cubit<SocialStates> {
//   SocialCubit() : super(SocialInitialState());
//
//   static SocialCubit get(context) => BlocProvider.of(context);
//
//   SocialUserModel userModel;
//
//   void getUserData() {
//     // emit(SocialGetUserLoadingState());
//     //
//     // FirebaseFirestore.instance.collection('users').doc('').get().then((value) {
//     //   //print(value.data());
//     //   userModel = SocialUserModel.fromJson(value.data());
//     //   emit(SocialGetUserSuccessState());
//     // }).catchError((error) {
//     //   print(error.toString());
//     //   emit(SocialGetUserErrorState(error.toString()));
//     // });
//   }
//
//   int currentIndex = 0;
//
//   List<Widget> screens = [
//     // FeedsScreen(),
//     // ChatsScreen(),
//     // NewPostScreen(),
//     // UsersScreen(),
//     // SettingsScreen(),
//   ];
//
//   List<String> titles = [
//     'Home',
//     'Chats',
//     'Post',
//     'Users',
//     'Settings',
//   ];
//
//   void changeBottomNav(int index) {
//     if (index == 1) getUsers();
//     if (index == 2) {
//       emit(SocialNewPostState());
//     } else {
//       currentIndex = index;
//       emit(SocialChangeBottomNavState());
//     }
//   }
//
//   File profileImage;
//   var picker  ;
//
//   Future<void> getProfileImage() async {
//     final pickedFile = await picker.getImage(
//       // source: ImageSource.gallery,
//     );
//
//     if (pickedFile != null) {
//
//       profileImage = File(pickedFile.path);
//
//       emit(SocialProfileImagePickedSuccessState());
//     } else {
//
//       emit(SocialProfileImagePickedErrorState());
//     }
//   }
//
//   // image_picker7901250412914563370.jpg
//
//   File coverImage;
//
//   Future<void> getCoverImage() async {
//     final pickedFile = await picker.getImage(
//       // source: ImageSource.gallery,
//     );
//
//     if (pickedFile != null) {
//       coverImage = File(pickedFile.path);
//       emit(SocialCoverImagePickedSuccessState());
//     } else {
//
//       emit(SocialCoverImagePickedErrorState());
//     }
//   }
//
//   void uploadProfileImage({
//     @required String name,
//     @required String phone,
//     @required String bio,
//   }) {
//     // emit(SocialUserUpdateLoadingState());
//     //
//     // firebase_storage.FirebaseStorage.instance
//     //     .ref()
//     //     .child('users/${Uri.file(profileImage.path).pathSegments.last}')
//     //     .putFile(profileImage)
//     //     .then((value) {
//     //   value.ref.getDownloadURL().then((value) {
//     //     //emit(SocialUploadProfileImageSuccessState());
//     //     print(value);
//     //     updateUser(
//     //       name: name,
//     //       phone: phone,
//     //       bio: bio,
//     //       image: value,
//     //     );
//     //   }).catchError((error) {
//     //     emit(SocialUploadProfileImageErrorState());
//     //   });
//     // }).catchError((error) {
//     //   emit(SocialUploadProfileImageErrorState());
//     // });
//   }
//
//   void uploadCoverImage({
//     @required String name,
//     @required String phone,
//     @required String bio,
//   }) {
//     // emit(SocialUserUpdateLoadingState());
//     //
//     // firebase_storage.FirebaseStorage.instance
//     //     .ref()
//     //     .child('users/${Uri.file(coverImage.path).pathSegments.last}')
//     //     .putFile(coverImage)
//     //     .then((value) {
//     //   value.ref.getDownloadURL().then((value) {
//     //     //emit(SocialUploadCoverImageSuccessState());
//     //     print(value);
//     //     updateUser(
//     //       name: name,
//     //       phone: phone,
//     //       bio: bio,
//     //       cover: value,
//     //     );
//     //   }).catchError((error) {
//     //     emit(SocialUploadCoverImageErrorState());
//     //   });
//     // }).catchError((error) {
//     //   emit(SocialUploadCoverImageErrorState());
//     // });
//   }
//
// //   void updateUserImages({
// //   @required String name,
// //   @required String phone,
// //   @required String bio,
// // })
// //   {
// //     emit(SocialUserUpdateLoadingState());
// //
// //     if(coverImage != null)
// //     {
// //       uploadCoverImage();
// //     } else if(profileImage != null)
// //     {
// //       uploadProfileImage();
// //     } else if (coverImage != null && profileImage != null)
// //     {
// //
// //     } else
// //       {
// //         updateUser(
// //           name: name,
// //           phone: phone,
// //           bio: bio,
// //         );
// //       }
// //   }
//
//   void updateUser({
//     @required String name,
//     @required String phone,
//     @required String bio,
//     String cover,
//     String image,
//   }) {
//     // SocialUserModel model = SocialUserModel(
//     //   name: name,
//     //   phone: phone,
//     //   bio: bio,
//     //   email: userModel.email,
//     //   cover: cover ?? userModel.cover,
//     //   image: image ?? userModel.image,
//     //   uId: userModel.uId,
//     //   isEmailVerified: false,
//     // );
//     //
//     // FirebaseFirestore.instance
//     //     .collection('users')
//     //     .doc(userModel.uId)
//     //     .update(model.toMap())
//     //     .then((value) {
//     //   getUserData();
//     // }).catchError((error) {
//     //   emit(SocialUserUpdateErrorState());
//     // });
//   }
//
//   File postImage;
//
//   Future<void> getPostImage() async {
//     final pickedFile = await picker.getImage(
//       // source: ImageSource.gallery,
//     );
//
//     if (pickedFile != null) {
//       postImage = File(pickedFile.path);
//       emit(SocialPostImagePickedSuccessState());
//     } else {
//
//       emit(SocialPostImagePickedErrorState());
//     }
//   }
//
//   void removePostImage() {
//     postImage = null;
//     emit(SocialRemovePostImageState());
//   }
//
//   void uploadPostImage({
//     @required String dateTime,
//     @required String text,
//   }) {
//     // emit(SocialCreatePostLoadingState());
//     //
//     // firebase_storage.FirebaseStorage.instance
//     //     .ref()
//     //     .child('posts/${Uri.file(postImage.path).pathSegments.last}')
//     //     .putFile(postImage)
//     //     .then((value) {
//     //   value.ref.getDownloadURL().then((value) {
//     //     print(value);
//     //     createPost(
//     //       text: text,
//     //       dateTime: dateTime,
//     //       postImage: value,
//     //     );
//     //   }).catchError((error) {
//     //     emit(SocialCreatePostErrorState());
//     //   });
//     // }).catchError((error) {
//     //   emit(SocialCreatePostErrorState());
//     // });
//   }
//
//   void createPost({
//     @required String dateTime,
//     @required String text,
//     String postImage,
//   }) {
//     // emit(SocialCreatePostLoadingState());
//     //
//     // PostModel model = PostModel(
//     //   name: userModel.name,
//     //   image: userModel.image,
//     //   uId: userModel.uId,
//     //   dateTime: dateTime,
//     //   text: text,
//     //   postImage: postImage ?? '',
//     // );
//     //
//     // FirebaseFirestore.instance
//     //     .collection('posts')
//     //     .add(model.toMap())
//     //     .then((value) {
//     //   emit(SocialCreatePostSuccessState());
//     // }).catchError((error) {
//     //   emit(SocialCreatePostErrorState());
//     // });
//   }
//
//   List<PostModel> posts = [];
//   List<String> postsId = [];
//   List<int> likes = [];
//
//   void getPosts() {
//     // FirebaseFirestore.instance.collection('posts').get().then((value) {
//     //   value.docs.forEach((element) {
//     //     element.reference.collection('likes').get().then((value) {
//     //       likes.add(value.docs.length);
//     //       postsId.add(element.id);
//     //       posts.add(PostModel.fromJson(element.data()));
//     //     }).catchError((error) {});
//     //   });
//     //
//     //   emit(SocialGetPostsSuccessState());
//     // }).catchError((error) {
//     //   print(error.toString());
//     //   emit(SocialGetPostsErrorState(error.toString()));
//     // });
//   }
//
//   void likePost(String postId) {
//     // FirebaseFirestore.instance
//     //     .collection('posts')
//     //     .doc(postId)
//     //     .collection('likes')
//     //     .doc(userModel.uId)
//     //     .set({
//     //   'like': true,
//     // }).then((value) {
//     //   emit(SocialLikePostSuccessState());
//     // }).catchError((error) {
//     //   emit(SocialLikePostErrorState(error.toString()));
//     // });
//   }
//
//   List<SocialUserModel> users = [];
//
//   void getUsers() {
//     // if (users.length == 0)
//     //   FirebaseFirestore.instance.collection('users').get().then((value) {
//     //     value.docs.forEach((element) {
//     //       if (element.data()['uId'] != userModel.uId)
//     //         users.add(SocialUserModel.fromJson(element.data()));
//     //     });
//     //
//     //     emit(SocialGetAllUsersSuccessState());
//     //   }).catchError((error) {
//     //     print(error.toString());
//     //     emit(SocialGetAllUsersErrorState(error.toString()));
//     //   });
//   }
//
//   void sendMessage({
//     @required String receiverId,
//     @required String dateTime,
//     @required String text,
//   }) {
//
//     // set my chats
//     //
//     // FirebaseFirestore.instance
//     //     .collection('users')
//     //     .doc(userModel.uId)
//     //     .collection('chats')
//     //     .doc(receiverId)
//     //     .collection('messages')
//     //     .add(model.toMap())
//     //     .then((value) {
//     //   emit(SocialSendMessageSuccessState());
//     // }).catchError((error) {
//     //   emit(SocialSendMessageErrorState());
//     // });
//     //
//     // // set receiver chats
//     //
//     // FirebaseFirestore.instance
//     //     .collection('users')
//     //     .doc(receiverId)
//     //     .collection('chats')
//     //     .doc(userModel.uId)
//     //     .collection('messages')
//     //     .add(model.toMap())
//     //     .then((value) {
//     //   emit(SocialSendMessageSuccessState());
//     // }).catchError((error) {
//     //   emit(SocialSendMessageErrorState());
//     // });
//   }
//
//   List<MessageModel> messages = [];
//
//   void getMessages({
//     @required String receiverId,
//   }) {
//     // FirebaseFirestore.instance
//     //     .collection('users')
//     //     .doc(userModel.uId)
//     //     .collection('chats')
//     //     .doc(receiverId)
//     //     .collection('messages')
//     //     .orderBy('dateTime')
//     //     .snapshots()
//     //     .listen((event) {
//     //   messages = [];
//     //
//     //   event.docs.forEach((element) {
//     //     messages.add(MessageModel.fromJson(element.data()));
//     //   });
//     //
//     //   emit(SocialGetMessagesSuccessState());
//     // });
//   }
// }
