import Foundation

/// The type of message
enum MessageType {
    case prompt
    case answer
}

/// A conversation entry made by the user of the app
struct Message {
    //let date: Date
    let text: String
    let type: MessageType
}

/// The welcoming text to display to open the conversation
let openingLine = Message(text: "Welcome to Camel Game!", type: .prompt)
