import SwiftUI

struct NutritionView: View {
    @StateObject private var viewModel = NutritionViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Nutrition")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text(Date().readableDate)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                    // Summary Card
                    NutritionDetailCard(viewModel: viewModel)

                    // Meals by Type
                    ForEach(MealType.allCases, id: \.self) { mealType in
                        MealSectionCard(
                            mealType: mealType,
                            meals: viewModel.getMeals(for: mealType),
                            totalCalories: viewModel.getMealCalories(for: mealType),
                            onAddFood: { viewModel.openLogSheet(for: mealType) },
                            onDelete: { viewModel.deleteMealEntry($0) }
                        )
                    }
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .onAppear {
                viewModel.loadData()
            }
            .refreshable {
                viewModel.loadData()
            }
            .sheet(isPresented: $viewModel.showLogSheet) {
                LogFoodSheet(viewModel: viewModel)
            }
        }
    }
}

struct NutritionDetailCard: View {
    @ObservedObject var viewModel: NutritionViewModel

    var body: some View {
        VStack(spacing: 16) {
            // Calorie Circle
            VStack {
                Text("\(viewModel.dailyNutrition?.totalCalories ?? 0)")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.blue)
                Text("/ \(viewModel.goals.dailyCalories) kcal")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            // Macro Progress Bars
            VStack(spacing: 12) {
                MacroProgressRow(
                    label: "Protein",
                    current: viewModel.dailyNutrition?.totalProtein ?? 0,
                    goal: viewModel.goals.dailyProtein,
                    color: .red
                )
                MacroProgressRow(
                    label: "Carbs",
                    current: viewModel.dailyNutrition?.totalCarbs ?? 0,
                    goal: viewModel.goals.dailyCarbs,
                    color: .blue
                )
                MacroProgressRow(
                    label: "Fat",
                    current: viewModel.dailyNutrition?.totalFat ?? 0,
                    goal: viewModel.goals.dailyFat,
                    color: .orange
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

struct MacroProgressRow: View {
    let label: String
    let current: Double
    let goal: Double
    let color: Color

    var progress: Double {
        min(1.0, current / goal)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            ProgressView(value: progress)
                .tint(color)
            Text("\(Int(current))g / \(Int(goal))g")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct MealSectionCard: View {
    let mealType: MealType
    let meals: [MealEntry]
    let totalCalories: Int
    let onAddFood: () -> Void
    let onDelete: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: mealType.icon)
                    .foregroundColor(.blue)
                Text(mealType.displayName)
                    .font(.headline)
                Spacer()
                Text("\(totalCalories) kcal")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }

            if meals.isEmpty {
                Text("No food logged")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
            } else {
                ForEach(meals) { entry in
                    FoodEntryRow(entry: entry, onDelete: { onDelete(entry.id) })
                }
            }

            Button(action: onAddFood) {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Food")
                }
                .font(.subheadline)
                .foregroundColor(.blue)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 4)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct FoodEntryRow: View {
    let entry: MealEntry
    let onDelete: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(entry.foodItem.name)
                    .font(.subheadline)
                Text("P: \(Int(entry.totalProtein))g  C: \(Int(entry.totalCarbs))g  F: \(Int(entry.totalFat))g")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text("\(entry.totalCalories) kcal")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .contextMenu {
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

struct LogFoodSheet: View {
    @ObservedObject var viewModel: NutritionViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Quick Log Form
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Quick Log")
                            .font(.headline)

                        TextField("Food name", text: $viewModel.foodName)
                            .textFieldStyle(.roundedBorder)

                        TextField("Calories", text: $viewModel.calories)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)

                        HStack(spacing: 8) {
                            TextField("Protein", text: $viewModel.protein)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                            TextField("Carbs", text: $viewModel.carbs)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                            TextField("Fat", text: $viewModel.fat)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                        }

                        Button {
                            viewModel.quickLog()
                        } label: {
                            Text("Log Food")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .disabled(viewModel.foodName.isEmpty || viewModel.calories.isEmpty)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)

                    // Recent Foods
                    if !viewModel.savedFoods.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Recent Foods")
                                .font(.headline)

                            ForEach(viewModel.savedFoods.prefix(10)) { food in
                                Button {
                                    viewModel.logSavedFood(food)
                                } label: {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(food.name)
                                                .font(.subheadline)
                                                .foregroundColor(.primary)
                                            Text("P: \(Int(food.protein))g  C: \(Int(food.carbs))g  F: \(Int(food.fat))g")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        Spacer()
                                        Text("\(food.calories) kcal")
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                    }
                                    .padding(.vertical, 8)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Log \(viewModel.selectedMealType.displayName)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        viewModel.clearForm()
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NutritionView()
}
