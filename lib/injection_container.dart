import 'package:amazon_clone/injection_container.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

GetIt locator = GetIt.I;

@InjectableInit()
void configureDependencies() => locator.init();
