import Foundation

struct ExerciseData {

    // MARK: - All Exercises

    static let allExercises: [Exercise] = noEquipmentExercises + minimalEquipmentExercises + fullGymExercises

    // MARK: - No Equipment (Bodyweight Only)

    static let noEquipmentExercises: [Exercise] = [
        // Push - No Equipment
        Exercise(
            id: "push-ups",
            name: "Push-Ups",
            category: .push,
            muscleGroups: [.chest, .triceps, .shoulders],
            description: "Classic bodyweight push exercise. Keep core tight and body straight.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "diamond-push-ups",
            name: "Diamond Push-Ups",
            category: .push,
            muscleGroups: [.triceps, .chest],
            description: "Hands close together forming a diamond shape. Targets triceps.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "wide-push-ups",
            name: "Wide Push-Ups",
            category: .push,
            muscleGroups: [.chest, .shoulders],
            description: "Hands wider than shoulder width. Greater chest emphasis.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "pike-push-ups",
            name: "Pike Push-Ups",
            category: .push,
            muscleGroups: [.shoulders, .triceps],
            description: "Hips high, body in inverted V. Targets shoulders.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "decline-push-ups",
            name: "Decline Push-Ups",
            category: .push,
            muscleGroups: [.chest, .shoulders, .triceps],
            description: "Feet elevated on a surface. Increases difficulty.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "bench-dips",
            name: "Bench Dips",
            category: .push,
            muscleGroups: [.triceps, .chest, .shoulders],
            description: "Using a chair or bench. Keep elbows close to body.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "archer-push-ups",
            name: "Archer Push-Ups",
            category: .push,
            muscleGroups: [.chest, .triceps, .shoulders],
            description: "Wide stance, shift weight to one side. Advanced unilateral push.",
            equipmentLevel: .none,
            equipment: []
        ),

        // Pull - No Equipment
        Exercise(
            id: "superman",
            name: "Superman Hold",
            category: .pull,
            muscleGroups: [.back, .glutes],
            description: "Lie face down, lift arms and legs. Strengthens lower back.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "reverse-snow-angels",
            name: "Reverse Snow Angels",
            category: .pull,
            muscleGroups: [.back, .shoulders],
            description: "Lie face down, move arms in arc motion. Great for posture.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "prone-y-raises",
            name: "Prone Y Raises",
            category: .pull,
            muscleGroups: [.back, .shoulders],
            description: "Face down, raise arms in Y position. Targets upper back.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "inverted-rows-table",
            name: "Inverted Rows (Table)",
            category: .pull,
            muscleGroups: [.back, .biceps],
            description: "Using a sturdy table edge. Great pull-up alternative.",
            equipmentLevel: .none,
            equipment: []
        ),

        // Legs - No Equipment
        Exercise(
            id: "squats",
            name: "Bodyweight Squats",
            category: .legs,
            muscleGroups: [.quads, .glutes, .hamstrings],
            description: "Feet shoulder width, squat down until thighs parallel.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "lunges",
            name: "Lunges",
            category: .legs,
            muscleGroups: [.quads, .glutes, .hamstrings],
            description: "Step forward, lower back knee toward ground.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "jump-squats",
            name: "Jump Squats",
            category: .legs,
            muscleGroups: [.quads, .glutes, .calves],
            description: "Explosive squat with jump at the top.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "pistol-squats",
            name: "Pistol Squats",
            category: .legs,
            muscleGroups: [.quads, .glutes, .hamstrings],
            description: "Single leg squat. Advanced exercise requiring balance.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "wall-sit",
            name: "Wall Sit",
            category: .legs,
            muscleGroups: [.quads],
            description: "Hold squat position against a wall. Isometric hold.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "calf-raises",
            name: "Calf Raises",
            category: .legs,
            muscleGroups: [.calves],
            description: "Rise up on toes, lower slowly. Use step for full range.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "glute-bridges",
            name: "Glute Bridges",
            category: .legs,
            muscleGroups: [.glutes, .hamstrings],
            description: "Lie on back, feet flat, lift hips. Squeeze glutes at top.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "step-ups",
            name: "Step-Ups",
            category: .legs,
            muscleGroups: [.quads, .glutes],
            description: "Step onto elevated surface. Alternate legs.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "bulgarian-split-squats",
            name: "Bulgarian Split Squats",
            category: .legs,
            muscleGroups: [.quads, .glutes, .hamstrings],
            description: "Rear foot elevated on chair. Deep single leg squat.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "nordic-curls",
            name: "Nordic Curls",
            category: .legs,
            muscleGroups: [.hamstrings],
            description: "Kneel with feet anchored. Lower body forward slowly.",
            equipmentLevel: .none,
            equipment: []
        ),

        // Core - No Equipment
        Exercise(
            id: "plank",
            name: "Plank",
            category: .core,
            muscleGroups: [.abs, .obliques],
            description: "Hold push-up position on forearms. Keep body straight.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "side-plank",
            name: "Side Plank",
            category: .core,
            muscleGroups: [.obliques, .abs],
            description: "Balance on one forearm, body sideways. Hold position.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "crunches",
            name: "Crunches",
            category: .core,
            muscleGroups: [.abs],
            description: "Lie on back, lift shoulders off ground. Controlled movement.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "leg-raises",
            name: "Leg Raises",
            category: .core,
            muscleGroups: [.abs],
            description: "Lie on back, raise straight legs to 90 degrees.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "mountain-climbers",
            name: "Mountain Climbers",
            category: .core,
            muscleGroups: [.abs, .fullBody],
            description: "Plank position, alternate driving knees to chest.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "russian-twists",
            name: "Russian Twists",
            category: .core,
            muscleGroups: [.obliques, .abs],
            description: "Seated, lean back, rotate torso side to side.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "dead-bug",
            name: "Dead Bug",
            category: .core,
            muscleGroups: [.abs],
            description: "On back, extend opposite arm and leg. Core stability.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "hollow-body-hold",
            name: "Hollow Body Hold",
            category: .core,
            muscleGroups: [.abs],
            description: "Lie on back, lift arms and legs slightly. Hold position.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "bicycle-crunches",
            name: "Bicycle Crunches",
            category: .core,
            muscleGroups: [.abs, .obliques],
            description: "Alternate elbow to opposite knee. Rotational core work.",
            equipmentLevel: .none,
            equipment: []
        ),

        // Cardio - No Equipment
        Exercise(
            id: "burpees",
            name: "Burpees",
            category: .cardio,
            muscleGroups: [.fullBody],
            description: "Squat, jump back to plank, push-up, jump forward, jump up.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "jumping-jacks",
            name: "Jumping Jacks",
            category: .cardio,
            muscleGroups: [.fullBody],
            description: "Classic cardio move. Jump while spreading arms and legs.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "high-knees",
            name: "High Knees",
            category: .cardio,
            muscleGroups: [.fullBody],
            description: "Run in place bringing knees up high.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "butt-kicks",
            name: "Butt Kicks",
            category: .cardio,
            muscleGroups: [.hamstrings, .fullBody],
            description: "Run in place kicking heels to glutes.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "skaters",
            name: "Skaters",
            category: .cardio,
            muscleGroups: [.glutes, .quads],
            description: "Lateral jumps side to side. Great for agility.",
            equipmentLevel: .none,
            equipment: []
        ),

        // Flexibility - No Equipment
        Exercise(
            id: "downward-dog",
            name: "Downward Dog",
            category: .flexibility,
            muscleGroups: [.hamstrings, .calves, .shoulders],
            description: "Inverted V position. Stretch hamstrings and shoulders.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "cobra-stretch",
            name: "Cobra Stretch",
            category: .flexibility,
            muscleGroups: [.abs],
            description: "Lie face down, push chest up. Opens hip flexors and abs.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "pigeon-pose",
            name: "Pigeon Pose",
            category: .flexibility,
            muscleGroups: [.glutes, .hamstrings],
            description: "Deep hip stretch. One leg forward bent, other extended back.",
            equipmentLevel: .none,
            equipment: []
        ),
        Exercise(
            id: "childs-pose",
            name: "Child's Pose",
            category: .flexibility,
            muscleGroups: [.back, .shoulders],
            description: "Kneel, sit back on heels, arms extended forward.",
            equipmentLevel: .none,
            equipment: []
        ),
    ]

