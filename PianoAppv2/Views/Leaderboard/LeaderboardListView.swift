import SwiftUI

struct LeaderboardListView: View {
    let students: [RankedStudent]

    var body: some View {
        VStack(spacing: 8) {
            ForEach(students) { item in
                HStack {
                    Text(item.student.name)
                    Spacer()
                    Text("\(item.student.score)")
                }
                .padding(.vertical, 6)
            }
        }
    }
}
