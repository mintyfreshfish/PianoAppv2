import SwiftUI

struct PodiumView: View {
    let students: [RankedStudent]

    var body: some View {
        let grouped = Dictionary(grouping: students, by: { $0.rank })

        HStack(alignment: .bottom, spacing: 24) {

            // 🥈 LEFT
            podiumColumn(grouped[1] ?? [], rank: 1)

            // 🥇 CENTER (tallest)
            podiumColumn(grouped[0] ?? [], rank: 0)
                .scaleEffect(1.1)

            // 🥉 RIGHT
            podiumColumn(grouped[2] ?? [], rank: 2)
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private func podiumColumn(_ items: [RankedStudent], rank: Int) -> some View {
        VStack(spacing: 6) {
            ForEach(items) { item in
                VStack {
                    Text(item.student.name)
                        .font(.headline)

                    Text("\(item.student.score)")
                        .font(.caption)
                }
            }

            Rectangle()
                .fill(podiumColor(rank))
                .frame(height: height(for: rank))
                .overlay(
                    Text(medal(for: rank))
                        .font(.largeTitle)
                )
                .cornerRadius(10)
        }
    }

    private func height(for rank: Int) -> CGFloat {
        switch rank {
        case 0: return 140
        case 1: return 110
        case 2: return 90
        default: return 70
        }
    }

    private func medal(for rank: Int) -> String {
        switch rank {
        case 0: return "🥇"
        case 1: return "🥈"
        case 2: return "🥉"
        default: return ""
        }
    }

    private func podiumColor(_ rank: Int) -> Color {
        switch rank {
        case 0: return .yellow.opacity(0.5)
        case 1: return .gray.opacity(0.4)
        case 2: return .orange.opacity(0.4)
        default: return .clear
        }
    }
}
