import Foundation

class NutritionService {
    static let shared = NutritionService()
    private let storage = StorageService.shared

    private init() {}

    // MARK: - Food Items

    func getAllFoodItems() -> [FoodItem] {
        storage.load(for: .foodItems) ?? []
    }

    func getFoodItem(by id: String) -> FoodItem? {
        getAllFoodItems().first { $0.id == id }
    }

    func searchFoodItems(query: String) -> [FoodItem] {
        let lowercaseQuery = query.lowercased()
        return getAllFoodItems().filter {
            $0.name.lowercased().contains(lowercaseQuery) ||
            ($0.brand?.lowercased().contains(lowercaseQuery) ?? false)
        }
    }

    @discardableResult
    func saveFoodItem(_ item: FoodItem) -> FoodItem {
        var items = getAllFoodItems()
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
        } else {
            items.append(item)
        }
        storage.save(items, for: .foodItems)
        return item
    }

    func deleteFoodItem(_ id: String) -> Bool {
        var items = getAllFoodItems()
        let initialCount = items.count
        items.removeAll { $0.id == id }
        if items.count < initialCount {
            storage.save(items, for: .foodItems)
            return true
        }
        return false
    }

    // MARK: - Meal Entries

    func getAllMealEntries() -> [MealEntry] {
        storage.load(for: .meals) ?? []
    }

    func getMealEntries(for date: String) -> [MealEntry] {
        getAllMealEntries().filter { $0.date == date }
    }

    func getMealEntries(for date: String, mealType: MealType) -> [MealEntry] {
        getMealEntries(for: date).filter { $0.mealType == mealType }
    }

    @discardableResult
    func logMeal(_ entry: MealEntry) -> MealEntry {
        var entries = getAllMealEntries()
        entries.append(entry)
        storage.save(entries, for: .meals)

        // Also save the food item for future quick access
        saveFoodItem(entry.foodItem)

        return entry
    }

    @discardableResult
    func updateMealEntry(_ entry: MealEntry) -> MealEntry? {
        var entries = getAllMealEntries()
        guard let index = entries.firstIndex(where: { $0.id == entry.id }) else {
            return nil
        }
        entries[index] = entry
        storage.save(entries, for: .meals)
        return entry
    }

    func deleteMealEntry(_ id: String) -> Bool {
        var entries = getAllMealEntries()
        let initialCount = entries.count
        entries.removeAll { $0.id == id }
        if entries.count < initialCount {
            storage.save(entries, for: .meals)
            return true
        }
        return false
    }

    // MARK: - Daily Nutrition

    func getDailyNutrition(for date: String) -> DailyNutrition {
        let meals = getMealEntries(for: date)
        return DailyNutrition(date: date, meals: meals)
    }

    func getNutrition(from startDate: String, to endDate: String) -> [DailyNutrition] {
        let entries = getAllMealEntries().filter {
            $0.date >= startDate && $0.date <= endDate
        }

        let groupedByDate = Dictionary(grouping: entries) { $0.date }
        return groupedByDate.map { DailyNutrition(date: $0.key, meals: $0.value) }
            .sorted { $0.date < $1.date }
    }

    // MARK: - Quick Log

    @discardableResult
    func quickLog(
        name: String,
        calories: Int,
        protein: Double,
        carbs: Double,
        fat: Double,
        mealType: MealType
    ) -> MealEntry {
        let foodItem = FoodItem(
            name: name,
            calories: calories,
            protein: protein,
            carbs: carbs,
            fat: fat
        )

        let entry = MealEntry(
            foodItem: foodItem,
            mealType: mealType,
            date: Date().dateString,
            time: Date().timeString
        )

        return logMeal(entry)
    }

    // MARK: - Goals

    func getNutritionGoals() -> NutritionGoals {
        storage.load(for: .nutritionGoals) ?? .default
    }

    func saveNutritionGoals(_ goals: NutritionGoals) {
        storage.save(goals, for: .nutritionGoals)
    }

    // MARK: - Weekly Stats

    func getWeeklyAverages(from weekStart: String) -> NutritionAverages {
        let calendar = Calendar.current
        guard let startDate = dateFromString(weekStart) else {
            return NutritionAverages()
        }
        let endDate = calendar.date(byAdding: .day, value: 7, to: startDate) ?? startDate

        let nutritionData = getNutrition(from: weekStart, to: endDate.dateString)

        guard !nutritionData.isEmpty else {
            return NutritionAverages()
        }

        let totalCalories = nutritionData.reduce(0) { $0 + $1.totalCalories }
        let totalProtein = nutritionData.reduce(0) { $0 + $1.totalProtein }
        let totalCarbs = nutritionData.reduce(0) { $0 + $1.totalCarbs }
        let totalFat = nutritionData.reduce(0) { $0 + $1.totalFat }

        let count = Double(nutritionData.count)

        return NutritionAverages(
            avgCalories: Int(Double(totalCalories) / count),
            avgProtein: totalProtein / count,
            avgCarbs: totalCarbs / count,
            avgFat: totalFat / count,
            daysTracked: nutritionData.count
        )
    }

    private func dateFromString(_ string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: string)
    }
}

struct NutritionAverages {
    var avgCalories: Int = 0
    var avgProtein: Double = 0
    var avgCarbs: Double = 0
    var avgFat: Double = 0
    var daysTracked: Int = 0
}
