import '../../domain/domain.dart';

class AppExceptionWrapper {
  AppExceptionWrapper({
    required this.appError,
    this.doOnRetry,
  });

  final AppError appError;

  final Future<void> Function()? doOnRetry;
}
