import 'package:chewie/chewie.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../data/database/DAO/file_download_dao.dart';
import '../data/models/file_download/file_download.dart';
import '../di/di_setup.dart';
import 'loader_widget/loading_logo_widget.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String url;
  final String name;
  final bool isMedia;
  const VideoPlayerWidget(
      {Key? key, required this.url, required this.name, required this.isMedia})
      : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;
  int? bufferDelay;
  final FileDownloadDAO fileDownloadDAO = FileDownloadDAO.instance;
  bool downloading = false;
  bool downloaded = false;
  String? localPath;

  @override
  void initState() {
    super.initState();
    initializePlayer();
    getIt.get<EventBus>().on<FileDownload>().listen((event) async {
      if (event.urlDownload == widget.url) {
        await fileDownloadDAO.insert(event);
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(widget.url);
    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: false,
      showOptions: true,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () {
              download(
                fileName: widget.name,
              );
              Navigator.pop(context);
            },
            iconData: Icons.download,
            title: 'download'.tr,
          ),
        ];
      },
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,

      hideControlsTimer: const Duration(seconds: 1),

      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorUtils.lightPrimary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(
                controller: _chewieController!,
              )
            : Container(height: 44.w, width: 44.w, child: LoadingLogoWidget()),
      ),
    );
  }

  Future<void> download({String? fileName}) async {
    if ((widget.url ?? "").isEmpty || (widget.name ?? "").isEmpty) return;
    setState(() {
      downloading = true;
    });
    final _file = await downloadFile(
      widget.url,
      fileName: fileName,
      onByteReceived: (x, y) {
        // print("$x --- $y");
      },
    );
    if (_file == null) {
      setState(() {
        downloading = false;
      });
      return;
    } else {
      localPath = _file.path;
      if (widget.isMedia && _file.existsSync()) {
        // final success = await GallerySaver.saveImage(_file.path);
        // if (success ?? false) {
        SmartDialog.showToast("downloaded".tr);
        setState(() {
          downloading = false;
          downloaded = true;
        });
        // }
      } else {
        SmartDialog.showToast("download_successfully".tr);
        setState(() {
          downloading = false;
          downloaded = true;
        });
      }
    }
  }
}

class DelaySlider extends StatefulWidget {
  const DelaySlider({Key? key, required this.delay, required this.onSave})
      : super(key: key);

  final int? delay;
  final void Function(int?) onSave;

  @override
  State<DelaySlider> createState() => _DelaySliderState();
}

class _DelaySliderState extends State<DelaySlider> {
  int? delay;
  bool saved = false;

  @override
  void initState() {
    super.initState();
    delay = widget.delay;
  }

  @override
  Widget build(BuildContext context) {
    const int max = 1000;
    return ListTile(
      title: Text(
        "Progress indicator delay ${delay != null ? "${delay.toString()} MS" : ""}",
      ),
      subtitle: Slider(
        value: delay != null ? (delay! / max) : 0,
        onChanged: (value) async {
          delay = (value * max).toInt();
          setState(() {
            saved = false;
          });
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.save),
        onPressed: saved
            ? null
            : () {
                widget.onSave(delay);
                setState(() {
                  saved = true;
                });
              },
      ),
    );
  }
}
