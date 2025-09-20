import 'package:get/get.dart';

import '../../../../../common_models/my_compaigns_model.dart';
import '../../../../../common_models/song_model.dart';

class MyCompaignsController extends GetxController{
  var selectedTab = 0.obs;
  List<MyCompaignsModel> activeCompaignsList = [
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_1.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_2.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_3.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_4.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_5.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_6.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_2.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_3.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_4.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
  ];
  List<MyCompaignsModel> pauseCompaignsList = [
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_4.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_5.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_6.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_1.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_2.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_3.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),

    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_2.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_3.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_4.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
  ];
  List<MyCompaignsModel> draftsList = [
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_2.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_3.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),

    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_2.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_3.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_4.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 25000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
  ];
  List<MyCompaignsModel> completedList = [
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_3.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 50000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
    MyCompaignsModel(
      imagePath: 'assets/images/thumbnail_4.png',
      compaignName: 'Campaign Name',
      GoalPrice: 50000,
      currentPrice: 50000,
      cause:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      description:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
      attachedPlaylist: [
        SongModel(
          imagePath: 'assets/images/thumbnail_1.png',
          songName: 'Lost Umbrella',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_2.png',
          songName: 'Clockwork Hearts',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_3.png',
          songName: 'The Lighthouse Whispered',
          length: '05:47 min',
        ),
        SongModel(
          imagePath: 'assets/images/thumbnail_4.png',
          songName: 'Recording 1',
          length: '05:47 min',
        ),
      ],
    ),
  ];

}