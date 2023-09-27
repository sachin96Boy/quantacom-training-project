import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// create `Dio` with a `BaseOptions` instance.
final options = BaseOptions(
  baseUrl: dotenv.env['EMPLOY_BACKEND_URI']!,
);
final dioInstance = Dio(options);
