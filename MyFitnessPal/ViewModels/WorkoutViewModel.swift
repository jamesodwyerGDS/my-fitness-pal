import Foundation
import SwiftUI

@MainActor
class WorkoutViewModel: ObservableObject {
    @Published var todayWorkouts: [Workout] = []
    @Published var activeWorkout: Workout?
    @Published var selectedCategory: ExerciseCategory?
    @Published var selectedEquipmentLevel: EquipmentLevel = .none
    @Published var showExercisePicker = false
    @Published var showEquipmentSelector = false

    private let workoutService = WorkoutService.shared

    var filteredExercises: [Exercise] {
        let equipmentLevel = activeWorkout?.equipmentLevel ?? selectedEquipmentLevel
        if let category = selectedCategory {
            return ExerciseData.exercises(for: category, equipmentLevel: equipmentLevel)
        }
        return ExerciseData.exercises(for: equipmentLevel)
    }

    var availableExerciseCount: Int {
        ExerciseData.exerciseCount(for: selectedEquipmentLevel)
    }

    func loadTodayWorkouts() {
        todayWorkouts = workoutService.getWorkouts(for: Date().dateString)

        // Resume incomplete workout if exists
        if activeWorkout == nil {
            activeWorkout = todayWorkouts.first { !$0.completed }
        }
    }

    func startNewWorkout(name: String) {
        let workoutName: String
        switch selectedEquipmentLevel {
        case .none:
            workoutName = name.isEmpty ? "Bodyweight Workout" : name
        case .minimal:
            workoutName = name.isEmpty ? "Home Workout" : name
        case .full:
            workoutName = name.isEmpty ? "Gym Workout" : name
        }
        activeWorkout = workoutService.createWorkout(name: workoutName, equipmentLevel: selectedEquipmentLevel)
        loadTodayWorkouts()
    }

    func addExercise(_ exercise: Exercise) {
        guard let workout = activeWorkout else { return }
        activeWorkout = workoutService.addExercise(to: workout.id, exercise: exercise)
        showExercisePicker = false
    }

    func removeExercise(_ exerciseId: String) {
        guard let workout = activeWorkout else { return }
        activeWorkout = workoutService.removeExercise(from: workout.id, exerciseId: exerciseId)
    }

    func addSet(to exerciseId: String) {
        guard let workout = activeWorkout else { return }
        activeWorkout = workoutService.addSet(to: workout.id, exerciseId: exerciseId)
    }

    func updateSet(_ set: ExerciseSet, in exerciseId: String) {
        guard let workout = activeWorkout else { return }
        activeWorkout = workoutService.updateSet(in: workout.id, exerciseId: exerciseId, set: set)
    }

    func toggleSetComplete(_ set: ExerciseSet, in exerciseId: String) {
        var updatedSet = set
        updatedSet.completed.toggle()
        updateSet(updatedSet, in: exerciseId)
    }

    func updateSetReps(_ set: ExerciseSet, reps: Int, in exerciseId: String) {
        var updatedSet = set
        updatedSet.reps = reps
        updateSet(updatedSet, in: exerciseId)
    }

    func updateSetWeight(_ set: ExerciseSet, weight: Double, in exerciseId: String) {
        var updatedSet = set
        updatedSet.weight = weight
        updateSet(updatedSet, in: exerciseId)
    }

    func completeWorkout() {
        guard let workout = activeWorkout else { return }
        workoutService.completeWorkout(workout.id)
        activeWorkout = nil
        loadTodayWorkouts()
    }

    func cancelWorkout() {
        activeWorkout = nil
    }
}
