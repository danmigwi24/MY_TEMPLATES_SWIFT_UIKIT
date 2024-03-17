import SwiftUI
import MBCore
import MessageUI
import UIKit


struct MailComposeUIViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = MFMailComposeViewController
    
    @Binding var isShowing: Bool
    let recipientEmail: String
    let subject: String
    let body: String
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailViewController = MFMailComposeViewController()
        mailViewController.mailComposeDelegate = context.coordinator
        mailViewController.setToRecipients([recipientEmail])
        mailViewController.setSubject(subject)
        mailViewController.setMessageBody(body, isHTML: false)
        return mailViewController
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool
        
        init(isShowing: Binding<Bool>) {
            _isShowing = isShowing
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            isShowing = false
        }
    }
}

