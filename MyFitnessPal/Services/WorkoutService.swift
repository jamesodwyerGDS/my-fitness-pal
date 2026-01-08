import Foundation

class WorkoutService {
    static let shared = WorkoutService()
    private let storage = StorageService.shared

    private init() {}

    // MARK: - Workouts

    func getAllWorkouts() -> [Workout] {
        storage.load(for: .workouts) ?? []
    }

    func getWorkout(by id: String) -> Workout? {
        getAllWorkouts().first { $0.id == id }
    }

    func getWorkouts(for date: String) -> [Workout] {
        getAllWorkouts().filter { $0.date == date }
    }

    func getWorkouts(from startDate: String, to endDate: String) -> [Workout] {
        getAllWorkouts().filter { $0.date >= startDate && $0.date <= endDate }
    }

    @discardableResult
    func createWorkout(name: String, date: String = Date().dateString, equipmentLevel: EquipmentLevel = .none) -> Workout {
        var workouts = getAllWorkouts()
        let workout = Workout(
            name: name,
            date: date,
            startTime: Date().timeString,
            equipmentLevel: equipmentLevel
        )
        workouts.append(workout)
        storage.save(workouts, for: .workouts)
        return workout
    }

    @discardableResult
    func updateWorkout(_ workout: Workout) -> Workout? {
        var workouts = getAllWorkouts()
        guard let index = workouts.firstIndex(where: { $0.id == workout.id }) else {
            return nil
        }
        workouts[index] = workout
        storage.save(workouts, for: .workouts)
        return workout
    }

    func deleteWorkout(_ id: String) -> Bool {
        var workouts = getAllWorkouts()
        let initialCount = workouts.count
        workouts.removeAll { $0.id == id }
        if workouts.count < initialCount {
            storage.save(workouts, for: .workouts)
            return true
        }
        return false
    }

    // MARK: - Exercises in Workout

    @discardableResult
    func addExercise(to workoutId: String, exercise: Exercise) -> Workout? {
        guard var workout = getWorkout(by: workoutId) else { return nil }

        let workoutExercise = WorkoutExercise(
            exerciseId: exercise.id,
            exercise: exercise
        )
        workout.exercises.append(workoutExercise)
        return updateWorkout(workout)
    }

    @discardableResult
    func removeExercise(from workoutId: String, exerciseId: String) -> Workout? {
        guard var workout = getWorkout(by: workoutId) else { return nil }
        workout.exercises.removeAll { $0.id == exerciseId }
        return updateWorkout(workout)
    }

    // MARK: - Sets

    @discardableResult
    func addSet(to workoutId: String, exerciseId: String) -> Workout? {
        guard var workout = getWorkout(by: workoutId),
              let exerciseIndex = workout.exercises.firstIndex(where: { $0.id == exerciseId }) else {
            return nil
        }

        workout.exercises[exerciseIndex].sets.append(ExerciseSet())
        return updateWorkout(workout)
    }

    @discardableResult
    func updateSet(in workoutId: String, exerciseId: String, set: ExerciseSet) -> Workout? {
        guard var workout = getWorkout(by: workoutId),
              let exerciseIndex = workout.exercises.firstIndex(where: { $0.id == exerciseId }),
              let setIndex = workout.exercises[exerciseIndex].sets.firstIndex(where: { $0.id == set.id }) else {
            return nil
        }

        workout.exercises[exerciseIndex].sets[setIndex] = set
        return updateWorkout(workout)
    }

    @discardableResult
    func removeSet(from workoutId: String, exerciseId: String, setId: String) -> Workout? {
        guard var workout = getWorkout(by: workoutId),
              let exerciseIndex = workout.exercises.firstIndex(where: { $0.id == exerciseId }) else {
            return nil
        }

        workout.exercises[exerciseIndex].sets.removeAll { $0.id == setId }
        return updateWorkout(workout)
    }

    // MARK: - Complete Workout

    @discardableResult
    func completeWorkout(_ id: String) -> Workout? {
        guard var workout = getWorkout(by: id) else { return nil }
        workout.completed = true
        workout.endTime = Date().timeString
        return updateWorkout(workout)
    }

    // MARK: - Stats

    func getWeeklyStats(from weekStart: String) -> WorkoutStats {
        let calendar = Calendar.current
        guard let startDate = dateFromString(weekStart) else {
            return WorkoutStats()
        }
        let endDate = calendar.date(byAdding: .day, value: 7, to: startDate) ?? startDate

        let workouts = getWorkouts(from: weekStart, to: endDate.dateString)
        let completedWorkouts = workouts.filter { $0.completed }

        var exercisesByCategory: [ExerciseCategory: Int] = [:]
        var totalExercises = 0
        var totalSets = 0

        for workout in workouts {
            for exercise in workout.exercises {
                totalExercises += 1
                totalSets += exercise.sets.count
                exercisesByCategory[exercise.exercise.category, default: 0] += 1
            }
        }

        return WorkoutStats(
            totalWorkouts: completedWorkouts.count,
            totalExercises: totalExercises,
            totalSets: totalSets,
            exercisesByCategory: exercisesByCategory
        )
    }

    private func dateFromString(_ string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: string)
    }
}

struct WorkoutStats {
    var totalWorkouts: Int = 0
    var totalExercises: Int = 0
    var totalSets: Int = 0
    var exercisesByCategory: [ExerciseCategory: Int] = [:]
}
