class RecipeDetail {
  final int readyInMinutes;
  final String instructions;
  final List<AnalyzedInstructions> analyzedInstructions;

  RecipeDetail({
    required this.readyInMinutes,
    required this.instructions,
    required this.analyzedInstructions,
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json) {
    return RecipeDetail(
        readyInMinutes: json['readyInMinutes'] ?? '',
        instructions: json['instructions'] ?? '',
        analyzedInstructions: List<AnalyzedInstructions>.from(json['analyzedInstructions'].map((e)=> AnalyzedInstructions.fromJson(e)))
    );
  }
}

class AnalyzedInstructions{
  final List<Steps> steps;

  AnalyzedInstructions({required this.steps});
  factory AnalyzedInstructions.fromJson(Map<String, dynamic>json){
    return AnalyzedInstructions(steps: List<Steps>.from(json['steps'].map((e)=> Steps.fromJson(e)))
    );
  }
}

class Steps{
  final int number;
  final String step;
  final List<Ingredients> ingredients;

  Steps({
    required this.number,
    required this.step,
    required this.ingredients});

  factory Steps.fromJson(Map<String, dynamic>json){
    return Steps(
        number: json['number'],
        step: json['step'],
        ingredients: List<Ingredients>.from(json['ingredients'].map((e)=> Ingredients.fromJson(e)))
    );
  }
}

class Ingredients{
  final int id;
  final String name;
  final String image;

  Ingredients({
   required this.id,
   required this.name,
   required this.image});

  factory Ingredients.fromJson(Map<String, dynamic>json){
    return Ingredients(
        id: json['id'],
        name: json['name'],
        image: json['image']
    );
  }
}





//-------------------------------------------------------------------------------------------------------



//
// class RecipeDetail {
//   final int? readyInMinutes;
//   final String? instructions;
//   final List<AnalyzedInstructions>? analyzedInstructions;
//   final String? spoonacularSourceUrl;
//
//   RecipeDetail({
//     this.readyInMinutes,
//     this.instructions,
//     this.analyzedInstructions,
//     this.spoonacularSourceUrl,
//   });
//
//   RecipeDetail.fromJson(Map<String, dynamic> json)
//       : readyInMinutes = json['readyInMinutes'] as int?,
//         instructions = json['instructions'] as String?,
//         analyzedInstructions = (json['analyzedInstructions'] as List?)?.map((dynamic e) => AnalyzedInstructions.fromJson(e as Map<String,dynamic>)).toList(),
//         spoonacularSourceUrl = json['spoonacularSourceUrl'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'readyInMinutes' : readyInMinutes,
//     'instructions' : instructions,
//     'analyzedInstructions' : analyzedInstructions?.map((e) => e.toJson()).toList(),
//     'spoonacularSourceUrl' : spoonacularSourceUrl
//   };
// }
//
// class AnalyzedInstructions {
//   final String? name;
//   final List<Steps>? steps;
//
//   AnalyzedInstructions({
//     this.name,
//     this.steps,
//   });
//
//   AnalyzedInstructions.fromJson(Map<String, dynamic> json)
//       : name = json['name'] as String?,
//         steps = (json['steps'] as List?)?.map((dynamic e) => Steps.fromJson(e as Map<String,dynamic>)).toList();
//
//   Map<String, dynamic> toJson() => {
//     'name' : name,
//     'steps' : steps?.map((e) => e.toJson()).toList()
//   };
// }
//
// class Steps {
//   final int? number;
//   final String? step;
//   final List<Ingredients>? ingredients;
//   final List<dynamic>? equipment;
//   final Length? length;
//
//   Steps({
//     this.number,
//     this.step,
//     this.ingredients,
//     this.equipment,
//     this.length,
//   });
//
//   Steps.fromJson(Map<String, dynamic> json)
//       : number = json['number'] as int?,
//         step = json['step'] as String?,
//         ingredients = (json['ingredients'] as List?)?.map((dynamic e) => Ingredients.fromJson(e as Map<String,dynamic>)).toList(),
//         equipment = json['equipment'] as List?,
//         length = (json['length'] as Map<String,dynamic>?) != null ? Length.fromJson(json['length'] as Map<String,dynamic>) : null;
//
//   Map<String, dynamic> toJson() => {
//     'number' : number,
//     'step' : step,
//     'ingredients' : ingredients?.map((e) => e.toJson()).toList(),
//     'equipment' : equipment,
//     'length' : length?.toJson()
//   };
// }
//
// class Ingredients {
//   final int? id;
//   final String? name;
//   final String? localizedName;
//   final String? image;
//
//   Ingredients({
//     this.id,
//     this.name,
//     this.localizedName,
//     this.image,
//   });
//
//   Ingredients.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         name = json['name'] as String?,
//         localizedName = json['localizedName'] as String?,
//         image = json['image'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'name' : name,
//     'localizedName' : localizedName,
//     'image' : image
//   };
// }
//
// class Length {
//   final int? number;
//   final String? unit;
//
//   Length({
//     this.number,
//     this.unit,
//   });
//
//   Length.fromJson(Map<String, dynamic> json)
//       : number = json['number'] as int?,
//         unit = json['unit'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'number' : number,
//     'unit' : unit
//   };
// }