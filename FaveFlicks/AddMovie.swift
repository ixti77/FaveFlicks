

import SwiftUI

struct AddMovie: View {
  static let DefaultMovieTitle = "An untitled masterpiece"
  static let DefaultMovieGenre = "Genre-buster"

  @State var title = ""
  @State var genre = ""
  @State var releaseDate = Date()
  let onComplete: (String, String, Date) -> Void

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Title")) {
          TextField("Title", text: $title)
        }
        Section(header: Text("Genre")) {
          TextField("Genre", text: $genre)
        }
        Section {
          DatePicker(
            selection: $releaseDate,
            displayedComponents: .date
					) { Text("Release Date").foregroundColor(Color(.gray)) }
        }
        Section {
          Button(action: addMoveAction) {
            Text("Add Movie")
          }
        }
      }
      .navigationBarTitle(Text("Add Movie"), displayMode: .inline)
    }
  }

  private func addMoveAction() {
    onComplete(
      title.isEmpty ? AddMovie.DefaultMovieTitle : title,
      genre.isEmpty ? AddMovie.DefaultMovieGenre : genre,
      releaseDate)
  }
}
