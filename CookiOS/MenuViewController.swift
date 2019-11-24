import UIKit
import GameKit

class MenuViewController: UIViewController, GKLocalPlayerListener {

    
    @IBOutlet weak var hostButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    var hosting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        authenticatePlayer()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func host(_ sender: Any) {
        print("Host pressed")
        hosting = true
        createSession()
    }
    
    @IBAction func join(_ sender: Any) {
        print("Join pressed")
        createSession()
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
            hostButton.isEnabled = true
            joinButton.isEnabled = true
            
        }
        else
        {
            // Forçar a view ir pra uma VC de unheeee vc nao tem gamecenter chore
            print("fodeu")
        }
    }
    
    func createSession() {
        
        let localPlayer = GKLocalPlayer.local
        localPlayer.unregisterAllListeners()
        localPlayer.register(self)
        
        localPlayer.loadChallengableFriends { (players, error) in
            print("Load Challengable Friends \(players), \(error)")
        }
        
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
    
    func player(_ player: GKPlayer, didAccept invite: GKInvite) {
        
    }
    
    func player(_ player: GKPlayer, didRequestMatchWithRecipients recipientPlayers: [GKPlayer]) {
        
    }
    
}
