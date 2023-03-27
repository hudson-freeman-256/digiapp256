// To parse this JSON data, do
//
//     final faqs = faqsFromJson(jsonString);

import 'dart:convert';

Faqs faqsFromJson(String str) => Faqs.fromJson(json.decode(str));

String faqsToJson(Faqs data) => json.encode(data.toJson());

class Faqs {
  Faqs({
    required this.id,
    required this.question,
    required this.answer,
    required this.faqCategoryId,
    required this.faqCategory,
  });

  int id;
  String question;
  String answer;
  int faqCategoryId;
  FaqCategory faqCategory;

  factory Faqs.fromJson(Map<String, dynamic> json) => Faqs(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
    faqCategoryId: json["faq_category_id"],
    faqCategory: FaqCategory.fromJson(json["faq_category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
    "faq_category_id": faqCategoryId,
    "faq_category": faqCategory.toJson(),
  };
}

class FaqCategory {
  FaqCategory({
    required this.id,
    required this.name,
    required this.image,
  });

  int id;
  String name;
  String image;

  factory FaqCategory.fromJson(Map<String, dynamic> json) => FaqCategory(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
