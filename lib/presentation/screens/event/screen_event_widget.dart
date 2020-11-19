//         if (_eventStore != null)
//           Container(
// //            padding: const EdgeInsets.only(right: 12.0),
//             decoration: BoxDecoration(shape: BoxShape.circle),
//             child: Transform.scale(
//               scale: 0.5,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(36.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     if (_eventStore.canShowAds) {
//                       showDialog(
//                         context: context,
//                         barrierDismissible: false,
//                         builder: (context) => new AdDialog(
//                           ads: _eventStore.ads,
//                           initCheck: _eventStore.checkSkip,
//                           onClose: (skipNextTime) {
//                             debugPrint('ads dialog close, skip=$skipNextTime');
//                             _eventStore.setSkipAd(skipNextTime);
//                             _eventStore.adsDialogClose();
//                           },
//                         ),
//                       );
//                     }
//                   },
//                   child: networkImageBuilder(
//                     'images/AD_ICON2.png',
//                     imgScale: 3.0,
//                   ),
//                 ),
//               ),
//             ),
//           ),

// bool _showingEventDialog = false;
//
// void _checkShowEvent() {
//   _eventStore.debugEvent();
//   if (_eventStore.forceShowEvent && _eventStore.hasEvent == false) {
//     Future.delayed(Duration(milliseconds: 200), () {
//       callToastInfo(localeStr.messageNoEvent);
//     });
//     // set to false so it will not pop on other pages
//     _eventStore.setForceShowEvent = false;
//     return;
//   }
//   if (_eventStore.showEventOnHome && !_showingEventDialog) {
//     _showingEventDialog = true;
//     Future.delayed(Duration(milliseconds: 1200), () {
//       // will not show
//       if (_store.hasUser == false ||
//           (_store.navIndex != 0 && _eventStore.forceShowEvent == false)) {
//         _stopEventAutoShow();
//         return;
//       } else {
//         // set to false so it will not pop on other pages
//         _eventStore.setForceShowEvent = false;
//       }
//       _showEventDialog();
//     });
//   }
// }
//
// void _showEventDialog() {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (_) => (_eventStore.hasSignedEvent == false)
//         ? new EventDialog(
//       event: _eventStore.event.eventData,
//       signCount: _eventStore.event.signData.times,
//       onSign: () => _eventStore.signEvent(),
//       onSignError: () => _eventStore.getEventError(),
//       onDialogClose: () => _stopEventAutoShow(),
//     )
//         : new EventDialogSigned(
//       event: _eventStore.event.eventData,
//       signCount: _eventStore.event.signData.times,
//       onDialogClose: () => _stopEventAutoShow(),
//     ),
//   );
// }
//
// void _stopEventAutoShow() {
//   if (_store == null) return;
//   _showingEventDialog = false;
//   // set to false so it will not pop again when return to home page
//   _eventStore.setShowEvent = false;
// }
