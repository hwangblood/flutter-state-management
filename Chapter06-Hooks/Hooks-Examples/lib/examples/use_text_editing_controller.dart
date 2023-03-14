import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseTextEditingControllerPage extends HookWidget {
  const UseTextEditingControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final text = useState('');

    void listener() {
      text.value = controller.text.trim();
    }

    // we don't want call this when app hot-reload
    useEffect(() {
      controller.addListener(listener);
      return () {
        controller.removeListener(listener);
      };
    }, [controller]);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('useTextEditingController Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
            ),
            const SizedBox(height: 10),
            Text('You typed ${text.value}'),
          ],
        ),
      ),
    );
  }
}
