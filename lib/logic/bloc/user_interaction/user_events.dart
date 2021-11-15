import 'package:card_holder_app_with_kistik_love/data/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserEvents {
  final User user;
  const UserEvents(this.user);
}

class UserChangeAvaEvent implements UserEvents {
  @override
  final User user;
  final XFile pickedImage;
  const UserChangeAvaEvent({ required this.user, required this.pickedImage});
}
