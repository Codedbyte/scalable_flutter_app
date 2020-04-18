import 'package:get_it/get_it.dart';
import 'providers/authenticationprovider.dart';
import 'services/data/abstracts/authenticationservice.dart';
import 'services/data/abstracts/databaseservice.dart';
import 'services/data/remotedata/firebaseauthentication.dart';
import 'services/data/remotedata/firestoredatabase.dart';
import 'services/data/servicemodels/firebaseauthenticationmodel.dart';
import 'services/data/servicemodels/firestoredatabasemodel.dart';
import 'services/navigation/navigationservice.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //register services
  locator.registerLazySingleton<AuthenticationService>(()=>FirebaseAuthentication());
  locator.registerLazySingleton<DatabaseService>(()=>FireStoreDatabase());
  locator.registerLazySingleton<NavigationService>(()=>NavigationService());

  //register service models
  locator.registerLazySingleton<FirebaseAuthenticationModel>(()=>FirebaseAuthenticationModel());
  locator.registerLazySingleton<FireStoreDatabaseModel>(()=>FireStoreDatabaseModel());

  //register providers
  locator.registerLazySingleton<AuthenticationProvider>(()=>AuthenticationProvider());


}