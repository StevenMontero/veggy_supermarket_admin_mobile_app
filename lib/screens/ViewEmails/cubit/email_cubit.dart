import 'package:admin/models/email.dart';
import 'package:admin/services/production/repositories/email_repository.dart';
import 'package:bloc/bloc.dart';

class EmailCubit extends Cubit<List<Email>> {
  EmailCubit() : super([]);
  final _emailRepo = EmailRepository();
  void loadEmail() async {
    final emails = await _emailRepo.getEmails();
    emit(emails);
  }
}
