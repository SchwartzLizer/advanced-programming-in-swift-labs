enum Ingredient: String, CaseIterable {
    case spinach = "Spinach"
    case broccoli = "Broccoli"
    case carrot = "Carrot"
    case pasta = "Pasta"
}

enum RecipeInformation {
    case allergens(information: String)
}

let mainIngredient = Ingredient.pasta
print("Main ingredient: \(mainIngredient.rawValue)")

let recipeInformation = RecipeInformation.allergens(information: "Peanuts")
if case let .allergens(information) = recipeInformation {
    print("Allergens: \(information)")
}
