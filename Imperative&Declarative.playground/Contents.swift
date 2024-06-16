enum Subject: String, CaseIterable {
    case Chinese
    case Mathematics
    case English
    case Physics
}

struct Student {
    let name: String
    let scores: [Subject : Int]
}

let s1 = Student(
    name: "Jane",
    scores: [.Chinese: 86, .Mathematics: 92, .English: 73, .Physics: 88]
)

let s2 = Student(
    name: "Jane",
    scores: [.Chinese: 99, .Mathematics: 52, .English: 97, .Physics: 36]
)

let s3 = Student(
    name: "Jane",
    scores: [.Chinese: 91, .Mathematics: 92, .English: 100, .Physics: 99]
)

let students = [s1, s2, s3]

// - MARK: Imperative

var best: (Student, Double)?
for student in students {
    var totalScore = 0
    for key in Subject.allCases {
        totalScore += student.scores[key] ?? 0
    }
    let averageScore = Double(totalScore) / Double(Subject.allCases.count)
    
    if let temp = best {
        if averageScore > temp.1 { 
            best = (student, averageScore)
        }
    } else {
        best = (student, averageScore)
    }
}


// - MARK: Declarative

func average(_ scores: [Subject: Int]) -> Double {
    return Double(scores.values.reduce(0, +)) / Double(scores.keys.count)
}

let bestStudent = students
    .map { ($0, average($0.scores)) }
    .max { $0.1 > $1.1 }

// - MARK: 课后习题

let totalChineseScore = students.reduce(0) { $0 + ($1.scores[.Chinese] ?? 0) }
let averageChinese = totalChineseScore / students.count

func passRate(_ students: [Student], _ subject: Subject ) -> (Subject, Double) {
    let passCount = students
        .map { $0.scores[subject] ?? 0 }
        .filter { $0 > 60 }
        .count
    return (subject, (Double(passCount) / Double(students.count)))
}

let rate = Subject.allCases
    .map { passRate(students, $0) }
    .sorted { $0.1 > $1.1 }
