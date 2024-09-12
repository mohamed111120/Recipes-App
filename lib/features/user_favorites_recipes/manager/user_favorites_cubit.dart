import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'user_favorites_state.dart';

class UserFavoritesCubit extends Cubit<UserFavoritesState> {
  UserFavoritesCubit() : super(UserFavoritesInitial());
  static UserFavoritesCubit get(context) => BlocProvider.of(context);

}
