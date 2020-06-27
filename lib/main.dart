import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:noting/utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final List<Side> _mode = const [Side.note, Side.handing];

  @override
  State<StatefulWidget> createState() {
    return new MyAppState(_mode);
  }
}

class MyAppState extends State<MyApp> {
  Handing _handing;
  int side = 0;
  List<Side> _mode;

  // #region SVG
  String get _handingSvg {
    String color = "#" + _theme.accentColor.value.toRadixString(16);
    return '''
    <svg viewBox="0 0 13.208 48.991">
      <g ${_mirrored ? 'transform="scale (-1, 1) translate(-13.208,0)"' : ''}>
        <g transform="translate(-78.317 -83.812)" stroke="#000" stroke-width=".27093">
          <path fill="${_handing[0] ? color : "none"}" d="m81.678 85.331c0 0.77509-0.36292 1.4034-0.8106 1.4034-0.44768 0-0.8106-0.62834-0.8106-1.4034 0-0.33204 0.27264-0.46129 0.4053-0.70161 0.17701-0.32067 0.01234-0.70182 0.4053-0.70182 0.39296 0 0.22893 0.38798 0.4053 0.70182 0.13606 0.2421 0.4053 0.36407 0.4053 0.70161z" stroke-dasharray="0.270933, 0.270933"/>
          <path fill="${_handing[1] ? color : "none"}" d="m81.654 88.211a0.7985 0.7985 0 0 1-0.7985 0.7985 0.7985 0.7985 0 0 1-0.7985-0.7985 0.7985 0.7985 0 0 1 0.7985-0.7985 0.7985 0.7985 0 0 1 0.7985 0.7985z" stroke-dasharray="0.270933, 0.270933"/>
          
          <path fill="${_handing[2] ? color : "none"}" d="m85.351 88.215a0.87109 0.89529 0 0 1-0.87109 0.89529 0.87109 0.89529 0 0 1-0.87109-0.89529 0.87109 0.89529 0 0 1 0.87109-0.89529 0.87109 0.89529 0 0 1 0.87109 0.89529z"/>
          <path fill="${_handing[3] ? color : "none"}" d="m87.335 88.554a0.67752 1.3066 0 0 1-0.67752 1.3066 0.67752 1.3066 0 0 1-0.67752-1.3066 0.67752 1.3066 0 0 1 0.67752-1.3066 0.67752 1.3066 0 0 1 0.67752 1.3066z"/>
          
          <path fill="${_handing[4] ? color : "none"}" d="m86.06 91.457c0 0.84191-0.67747 1.5244-1.5194 1.5244-0.84191 0-1.5194-0.6825-1.5194-1.5244 1e-6 -0.84191 0.67747-1.5244 1.5194-1.5244 0.84191 0 1.5194 0.6825 1.5194 1.5244z"/>
          <path fill="${_handing[5] ? color : "none"}" d="m84.54 94.129c0.83635 0 1.5194 0.29883 1.5194 0.66745s-0.68303 0.66744-1.5194 0.66744-1.5194-0.29882-1.5194-0.66744 0.68303-0.66745 1.5194-0.66745"/>
          <path fill="${_handing[6] ? color : "none"}" d="m86.06 97.882c0 0.84191-0.67747 1.5244-1.5194 1.5244-0.84191 0-1.5194-0.6825-1.5194-1.5244 1e-6 -0.84191 0.67747-1.5244 1.5194-1.5244 0.84191 0 1.5194 0.6825 1.5194 1.5244z"/>
          <path fill="${_handing[7] ? color : "none"}" d="m84.54 100.57c0.83635 0 1.5194 0.29882 1.5194 0.66744 0 0.36863-0.68303 0.66745-1.5194 0.66745s-1.5194-0.29882-1.5194-0.66745c0-0.36862 0.68303-0.66744 1.5194-0.66744"/>
          <path fill="${_handing[8] ? color : "none"}" d="m86.06 104.31c0 0.84192-0.67747 1.5244-1.5194 1.5244-0.84191 0-1.5194-0.6825-1.5194-1.5244 1e-6 -0.8419 0.67747-1.5244 1.5194-1.5244 0.84191 0 1.5194 0.6825 1.5194 1.5244z"/>
          
          <path fill="${_handing[9] ? color : "none"}" d="m83.633 108.1c0-0.59999 1.3958-0.226 1.4034-0.58071 0.01711-0.79183 4.0893-1.1721 4.0893 0.21778 0 1.3899-5.4927 0.96292-5.4927 0.36293z"/>

          <path fill="${_handing[10] ? color : "none"}" d="m82.375 104.87a0.94368 0.53233 0 0 1-0.94368 0.53234 0.94368 0.53233 0 0 1-0.94368-0.53234 0.94368 0.53233 0 0 1 0.94368-0.53233 0.94368 0.53233 0 0 1 0.94368 0.53233z"/>
          <path fill="${_handing[11] ? color : "none"}" d="m82.157 106.49a0.94368 0.53233 0 0 1-0.94368 0.53234 0.94368 0.53233 0 0 1-0.94368-0.53234 0.94368 0.53233 0 0 1 0.94368-0.53234 0.94368 0.53233 0 0 1 0.94368 0.53234"/>
          <path fill="${_handing[12] ? color : "none"}" d="m80.705 108.29a0.70171 0.70171 0 0 1-0.70171 0.70171 0.70171 0.70171 0 0 1-0.70172-0.70171 0.70171 0.70171 0 0 1 0.70172-0.7017 0.70171 0.70171 0 0 1 0.70171 0.7017"/>
          <path fill="${_handing[13] ? color : "none"}" d="m78.453 111.08c0-0.83635 0.29882-1.5194 0.66744-1.5194 0.36863 0 0.66745 0.68303 0.66745 1.5194s-0.29882 1.5194-0.66745 1.5194c-0.36862 0-0.66744-0.68302-0.66744-1.5194"/>
          
          <path fill="${_handing[14] ? color : "none"}" d="m88.714 111.02c-1.0872-1.0872-2.019-0.76404-2.019 0s0.36486 2.7205 2.019 2.7205z"/>
          <path fill="${_handing[15] ? color : "none"}" d="m89.37 111.02c1.0872-1.0872 2.019-0.76404 2.019 0s-0.36486 2.7205-2.019 2.7205z"/>

          <path fill="${_handing[16] ? color : "none"}" d="m88.714 115.07a0.70171 0.70171 0 0 1-0.70171 0.70172 0.70171 0.70171 0 0 1-0.70171-0.70172 0.70171 0.70171 0 0 1 0.70171-0.70171 0.70171 0.70171 0 0 1 0.70171 0.70171z"/>
          <path fill="${_handing[17] ? color : "none"}" d="m90.774 115.07a0.70171 0.70171 0 0 1-0.70172 0.70172 0.70171 0.70171 0 0 1-0.70171-0.70172 0.70171 0.70171 0 0 1 0.70171-0.70171 0.70171 0.70171 0 0 1 0.70172 0.70171"/>
          
          <path fill="${_handing[18] ? color : "none"}" d="m86.06 114.23c0 0.84192-0.67747 1.5244-1.5194 1.5244-0.84191 0-1.5194-0.6825-1.5194-1.5244 1e-6 -0.8419 0.67747-1.5244 1.5194-1.5244 0.84191 0 1.5194 0.68251 1.5194 1.5244z"/>
          <path fill="${_handing[19] ? color : "none"}" d="m86.06 120.65c0 0.84191-0.67747 1.5244-1.5194 1.5244-0.84191 0-1.5194-0.6825-1.5194-1.5244 1e-6 -0.84191 0.67747-1.5244 1.5194-1.5244 0.84191 0 1.5194 0.68251 1.5194 1.5244z"/>
          <path fill="${_handing[20] ? color : "none"}" d="m84.54 123.34c0.83635 0 1.5194 0.29882 1.5194 0.66744 0 0.36863-0.68303 0.66745-1.5194 0.66745s-1.5194-0.29882-1.5194-0.66745c0-0.36862 0.68303-0.66744 1.5194-0.66744"/>
          <path fill="${_handing[21] ? color : "none"}" d="m86.06 127.08c0 0.84192-0.67747 1.5244-1.5194 1.5244-0.84191 0-1.5194-0.68249-1.5194-1.5244 1e-6 -0.8419 0.67747-1.5244 1.5194-1.5244 0.84191 0 1.5194 0.68251 1.5194 1.5244z"/>
          
          <path fill="${_handing[22] ? color : "none"}" d="m79.152 129.99c-1.0872-1.0872-0.76404-2.019 0-2.019s2.7205 0.36486 2.7205 2.019z"/>
          <path fill="${_handing[23] ? color : "none"}" d="m79.152 130.65c-1.0872 1.0872-0.76404 2.019 0 2.019s2.7205-0.36486 2.7205-2.019z"/>
        </g>
      </g>
    </svg>
''';
  }

