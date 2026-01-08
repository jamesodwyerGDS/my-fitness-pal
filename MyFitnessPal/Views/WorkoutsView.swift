import SwiftUI

struct WorkoutsView: View {
    @StateObject private var viewModel = WorkoutViewModel()
    @State private var workoutName = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    if viewModel.activeWorkout == nil {
                        // Start New Workout
                        StartWorkoutCard(
                            workoutName: $workoutName,
                            onStart: {
                                viewModel.startNewWorkout(name: workoutName)
                                workoutName = ""
                            }
                        )

                        // Today's Workouts
                        if !viewModel.todayWorkouts.isEmpty {
                            TodayWorkoutsCard(workouts: viewModel.todayWorkouts)
                        }
                    } else {
                        // Active Workout
                        ActiveWorkoutView(viewModel: viewModel)
                    }
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Workouts")
            .onAppear {
                viewModel.loadTodayWorkouts()
            }
        }
    }
}

struct StartWorkoutCard: View {
    @Binding var workoutName: String
    let onStart: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            TextField("Workout name (optional)", text: $workoutName)
                .textFieldStyle(.roundedBorder)

            Button(action: onStart) {
                Text("Start New Workout")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct TodayWorkoutsCard: View {
    let workouts: [Workout]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Today's Workouts")
                .font(.headline)

            ForEach(workouts) { workout in
                HStack {
                    VStack(alignment: .leading) {
                        Text(workout.name)
                            .fontWeight(.medium)
                        Text("\(workout.exercises.count) exercises")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Text(workout.completed ? "Completed" : "In Progress")
                        .font(.caption)
                        .foregroundColor(workout.completed ? .green : .orange)
                }
                .padding(.vertical, 4)

                if workout.id != workouts.last?.id {
                    Divider()
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct ActiveWorkoutView: View {
    @ObservedObject var viewModel: WorkoutViewModel

    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                Text(viewModel.activeWorkout?.name ?? "Workout")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button("Complete") {
                    viewModel.completeWorkout()
                }
                .foregroundColor(.blue)
            }
            .padding(.horizontal)

            // Exercises
            ForEach(viewModel.activeWorkout?.exercises ?? []) { workoutExercise in
                ExerciseCard(
                    workoutExercise: workoutExercise,
                    onAddSet: { viewModel.addSet(to: workoutExercise.id) },
                    onToggleSet: { set in
                        viewModel.toggleSetComplete(set, in: workoutExercise.id)
                    },
                    onUpdateReps: { set, reps in
                        viewModel.updateSetReps(set, reps: reps, in: workoutExercise.id)
                    },
                    onRemove: { viewModel.removeExercise(workoutExercise.id) }
                )
            }

            // Add Exercise Button
            Button {
                viewModel.showExercisePicker = true
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Exercise")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.1))
                .foregroundColor(.blue)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .foregroundColor(.blue)
                )
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $viewModel.showExercisePicker) {
            ExercisePickerView(viewModel: viewModel)
        }
    }
}

struct ExerciseCard: View {
    let workoutExercise: WorkoutExercise
    let onAddSet: () -> Void
    let onToggleSet: (ExerciseSet) -> Void
    let onUpdateReps: (ExerciseSet, Int) -> Void
    let onRemove: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading) {
                    Text(workoutExercise.exercise.name)
                        .font(.headline)
                    Text(workoutExercise.exercise.category.displayName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Button(action: onRemove) {
                    Text("Remove")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }

            ForEach(Array(workoutExercise.sets.enumerated()), id: \.element.id) { index, set in
                SetRow(
                    setNumber: index + 1,
                    set: set,
                    onToggle: { onToggleSet(set) },
                    onUpdateReps: { reps in onUpdateReps(set, reps) }
                )
            }

            Button(action: onAddSet) {
                Text("+ Add Set")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct SetRow: View {
    let setNumber: Int
    let set: ExerciseSet
    let onToggle: () -> Void
    let onUpdateReps: (Int) -> Void

    @State private var repsText: String = ""

    var body: some View {
        HStack {
            Text("Set \(setNumber)")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(width: 50, alignment: .leading)

            TextField("Reps", text: $repsText)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .onChange(of: repsText) { _, newValue in
                    if let reps = Int(newValue) {
                        onUpdateReps(reps)
                    }
                }
                .onAppear {
                    repsText = set.reps > 0 ? "\(set.reps)" : ""
                }

            Button(action: onToggle) {
                Image(systemName: set.completed ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(set.completed ? .green : .gray)
            }
        }
    }
}

struct ExercisePickerView: View {
    @ObservedObject var viewModel: WorkoutViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Category Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        CategoryChip(
                            title: "All",
                            isSelected: viewModel.selectedCategory == nil,
                            action: { viewModel.selectedCategory = nil }
                        )

                        ForEach(ExerciseCategory.allCases, id: \.self) { category in
                            CategoryChip(
                                title: category.displayName,
                                isSelected: viewModel.selectedCategory == category,
                                action: { viewModel.selectedCategory = category }
                            )
                        }
                    }
                    .padding()
                }
                .background(Color(.systemBackground))

                // Exercise List
                List(viewModel.filteredExercises) { exercise in
                    Button {
                        viewModel.addExercise(exercise)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(exercise.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text(exercise.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(exercise.muscleGroups.map { $0.displayName }.joined(separator: ", "))
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Select Exercise")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}

struct CategoryChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray5))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

#Preview {
    WorkoutsView()
}
