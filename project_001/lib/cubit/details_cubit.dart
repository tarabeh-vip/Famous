import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/api_service.dart';


class DetailsCubit extends Cubit<Map<String, dynamic>> {
  final ApiService apiService;

  DetailsCubit(this.apiService) : super({});

  Future<void> fetchPersonDetails(String id) async {
    try {
      final details = await apiService.fetchPersonDetails(id);
      emit(details);
    } catch (e) {
      emit({});
    }
  }
}
