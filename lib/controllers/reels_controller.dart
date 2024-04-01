import 'package:get/get.dart';

import 'package:get/get.dart';

class ReelsController extends GetxController {
  // Observable variables
  var isMuted = false.obs;
  var isLiked = false.obs;
  var likeCount = '570K'.obs;
  var commentCount = '4458'.obs;
  var shareCount = '131K'.obs;
  RxInt tabIndex = 0.obs;

  // Method to toggle the volume
  void toggleVolume() {
    isMuted.value = !isMuted.value;
  }

  // Method to toggle the like status
  void toggleLike() {
    isLiked.toggle(); // This is a GetX method to toggle boolean values.
    // Here you would add your logic to increment or decrement the like count.
    if (isLiked.isTrue) {
      // If the post is liked, increment the like count
      // Convert to actual number and increment (this is just for illustration)
      likeCount.value =
          (int.parse(likeCount.value.replaceAll('K', '')) + 1).toString() + 'K';
    } else {
      // If the post is unliked, decrement the like count
      // Convert to actual number and decrement (this is just for illustration)
      likeCount.value =
          (int.parse(likeCount.value.replaceAll('K', '')) - 1).toString() + 'K';
    }
  }

  // Method to handle comments
  void onComment() {
    // Here you would implement the logic to handle when a user comments
    // For now, let's just increment a dummy comment count
    commentCount.value = (int.parse(commentCount.value) + 1).toString();
  }

  // Method to handle shares
  void onShare() {
    // Here you would implement the logic to handle when a user shares the reel
    // For now, let's just increment a dummy share count
    shareCount.value =
        (int.parse(shareCount.value.replaceAll('K', '')) + 1).toString() + 'K';
  }

  // Method to handle follow action
  void onFollow() {
    // Implement the logic to follow a user
    // This could involve setting a boolean value and sending a request to your backend
  }

  void changeTab(int index) {
    tabIndex.value = index;
  }
}
