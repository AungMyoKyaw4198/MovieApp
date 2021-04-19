import 'package:youTubeApp/model/category.dart';
import 'package:youTubeApp/model/channel.dart';
import 'package:youTubeApp/model/movie.dart';


const String API_Key= 'AIzaSyD6xP6xKcKeJgDDyFTgtaDOUEy_ynTwBwg';
List<Channel> channelCache = [];

List<Category> categoryCache = [];
List<Movie> moviesCache = [];
List<Movie> recomdMovieListCache = [];
List<Movie> newMovieListCache = [];
String appUnitId = '';
String bannerAdId = '';
String fullScreenAdId= '';

// List<String> channelIDs = [
//   'UCJFGNmtLtwmX752P7OhcdvQ',
//   'UCyprSUcaLP0mQAB1b9N90pg',
//   'UCWZzuQbRIeAKM9Nx-11-d_Q',
//   'UCtM609HMCJHMA812GdHvxqA',
//   'UCesiu2rvAlopyNVzEK4RFMA',
//   'UC_IUdjPSWoo1jov91VEHa7A',
//   'UCSaXL4MiaEG0m0yEHKWzpgQ',
//   // 'UCBZWU1iRrtll1QoO9O_rD_w',
//   'UC_kHjyFSbgLvESmeLhxLB8g',
//   'UCbpn8tQkYB-zMMqo22-YnfA',
//   ];

List<Map<String,String>> tvChannelsJson = [
  {
    'name': '5Plus',
    'image': 'assets/5plus.jpg',
    'url': 'https://www.mmtvchannels.com/5-plus.html',
  },
  {
    'name': 'Channel7',
    'image': 'assets/channel7.jpg',
    'url': 'https://www.mmtvchannels.com/channel-7.html',
  },
  {
    'name': 'Channel9',
    'image': 'assets/channel9.jpg',
    'url': 'https://www.mmtvchannels.com/channel9.html',
  },
  {
    'name': 'ChannelK',
    'image': 'assets/channelk.jpg',
    'url': 'https://www.mmtvchannels.com/channel-k.html',
  },
  {
    'name': 'DVB',
    'image': 'assets/dvb.jpg',
    'url': 'https://www.mmtvchannels.com/dvb.html',
  },
  {
    'name': 'Education Channel',
    'image': 'assets/education.jpg',
    'url': 'https://www.mmtvchannels.com/education-channel.html',
  },
  {
    'name': 'Farmer Channel',
    'image': 'assets/farmer.jpg',
    'url': 'https://www.mmtvchannels.com/farmer.html',
  },
  {
    'name': 'Fortune Tv',
    'image': 'assets/fortune.jpg',
    'url': 'https://www.mmtvchannels.com/fortune.html',
  },
  {
    'name': 'Hluttaw',
    'image': 'assets/hluttaw.jpg',
    'url': 'https://www.mmtvchannels.com/hluttaw.html',
  },
  {
    'name': 'Mahar',
    'image': 'assets/mahar.jpg',
    'url': 'https://www.mmtvchannels.com/mahar.html',
  },
  {
    'name': 'Maharbawdi Channel',
    'image': 'assets/maharbawdi.jpg',
    'url': 'https://www.mmtvchannels.com/mahar-bawdi.html',
  },
  {
    'name': 'MITV',
    'image': 'assets/mitv.jpg',
    'url': 'https://www.mmtvchannels.com/mitv.html',
  },
  {
    'name': 'Mizzima',
    'image': 'assets/mizzima.jpg',
    'url': 'https://www.mmtvchannels.com/mizzima.html',
  },
  {
    'name': 'MNTV',
    'image': 'assets/mntv.jpg',
    'url': '',
  },
  {
    'name': 'MRTV',
    'image': 'assets/mrtv.jpg',
    'url': 'https://www.mmtvchannels.com/mntv-channel.html',
  },
  {
    'name': 'MRTV-4',
    'image': 'assets/mrtv4.jpg',
    'url': 'https://www.mmtvchannels.com/mrtv4.html',
  },
  {
    'name': 'Channel ME',
    'image': 'assets/mrtvent.jpg',
    'url': 'https://www.mmtvchannels.com/mrtv-entertainment.html',
  },
  {
    'name': 'MWD',
    'image': 'assets/mwd.jpg',
    'url': 'https://www.mmtvchannels.com/mwd.html',
  },
  {
    'name': 'MWD Documentary',
    'image': 'assets/mwddoc.jpg',
    'url': 'https://www.mmtvchannels.com/mwd-documentary.html',
  },
  {
    'name': 'MWD Education',
    'image': 'assets/mwdedu.jpg',
    'url': 'https://www.mmtvchannels.com/mwd-education.html',
  },
  {
    'name': 'NRC',
    'image': 'assets/nrc.jpg',
    'url': 'https://www.mmtvchannels.com/nrc.html',
  },
  {
    'name': 'Reader',
    'image': 'assets/reader.jpg',
    'url': 'https://www.mmtvchannels.com/readers.html',
  },
  {
    'name': 'YTV',
    'image': 'assets/ytv.jpg',
    'url': 'https://www.mmtvchannels.com/ytv.html',
  },
];