import SwiftUI

@main
struct AminoBarApp: App {
    var body: some Scene {
        MenuBarExtra("AminoBar", systemImage: "testtube.2") {
            AminoMenu()
        }
        .menuBarExtraStyle(.window)

        Window("About AminoBar", id: "about") {
            AboutView()
                .frame(width: 420, height: 260)
        }
        .defaultPosition(.center)
        .defaultSize(width: 420, height: 260)
        .commands {
            CommandGroup(replacing: .find) {
                Button("Focus Search", action: FocusSearchCenter.shared.focusSearch)
                    .keyboardShortcut("f", modifiers: [.command])
            }
        }
    }
}

private struct AminoMenu: View {
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        AminoPanel()
            .frame(width: 380)
            .padding(.vertical, 8)
        Divider()
        Button("About AminoBar…") { openWindow(id: "about") }
        Button("Quit AminoBar") { NSApplication.shared.terminate(nil) }
    }
}
