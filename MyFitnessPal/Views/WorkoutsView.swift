import SwiftUI

struct WorkoutsView: View {
    @StateObject private var viewModel = WorkoutViewModel()
    @State private var workoutName = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    if viewModel.activeWorkout == nil {
                        // Equipment Level Selector
                        EquipmentLevelSelector(selectedLevel: $viewModel.selectedEquipmentLevel)

                        // Start New Workout
                        StartWorkoutCard(
                            workoutName: $workoutName,
                            equipmentLevel: viewModel.selectedEquipmentLevel,
                            exerciseCount: viewModel.availableExerciseCount,
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

struct EquipmentLevelSelector: View {
    @Binding var selectedLevel: EquipmentLevel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Equipment Available")
                .font(.headline)

            ForEach(EquipmentLevel.allCases, id: \.self) { level in
                EquipmentOptionRow(
                    level: level,
                    isSelected: selectedLevel == level,
                    onSelect: { selectedLevel = level }
                )
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct EquipmentOptionRow: View {
    let level: EquipmentLevel
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 12) {
                Image(systemName: level.icon)
                    .font(.title2)
                    .foregroundColor(isSelected ? .white : .blue)
                    .frame(width: 44, height: 44)
                    .background(isSelected ? Color.blue : Color.blue.opacity(0.1))
                    .cornerRadius(10)

                VStack(alignment: .leading, spacing: 2) {
                    Text(level.displayName)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(level.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                }
            }
            .padding(12)
            .background(isSelected ? Color.blue.opacity(0.1) : Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}

struct StartWorkoutCard: View {
    @Binding var workoutName: String
    let equipmentLevel: EquipmentLevel
    let exerciseCount: Int
    let onStart: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: equipmentLevel.icon)
                    .foregroundColor(.blue)
                Text("\(exerciseCount) exercises available")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            TextField("Workout name (optional)", text: $workoutName)
                .textFieldStyle(.roundedBorder)

            Button(action: onStart) {
                Text("Start \(equipmentLevel.displayName) Workout")
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
                    Image(systemName: workout.equipmentLevel.icon)
                        .foregroundColor(.blue)
                        .frame(width: 24)

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
                VStack(alignment: .leading) {
                    Text(viewModel.activeWorkout?.name ?? "Workout")
                        .font(.title2)
                        .fontWeight(.bold)
                    HStack {
                        Image(systemName: viewModel.activeWorkout?.equipmentLevel.icon ?? "figure.stand")
                        Text(viewModel.activeWorkout?.equipmentLevel.displayName ?? "")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
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
                    showWeight: !workoutExercise.exercise.isBodyweight,
                    onAddSet: { viewModel.addSet(to: workoutExercise.id) },
                    onToggleSet: { set in
                        viewModel.toggleSetComplete(set, in: workoutExercise.id)
                    },
                    onUpdateReps: { set, reps in
                        viewModel.updateSetReps(set, reps: reps, in: workoutExercise.id)
                    },
                    onUpdateWeight: { set, weight in
                        viewModel.updateSetWeight(set, weight: weight, in: workoutExercise.id)
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
    let showWeight: Bool
    let onAddSet: () -> Void
    let onToggleSet: (ExerciseSet) -> Void
    let onUpdateReps: (ExerciseSet, Int) -> Void
    let onUpdateWeight: (ExerciseSet, Double) -> Void
    let onRemove: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading) {
                    Text(workoutExercise.exercise.name)
                        .font(.headline)
                    HStack {
                        Text(workoutExercise.exercise.category.displayName)
                        if !workoutExercise.exercise.equipment.isEmpty {
                            Text("•")
                            Text(workoutExercise.exercise.equipment.joined(separator: ", "))
                        }
                    }
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
                    showWeight: showWeight,
                    onToggle: { onToggleSet(set) },
                    onUpdateReps: { reps in onUpdateReps(set, reps) },
                    onUpdateWeight: { weight in onUpdateWeight(set, weight) }
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
    let showWeight: Bool
    let onToggle: () -> Void
    let onUpdateReps: (Int) -> Void
    let onUpdateWeight: (Double) -> Void

    @State private var repsText: String = ""
    @State private var weightText: String = ""

    var body: some View {
        HStack {
            Text("Set \(setNumber)")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(width: 50, alignment: .leading)

            TextField("Reps", text: $repsText)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .frame(width: showWeight ? 70 : nil)
                .onChange(of: repsText) { _, newValue in
                    if let reps = Int(newValue) {
                        onUpdateReps(reps)
                    }
                }
                .onAppear {
                    repsText = set.reps > 0 ? "\(set.reps)" : ""
                }

            if showWeight {
                TextField("Weight", text: $weightText)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: weightText) { _, newValue in
                        if let weight = Double(newValue) {
                            onUpdateWeight(weight)
                        }
                    }
                    .onAppear {
                        if let weight = set.weight, weight > 0 {
                            weightText = String(format: "%.1f", weight)
                        }
                    }

                Text("kg")
                    .font(.caption)
                    .foregroundColor(.secondary)
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
                // Equipment Info
                HStack {
                    Image(systemName: viewModel.activeWorkout?.equipmentLevel.icon ?? "figure.stand")
                    Text(viewModel.activeWorkout?.equipmentLevel.displayName ?? "No Equipment")
                    Text("•")
                    Text("\(viewModel.filteredExercises.count) exercises")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))

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
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(exercise.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)

                                    if exercise.equipmentLevel != .none {
                                        Image(systemName: exercise.equipmentLevel.icon)
                                            .font(.caption)
                                            .foregroundColor(.blue)
                                    }
                                }

                                Text(exercise.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                HStack {
                                    Text(exercise.muscleGroups.map { $0.displayName }.joined(separator: ", "))
                                        .font(.caption)
                                        .foregroundColor(.blue)

                                    if !exercise.equipment.isEmpty {
                                        Text("•")
                                            .foregroundColor(.secondary)
                                        Text(exercise.equipment.joined(separator: ", "))
                                            .font(.caption)
                                            .foregroundColor(.orange)
                                    }
                                }
                            }
                            Spacer()
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
