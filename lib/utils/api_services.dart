// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant/app/models/category_model.dart';
import 'package:restaurant/app/models/sub_category_model.dart';
import 'package:restaurant/constant/constant.dart';

class ApiServices {
  static Map<String, String> headerOpenAI = {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.connectionHeader: 'keep-alive',
    HttpHeaders.contentTypeHeader: 'application/json',
    'Authorization': "Bearer ${Constant.aiSetting!.apiKey}",
  };

  // -------------------------------
  // 1️⃣ Generate basic info
  // -------------------------------
  Future<String> generateBasicInfo(String productName, List<CategoryModel> categoryList, List<SubCategoryModel> subCategoryList) async {
    // Convert categories to JSON
    final categoriesJson = categoryList
        .map((c) => {
              "id": c.id,
              "categoryName": c.categoryName,
              "active": c.active,
              "image": c.image,
            })
        .toList();

    // Convert subcategories to JSON
    final subCategoriesJson = subCategoryList
        .map((s) => {
              "id": s.id,
              "subCategoryName": s.subCategoryName,
              "categoryId": s.categoryId,
            })
        .toList();

    final systemPrompt = '''
You are a helpful assistant that returns ONLY a strict JSON object (no markdown, no extra text).
Generate realistic data with these fields:
{
  "itemName": "string",
  "description": "string",
  "categoryModel": {
    "id": "string",
    "categoryName": "string",
    "active": true,
    "image": "string"
  },
  "subCategoryModel": {
    "id": "string",
    "subCategoryName": "string",
    "categoryId": "string"
  }
}
Rules:
- Choose the most relevant category from the following categories based on the product name "$productName":
${jsonEncode(categoriesJson)}
- Choose the most relevant subcategory from the following list that matches the selected category:
${jsonEncode(subCategoriesJson)}
- The "description" field must be **long, multi-sentence, detailed**, describing features, taste, ingredients, or usage. Minimum 3–7 sentences. 
- Do not include any explanation or extra text.
- All values must be realistic and filled (no empty strings unless unavoidable).
''';

    final userPrompt = 'Generate itemName, description, categoryModel, and subCategoryModel for the product: "$productName".';

    return _callOpenAI(systemPrompt, userPrompt);
  }

  // -------------------------------
  // 2️⃣ Generate price & discount
  // -------------------------------
  Future<String> generatePricing(String productName, String description) async {
    final systemPrompt = '''
You are a helpful assistant that returns ONLY valid JSON with the following fields:
{
  "price": "string",
  "discount": "string"
}

Rules:
1. Price and discount must be numeric strings only (e.g., "200", "0").
2. Do NOT include any currency symbols, percentage signs, text, or extra characters.
3. Do NOT include any explanation, notes, or additional text—ONLY JSON.
4. Ensure the JSON is valid and parseable.
5. Discount can be "0" if there is no discount. 
''';

    final userPrompt = 'Generate realistic price and discount for the product "$productName" (description: "$description"). Return ONLY JSON as described.';

    return _callOpenAI(systemPrompt, userPrompt);
  }

  // -------------------------------
  // 3️⃣ Generate addons list
  // -------------------------------
  Future<String> generateAddons(String productName) async {
    final systemPrompt = '''
Return ONLY a JSON array of addons in this format:
[
  {"inStock": true, "name": "string", "price": "string"}
]
0 to 3 realistic addons related to "$productName". If none, return [].
Ensure "price" is a string that represents a valid number (e.g. "9.99").
''';

    final userPrompt = 'Generate addons for "$productName".';

    return _callOpenAI(systemPrompt, userPrompt);
  }

  // -------------------------------
  // 4️⃣ Generate variation list
  // -------------------------------
  Future<String> generateVariations(String productName) async {
    final systemPrompt = '''
Return ONLY a JSON array of variations in this format:
[
  {
    "inStock": true,
    "name": "string",
    "optionList": [
      {"name": "string", "price": "string"}
    ]
  }
]
0 to 2 realistic variations for "$productName". If none, return [].
Ensure "price" is always a string (e.g. "20" not 20).
''';

    final userPrompt = 'Generate variations for "$productName".';

    return _callOpenAI(systemPrompt, userPrompt);
  }

  // -------------------------------
  // 🔧 Common OpenAI call helper
  // -------------------------------
  Future<String> _callOpenAI(String systemPrompt, String userPrompt) async {
    final body = {
      "model": Constant.aiSetting!.gptModel,
      "messages": [
        {"role": "system", "content": systemPrompt},
        {"role": "user", "content": userPrompt}
      ],
      "max_tokens": int.parse(Constant.aiSetting!.maxToken.toString())
    };

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: headerOpenAI,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final content = decoded['choices']?[0]?['message']?['content'];
      if (content == null) {
        throw Exception('OpenAI response missing content');
      }
      return content.toString().trim();
    } else {
      throw Exception('OpenAI request failed: ${response.statusCode} ${response.body}');
    }
  }
}