  String get _noteSvg {
    return '''
    <svg viewBox="0 0 75 200">
      <path stroke-width="1" fill="none" stroke="#999999" stroke-dasharray="none" d="M0 70L74 70"/>
      <path stroke-width="1" fill="none" stroke="#999999" stroke-dasharray="none" d="M0 80L74 80"/>
      <path stroke-width="1" fill="none" stroke="#999999" stroke-dasharray="none" d="M0 90L74 90"/>
      <path stroke-width="1" fill="none" stroke="#999999" stroke-dasharray="none" d="M0 100L74 100"/>
      <path stroke-width="1" fill="none" stroke="#999999" stroke-dasharray="none" d="M0 110L74 110"/>
      <rect stroke-width="0.3" fill="black" stroke="black" stroke-dasharray="none" x="0" y="69.5" width="1" height="41"/>
      <rect stroke-width="0.3" fill="black" stroke="black" stroke-dasharray="none" x="74" y="69.5" width="1" height="41"/>
      <path stroke-width="0.3" fill="black" stroke="none" stroke-dasharray="none" d="M5 101M18.280256 110.199872C19.116608 110.199872,20.079680000000003 110.12384,20.814656 109.971776C21.194816000000003 109.89574400000001,21.270848 109.8704,21.346880000000002 110.301248C21.777728 112.759616,22.335296 115.927616,22.335296 117.651008C22.335296 123.04928000000001,18.685760000000002 123.708224,16.53152 123.708224C14.554688 123.708224,13.61696 123.12531200000001,13.61696 122.643776C13.61696 122.390336,13.946432000000001 122.28896,14.782784000000001 122.010176C15.923264000000001 121.680704,17.215808000000003 120.71763200000001,17.215808000000003 118.588736C17.215808000000003 116.58656,15.948608 114.863168,13.718336 114.863168C11.285312000000001 114.863168,9.81536 116.814656,9.81536 119.070272C9.81536 121.42726400000001,11.234624 125.026112,16.759616 125.026112C19.19264 125.026112,23.931968 123.910976,23.931968 117.72704C23.931968 115.62348800000001,23.273024000000003 112.176704,22.892864000000003 109.89574400000001C22.816832 109.464896,22.842176000000002 109.515584,23.349056 109.287488C27.049280000000003 107.817536,29.482304000000003 104.725568,29.482304000000003 100.594496C29.482304000000003 95.9312,26.060864000000002 91.800128,20.687936 91.800128C19.750208 91.800128,19.750208 91.800128,19.623488000000002 91.141184L18.711104 85.844288C18.660416 85.41344,18.711104 85.388096,18.9392 85.16C22.892864000000003 81.48512,25.883456000000002 76.847168,25.883456000000002 71.246144C25.883456000000002 68.078144,24.996416 64.93548799999999,23.50112 62.755903999999994C22.943552 61.944896,22.005824 60.931135999999995,21.60032 60.931135999999995C21.09344 60.931135999999995,19.95296 61.868863999999995,19.243328 62.679871999999996C16.53152 65.670464,15.644480000000001 70.232384,15.644480000000001 74.033984C15.644480000000001 76.137536,15.923264000000001 78.51987199999999,16.176704 80.015168C16.252736 80.446016,16.278080000000003 80.522048,15.847232 80.902208C10.57568 85.236032,5 90.456896,5 97.832C5 104.168,9.333824 110.199872,18.280256 110.199872M7.91456 100.265024C7.91456 98.110784,8.29472 95.221568,11.310656000000002 91.800128C13.515584 89.367104,15.188288 87.998528,16.886336 86.629952C17.266496 86.325824,17.342528 86.37651199999999,17.41856 86.756672L18.17888 91.445312C18.280256 92.1296,18.280256 92.10425599999999,17.621312000000003 92.307008C14.427968 93.3968,12.324416 96.286016,12.324416 99.403328C12.324416 102.672704,14.047808 105.004352,16.53152 105.866048C16.835648 105.967424,17.266496 106.0688,17.519936 106.0688C17.798720000000003 106.0688,17.950784 105.891392,17.950784 105.663296C17.950784 105.409856,17.672 105.30848,17.41856 105.207104C15.872576 104.54816,14.782784000000001 102.976832,14.782784000000001 101.304128C14.782784000000001 99.200576,16.202048 97.654592,18.43232 97.020992C19.015232 96.868928,19.091264000000002 96.919616,19.167296 97.32512L20.992064 108.19769600000001C21.068096 108.6032,21.017408 108.6032,20.485184000000004 108.704576C19.902272000000004 108.805952,19.167296 108.881984,18.43232 108.881984C12.045632000000001 108.881984,7.91456 105.33382399999999,7.91456 100.265024M22.157888 66.582848C23.349056 66.582848,24.337472 67.571264,24.337472 69.57344C24.337472 73.62848,20.865344 76.9232,18.001472 79.432256C17.748032000000002 79.660352,17.595968 79.609664,17.519936 79.128128C17.367872 78.1904,17.29184 76.948544,17.29184 75.78272C17.29184 70.08032,19.927616 66.582848,22.157888 66.582848M21.09344 96.742208C24.058688 96.995648,26.491712000000003 99.47936,26.491712000000003 102.672704C26.491712000000003 104.979008,25.097792000000002 106.82912,23.070272000000003 107.868224C22.639424 108.070976,22.563392 108.070976,22.487360000000002 107.640128L20.687936 97.249088C20.611904000000003 96.792896,20.662592000000004 96.69152,21.09344 96.742208"/>
      ${_handing.note.value <= 0 ? List.generate((_handing.note.value ~/ -2) + 1, (index) => '<path stroke-width="1" fill="none" stroke="#999999" stroke-dasharray="none" d="M40 ${120 + index * 10}L57.934 ${120 + index * 10}"/>').join('\n') : ''}
      ${_handing.note.value < 0 ? '<path stroke-width="1.5" fill="none" stroke="black" stroke-dasharray="none" d="M54.184 ${118 - 5 * _handing.note.value}L54.184 90"/>' : ''}
      ${_handing.note.value >= 12 ? List.generate((_handing.note.value - 12) ~/ 2 + 1, (index) => '<path stroke-width="1" fill="none" stroke="#999999" stroke-dasharray="none" d="M40 ${120 - (6 + index) * 10}L57.934 ${120 - (6 + index) * 10}"/>').join('\n') : ''}
      ${_handing.note.value > 12 ? '<path stroke-width="1.5" fill="none" stroke="black" stroke-dasharray="none" d="M43.75 ${122 - 5 * _handing.note.value}L43.75 90"/>' : ''}
      <g transform="translate(0,${_handing.note.value * -5})">
          ${_handing.note.value >= 0 && _handing.note.value < 13 ? (_handing.note.value < 6 ? '<path stroke-width="1.5" fill="none" stroke="black" stroke-dasharray="none" d="M54.184 118L54.184 85"/>' : '<path stroke-width="1.5" fill="none" stroke="black" stroke-dasharray="none" d="M43.75 122L43.75 155"/>') : ''}
          ${_handing.note.value < 6 ? '<path stroke-width="0.3" fill="black" stroke="none" stroke-dasharray="none" d="M43 120M43 121.6848C43 123.7908,44.74096 125.0544,46.9312 125.0544C50.52544 125.0544,54.934 121.74096,54.934 118.3152C54.934 116.23728,53.30536 114.9456,51.0028 114.9456C46.566159999999996 114.9456,43 118.23096,43 121.6848"/>' : '<path stroke-width="0.3" fill="black" stroke="none" stroke-dasharray="none" d="M43 120M43 121.6848C43 123.7908,44.74096 125.0544,46.9312 125.0544C50.52544 125.0544,54.934 121.74096,54.934 118.3152C54.934 116.23728,53.30536 114.9456,51.0028 114.9456C46.566159999999996 114.9456,43 118.23096,43 121.6848"/>'}
          ${_handing.sign == Sign.c ? '<path transform="translate(-12,0)" stroke-width="0.3" fill="black" stroke="none" stroke-dasharray="none" d="M44 120M44.32832 118.98768C44.46512 118.98768,45.2312 118.632,45.34064 118.54992C45.368 118.54992,45.42272 118.4952,45.45008 118.4952C45.72368 118.4952,45.96992 118.9056,45.96992 119.20656L45.96992 123.11904C45.96992 123.5568,45.7784 123.91248,45.53216 124.02192C45.31328 124.104,44.46512 124.45968,44.46512 124.45968C44.19152 124.54176,44 124.84272,44 125.08896L44 127.87968C44 128.12592,44.10944 128.23536000000001,44.32832 128.23536000000001C44.35568 128.23536000000001,44.43776 128.208,44.46512 128.208C44.46512 128.208,45.01232 127.96176,45.368 127.85232C45.42272 127.7976,45.45008 127.7976,45.5048 127.7976C45.7784 127.7976,45.96992 128.23536000000001,45.96992 128.42688L45.96992 133.2696C45.96992 133.51584,46.21616 133.70736,46.48976 133.70736C46.8728 133.70736,47.1464 133.51584,47.1464 133.2696L47.1464 127.7976C47.1464 127.27776,47.33792 127.00416,47.5568 126.92208L49.93712 125.93712C49.991839999999996 125.93712,50.07392 125.90976,50.10128 125.90976C50.4296 125.90976,50.62112 126.37488,50.62112 126.62112L50.62112 131.54592C50.62112 131.79216,50.86736 131.98368,51.14096 131.98368C51.55136 131.98368,51.7976 131.79216,51.7976 131.54592L51.7976 125.93712C51.7976 125.63616,51.96176 125.17104,52.23536 125.03424C52.50896 124.9248,53.32976 124.59648,53.32976 124.59648C53.60336 124.48704,53.82224 124.18608,53.82224 123.93984L53.82224 121.14912C53.82224 120.9576,53.68544 120.8208,53.52128 120.8208C53.46656 120.8208,53.41184 120.8208,53.32976 120.87552L52.31744 121.25856C52.0712 121.25856,51.7976 121.01232,51.7976 120.5472L51.7976 116.88096C51.7976 116.60736,51.98912 115.86864,52.31744 115.73184L53.32976 115.3488C53.60336 115.23936,53.82224 114.91104,53.82224 114.69216L53.82224 111.87408C53.82224 111.68256,53.68544 111.57312,53.52128 111.57312C53.46656 111.57312,53.41184 111.57312,53.32976 111.60048C53.32976 111.60048,52.53632 111.9288,52.3448 111.95616C52.0712 111.95616,51.7976 111.76464,51.7976 111.46368L51.7976 106.64832C51.7976 106.40208,51.55136 106.21056,51.2504 106.21056C50.86736 106.21056,50.62112 106.40208,50.62112 106.64832L50.62112 111.76464C50.5664 112.14768,50.45696 112.66752,50.10128 112.91376C49.63616 113.18736,48.295519999999996 113.73456,47.61152 113.89872C47.2832 113.89872,47.1464 113.4336,47.1464 113.10528L47.1464 108.372C47.1464 108.15312,46.8728 107.93424,46.599199999999996 107.93424C46.21616 107.93424,45.96992 108.15312,45.96992 108.372L45.96992 113.7072C45.96992 114.2544,45.72368 114.63744,45.5048 114.74688C45.25856 114.88368,44.46512 115.18464,44.46512 115.18464C44.19152 115.26672,44 115.59504,44 115.81392L44 118.632C44 118.85088,44.10944 118.98768,44.32832 118.98768M47.03696 121.17648C47.03696 119.97264,47.06432 118.57728,47.1464 118.27632C47.22848 117.59232,49.03424 116.77152,50.0192 116.77152C50.2928 116.77152,50.53904 116.8536,50.62112 117.01776C50.7032 117.20928,50.78528 118.19424,50.78528 119.26128C50.78528 120.32832,50.7032 121.42272,50.62112 121.7784C50.37488 122.57184,48.54176 123.33792,47.61152 123.33792C47.39264 123.33792,47.20112 123.2832,47.1464 123.1464C47.06432 122.98224,47.03696 122.13408,47.03696 121.17648"/>' : ''}
          ${_handing.sign == Sign.b ? '<path transform="translate(-12,0)" stroke-width="0.3" fill="black" stroke="none" stroke-dasharray="none" d="M44 120M44.46512 126.7032C44.60192 126.86736,44.71136 126.89472,44.8208 126.89472C44.9576 126.89472,45.06704 126.81264,45.06704 126.81264C46.24352 126.156,47.20112 125.08896,48.18608 124.40496C51.688159999999996 121.96992,52.891999999999996 119.56224,52.891999999999996 117.75648C52.891999999999996 115.51296,51.16832 114.09024,49.36256 113.9808C48.67856 113.9808,47.74832 114.28176,47.20112 114.63744C46.95488 114.82896,46.51712 115.18464,46.3256 115.18464C46.24352 115.18464,46.21616 115.18464,46.13408 115.15728C45.86048 115.04784,45.69632 114.74688,45.69632 114.47328C45.72368 113.62512,45.96992 104.15856,45.96992 103.36512C45.96992 102.92736,45.61424 102.70848000000001,45.2312 102.70848000000001C44.65664 102.70848000000001,44.02736 103.09152,44 103.80288C44 103.80288,44.16416 126.2928,44.46512 126.7032M45.80576 118.00272C46.07936 117.20928,47.66624 116.06016,48.56912 116.06016C49.71824 116.06016,50.18336 117.37344,50.18336 118.3584C50.18336 120.46512,48.3776 122.5992,46.68128 123.66624C46.51712 123.74832,46.40768 123.77568,46.29824 123.77568C45.94256 123.77568,45.86048 123.39264,45.86048 123.20112C45.86048 123.20112,45.72368 120.8208,45.72368 119.26128C45.72368 118.632,45.7784 118.13952,45.80576 118.00272"/>' : ''}
      </g>
  </svg>
  ''';
  }

