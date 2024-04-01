import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/utils/constants.dart';
import 'package:troptrip/views/reels/following_reels_screen.dart';
import 'package:troptrip/views/reels/trips_reels_screen.dart';
import 'package:troptrip/widgets/my_text.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../controllers/reels_controller.dart';
// Your ReelsController file

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen>
    with SingleTickerProviderStateMixin {
  final ReelsController controller = Get.put(ReelsController());
  TabController? _tabController;
    //Controller? tikTokController;

  final List<String> videoPaths = [
    'assets/videos/f1.mp4',
    'assets/videos/f2.mp4',
    'assets/videos/f3.mp4',
  ];

  final List<VideoPlayerController> _controllers = [];
  int _currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    for (final videoPath in videoPaths) {
      final controller = VideoPlayerController.asset(videoPath)
        ..initialize().then((_) => setState(() {}));
      _controllers.add(controller);
    }
  }
  

  @override
  void dispose() {
     _tabController?.dispose();
    for (final controller in _controllers) {
      controller.dispose();
    }

    super.dispose();
  }

void _goToNextVideo() {
    setState(() {
      _currentVideoIndex = (_currentVideoIndex + 1) % videoPaths.length;
      _controllers[_currentVideoIndex].play();
      _controllers[_currentVideoIndex - 1].pause(); // Pause previous video
    });
  }

  void _goToPreviousVideo() {
    setState(() {
      _currentVideoIndex =
          (_currentVideoIndex - 1 + videoPaths.length) % videoPaths.length;
      _controllers[_currentVideoIndex].play();
      _controllers[_currentVideoIndex + 1].pause(); // Pause next video
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          _goToNextVideo();
        } else if (details.primaryVelocity! < 0) {
          _goToPreviousVideo();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: _buildTopBar(),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Stack(
              children: [
                // Placeholder for video content
                TikTokStyleFullPageScroller(
                  contentSize: videoPaths.length,
                  builder: (context, index) {
                    
                        final controller = _controllers[index];
                        return VisibilityDetector(
                          key: Key(index.toString()),
                          onVisibilityChanged: (visibilityInfo) {
                            if (visibilityInfo.visibleFraction > 0.5) {
                              _currentVideoIndex = index;
                              controller.play();
                            } else {
                              controller.pause();
                            }
                          },
                          child: AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: VideoPlayer(controller),
                          ),
                        
                      
                    );
                  }
                ),
                // Positioned(
                //   top: MediaQuery.of(context).padding.top,
                //   left: 0,
                //   right: 0,
                //   child: _buildTopBar(),
                // ),
                // Profile, Follow and Sound Information
                Positioned(
                  left: 16,
                  bottom: 10,
                  child: _buildProfileSection(),
                ),
                // Like, Comment, Share, and More Options
                Positioned(
                  right: 16,
                  bottom: 60,
                  child: _buildInteractionButtons(),
                ),
              ],
            ),
          
          const TripsReelsScreen(),
          const FollowinfReelsScreen(),
          ],
        ),
      ),
    );
  }

  // Widget _buildTopBar() {
  Widget _buildTopBar() {
    return TabBar(
      controller: _tabController,
      
      tabs: const [
        Tab(text: 'Explore'),
        Tab(text: 'Trips'),
        Tab(text: 'Following'),

      ],
      //onTap: controller.changeTab,
    );
  }

  Widget _buildProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(
                AppConstants.kProfileImage,
              ),
              backgroundColor: AppTheme.whiteColor,
              radius: 30,
            ),
            const SizedBox(width: 8),
            const MyText(
              text: 'king.silas',
              color: AppTheme.whiteColor,
              weight: FontWeight.bold,
              size: 16.0,
            ),
            const SizedBox(width: 8),
            Container(
              height: 30.0,
              width: 80.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  border: Border.all(
                    color: AppTheme.whiteColor,
                  )),
              child: const Center(
                  child: MyText(
                text: 'Follow',
                color: AppTheme.whiteColor,
                weight: FontWeight.bold,
              )),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text('Remix with anakobra45',
            style: TextStyle(color: Colors.white, fontSize: 14)),
        const SizedBox(height: 8),
        Container(
          height: 20.0,
          decoration: BoxDecoration(
            gradient: AppTheme.appGradient(),
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(3.0),
              child: Text('tipsbeats . Original audio',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInteractionButtons() {
    return Column(
      children: [
        IconButton(
          icon: Obx(() => Icon(
                controller.isLiked.value
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: controller.isLiked.value ? Colors.red : Colors.white,
              )),
          onPressed: controller.toggleLike,
        ),
        Obx(() => Text(controller.likeCount.value,
            style: const TextStyle(color: Colors.white))),

        IconButton(
          icon: Image.asset(
              'assets/icons/comment.png',
              height: 24.0,
              width: 24.0,
            ),
          
          onPressed: controller.toggleLike,
        ),
        Obx(() => Text(controller.commentCount.value,
            style: const TextStyle(color: Colors.white))),
        // Repeat this IconButton and Text for comments and shares

        IconButton(
          icon: Image.asset(
              'assets/icons/share.png',
              height: 24.0,
              width: 24.0,
            ),
          
          onPressed: controller.toggleLike,
        ),
        Obx(() => Text(controller.shareCount.value,
            style: const TextStyle(color: Colors.white))),
        // Repeat this IconButton and Text for comments and shares
      ],
    );
  }
}
