import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class CurlLogInterceptor extends Interceptor {
  static const _uuid = Uuid();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      // Generate trace ID and add to request headers
      final traceId = _uuid.v4();
      options.extra['trace_id'] = traceId;
      options.headers['X-Trace-ID'] = traceId;

      _logCurlRequest(options, traceId);
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      final traceId = response.requestOptions.extra['trace_id'] as String?;
      if (traceId != null) {
        _logResponse(response, traceId);
      }
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      final traceId = err.requestOptions.extra['trace_id'] as String?;
      if (traceId != null) {
        _logError(err, traceId);
      }
    }
    super.onError(err, handler);
  }

  void _logCurlRequest(RequestOptions options, String traceId) {

    if (kDebugMode) {
      print('┌${'─' * 78}');
      print('│ [TRACE: $traceId] CURL REQUEST');
      print('├${'─' * 78}');
    }

    // print(curlCommand);
    final curlCommand = _buildCurlCommand(options);
    _logWithPagination( curlCommand ,'|');
    if (kDebugMode) {
      print('└${'─' * 78}');
    }
  }

  void _logResponse(Response response, String traceId) {
    final statusInfo = 'Status: ${response.statusCode} ${response.statusMessage}';
    final dataInfo = '\n Data: ${_formatResponseData(response.data)}';
    final responseInfo = '$statusInfo | $dataInfo';

    if (kDebugMode) {
      print('┌${'─' * 78}');
      print('│ [TRACE: $traceId] RESPONSE ($responseInfo)');
      print('├${'─' * 78}');

      print('='*60);
    }

    _logWithPagination( responseInfo, '|');
  }

  String _formatResponseData(dynamic data) {
    if (data == null) return 'null';
    if (data is String) return data;
    if (data is Map || data is List) {
      try {
        const encoder = JsonEncoder.withIndent('  ');
        return encoder.convert(data);
      } catch (e) {
        return 'Error formatting data: $e \nFallback data: ${data.toString()}';
      }
    }
    return data.toString();
  }

  void _logWithPagination(String prefix, String content) {
    // Giới hạn ký tự trên 1 dòng (giảm từ 3000 để dễ đọc hơn)
    const maxChunkLength = 800;
    // Debug: log độ dài để kiểm tra
    if (kDebugMode) {
      print('Content length: ${content.length} \n characters (max: $maxChunkLength)');
    }

    final lines = content.split('\n');
    for(final line in lines) {

      if(line.length <= maxChunkLength) {
        if (kDebugMode) {
          print('$prefix\n');
        }
      } else{
        final totalChunks = (line.length / maxChunkLength).ceil();
        for (int i = 0; i < totalChunks; i++) {
          final start = i * maxChunkLength;
          final end = (start + maxChunkLength < line.length)
              ? start + maxChunkLength
              : line.length;
          if (kDebugMode) {
            print('$prefix${line.substring(start, end)}');
          }
        }
      }
    }
    if (kDebugMode) {
      print('=' * 80);
    }
  }
// .... _logError vaf _build CurlCommand
  void _logError(DioException error, String traceId) {
    if (kDebugMode) {
      print('[TRACE: $traceId] ERROR:');
      print('Type: ${error.type}');
      print('Message: ${error.message}');
    }

    if(error.response != null) {
      if (kDebugMode) {
        print('Response Body:');
        print(_formatResponseData(error.response?.data));
      }

    }
    if (kDebugMode) {
      print('─' * 80);
    }
  }

  String _buildCurlCommand(RequestOptions options) {
    final buffer = StringBuffer();

    // Start with curl command
    buffer.write('curl');

    // Add method
    if (options.method.toUpperCase() != 'GET') {
      buffer.write(' -X ${options.method.toUpperCase()}');
    }

    // Add URL
    buffer.write(' "${options.uri}"');

    // Add headers
    options.headers.forEach((key, value) {
      if (key.toLowerCase() != 'content-length') {
        buffer.write(' -H "$key: $value"');
      }
    });

    // Add body for POST, PUT, PATCH
    if (options.data != null &&
        ['POST', 'PUT', 'PATCH'].contains(options.method.toUpperCase())) {
      String body = '';

      if (options.data is String) {
        body = options.data as String;
      } else if (options.data is Map || options.data is List) {
        try{
          body = jsonEncode(options.data);
        } catch (e) {
          body = options.data.toString();
        }

      } else if (options.data is FormData) {
        // Handle FormData
        final formData = options.data as FormData;
        for (final field in formData.fields) {
          buffer.write(' -F "${field.key}=${field.value}"');
        }
        for (final file in formData.files) {
          buffer.write(' -F "${file.key}=@${file.value.filename}"');
        }
        return buffer.toString();
      }

      if (body.isNotEmpty) {
        // Escape quotes and newlines in body
        body = body.replaceAll('"', '\\"').replaceAll('\n', '\\n');
        buffer.write(' -d "$body"');
      }
    }

    // Add query parameters
    if (options.queryParameters.isNotEmpty) {
      final queryString = options.queryParameters.entries
          .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
          .join('&');
      buffer.write(' -G --data-urlencode "$queryString"');
    }

    return buffer.toString();
  }
}