  // #endregion

  bool _isRecording = true;
  double counter = 0;

  StreamSubscription<NoiseReading> _noiseSubscription;
  NoiseMeter _noiseMeter = new NoiseMeter();

  double _lastVolume = 0;
  double _activeMin = 20;
  final _queue = LimitedQueue<double>(5);

  bool playing = true;
  bool _mirrored = false;
  Handing _last;
  AudioSignal _audioSignal = AudioSignal.start;
  ThemeData _theme = ThemeData(
      primaryColor: Colors.lightGreen.shade500,
      accentColor: Colors.pink.shade600);

  MyAppState(this._mode) {
    _handing = getRandomHanding();
    if (_isRecording) startRecorder();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noting',
      theme: _theme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Noting ${counter.toStringAsFixed(1)}'),
          actions: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.undo),
                    onPressed: side > 0
                        ? () => setState(() => side--)
                        : _last != null
                            ? () => setState(() {
                                  _handing = _last;
                                  _last = null;
                                  side = _mode.length - 1;
                                })
                            : null),
                if (_isRecording)
                  IconButton(
                      icon: Icon(playing ? Icons.pause : Icons.play_arrow),
                      onPressed: () => setState(() => playing = !playing))
              ],
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox.expand(
            child: Card(
              child: InkWell(
                onTap: () {
                  next();
                },
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: _mode[side] == Side.handing
                      ? SvgPicture.string(_handingSvg)
                      : _mode[side] == Side.note
                          ? SvgPicture.string(_noteSvg)
                          : Center(
                              child: Text(
                              _handing.note.name,
                              style: TextStyle(fontSize: 100),
                            )),
                ),
              ),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: null,
                decoration: BoxDecoration(color: _theme.accentColor),
              ),
              PopupMenuButton(
                onSelected: (value) => setState(() {
                  if (value == AudioSignal.none)
                    stopRecorder();
                  else {
                    startRecorder();
                    _audioSignal = value;
                  }
                }),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: AudioSignal.none,
                    child: Text('Disabled',
                        style: !_isRecording
                            ? TextStyle(color: _theme.accentColor)
                            : null),
                  ),
                  PopupMenuItem(
                    value: AudioSignal.start,
                    child: Text(
                      'At Start',
                      style: _audioSignal == AudioSignal.start && _isRecording
                          ? TextStyle(color: _theme.accentColor)
                          : null,
                    ),
                  ),
                  PopupMenuItem(
                    value: AudioSignal.end,
                    child: Text('At End',
                        style: _audioSignal == AudioSignal.end && _isRecording
                            ? TextStyle(color: _theme.accentColor)
                            : null),
                  ),
                  PopupMenuItem(
                    enabled: _mode.length == 2,
                    value: AudioSignal.both,
                    child: Text('Both',
                        style: _audioSignal == AudioSignal.both && _isRecording
                            ? TextStyle(color: _theme.accentColor)
                            : null),
                  ),
                ],
                child: ListTile(
                  title: Text('Next on Sound'),
                  leading: Icon(Icons.audiotrack),
                  trailing: Switch(
                    value: _isRecording,
                    onChanged: (v) {
                      if (v)
                        startRecorder();
                      else
                        stopRecorder();
                    },
                  ),
                  onTap: null,
                ),
              ),
              ListTile(
                title: Text('Mirror Clarinet'),
                leading: Icon(Icons.flip),
                trailing: Switch(value: _mirrored, onChanged: (v) {}),
                onTap: () => setState(() => _mirrored = !_mirrored),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void next({manual = true}) {
    if (manual || playing)
      setState(() {
        side = 1 - side;
        if (side == 0) {
          _last = _handing;
          _handing = getRandomHanding();
        }
      });
  }

  void startRecorder() async {
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen((data) {
        setState(() => counter = data.maxDecibel - _lastVolume);
        if (_lastVolume + _activeMin < data.maxDecibel &&
            (_audioSignal == AudioSignal.start ||
                _audioSignal == AudioSignal.both)) next(manual: false);
        if (_lastVolume - _activeMin > data.maxDecibel &&
            (_audioSignal == AudioSignal.end ||
                _audioSignal == AudioSignal.both)) next(manual: false);
        _lastVolume = data.maxDecibel;

        _queue.push(data.meanDecibel);
        if (_queue.full) {
          
        }
      });
      this.setState(() {
        this._isRecording = true;
      });
    } catch (exception) {
      print(exception);
    }
  }

  void stopRecorder() async {
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription.cancel();
        _noiseSubscription = null;
      }
      this.setState(() {
        this._isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }
}

