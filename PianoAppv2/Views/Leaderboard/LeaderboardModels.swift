import Foundation

struct RankedStudent: Identifiable, Equatable {
    let id: UUID
    let student: Student
    let rank: Int
}

extension Array where Element == Student {
    func ranked() -> [RankedStudent] {
        var result: [RankedStudent] = []
        var currentRank = 0

        for (index, student) in self.enumerated() {
            if index > 0 && student.score < self[index - 1].score {
                currentRank += 1
            }

            result.append(
                RankedStudent(id: student.id, student: student, rank: currentRank)
            )
        }
        return result
    }
}
