import 'package:magambell/core/config/environment.dart';

Future<void> main() async => Environment.newInstance(BuildType.dev).run();
