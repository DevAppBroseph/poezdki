// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

// class DynamicLinkService {
//   Future handleDynamicLinks() async {
//     // 1. Get the initial dynamic link if the app is opened with a dynamic link
//     final PendingDynamicLinkData data =
//         await FirebaseDynamicLinks.instance.getInitialLink();

//     // 2. handle link that has been retrieved
//     _handleDeepLink(data);

//     // 3. Register a link callback to fire if the app is opened up from the background
//     // using a dynamic link.
//     FirebaseDynamicLinks.instance.onLink(
//         onSuccess: (PendingDynamicLinkData dynamicLink) async {
//       // 3a. handle link that has been retrieved
//       _handleDeepLink(dynamicLink);
//     }, onError: (OnLinkErrorException e) async {
//     });
//   }

//   void _handleDeepLink(PendingDynamicLinkData data) {
//     final Uri deepLink = data?.link;
//     if (deepLink != null && sl<AuthConfig>().userEntity != null) {

//       // Check if we want to make a post
//       var isPost = deepLink.pathSegments.contains('post');

//       if (isPost) {
//         // get the title of the post
//         var id = deepLink.queryParameters['id'];

//         if (id != null) {
//           // if we have a post navigate to the CreatePostViewRoute and pass in the title as the arguments.
//           _navigationService.navigateToAnketa('', int.parse(id));
//         }
//       }
//     }
//   }

//   Future<String> createFirstPostLink(String fullName, int id) async {
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://kerek.page.link',
//       link: Uri.parse('https://www.compound.com/post?id=$id'),
//       androidParameters: AndroidParameters(
//         packageName: 'kz.kerek',
//       ),
//       // NOT ALL ARE REQUIRED ===== HERE AS AN EXAMPLE =====
//       iosParameters: IosParameters(
//         bundleId: 'kz.kerek',
//         appStoreId: '1577074329',
//       ),
//     );

//     final Uri dynamicUrl = await parameters.buildUrl();
//     return dynamicUrl.toString();
//   }
// }
