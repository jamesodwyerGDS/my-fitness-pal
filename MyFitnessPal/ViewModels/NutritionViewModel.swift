import Foundation
import SwiftUI

@MainActor
class NutritionViewModel: ObservableObject {
    @Published var dailyNutrition: DailyNutrition?
    @Published var goals: NutritionGoals = .default
    @Published var savedFoods: [FoodItem] = []
    @Published var showLogSheet = false
    @Published var selectedMealType: MealType = .breakfast

    // Quick log form
    @Published var foodName = ""
    @Published var calories = ""
    @Published var protein = ""
    @Published var carbs = ""
    @Published var fat = ""

    private let nutritionService = NutritionService.shared

    func loadData() {
        dailyNutrition = nutritionService.getDailyNutrition(for: Date().dateString)
        goals = nutritionService.getNutritionGoals()
        savedFoods = nutritionService.getAllFoodItems()
    }

    func getMeals(for mealType: MealType) -> [MealEntry] {
        dailyNutrition?.meals.filter { $0.mealType == mealType } ?? []
    }

    func getMealCalories(for mealType: MealType) -> Int {
        getMeals(for: mealType).reduce(0) { $0 + $1.totalCalories }
    }

    func quickLog() {
        guard !foodName.isEmpty, let caloriesInt = Int(calories) else { return }

        nutritionService.quickLog(
            name: foodName,
            calories: caloriesInt,
            protein: Double(protein) ?? 0,
            carbs: Double(carbs) ?? 0,
            fat: Double(fat) ?? 0,
            mealType: selectedMealType
        )

        clearForm()
        showLogSheet = false
        loadData()
    }

    func logSavedFood(_ food: FoodItem) {
        let entry = MealEntry(
            foodItem: food,
            mealType: selectedMealType,
            date: Date().dateString,
            time: Date().timeString
        )
        nutritionService.logMeal(entry)
        showLogSheet = false
        loadData()
    }

    func deleteMealEntry(_ id: String) {
        nutritionService.deleteMealEntry(id)
        loadData()
    }

    func clearForm() {
        foodName = ""
        calories = ""
        protein = ""
        carbs = ""
        fat = ""
    }

    func openLogSheet(for mealType: MealType) {
        selectedMealType = mealType
        showLogSheet = true
    }

    // MARK: - Progress Calculations

    var calorieProgress: Double {
        guard let nutrition = dailyNutrition else { return 0 }
        return min(1.0, Double(nutrition.totalCalories) / Double(goals.dailyCalories))
    }

    var proteinProgress: Double {
        guard let nutrition = dailyNutrition else { return 0 }
        return min(1.0, nutrition.totalProtein / goals.dailyProtein)
    }

    var carbsProgress: Double {
        guard let nutrition = dailyNutrition else { return 0 }
        return min(1.0, nutrition.totalCarbs / goals.dailyCarbs)
    }

    var fatProgress: Double {
        guard let nutrition = dailyNutrition else { return 0 }
        return min(1.0, nutrition.totalFat / goals.dailyFat)
    }

    var remainingCalories: Int {
        guard let nutrition = dailyNutrition else { return goals.dailyCalories }
        return max(0, goals.dailyCalories - nutrition.totalCalories)
    }
}
