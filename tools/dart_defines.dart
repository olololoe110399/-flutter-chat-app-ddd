import 'dart:convert';
import 'dart:io';

void main(List<String> args) {
  ConfigWriter(
    projectPath: './.vscode/launch.json',
    configName: 'flutter_chat_app_ddd',
    dartDefineString: convertEnvToDartDefineString(generateDartDefines()),
  ).call();
}

Iterable<String> generateDartDefines() {
  final fileEnv = File('.env');
  checkFileExists(fileEnv.path);

  return LineSplitter.split(fileEnv.readAsStringSync());
}

void checkFileExists(String file) {
  if (!File(file).existsSync()) {
    exit(-1);
  }
}

void checkDirectoryExists(String file) {
  if (!Directory(file).existsSync()) {
    exit(-1);
  }
}

class ConfigWriter {
  ConfigWriter({
    required this.projectPath,
    required this.dartDefineString,
    required this.configName,
  });

  final String projectPath;
  final String dartDefineString;
  final String? configName;

  void call() {
    final mandatoryFile = File(projectPath);
    checkFileExists(mandatoryFile.path);
    mandatoryFile.writeAsStringSync(writeConfig(mandatoryFile.readAsStringSync()));
  }

  String writeConfig(String fileContent) {
    fileContent = fileContent.replaceAll(RegExp('.+// .+\n'), '');
    final dynamic configJson = jsonDecode(fileContent);
    final configList = configJson['configurations'] as Iterable;
    final dartDefineList = getDartDefineList();

    final configurations = configList.map<dynamic>((dynamic configMap) {
      return configName != null && configMap['name'] == configName
          ? updateConfig(configMap, dartDefineList)
          : configMap;
    }).toList();
    configJson['configurations'] = configurations;

    return prettifyJson(configJson);
  }

  Map<String, dynamic> updateConfig(
    Map<String, dynamic> config,
    Iterable<dynamic> dartDefineList,
  ) {
    config.update(
      'args',
      (dynamic value) => getNonDartDefineArguments(value).followedBy(dartDefineList).toList(),
      ifAbsent: () => dartDefineList.toList(),
    );

    return config;
  }

  String prettifyJson(dynamic json) {
    try {
      final spaces = ' ' * 2;
      final encoder = JsonEncoder.withIndent(spaces);

      return encoder.convert(json);
    } catch (e) {
      return '';
    }
  }

  List<dynamic> getNonDartDefineArguments(List<String> argList) {
    bool previousWasDartDefine = false;

    final List<String> retainedArgs = [];
    argList.forEach((arg) {
      if (arg == '--dart-define') {
        previousWasDartDefine = true;

        return;
      }

      if (!previousWasDartDefine) {
        retainedArgs.add(arg);
      }

      previousWasDartDefine = false;
    });

    return retainedArgs;
  }

  Iterable<String> getDartDefineList() {
    return (dartDefineString.split('--dart-define=')..removeAt(0))
        .expand((element) => ['--dart-define', element.trim()]);
  }
}

String convertEnvToDartDefineString(Iterable<String> envs) {
  final StringBuffer buffer = StringBuffer();
  envs.forEach((value) {
    buffer.write('--dart-define=$value ');
  });
  final string = buffer.toString();

  return string.substring(0, string.length - 1);
}
