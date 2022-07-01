
//  ViewController.swift

import UIKit

struct convoHistory {
    static var conversation = [String]()
    static var items = [Item]()
}
class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var actionTable: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var aButton: UIBarButtonItem!
    @IBOutlet weak var bButton: UIBarButtonItem!
    @IBOutlet weak var cButton: UIBarButtonItem!
    @IBOutlet weak var dButton: UIBarButtonItem!
    @IBOutlet weak var eButton: UIBarButtonItem!
    @IBOutlet weak var qButton: UIBarButtonItem!
    
    //text variables
    var welcomeMessage = "Welcome to Camel! 🐪\nYou have stolen a camel to make your way across the great Mobi desert. The natives want their camel back and are chasing you down! Survive your desert trek and outrun the natives. \nPress Q to quit."
    var prompt = "A. Drink from your canteen.\nB. Ahead moderate speed.\nC. Ahead full speed.\nD. Stop and rest.\nE. Status check."
    
    //background image
    let backgroundImage = UIImageView(image: UIImage(named: "background.png"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loading")
        self.actionTable.delegate = self
        self.actionTable.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        convoHistory.items = [.welcomeMessage, .prompt]
        convoHistory.conversation += ["place holder for welcome message",prompt]
        //set table background
        backgroundImage.contentMode = .scaleAspectFill
        actionTable.backgroundView = backgroundImage
        //change buttons font
        aButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Menlo-Regular", size: 12.0)!,NSAttributedString.Key.foregroundColor: UIColor.black],for: .normal)
        bButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Menlo-Regular", size: 12.0)!,NSAttributedString.Key.foregroundColor: UIColor.black],for: .normal)
        cButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Menlo-Regular", size: 12.0)!,NSAttributedString.Key.foregroundColor: UIColor.black],for: .normal)
        dButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Menlo-Regular", size: 12.0)!,NSAttributedString.Key.foregroundColor: UIColor.black],for: .normal)
        eButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Menlo-Regular", size: 12.0)!,NSAttributedString.Key.foregroundColor: UIColor.black],for: .normal)
        qButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Menlo-Regular", size: 12.0)!,NSAttributedString.Key.foregroundColor: UIColor.black],for: .normal)
        //change color of toolbar
        self.toolbar.isTranslucent = false
        self.toolbar.setBackgroundImage(UIImage(named: "Toolbar-color.png"), forToolbarPosition: .bottom, barMetrics: .default)
        navigationItem.titleView = UIImageView(image: UIImage(named: "Toolbar-color.png"))
        //change color of navigation bar
        let img = UIImage(named: "Toolbar-color.png")
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        //title image
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo.png")
        imageView.image = image
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
        //testing
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    //game variables
    var milesTraveled = 0
    var thirst = 0
    var camelTiredness = 0
    var nativesDistance = -20
    var canteenDrinksLeft = 6
    var walking = false

    //************************** button controls *************************
    
    @IBAction func pressedA(_ sender: UIBarButtonItem) {
        //user choice
        convoHistory.items += [.userChoice]
        convoHistory.conversation.append("Drink from your canteen.")
        nativesDistance += Int.random(in: 6..<10)
        //checks
        if foundOasis() == false  {
            if didWin() == false && checksNoThirst() == false  {
                //variables updates
                if canteenDrinksLeft > 0 {
                    canteenDrinksLeft -= 1
                    thirst = 0
                    convoHistory.conversation.append("You are offically rehydrated!")
                    convoHistory.conversation.append("\(prompt)")
                } else {
                    convoHistory.conversation.append("Sadly, you have no more drinks left.")
                    convoHistory.conversation.append("\(prompt)")
                }
                //the order: userResponse, computerResponse, prompt
                convoHistory.items += [.computerResponse, .prompt]
                actionTable.reloadData()
                let indexPath = IndexPath(row: convoHistory.items.count - 1, section: 0)
                actionTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    @IBAction func pressedB(_ sender: UIBarButtonItem) {
        //user choice
        convoHistory.items += [.userChoice]
        convoHistory.conversation.append("Ahead moderate speed.")
        //variables updates
        camelTiredness += 1
        thirst += 1
        if walking == true {
            milesTraveled += Int.random(in: 6..<10)
        } else {
            milesTraveled += Int.random(in: 7..<14)
        }
        nativesDistance += Int.random(in: 7..<10)
        //checks
        if foundOasis() == false {
            if didWin() == false && allChecks() == false {
                //prints
                convoHistory.conversation.append("You have traveled \(String(milesTraveled)) miles.")
                convoHistory.conversation.append("\(prompt)")
                //the order: userResponse, computerResponse, prompt
                convoHistory.items += [.computerResponse, .prompt]
                actionTable.reloadData()
                let indexPath = IndexPath(row: convoHistory.items.count - 1, section: 0)
                actionTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    @IBAction func pressedC(_ sender: UIBarButtonItem) {
        //user choice
        convoHistory.items += [.userChoice]
        convoHistory.conversation.append("Ahead full speed.")
        //variable updates
        if walking == true {
            milesTraveled += Int.random(in: 6..<10)
        } else {
            milesTraveled += Int.random(in: 10..<20)
        }
        camelTiredness += Int.random(in: 1..<3)
        thirst += 1
        nativesDistance += Int.random(in: 7..<10)
        //checks
        if foundOasis() == false {
            if  didWin() == false && allChecks() == false {
                //prints
                convoHistory.conversation.append("You have traveled \(String(milesTraveled)) miles.")
                convoHistory.conversation.append("\(prompt)")
                //the order: userResponse, computerResponse, prompt
                convoHistory.items += [.computerResponse, .prompt]
                actionTable.reloadData()
                let indexPath = IndexPath(row: convoHistory.items.count - 1, section: 0)
                actionTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    @IBAction func pressedD(_ sender: UIBarButtonItem) {
        //user choice
        convoHistory.items += [.userChoice]
        convoHistory.conversation.append("Stop and rest.")
        //variable updates
        camelTiredness = 0
        nativesDistance += Int.random(in: 7..<10)
        //checks
        if foundOasis() == false {
            if didWin() == false && allChecks() == false {
                //prints
                convoHistory.conversation.append("Your camel is very happy!")
                convoHistory.conversation.append("\(prompt)")
                //the order: userResponse, computerResponse, prompt
                convoHistory.items += [.computerResponse, .prompt]
                actionTable.reloadData()
                let indexPath = IndexPath(row: convoHistory.items.count - 1, section: 0)
                actionTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    @IBAction func pressedE(_ sender: Any) {
        //user choice
        convoHistory.items += [.userChoice]
        convoHistory.conversation.append("Status check.")
        //checks
        if foundOasis() == false {
            if didWin() == false && allChecks() == false {
                //all prints
                convoHistory.conversation.append("Miles traveled: \(String(milesTraveled))\nDrinks in canteen: \(String(canteenDrinksLeft))\nThe natives are \(String(milesTraveled - nativesDistance)) miles behind you.")
                convoHistory.conversation.append("\(prompt)")
                //the order: userResponse, computerResponse, prompt
                convoHistory.items += [.computerResponse, .prompt]
                actionTable.reloadData()
                let indexPath = IndexPath(row: convoHistory.items.count - 1, section: 0)
                actionTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
     
    func allChecks() -> Bool {
        let distance = milesTraveled - nativesDistance
        //all the deads
        if distance <= 0 { //natives caught you
            convoHistory.items += [.loss]
            convoHistory.conversation.append("The natives caught you. 🥵")
            aButton.isEnabled = false
            bButton.isEnabled = false
            cButton.isEnabled = false
            dButton.isEnabled = false
            eButton.isEnabled = false
            actionTable.reloadData()
            let indexPath = IndexPath(row: convoHistory.items.count - 1, section: 0)
            actionTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            return true
        } else if thirst >= 6 { //died of thirst
            convoHistory.items += [.loss]
            convoHistory.conversation.append("You died of thirst! 🥤")
            aButton.isEnabled = false
            bButton.isEnabled = false
            cButton.isEnabled = false
            dButton.isEnabled = false
            eButton.isEnabled = false
            actionTable.reloadData()
            let indexPath = IndexPath(row: convoHistory.items.count - 1, section: 0)
            actionTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            return true
        } else if camelTiredness >= 8 { //camel dead
            if walking == true {
                return false
            } else {
                convoHistory.items += [.computerResponse]
                convoHistory.conversation.append("Your camel is dead. You will now move slower. 😵")
                walking = true
                actionTable.reloadData()
                let indexPath = IndexPath(row: convoHistory.items.count - 1, section: 0)
                actionTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
                return false
            }
        }
        //all the warnings
        else if distance > 0 && distance < 15 { //natives close
            //distance is corret
            convoHistory.items += [.computerResponse]
            convoHistory.conversation.append("The natives are getting close!")
            walking = true
            actionTable.reloadData()
            let indexPath = IndexPath(row: convoHistory.items.count - 1, section: 0)
            actionTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            return false
        } else if thirst >= 4 && thirst < 6 { //thirst down
            convoHistory.items += [.computerResponse]
            convoHistory.conversation.append("You are thirsty")
            actionTable.reloadData()
            let indexPath = IndexPath(row: convoHistory.items.count - 1, section: 0)
            actionTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            return false
        } else if camelTiredness > 5 && camelTiredness < 8 { //camel tired
            convoHistory.items += [.computerResponse]
            if walking == true {
                convoHistory.conversation.append("You are well rested.")
            } else {
                convoHistory.conversation.append("Your camel is getting tired.")
            }
            actionTable.reloadData()
            let indexPath = IndexPath(row: convoHistory.items.count - 1, section: 0)
            actionTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            return false
        }
        return false
    }
    
    func checksNoThirst() -> Bool {
        let distance = milesTraveled - nativesDistance
        //all the deads
        if distance <= 0 { //natives caught you
            convoHistory.items += [.loss]
            convoHistory.conversation.append("The natives caught you. 🥵")
            aButton.isEnabled = false
            bButton.isEnabled = false
            cButton.isEnabled = false
            dButton.isEnabled = false
            eButton.isEnabled = false
            actionTable.reloadData()
            let indexPath = IndexPath(row: convoHistory.items.count - 1, section: 0)
            actionTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            return true
        } else if camelTiredness >= 8 { //camel dead
            if walking == true {
                return false
            } else {
                convoHistory.items += [.computerResponse]
                convoHistory.conversation.append("Your camel is dead. You will now move slower. 😵")
                walking = true
                actionTable.reloadData()
                let indexPath = IndexPath(row: convoHistory.items.count - 1, section: 0)
                actionTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
                return false
            }
        }
        //all the warnings
        else if distance > 0 && distance < 15 { //natives close
            //distance is corret
            convoHistory.items += [.computerResponse]
            convoHistory.conversation.append("The natives are getting close!")
            walking = true
            actionTable.reloadData()
            let indexPath = IndexPath(row: convoHistory.items.count - 1, section: 0)
            actionTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            return false
        } else if camelTiredness > 5 && camelTiredness < 8 { //camel tired
            convoHistory.items += [.computerResponse]
            if walking == true {
                convoHistory.conversation.append("You are well rested.")
            } else {
                convoHistory.conversation.append("Your camel is getting tired.")
            }
            actionTable.reloadData()
            let indexPath = IndexPath(row: convoHistory.items.count - 1, section: 0)
            actionTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            return false
        }
        return false
    }
    
    func didWin() -> Bool{
        if milesTraveled >= 200 {
            let distance = milesTraveled - nativesDistance
            if distance > 0 && thirst < 6 {
                convoHistory.items += [.win]
                convoHistory.conversation.append("You made is across the desert!! You've won! 🏆")
                aButton.isEnabled = false
                bButton.isEnabled = false
                cButton.isEnabled = false
                dButton.isEnabled = false
                eButton.isEnabled = false
                actionTable.reloadData()
                let indexPath = IndexPath(row: convoHistory.items.count - 1, section: 0)
                actionTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
                return true
            }
        }
        return false
    }
    
    func foundOasis() -> Bool {
        let randomNum = Int.random(in: 0..<80)
        if randomNum == 1 {
            convoHistory.items += [.computerResponse]
            convoHistory.conversation.append("Lucky you! You have found an Oasis. All your needs have been filled. 🏝")
            thirst = 0
            camelTiredness = 0
            return true
        }
        return false
    }
    
    @objc func loadList(notification: NSNotification){
        //remove data from arrays
        convoHistory.items.removeAll()
        convoHistory.conversation.removeAll()
        //reset variables
        milesTraveled = 0
        thirst = 0
        camelTiredness = 0
        nativesDistance = -20
        canteenDrinksLeft = 6
        walking = false
        //enable all buttons
        aButton.isEnabled = true
        bButton.isEnabled = true
        cButton.isEnabled = true
        dButton.isEnabled = true
        eButton.isEnabled = true
        //add intials
        convoHistory.items = [.welcomeMessage, .prompt]
        convoHistory.conversation += ["place holder for welcome message",prompt]
        //reload actionTable
        self.actionTable.reloadData()
    }
}

//****************** update actionTable w/correct cell *****************

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return convoHistory.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Switch through each cell, and implement the labels/setup for each row
        // The order of the cases is irrelevant!
        switch convoHistory.items[indexPath.row] {
        case .welcomeMessage:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MultipleChoiceTableViewCell") as! MultipleChoiceTableViewCell
            cell.mcLabel?.text = welcomeMessage
            return cell
        case .prompt:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MultipleChoiceTableViewCell") as! MultipleChoiceTableViewCell
            cell.mcLabel?.text = convoHistory.conversation[indexPath.row]
            return cell
        case .computerResponse:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MultipleChoiceTableViewCell") as! MultipleChoiceTableViewCell
            cell.mcLabel?.text = convoHistory.conversation[indexPath.row]
            return cell
        case .userChoice:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChoicesTableViewCell") as! ChoicesTableViewCell
            cell.choicesLabel?.text = convoHistory.conversation[indexPath.row]
            return cell
        case .win:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WinTableViewCell") as! WinTableViewCell
            cell.winLabel?.text = convoHistory.conversation[indexPath.row]
            return cell
        case .loss:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LossTableViewCell") as! LossTableViewCell
            cell.lossLabel?.text = convoHistory.conversation[indexPath.row]
            return cell
        }
    }
}

enum Item {
    case welcomeMessage
    case prompt
    case userChoice
    case computerResponse
    case win
    case loss
}




