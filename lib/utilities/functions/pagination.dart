// // function to effect pagination
// // currentPageBucket is used to store the current page number

// import 'package:circle/data/utilities/imports/generalImport.dart';

// listenToTransactionScroll(BuildContext context, {
//   required int index, required int currentPage, required int lastPage,required int currentPageBucket,
  
//   }) {
//     if (kDebugMode) {
//       debugPrint('startedd listening $currentPageBucket');
//     }
//     homePageHistoryScrollController.addListener(() {
//       if (homePageHistoryScrollController.position.extentAfter < 50 &&
//           index + 1 ==
//               homePageHistoryModel!.data!.perPage! *
//                   homePageHistoryModel!.data!.currentPage! &&
//           currentPageBucket! < homePageHistoryModel!.data!.lastPage!) {
//         // that means we are at the end of the list view
//         if (homePageHistoryModel!.data!.lastPage! ==
//             homePageHistoryModel!.data!.currentPage) {
//           // show the list has ended
//           loadingNewPage = 'End of the list';
//           debugPrint('index end');
//           notifyListeners();
//           // set loading back to empty string
//           Future.delayed(const Duration(milliseconds: 200), () {
//             loadingNewPage = '';
//             notifyListeners();
//             return;
//           });
//         }

//         // else if
//        else{ homePageHistoryFunction(context,
//             nextUrl: homePageHistoryModel!.data!.nextPageUrl);}
//       }
//     });
//   }