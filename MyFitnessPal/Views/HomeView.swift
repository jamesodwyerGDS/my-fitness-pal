import SwiftUI

struct HomeView: View {
    @StateObject private var workoutVM = WorkoutViewModel()
    @StateObject private var nutritionVM = NutritionViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("My Fitness")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text(Date().readableDate)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                    // Nutrition Card
                    NutritionSummaryCard(viewModel: nutritionVM)

                    // Workout Card
                    WorkoutSummaryCard(viewModel: workoutVM)

                    // Quick Actions
                    QuickActionsView(
                        nutritionVM: nutritionVM,
                        workoutVM: workoutVM
                    )
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .onAppear {
                workoutVM.loadTodayWorkouts()
                nutritionVM.loadData()
            }
            .refreshable {
                workoutVM.loadTodayWorkouts()
                nutritionVM.loadData()
            }
        }
    }
}

struct NutritionSummaryCard: View {
    @ObservedObject var viewModel: NutritionViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Nutrition Today")
                .font(.headline)

            HStack(alignment: .firstTextBaseline) {
                Text("\(viewModel.dailyNutrition?.totalCalories ?? 0)")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.blue)
                Text("/ \(viewModel.goals.dailyCalories) kcal")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            ProgressView(value: viewModel.calorieProgress)
                .tint(.blue)

            HStack(spacing: 20) {
                MacroItem(
                    label: "Protein",
                    value: "\(Int(viewModel.dailyNutrition?.totalProtein ?? 0))g",
                    color: .red
                )
                MacroItem(
                    label: "Carbs",
                    value: "\(Int(viewModel.dailyNutrition?.totalCarbs ?? 0))g",
                    color: .blue
                )
                MacroItem(
                    label: "Fat",
                    value: "\(Int(viewModel.dailyNutrition?.totalFat ?? 0))g",
                    color: .orange
                )
            }

            NavigationLink(destination: NutritionView()) {
                Text("Log Food")
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

struct MacroItem: View {
    let label: String
    let value: String
    let color: Color

    var body: some View {
        VStack {
            Text(value)
                .font(.headline)
                .foregroundColor(color)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct WorkoutSummaryCard: View {
    @ObservedObject var viewModel: WorkoutViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Workouts Today")
                .font(.headline)

            if viewModel.todayWorkouts.isEmpty {
                Text("No workouts logged today")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
            } else {
                ForEach(viewModel.todayWorkouts) { workout in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(workout.name)
                                .fontWeight(.medium)
                            Text("\(workout.exercises.count) exercises")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if workout.completed {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }

            NavigationLink(destination: WorkoutsView()) {
                Text("Start Workout")
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

struct QuickActionsView: View {
    @ObservedObject var nutritionVM: NutritionViewModel
    @ObservedObject var workoutVM: WorkoutViewModel

    var body: some View {
        HStack(spacing: 12) {
            Button {
                nutritionVM.showLogSheet = true
            } label: {
                VStack {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.blue)
                    Text("Quick Log")
                        .font(.caption)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            }
            .sheet(isPresented: $nutritionVM.showLogSheet) {
                QuickLogSheet(viewModel: nutritionVM)
            }

            NavigationLink(destination: WorkoutsView()) {
                VStack {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.blue)
                    Text("New Workout")
                        .font(.caption)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            }
        }
        .padding(.horizontal)
    }
}

struct QuickLogSheet: View {
    @ObservedObject var viewModel: NutritionViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("Food Details") {
                    TextField("Food name", text: $viewModel.foodName)
                    TextField("Calories", text: $viewModel.calories)
                        .keyboardType(.numberPad)
                }

                Section("Macros (optional)") {
                    TextField("Protein (g)", text: $viewModel.protein)
                        .keyboardType(.decimalPad)
                    TextField("Carbs (g)", text: $viewModel.carbs)
                        .keyboardType(.decimalPad)
                    TextField("Fat (g)", text: $viewModel.fat)
                        .keyboardType(.decimalPad)
                }

                Section("Meal Type") {
                    Picker("Meal", selection: $viewModel.selectedMealType) {
                        ForEach(MealType.allCases, id: \.self) { type in
                            Text(type.displayName).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Button("Log Food") {
                    viewModel.quickLog()
                }
                .frame(maxWidth: .infinity)
                .disabled(viewModel.foodName.isEmpty || viewModel.calories.isEmpty)
            }
            .navigationTitle("Quick Log")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        viewModel.clearForm()
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
