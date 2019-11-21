import UIKit
import GameKit

class MenuViewController: UIViewController {

    
    var hosting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func join(_ sender: Any) {
        print("Join pressed")
       
        if GKLocalPlayer.local.isAuthenticated {
            authenticatePlayer()
        } else {
            createSession()
        }
    }
    
    @IBAction func host(_ sender: Any) {
        print("Host pressed")
        hosting = true
        
        if GKLocalPlayer.local.isAuthenticated {
            authenticatePlayer()
        } else {
            createSession()
        }
    }
    
    func authenticatePlayer() {
        // Aparecer alguma view de aguarde
        // Desativar os botões
        GKLocalPlayer.local.authenticateHandler = handler
    }
    
    func handler(vc: UIViewController?, error: Error?) -> Void {
        print("Handler return:")
        if vc != nil
        {
            // Ainda não sei direito o que acontece
            print("VC is not nil!")
            self.present(vc!, animated: true, completion: nil)
        }
        else if GKLocalPlayer.local.isAuthenticated
        {
            // Forçar a view ir pra uma VC de menu
            print("OI")
            createSession()
        }
        else
        {
            // Forçar a view ir pra uma VC de unheeee vc nao tem gamecenter chore
            print("fodeu")
        }
    }
    
    func createSession() {
        if hosting {
            GKMatchmaker.shared().startBrowsingForNearbyPlayers { (player: GKPlayer, reachable) in
                // Player é o jogador vizinho.
                // reachable = true -> jogador novo apareceu
                // reachable = false -> jogador antigo sumiu
                print(player)
            }
        } else {
            GKMatchmaker.shared().startBrowsingForNearbyPlayers { (player: GKPlayer, reachable) in
                // Player é o jogador vizinho.
                // reachable = true -> jogador novo apareceu
                // reachable = false -> jogador antigo sumiu
                print(player)
            }
        }
    }
    
}
