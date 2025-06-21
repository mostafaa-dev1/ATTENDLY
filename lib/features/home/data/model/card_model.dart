import 'package:academe_mobile_new/features/home/data/model/subject_card_model.dart';

class CardModel {
  final List<SubjectCardModel> cards;
  CardModel({required this.cards});

  factory CardModel.fromJson(List<Map<String, dynamic>> json) {
    return CardModel(
      cards: json.map((e) => SubjectCardModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cards': cards,
    };
  }
}