// #region Data

enum AudioSignal { none, start, end, both }

enum Side { note, handing, name }

enum Note {
  e,
  f,
  g,
  a,
  b,
  c1,
  d1,
  e1,
  f1,
  g1,
  a1,
  b1,
  c2,
  d2,
  e2,
  f2,
  g2,
  a2,
  b2,
  c3,
}

extension NoteExt on Note {
  get name {
    switch (this) {
      case Note.e:
        return "e";
      case Note.f:
        return "f";
      case Note.g:
        return "g";
      case Note.a:
        return "a";
      case Note.b:
        return "b";
      case Note.c1:
        return "c'";
      case Note.d1:
        return "d'";
      case Note.e1:
        return "e'";
      case Note.f1:
        return "f'";
      case Note.g1:
        return "g'";
      case Note.a1:
        return "g'";
      case Note.b1:
        return "g'";
      case Note.c2:
        return "c''";
      case Note.d2:
        return "d''";
      case Note.e2:
        return "e''";
      case Note.f2:
        return "f''";
      case Note.g2:
        return "g''";
      case Note.a2:
        return "g''";
      case Note.b2:
        return "g''";
      case Note.c3:
        return "c'''";
      default:
        return "Note has no name.";
    }
  }

  get value {
    switch (this) {
      case Note.e:
        return -5;
      case Note.f:
        return -4;
      case Note.g:
        return -3;
      case Note.a:
        return -2;
      case Note.b:
        return -1;
      case Note.c1:
        return 0;
      case Note.d1:
        return 1;
      case Note.e1:
        return 2;
      case Note.f1:
        return 3;
      case Note.g1:
        return 4;
      case Note.a1:
        return 5;
      case Note.b1:
        return 6;
      case Note.c2:
        return 7;
      case Note.d2:
        return 8;
      case Note.e2:
        return 9;
      case Note.f2:
        return 10;
      case Note.g2:
        return 11;
      case Note.a2:
        return 12;
      case Note.b2:
        return 13;
      case Note.c3:
        return 14;
      default:
        return 0;
    }
  }
}

