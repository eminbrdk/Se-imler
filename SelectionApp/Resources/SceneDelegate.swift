import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
        window?.rootViewController = (DataManager.shared.getAllChestsData() == []) ? WelcomeVC() : createTabBarController()
    }
    
    func createTabBarController() -> UITabBarController {
        let vc = ChestsVC()
        let nc = UINavigationController(rootViewController: vc)
        nc.navigationBar.prefersLargeTitles = true
        nc.navigationItem.largeTitleDisplayMode = .always
        nc.tabBarItem = UITabBarItem(title: "Sandıklar", image: UIImage(systemName: "archivebox"), tag: 0)
        
        let vc2 = CheckVC()
        let nc2 = UINavigationController(rootViewController: vc2)
        nc2.navigationBar.prefersLargeTitles = true
        nc2.navigationItem.largeTitleDisplayMode = .always
        nc2.tabBarItem = UITabBarItem(title: "Denetleme", image: UIImage(systemName: "checkmark.circle"), tag: 1)
        
        let tbc = UITabBarController()
        tbc.viewControllers = [nc, nc2]
        
        return tbc
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

