import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {

  const FullScreenLoader({super.key});

  Stream<String> getLoadingMesages() {
    final messages = <String>[
      'Loading movies',
      'Cillum minim laborum occaecat cupidatat.',
      'Id laboris labore pariatur ullamco commodo.',
      'Nisi elit dolor laborum dolor aliqua est.',
      'Irure est et deserunt in ex ad proident.',
      'Duis consectetur consequat nulla esse voluptate.',
      'Ut veniam eiusmod ut magna exercitation mollit.',
    ];

    return Stream.periodic( const Duration(milliseconds: 1200 ), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Text('Please wait...'),
          const SizedBox(height: 10),
          const CircularProgressIndicator( strokeWidth: 2 ),
          const SizedBox(height: 10),

          StreamBuilder(
            stream: getLoadingMesages(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) return const Text('...');
              return Text(snapshot.data!);
            }
          ),
        ],
      )
    );
  }
}