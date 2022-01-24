

import SwiftUI

// swiftlint:disable multiple_closures_with_trailing_closure
struct MovieList: View {
	@FetchRequest(
		entity: Movie.entity(),
		sortDescriptors: [
			NSSortDescriptor(keyPath: \Movie.title, ascending: true)
		]
//		predicate: NSPredicate(format: "genre contains 'Action'")
	) var movies: FetchedResults<Movie>
	
	
	
	@Environment(\.managedObjectContext) var managedObjectContext
  @State var isPresented = false

  var body: some View {
    NavigationView {
      List {
        ForEach(movies, id: \.title) {
          MovieRow(movie: $0)
        }
        .onDelete(perform: deleteMovie)
      }
      .sheet(isPresented: $isPresented) {
        AddMovie { title, genre, release in
          self.addMovie(title: title, genre: genre, releaseDate: release)
          self.isPresented = false
        }
      }
      .navigationBarTitle(Text("Fave Flicks"))
        .navigationBarItems(trailing:
          Button(action: { self.isPresented.toggle() }) {
            Image(systemName: "plus")
          }
      )
    }
  }

  func deleteMovie(at offsets: IndexSet) {
		offsets.forEach { index in
			let movie = self.movies[index]
			self.managedObjectContext.delete(movie)
		}
		
		saveContext()
  }

  func addMovie(
		title: String,
		genre: String,
		releaseDate: Date
	) {
    let newMovie = Movie(context: managedObjectContext)
		
		newMovie.title = title
		newMovie.genre = genre
		newMovie.releaseDate = releaseDate
		
		saveContext()
  }
	
	func saveContext() {
		do {
			try managedObjectContext.save()
		} catch {
			print("Error saving managed object context: \(error)")
		}
	}
}

struct MovieList_Previews: PreviewProvider {
  static var previews: some View {
    MovieList()
  }
}