class Handing {
  final Note note;
  final List<int> _handing;
  final Sign sign;
  bool operator [](int i) => _handing.contains(i);

  const Handing(this.note, this._handing, {this.sign: Sign._});
}

enum Sign { _, b, c }

getRandomHanding() {
  const List<Handing> handings = [
    Handing(Note.e, [2, 4, 6, 8, 18, 19, 21, 23, 14]),
    Handing(Note.e, [2, 4, 6, 8, 18, 19, 21, 23], sign: Sign.c),
    Handing(Note.f, [2, 4, 6, 8, 18, 19, 21, 23]),
    Handing(Note.f, [2, 4, 6, 8, 18, 19, 21, 23, 14], sign: Sign.b),
    Handing(Note.f, [2, 4, 6, 8, 18, 19, 21, 23, 15], sign: Sign.c),
    Handing(Note.g, [2, 4, 6, 8, 18, 19, 21]),
    Handing(Note.g, [2, 4, 6, 8, 18, 19, 21, 23, 15], sign: Sign.b),
    Handing(Note.g, [2, 4, 6, 8, 18, 19, 21, 22], sign: Sign.c),
    Handing(Note.a, [2, 4, 6, 8, 18, 19]),
    Handing(Note.a, [2, 4, 6, 8, 18, 19, 21, 22], sign: Sign.b),
    Handing(Note.a, [2, 4, 6, 8, 18, 19, 20], sign: Sign.c),
    Handing(Note.b, [2, 4, 6, 8, 18]),
    Handing(Note.b, [2, 4, 6, 8, 18, 19, 20], sign: Sign.b),
    Handing(Note.b, [2, 4, 6, 8], sign: Sign.c),
    Handing(Note.c1, [2, 4, 6, 8]),
    Handing(Note.c1, [2, 4, 6, 8, 18], sign: Sign.b),
    Handing(Note.c1, [2, 4, 6, 8, 9], sign: Sign.c),
    Handing(Note.d1, [2, 4, 6]),
    Handing(Note.d1, [2, 4, 6, 8, 9], sign: Sign.b),
    Handing(Note.d1, [2, 4, 6, 7], sign: Sign.c),
    Handing(Note.e1, [2, 4]),
    Handing(Note.e1, [2, 4, 6, 7], sign: Sign.b),
    Handing(Note.e1, [2, 4, 5], sign: Sign.c),
    Handing(Note.f1, [2, 4, 5]),
    Handing(Note.f1, [2, 4], sign: Sign.b),
    Handing(Note.f1, [2], sign: Sign.c),
    Handing(Note.g1, []),
    Handing(Note.g1, [2], sign: Sign.b),
    Handing(Note.g1, [3], sign: Sign.c),
    Handing(Note.a1, [2]),
    Handing(Note.a1, [3], sign: Sign.b),
    Handing(Note.a1, [2, 0], sign: Sign.c),
    Handing(Note.b1, [0, 1, 4, 6, 8, 14, 18, 19, 21, 23]),
    Handing(Note.b1, [2, 0], sign: Sign.b),
    Handing(Note.b1, [0, 1, 4, 6, 8, 18, 19, 21, 23], sign: Sign.c),
    Handing(Note.c2, [0, 1, 4, 6, 8, 18, 19, 21, 23]),
    Handing(Note.c2, [0, 1, 4, 6, 8, 18, 19, 21, 23, 14], sign: Sign.b),
    Handing(Note.c2, [0, 1, 4, 6, 8, 18, 19, 21, 23, 15], sign: Sign.c),
    Handing(Note.d2, [0, 1, 4, 6, 8, 18, 19, 21]),
    Handing(Note.d2, [0, 1, 4, 6, 8, 18, 19, 21, 23, 15], sign: Sign.b),
    Handing(Note.d2, [0, 1, 4, 6, 8, 18, 19, 21, 22], sign: Sign.c),
    Handing(Note.e2, [0, 1, 4, 6, 8, 18, 19]),
    Handing(Note.e2, [0, 1, 4, 6, 8, 18, 19, 21, 22], sign: Sign.b),
    Handing(Note.e2, [0, 1, 4, 6, 8, 18, 19, 20], sign: Sign.c),
    Handing(Note.f2, [0, 1, 4, 6, 8, 18, 19, 20]),
    Handing(Note.f2, [0, 1, 4, 6, 8, 18, 19], sign: Sign.b),
    Handing(Note.f2, [0, 1, 4, 6, 8, 18], sign: Sign.c),
    Handing(Note.g2, [0, 1, 4, 6, 8]),
    Handing(Note.g2, [0, 1, 4, 6, 8, 18], sign: Sign.b),
    Handing(Note.g2, [0, 1, 4, 6, 8, 9], sign: Sign.c),
    Handing(Note.a2, [0, 1, 4, 6]),
    Handing(Note.a2, [0, 1, 4, 6, 8, 9], sign: Sign.b),
    Handing(Note.a2, [0, 1, 4, 6, 7], sign: Sign.c),
    Handing(Note.b2, [0, 1, 4]),
    Handing(Note.b2, [0, 1, 4, 6, 7], sign: Sign.b),
    Handing(Note.b2, [0, 1, 6], sign: Sign.c),
    Handing(Note.c3, [0, 1, 6]),
    Handing(Note.c3, [0, 1, 4], sign: Sign.b),
  ];
  final Random random = Random();

  return handings[random.nextInt(handings.length)];
}

// #endregion
