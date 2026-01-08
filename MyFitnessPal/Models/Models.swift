import Foundation

// MARK: - Exercise Types

enum ExerciseCategory: String, Codable, CaseIterable {
    case push
    case pull
    case legs
    case core
    case cardio
    case flexibility

    var displayName: String {
        rawValue.capitalized
    }
}

enum MuscleGroup: String, Codable, CaseIterable {
    case chest
    case back
    case shoulders
    case biceps
    case triceps
    case forearms
    case abs
    case obliques
    case quads
    case hamstrings
    case glutes
    case calves
    case fullBody = "full_body"

    var displayName: String {
        switch self {
        case .fullBody: return "Full Body"
        default: return rawValue.capitalized
        }
    }
}

struct Exercise: Identifiable, Codable {
    let id: String
    let name: String
    let category: ExerciseCategory
    let muscleGroups: [MuscleGroup]
    let description: String
    let isBodyweight: Bool
}

struct ExerciseSet: Identifiable, Codable {
    let id: String
    var reps: Int
    var weight: Double?
    var duration: Int?
    var completed: Bool

    init(id: String = UUID().uuidString, reps: Int = 0, weight: Double? = nil, duration: Int? = nil, completed: Bool = false) {
        self.id = id
        self.reps = reps
        self.weight = weight
        self.duration = duration
        self.completed = completed
    }
}

struct WorkoutExercise: Identifiable, Codable {
    let id: String
    let exerciseId: String
    let exercise: Exercise
    var sets: [ExerciseSet]
    var notes: String?

    init(id: String = UUID().uuidString, exerciseId: String, exercise: Exercise, sets: [ExerciseSet] = [], notes: String? = nil) {
        self.id = id
        self.exerciseId = exerciseId
        self.exercise = exercise
        self.sets = sets.isEmpty ? [ExerciseSet()] : sets
        self.notes = notes
    }
}

struct Workout: Identifiable, Codable {
    let id: String
    var name: String
    let date: String
    var startTime: String?
    var endTime: String?
    var exercises: [WorkoutExercise]
    var notes: String?
    var completed: Bool

    init(id: String = UUID().uuidString, name: String, date: String, startTime: String? = nil, endTime: String? = nil, exercises: [WorkoutExercise] = [], notes: String? = nil, completed: Bool = false) {
        self.id = id
        self.name = name
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.exercises = exercises
        self.notes = notes
        self.completed = completed
    }
}

// MARK: - Nutrition Types

struct FoodItem: Identifiable, Codable {
    let id: String
    var name: String
    var brand: String?
    var servingSize: Double
    var servingUnit: String
    var calories: Int
    var protein: Double
    var carbs: Double
    var fat: Double
    var fiber: Double?
    var sugar: Double?

    init(id: String = UUID().uuidString, name: String, brand: String? = nil, servingSize: Double = 1, servingUnit: String = "serving", calories: Int, protein: Double, carbs: Double, fat: Double, fiber: Double? = nil, sugar: Double? = nil) {
        self.id = id
        self.name = name
        self.brand = brand
        self.servingSize = servingSize
        self.servingUnit = servingUnit
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
        self.fiber = fiber
        self.sugar = sugar
    }
}

enum MealType: String, Codable, CaseIterable {
    case breakfast
    case lunch
    case dinner
    case snack

    var displayName: String {
        rawValue.capitalized
    }

    var icon: String {
        switch self {
        case .breakfast: return "sun.rise.fill"
        case .lunch: return "sun.max.fill"
        case .dinner: return "moon.fill"
        case .snack: return "carrot.fill"
        }
    }
}

struct MealEntry: Identifiable, Codable {
    let id: String
    let foodItem: FoodItem
    var servings: Double
    let mealType: MealType
    let date: String
    let time: String

    init(id: String = UUID().uuidString, foodItem: FoodItem, servings: Double = 1, mealType: MealType, date: String, time: String) {
        self.id = id
        self.foodItem = foodItem
        self.servings = servings
        self.mealType = mealType
        self.date = date
        self.time = time
    }

    var totalCalories: Int {
        Int(Double(foodItem.calories) * servings)
    }

    var totalProtein: Double {
        foodItem.protein * servings
    }

    var totalCarbs: Double {
        foodItem.carbs * servings
    }

    var totalFat: Double {
        foodItem.fat * servings
    }
}

struct DailyNutrition {
    let date: String
    var meals: [MealEntry]

    var totalCalories: Int {
        meals.reduce(0) { $0 + $1.totalCalories }
    }

    var totalProtein: Double {
        meals.reduce(0) { $0 + $1.totalProtein }
    }

    var totalCarbs: Double {
        meals.reduce(0) { $0 + $1.totalCarbs }
    }

    var totalFat: Double {
        meals.reduce(0) { $0 + $1.totalFat }
    }
}

// MARK: - User Goals

struct NutritionGoals: Codable {
    var dailyCalories: Int
    var dailyProtein: Double
    var dailyCarbs: Double
    var dailyFat: Double

    static let `default` = NutritionGoals(
        dailyCalories: 2000,
        dailyProtein: 150,
        dailyCarbs: 200,
        dailyFat: 65
    )
}

struct FitnessGoals: Codable {
    var workoutsPerWeek: Int
    var focusAreas: [MuscleGroup]

    static let `default` = FitnessGoals(
        workoutsPerWeek: 4,
        focusAreas: [.chest, .back, .legs, .core]
    )
}

// MARK: - Helpers

extension Date {
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }

    var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }

    var readableDate: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return "Today"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE, MMM d"
            return formatter.string(from: self)
        }
    }
}
