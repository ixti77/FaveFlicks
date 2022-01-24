

import SwiftUI

struct MovieRow: View {
  static let releaseFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
  }()
	
	let movie: Movie

  var body: some View {
    VStack(alignment: .leading) {
			movie.title.map(Text.init)
        .font(.title)
      HStack {
				movie.genre.map(Text.init)
          .font(.caption)
        Spacer()
				movie.releaseDate.map { Text(Self.releaseFormatter.string(from: $0)) }
          .font(.caption)
      }
    }
  }
}
