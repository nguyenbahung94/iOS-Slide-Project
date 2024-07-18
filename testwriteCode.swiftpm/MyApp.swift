import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
func testApp(firstNumber: Int, secondNumber: Int) -> Int {
  return firstNumber + secondNumber
}
