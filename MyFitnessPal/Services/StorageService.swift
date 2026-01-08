import Foundation

enum StorageKey: String {
    case workouts = "fitness_workouts"
    case meals = "fitness_meals"
    case foodItems = "fitness_food_items"
    case userProfile = "fitness_user_profile"
    case nutritionGoals = "fitness_nutrition_goals"
}

class StorageService {
    static let shared = StorageService()
    private let defaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private init() {}

    func save<T: Encodable>(_ value: T, for key: StorageKey) {
        do {
            let data = try encoder.encode(value)
            defaults.set(data, forKey: key.rawValue)
        } catch {
            print("Storage save error: \(error)")
        }
    }

    func load<T: Decodable>(for key: StorageKey) -> T? {
        guard let data = defaults.data(forKey: key.rawValue) else {
            return nil
        }
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Storage load error: \(error)")
            return nil
        }
    }

    func remove(for key: StorageKey) {
        defaults.removeObject(forKey: key.rawValue)
    }

    func clear() {
        StorageKey.allCases.forEach { key in
            defaults.removeObject(forKey: key.rawValue)
        }
    }
}

extension StorageKey: CaseIterable {}
