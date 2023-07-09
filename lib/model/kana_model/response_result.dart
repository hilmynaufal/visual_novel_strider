import 'package:visual_novel_strider/model/kana_model/characters_result.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';
import 'package:visual_novel_strider/model/kana_model/result.dart';

class ResponseResult {
  List<dynamic> results;
  bool more;

  ResponseResult({
    required this.results,
    required this.more,
  });

  factory ResponseResult.fromJson(Map<String, dynamic> json) => ResponseResult(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        more: json["more"],
      );

  factory ResponseResult.fromDetailJson(Map<String, dynamic> json) =>
      ResponseResult(
        results: List<DetailResult>.from(
            json["results"].map((x) => DetailResult.fromJson(x))),
        more: json["more"],
      );

  // factory ResponseResult.fromCharactersJson(Map<String, dynamic> json) =>
  //     ResponseResult(
  //       results: List<IndividualResult>.from(
  //           json["results"].map((x) => IndividualResult.fromJson(x))),
  //       more: json["more"],
  //     );

  factory ResponseResult.fromIndividualDetailJson(Map<String, dynamic> json) =>
      ResponseResult(
        results: List<IndividualResult>.from(
            json["results"].map((x) => IndividualResult.fromJson(x))),
        more: json["more"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "more": more,
      };
}
