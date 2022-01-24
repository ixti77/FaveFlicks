
import CoreData
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
	
	lazy var persistenceContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "FaveFlicks")
		container.loadPersistentStores { _, error in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
			
		}
		
		return container
	}()

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
		let context = persistenceContainer.viewContext
		let contentView = MovieList().environment(\.managedObjectContext, context)

    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: contentView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
	
	func sceneDidEnterBackground(_ scene: UIScene) {
		saveContext()
	}
	
	func saveContext() {
		let context = persistenceContainer.viewContext
		
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nsError = error as NSError
				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			}
		}
	}
}
