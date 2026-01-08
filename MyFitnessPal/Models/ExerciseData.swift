import Foundation

struct ExerciseData {
    static let calisthenicsExercises: [Exercise] = [
        // Push Exercises
        Exercise(
            id: "push-ups",
            name: "Push-Ups",
            category: .push,
            muscleGroups: [.chest, .triceps, .shoulders],
            description: "Classic bodyweight push exercise. Keep core tight and body straight.",
            isBodyweight: true
        ),
        Exercise(
            id: "diamond-push-ups",
            name: "Diamond Push-Ups",
            category: .push,
            muscleGroups: [.triceps, .chest],
            description: "Hands close together forming a diamond shape. Targets triceps.",
            isBodyweight: true
        ),
        Exercise(
            id: "wide-push-ups",
            name: "Wide Push-Ups",
            category: .push,
            muscleGroups: [.chest, .shoulders],
            description: "Hands wider than shoulder width. Greater chest emphasis.",
            isBodyweight: true
        ),
        Exercise(
            id: "pike-push-ups",
            name: "Pike Push-Ups",
            category: .push,
            muscleGroups: [.shoulders, .triceps],
            description: "Hips high, body in inverted V. Targets shoulders.",
            isBodyweight: true
        ),
        Exercise(
            id: "decline-push-ups",
            name: "Decline Push-Ups",
            category: .push,
            muscleGroups: [.chest, .shoulders, .triceps],
            description: "Feet elevated on a surface. Increases difficulty.",
            isBodyweight: true
        ),
        Exercise(
            id: "dips",
            name: "Dips (Chair/Bench)",
            category: .push,
            muscleGroups: [.triceps, .chest, .shoulders],
            description: "Using a chair or bench. Keep elbows close to body.",
            isBodyweight: true
        ),

        // Pull Exercises
        Exercise(
            id: "pull-ups",
            name: "Pull-Ups",
            category: .pull,
            muscleGroups: [.back, .biceps, .forearms],
            description: "Overhand grip, pull chin above bar. King of back exercises.",
            isBodyweight: true
        ),
        Exercise(
            id: "chin-ups",
            name: "Chin-Ups",
            category: .pull,
            muscleGroups: [.biceps, .back],
            description: "Underhand grip. More bicep emphasis than pull-ups.",
            isBodyweight: true
        ),
        Exercise(
            id: "inverted-rows",
            name: "Inverted Rows",
            category: .pull,
            muscleGroups: [.back, .biceps],
            description: "Using a low bar or table edge. Great pull-up progression.",
            isBodyweight: true
        ),
        Exercise(
            id: "superman",
            name: "Superman Hold",
            category: .pull,
            muscleGroups: [.back, .glutes],
            description: "Lie face down, lift arms and legs. Strengthens lower back.",
            isBodyweight: true
        ),

        // Leg Exercises
        Exercise(
            id: "squats",
            name: "Bodyweight Squats",
            category: .legs,
            muscleGroups: [.quads, .glutes, .hamstrings],
            description: "Feet shoulder width, squat down until thighs parallel.",
            isBodyweight: true
        ),
        Exercise(
            id: "lunges",
            name: "Lunges",
            category: .legs,
            muscleGroups: [.quads, .glutes, .hamstrings],
            description: "Step forward, lower back knee toward ground.",
            isBodyweight: true
        ),
        Exercise(
            id: "jump-squats",
            name: "Jump Squats",
            category: .legs,
            muscleGroups: [.quads, .glutes, .calves],
            description: "Explosive squat with jump at the top.",
            isBodyweight: true
        ),
        Exercise(
            id: "pistol-squats",
            name: "Pistol Squats",
            category: .legs,
            muscleGroups: [.quads, .glutes, .hamstrings],
            description: "Single leg squat. Advanced exercise requiring balance.",
            isBodyweight: true
        ),
        Exercise(
            id: "wall-sit",
            name: "Wall Sit",
            category: .legs,
            muscleGroups: [.quads],
            description: "Hold squat position against a wall. Isometric hold.",
            isBodyweight: true
        ),
        Exercise(
            id: "calf-raises",
            name: "Calf Raises",
            category: .legs,
            muscleGroups: [.calves],
            description: "Rise up on toes, lower slowly. Use step for full range.",
            isBodyweight: true
        ),
        Exercise(
            id: "glute-bridges",
            name: "Glute Bridges",
            category: .legs,
            muscleGroups: [.glutes, .hamstrings],
            description: "Lie on back, feet flat, lift hips. Squeeze glutes at top.",
            isBodyweight: true
        ),
        Exercise(
            id: "step-ups",
            name: "Step-Ups",
            category: .legs,
            muscleGroups: [.quads, .glutes],
            description: "Step onto elevated surface. Alternate legs.",
            isBodyweight: true
        ),

        // Core Exercises
        Exercise(
            id: "plank",
            name: "Plank",
            category: .core,
            muscleGroups: [.abs, .obliques],
            description: "Hold push-up position on forearms. Keep body straight.",
            isBodyweight: true
        ),
        Exercise(
            id: "side-plank",
            name: "Side Plank",
            category: .core,
            muscleGroups: [.obliques, .abs],
            description: "Balance on one forearm, body sideways. Hold position.",
            isBodyweight: true
        ),
        Exercise(
            id: "crunches",
            name: "Crunches",
            category: .core,
            muscleGroups: [.abs],
            description: "Lie on back, lift shoulders off ground. Controlled movement.",
            isBodyweight: true
        ),
        Exercise(
            id: "leg-raises",
            name: "Leg Raises",
            category: .core,
            muscleGroups: [.abs],
            description: "Lie on back, raise straight legs to 90 degrees.",
            isBodyweight: true
        ),
        Exercise(
            id: "mountain-climbers",
            name: "Mountain Climbers",
            category: .core,
            muscleGroups: [.abs, .fullBody],
            description: "Plank position, alternate driving knees to chest.",
            isBodyweight: true
        ),
        Exercise(
            id: "russian-twists",
            name: "Russian Twists",
            category: .core,
            muscleGroups: [.obliques, .abs],
            description: "Seated, lean back, rotate torso side to side.",
            isBodyweight: true
        ),
        Exercise(
            id: "dead-bug",
            name: "Dead Bug",
            category: .core,
            muscleGroups: [.abs],
            description: "On back, extend opposite arm and leg. Core stability.",
            isBodyweight: true
        ),
        Exercise(
            id: "hollow-body-hold",
            name: "Hollow Body Hold",
            category: .core,
            muscleGroups: [.abs],
            description: "Lie on back, lift arms and legs slightly. Hold position.",
            isBodyweight: true
        ),

        // Cardio Exercises
        Exercise(
            id: "burpees",
            name: "Burpees",
            category: .cardio,
            muscleGroups: [.fullBody],
            description: "Squat, jump back to plank, push-up, jump forward, jump up.",
            isBodyweight: true
        ),
        Exercise(
            id: "jumping-jacks",
            name: "Jumping Jacks",
            category: .cardio,
            muscleGroups: [.fullBody],
            description: "Classic cardio move. Jump while spreading arms and legs.",
            isBodyweight: true
        ),
        Exercise(
            id: "high-knees",
            name: "High Knees",
            category: .cardio,
            muscleGroups: [.fullBody],
            description: "Run in place bringing knees up high.",
            isBodyweight: true
        ),
        Exercise(
            id: "box-jumps",
            name: "Box Jumps",
            category: .cardio,
            muscleGroups: [.quads, .glutes, .calves],
            description: "Jump onto elevated surface. Step down and repeat.",
            isBodyweight: true
        ),

        // Flexibility
        Exercise(
            id: "downward-dog",
            name: "Downward Dog",
            category: .flexibility,
            muscleGroups: [.hamstrings, .calves, .shoulders],
            description: "Inverted V position. Stretch hamstrings and shoulders.",
            isBodyweight: true
        ),
        Exercise(
            id: "cobra-stretch",
            name: "Cobra Stretch",
            category: .flexibility,
            muscleGroups: [.abs],
            description: "Lie face down, push chest up. Opens hip flexors and abs.",
            isBodyweight: true
        ),
        Exercise(
            id: "pigeon-pose",
            name: "Pigeon Pose",
            category: .flexibility,
            muscleGroups: [.glutes, .hamstrings],
            description: "Deep hip stretch. One leg forward bent, other extended back.",
            isBodyweight: true
        )
    ]

    static func exercises(for category: ExerciseCategory) -> [Exercise] {
        calisthenicsExercises.filter { $0.category == category }
    }

    static func exercise(by id: String) -> Exercise? {
        calisthenicsExercises.first { $0.id == id }
    }
}
