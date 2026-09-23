import SwiftUI

@main
struct AminoBarApp: App {
    var body: some Scene {
        MenuBarExtra("AminoBar", systemImage: "testtube.2") {
            AminoPanel()
                .frame(width: 380)
                .padding(.vertical, 8)

            Divider()

            SettingsLink {
                Text("About AminoBar…")
            }

            Button("Quit AminoBar") {
                NSApplication.shared.terminate(nil)
            }
        }
        .menuBarExtraStyle(.window)

        Settings {
            AboutView()
                .frame(width: 420, height: 260)
        }
        .commands {
            CommandGroup(replacing: .find) {
                Button("Focus Search", action: FocusSearchCenter.shared.focusSearch)
                    .keyboardShortcut("f", modifiers: [.command])
            }
        }
    }
}