    // MARK: - Minimal Equipment (Dumbbells, Bands, Pull-up Bar)

    static let minimalEquipmentExercises: [Exercise] = [
        // Push - Minimal Equipment
        Exercise(
            id: "dumbbell-bench-press",
            name: "Dumbbell Floor Press",
            category: .push,
            muscleGroups: [.chest, .triceps, .shoulders],
            description: "Lie on floor, press dumbbells up. Great chest builder.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbells"]
        ),
        Exercise(
            id: "dumbbell-shoulder-press",
            name: "Dumbbell Shoulder Press",
            category: .push,
            muscleGroups: [.shoulders, .triceps],
            description: "Press dumbbells overhead. Seated or standing.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbells"]
        ),
        Exercise(
            id: "dumbbell-lateral-raises",
            name: "Lateral Raises",
            category: .push,
            muscleGroups: [.shoulders],
            description: "Raise dumbbells to sides. Targets side delts.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbells"]
        ),
        Exercise(
            id: "dumbbell-tricep-extension",
            name: "Overhead Tricep Extension",
            category: .push,
            muscleGroups: [.triceps],
            description: "Hold dumbbell overhead, lower behind head.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbell"]
        ),
        Exercise(
            id: "band-push-ups",
            name: "Banded Push-Ups",
            category: .push,
            muscleGroups: [.chest, .triceps, .shoulders],
            description: "Push-ups with resistance band across back. Added resistance.",
            equipmentLevel: .minimal,
            equipment: ["Resistance Band"]
        ),
        Exercise(
            id: "dumbbell-flyes",
            name: "Dumbbell Floor Flyes",
            category: .push,
            muscleGroups: [.chest],
            description: "Lie on floor, arc dumbbells out and in. Chest isolation.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbells"]
        ),

        // Pull - Minimal Equipment
        Exercise(
            id: "pull-ups",
            name: "Pull-Ups",
            category: .pull,
            muscleGroups: [.back, .biceps, .forearms],
            description: "Overhand grip, pull chin above bar. King of back exercises.",
            equipmentLevel: .minimal,
            equipment: ["Pull-up Bar"]
        ),
        Exercise(
            id: "chin-ups",
            name: "Chin-Ups",
            category: .pull,
            muscleGroups: [.biceps, .back],
            description: "Underhand grip. More bicep emphasis than pull-ups.",
            equipmentLevel: .minimal,
            equipment: ["Pull-up Bar"]
        ),
        Exercise(
            id: "dumbbell-rows",
            name: "Dumbbell Rows",
            category: .pull,
            muscleGroups: [.back, .biceps],
            description: "Bent over, row dumbbell to hip. One arm at a time.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbell"]
        ),
        Exercise(
            id: "band-pull-aparts",
            name: "Band Pull-Aparts",
            category: .pull,
            muscleGroups: [.back, .shoulders],
            description: "Hold band at shoulder height, pull apart. Rear delt focus.",
            equipmentLevel: .minimal,
            equipment: ["Resistance Band"]
        ),
        Exercise(
            id: "band-rows",
            name: "Banded Rows",
            category: .pull,
            muscleGroups: [.back, .biceps],
            description: "Anchor band, row handles to chest. Great for back.",
            equipmentLevel: .minimal,
            equipment: ["Resistance Band"]
        ),
        Exercise(
            id: "dumbbell-curls",
            name: "Dumbbell Bicep Curls",
            category: .pull,
            muscleGroups: [.biceps],
            description: "Curl dumbbells up. Keep elbows at sides.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbells"]
        ),
        Exercise(
            id: "hammer-curls",
            name: "Hammer Curls",
            category: .pull,
            muscleGroups: [.biceps, .forearms],
            description: "Neutral grip curls. Targets brachialis and forearms.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbells"]
        ),
        Exercise(
            id: "face-pulls-band",
            name: "Face Pulls (Band)",
            category: .pull,
            muscleGroups: [.shoulders, .back],
            description: "Pull band to face level. Great for rear delts and posture.",
            equipmentLevel: .minimal,
            equipment: ["Resistance Band"]
        ),

        // Legs - Minimal Equipment
        Exercise(
            id: "goblet-squats",
            name: "Goblet Squats",
            category: .legs,
            muscleGroups: [.quads, .glutes],
            description: "Hold dumbbell at chest, squat deep. Great form builder.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbell"]
        ),
        Exercise(
            id: "dumbbell-lunges",
            name: "Dumbbell Lunges",
            category: .legs,
            muscleGroups: [.quads, .glutes, .hamstrings],
            description: "Hold dumbbells at sides, lunge forward.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbells"]
        ),
        Exercise(
            id: "dumbbell-rdl",
            name: "Dumbbell Romanian Deadlift",
            category: .legs,
            muscleGroups: [.hamstrings, .glutes, .back],
            description: "Hinge at hips, lower dumbbells along legs. Hamstring focus.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbells"]
        ),
        Exercise(
            id: "dumbbell-split-squats",
            name: "Dumbbell Bulgarian Split Squats",
            category: .legs,
            muscleGroups: [.quads, .glutes],
            description: "Rear foot elevated, hold dumbbells. Deep single leg work.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbells"]
        ),
        Exercise(
            id: "band-squats",
            name: "Banded Squats",
            category: .legs,
            muscleGroups: [.quads, .glutes],
            description: "Stand on band, hold at shoulders. Added resistance.",
            equipmentLevel: .minimal,
            equipment: ["Resistance Band"]
        ),
        Exercise(
            id: "dumbbell-calf-raises",
            name: "Dumbbell Calf Raises",
            category: .legs,
            muscleGroups: [.calves],
            description: "Hold dumbbells, rise on toes. Weighted calf work.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbells"]
        ),
        Exercise(
            id: "kettlebell-swings",
            name: "Kettlebell/Dumbbell Swings",
            category: .legs,
            muscleGroups: [.glutes, .hamstrings, .back],
            description: "Hinge and swing weight between legs. Hip power.",
            equipmentLevel: .minimal,
            equipment: ["Kettlebell or Dumbbell"]
        ),

        // Core - Minimal Equipment
        Exercise(
            id: "hanging-leg-raises",
            name: "Hanging Leg Raises",
            category: .core,
            muscleGroups: [.abs],
            description: "Hang from bar, raise legs. Advanced ab exercise.",
            equipmentLevel: .minimal,
            equipment: ["Pull-up Bar"]
        ),
        Exercise(
            id: "hanging-knee-raises",
            name: "Hanging Knee Raises",
            category: .core,
            muscleGroups: [.abs],
            description: "Hang from bar, raise knees to chest.",
            equipmentLevel: .minimal,
            equipment: ["Pull-up Bar"]
        ),
        Exercise(
            id: "dumbbell-russian-twists",
            name: "Weighted Russian Twists",
            category: .core,
            muscleGroups: [.obliques, .abs],
            description: "Hold dumbbell, rotate side to side.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbell"]
        ),
        Exercise(
            id: "band-pallof-press",
            name: "Pallof Press",
            category: .core,
            muscleGroups: [.abs, .obliques],
            description: "Press band away from chest. Anti-rotation core work.",
            equipmentLevel: .minimal,
            equipment: ["Resistance Band"]
        ),
        Exercise(
            id: "ab-rollout-dumbbell",
            name: "Dumbbell Ab Rollout",
            category: .core,
            muscleGroups: [.abs],
            description: "Use round dumbbells to roll out. Core stability.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbells"]
        ),

        // Cardio - Minimal Equipment
        Exercise(
            id: "jump-rope",
            name: "Jump Rope",
            category: .cardio,
            muscleGroups: [.calves, .fullBody],
            description: "Classic cardio. Great for conditioning.",
            equipmentLevel: .minimal,
            equipment: ["Jump Rope"]
        ),
        Exercise(
            id: "dumbbell-thrusters",
            name: "Dumbbell Thrusters",
            category: .cardio,
            muscleGroups: [.fullBody],
            description: "Squat to overhead press. Full body cardio strength.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbells"]
        ),
        Exercise(
            id: "dumbbell-snatches",
            name: "Dumbbell Snatches",
            category: .cardio,
            muscleGroups: [.fullBody],
            description: "Explosive lift from floor to overhead. Power cardio.",
            equipmentLevel: .minimal,
            equipment: ["Dumbbell"]
        ),
    ]

    // MARK: - Full Gym Equipment

    static let fullGymExercises: [Exercise] = [
        // Push - Full Gym
        Exercise(
            id: "barbell-bench-press",
            name: "Barbell Bench Press",
            category: .push,
            muscleGroups: [.chest, .triceps, .shoulders],
            description: "Classic chest builder. Press barbell from chest.",
            equipmentLevel: .full,
            equipment: ["Barbell", "Bench"]
        ),
        Exercise(
            id: "incline-bench-press",
            name: "Incline Bench Press",
            category: .push,
            muscleGroups: [.chest, .shoulders, .triceps],
            description: "Bench at 30-45 degrees. Upper chest focus.",
            equipmentLevel: .full,
            equipment: ["Barbell", "Incline Bench"]
        ),
        Exercise(
            id: "decline-bench-press",
            name: "Decline Bench Press",
            category: .push,
            muscleGroups: [.chest, .triceps],
            description: "Head lower than hips. Lower chest emphasis.",
            equipmentLevel: .full,
            equipment: ["Barbell", "Decline Bench"]
        ),
        Exercise(
            id: "overhead-press",
            name: "Barbell Overhead Press",
            category: .push,
            muscleGroups: [.shoulders, .triceps],
            description: "Press barbell overhead from shoulders. Shoulder builder.",
            equipmentLevel: .full,
            equipment: ["Barbell"]
        ),
        Exercise(
            id: "cable-flyes",
            name: "Cable Flyes",
            category: .push,
            muscleGroups: [.chest],
            description: "Constant tension chest isolation. Various angles.",
            equipmentLevel: .full,
            equipment: ["Cable Machine"]
        ),
        Exercise(
            id: "tricep-pushdowns",
            name: "Tricep Pushdowns",
            category: .push,
            muscleGroups: [.triceps],
            description: "Push cable down, squeeze triceps. Isolation exercise.",
            equipmentLevel: .full,
            equipment: ["Cable Machine"]
        ),
        Exercise(
            id: "skull-crushers",
            name: "Skull Crushers",
            category: .push,
            muscleGroups: [.triceps],
            description: "Lower EZ bar to forehead. Tricep mass builder.",
            equipmentLevel: .full,
            equipment: ["EZ Bar", "Bench"]
        ),
        Exercise(
            id: "machine-chest-press",
            name: "Machine Chest Press",
            category: .push,
            muscleGroups: [.chest, .triceps],
            description: "Guided movement. Safe for beginners.",
            equipmentLevel: .full,
            equipment: ["Chest Press Machine"]
        ),
        Exercise(
            id: "pec-deck",
            name: "Pec Deck Flyes",
            category: .push,
            muscleGroups: [.chest],
            description: "Machine flye movement. Chest isolation.",
            equipmentLevel: .full,
            equipment: ["Pec Deck Machine"]
        ),

        // Pull - Full Gym
        Exercise(
            id: "barbell-rows",
            name: "Barbell Bent Over Rows",
            category: .pull,
            muscleGroups: [.back, .biceps],
            description: "Bend forward, row barbell to chest. Back builder.",
            equipmentLevel: .full,
            equipment: ["Barbell"]
        ),
        Exercise(
            id: "lat-pulldowns",
            name: "Lat Pulldowns",
            category: .pull,
            muscleGroups: [.back, .biceps],
            description: "Pull bar to chest. Great for lat development.",
            equipmentLevel: .full,
            equipment: ["Cable Machine", "Lat Bar"]
        ),
        Exercise(
            id: "seated-cable-rows",
            name: "Seated Cable Rows",
            category: .pull,
            muscleGroups: [.back, .biceps],
            description: "Pull cable to stomach. Mid-back focus.",
            equipmentLevel: .full,
            equipment: ["Cable Machine"]
        ),
        Exercise(
            id: "t-bar-rows",
            name: "T-Bar Rows",
            category: .pull,
            muscleGroups: [.back, .biceps],
            description: "Row landmine or T-bar to chest. Thick back builder.",
            equipmentLevel: .full,
            equipment: ["T-Bar", "Landmine"]
        ),
        Exercise(
            id: "face-pulls",
            name: "Face Pulls",
            category: .pull,
            muscleGroups: [.shoulders, .back],
            description: "Pull rope to face. Rear delts and rotator cuff.",
            equipmentLevel: .full,
            equipment: ["Cable Machine", "Rope"]
        ),
        Exercise(
            id: "barbell-curls",
            name: "Barbell Curls",
            category: .pull,
            muscleGroups: [.biceps],
            description: "Classic bicep builder. Curl barbell up.",
            equipmentLevel: .full,
            equipment: ["Barbell"]
        ),
        Exercise(
            id: "preacher-curls",
            name: "Preacher Curls",
            category: .pull,
            muscleGroups: [.biceps],
            description: "Curl on preacher bench. Bicep isolation.",
            equipmentLevel: .full,
            equipment: ["Preacher Bench", "EZ Bar"]
        ),
        Exercise(
            id: "cable-curls",
            name: "Cable Curls",
            category: .pull,
            muscleGroups: [.biceps],
            description: "Constant tension curls. Great pump.",
            equipmentLevel: .full,
            equipment: ["Cable Machine"]
        ),
        Exercise(
            id: "machine-rows",
            name: "Machine Rows",
            category: .pull,
            muscleGroups: [.back, .biceps],
            description: "Guided rowing motion. Safe and effective.",
            equipmentLevel: .full,
            equipment: ["Row Machine"]
        ),
        Exercise(
            id: "shrugs",
            name: "Barbell Shrugs",
            category: .pull,
            muscleGroups: [.back, .shoulders],
            description: "Shrug shoulders up with barbell. Trap builder.",
            equipmentLevel: .full,
            equipment: ["Barbell"]
        ),

        // Legs - Full Gym
        Exercise(
            id: "barbell-squats",
            name: "Barbell Back Squats",
            category: .legs,
            muscleGroups: [.quads, .glutes, .hamstrings],
            description: "King of leg exercises. Bar on upper back.",
            equipmentLevel: .full,
            equipment: ["Barbell", "Squat Rack"]
        ),
        Exercise(
            id: "front-squats",
            name: "Front Squats",
            category: .legs,
            muscleGroups: [.quads, .glutes],
            description: "Bar on front delts. Quad dominant squat.",
            equipmentLevel: .full,
            equipment: ["Barbell", "Squat Rack"]
        ),
        Exercise(
            id: "deadlifts",
            name: "Conventional Deadlifts",
            category: .legs,
            muscleGroups: [.hamstrings, .glutes, .back],
            description: "Lift barbell from floor. Full body power.",
            equipmentLevel: .full,
            equipment: ["Barbell"]
        ),
        Exercise(
            id: "sumo-deadlifts",
            name: "Sumo Deadlifts",
            category: .legs,
            muscleGroups: [.glutes, .hamstrings, .quads],
            description: "Wide stance deadlift. More glute emphasis.",
            equipmentLevel: .full,
            equipment: ["Barbell"]
        ),
        Exercise(
            id: "romanian-deadlifts",
            name: "Barbell Romanian Deadlifts",
            category: .legs,
            muscleGroups: [.hamstrings, .glutes],
            description: "Hinge movement. Hamstring stretch and strength.",
            equipmentLevel: .full,
            equipment: ["Barbell"]
        ),
        Exercise(
            id: "leg-press",
            name: "Leg Press",
            category: .legs,
            muscleGroups: [.quads, .glutes],
            description: "Press weight with legs. Safe heavy loading.",
            equipmentLevel: .full,
            equipment: ["Leg Press Machine"]
        ),
        Exercise(
            id: "hack-squats",
            name: "Hack Squats",
            category: .legs,
            muscleGroups: [.quads, .glutes],
            description: "Machine squat variation. Quad focused.",
            equipmentLevel: .full,
            equipment: ["Hack Squat Machine"]
        ),
        Exercise(
            id: "leg-extensions",
            name: "Leg Extensions",
            category: .legs,
            muscleGroups: [.quads],
            description: "Extend legs against resistance. Quad isolation.",
            equipmentLevel: .full,
            equipment: ["Leg Extension Machine"]
        ),
        Exercise(
            id: "leg-curls",
            name: "Lying Leg Curls",
            category: .legs,
            muscleGroups: [.hamstrings],
            description: "Curl legs up. Hamstring isolation.",
            equipmentLevel: .full,
            equipment: ["Leg Curl Machine"]
        ),
        Exercise(
            id: "calf-raises-machine",
            name: "Standing Calf Raises",
            category: .legs,
            muscleGroups: [.calves],
            description: "Heavy calf work on machine.",
            equipmentLevel: .full,
            equipment: ["Calf Raise Machine"]
        ),
        Exercise(
            id: "hip-thrusts",
            name: "Barbell Hip Thrusts",
            category: .legs,
            muscleGroups: [.glutes, .hamstrings],
            description: "Back on bench, thrust hips up. Glute builder.",
            equipmentLevel: .full,
            equipment: ["Barbell", "Bench"]
        ),
        Exercise(
            id: "hip-abductor",
            name: "Hip Abductor Machine",
            category: .legs,
            muscleGroups: [.glutes],
            description: "Push legs apart. Outer glute focus.",
            equipmentLevel: .full,
            equipment: ["Hip Abductor Machine"]
        ),

        // Core - Full Gym
        Exercise(
            id: "cable-crunches",
            name: "Cable Crunches",
            category: .core,
            muscleGroups: [.abs],
            description: "Kneel, crunch against cable resistance.",
            equipmentLevel: .full,
            equipment: ["Cable Machine", "Rope"]
        ),
        Exercise(
            id: "cable-woodchops",
            name: "Cable Woodchops",
            category: .core,
            muscleGroups: [.obliques, .abs],
            description: "Diagonal chop movement. Rotational power.",
            equipmentLevel: .full,
            equipment: ["Cable Machine"]
        ),
        Exercise(
            id: "ab-machine",
            name: "Ab Crunch Machine",
            category: .core,
            muscleGroups: [.abs],
            description: "Machine assisted crunches. Progressive loading.",
            equipmentLevel: .full,
            equipment: ["Ab Machine"]
        ),
        Exercise(
            id: "decline-crunches",
            name: "Decline Sit-Ups",
            category: .core,
            muscleGroups: [.abs],
            description: "Sit-ups on decline bench. Increased difficulty.",
            equipmentLevel: .full,
            equipment: ["Decline Bench"]
        ),

        // Cardio - Full Gym
        Exercise(
            id: "treadmill",
            name: "Treadmill Running",
            category: .cardio,
            muscleGroups: [.fullBody],
            description: "Running or walking on treadmill.",
            equipmentLevel: .full,
            equipment: ["Treadmill"]
        ),
        Exercise(
            id: "stairmaster",
            name: "Stairmaster",
            category: .cardio,
            muscleGroups: [.glutes, .quads],
            description: "Climb stairs continuously. Glute and cardio.",
            equipmentLevel: .full,
            equipment: ["Stairmaster"]
        ),
        Exercise(
            id: "rowing-machine",
            name: "Rowing Machine",
            category: .cardio,
            muscleGroups: [.back, .fullBody],
            description: "Full body cardio. Low impact.",
            equipmentLevel: .full,
            equipment: ["Rowing Machine"]
        ),
        Exercise(
            id: "assault-bike",
            name: "Assault/Air Bike",
            category: .cardio,
            muscleGroups: [.fullBody],
            description: "Arms and legs work together. High intensity.",
            equipmentLevel: .full,
            equipment: ["Assault Bike"]
        ),
        Exercise(
            id: "elliptical",
            name: "Elliptical",
            category: .cardio,
            muscleGroups: [.fullBody],
            description: "Low impact full body cardio.",
            equipmentLevel: .full,
            equipment: ["Elliptical Machine"]
        ),
    ]

    // MARK: - Helper Functions

    static func exercises(for equipmentLevel: EquipmentLevel) -> [Exercise] {
        switch equipmentLevel {
        case .none:
            return noEquipmentExercises
        case .minimal:
            return noEquipmentExercises + minimalEquipmentExercises
        case .full:
            return allExercises
        }
    }

    static func exercises(for category: ExerciseCategory, equipmentLevel: EquipmentLevel) -> [Exercise] {
        exercises(for: equipmentLevel).filter { $0.category == category }
    }

    static func exercise(by id: String) -> Exercise? {
        allExercises.first { $0.id == id }
    }

    static func exerciseCount(for equipmentLevel: EquipmentLevel) -> Int {
        exercises(for: equipmentLevel).count
    }
}
