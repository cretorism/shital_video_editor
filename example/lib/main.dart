import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/video_picker_screen.dart';
import 'blocs/video_picker_bloc.dart';

void main() {
  runApp(const ShitalVE());
}

class ShitalVE extends StatelessWidget {
  const ShitalVE({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoPickerBloc(),
      child: MaterialApp(
        title: 'Video Picker Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const VideoPickerScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
