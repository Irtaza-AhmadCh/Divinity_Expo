import '../Paths/imports.dart';


class GetstartScreen extends StatefulWidget {
  const GetstartScreen({super.key});

  @override
  State<GetstartScreen> createState() => _GetstartScreenState();
}

class _GetstartScreenState extends State<GetstartScreen> {

  // Video player
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/yoga.MP4')
      ..addListener(() {
    })..setLooping(true)
      ..initialize().then((_) {
        setState(() {

        });
        print(
          'Video initialized successfully');
        _controller.play();}).catchError((error) {
      print('Error initializing video: $error');
    });;
  }

    @override
    Widget build(BuildContext context) {
      final aspectRatio = MediaQuery.of(context).size.aspectRatio;

      final w = MediaQuery
          .sizeOf(context)
          .width * (1 / 360);
      final h = MediaQuery
          .sizeOf(context)
          .height * (1 / 760);

      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: MyColors.bgBlue,
                child: _controller.value.isInitialized
          ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
                : Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  color: Colors.blue,
                ),
      ),
              Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: Color(0xff6F93B3).withOpacity(.45)),

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text('Featured at Divinity\n Expo Events',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: "Lora",
                            color: MyColors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Image.asset('assets/text/text.png', scale: 1,),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          NavigateToReplace(context, LogInScreen());
                        },
                          child: Button('Get Strated', 270*w))
                    ],
                  ),
                ),
              )


            ],
          ),
        ),
      );
    }
  }

