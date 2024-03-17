//
//  NetworkMonitorSwiftUIView.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 23/02/2024.
//

import SwiftUI
import MBCore
import Network


class NetworkMonitor : ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    @Published var isActive = false
    @Published var isExpensive = false
    @Published var isConstrained = false
    @Published var connectionType = NWInterface.InterfaceType.other
    
    init(){
        monitor.pathUpdateHandler = {path in
            DispatchQueue.main.async {
                self.isActive = path.status == .satisfied
                self.isExpensive = path .isExpensive
                self.isConstrained = path.isConstrained
                
                let connectionType:[NWInterface.InterfaceType] = [.cellular,.wifi,.wiredEthernet]
                self.connectionType = connectionType.first(where: path.usesInterfaceType) ?? .other
                
                
            }
        }
        monitor.start(queue: queue)
    }
    
}

struct NetworkMonitorSwiftUIView: View {
    
    @StateObject private var networkManager = NetworkMonitor()
    
    var body: some View {
        VStack(alignment: .leading){
            Text(verbatim: "Connected : \(networkManager.isActive)")
            Text(verbatim: "Low Data Mode : \(networkManager.isConstrained)")
            Text(verbatim: "Mobile Data / Hotspot : \(networkManager.isExpensive)")
            Text(verbatim: "Type : \(networkManager.connectionType)")
        }
    }
}

#Preview {
    NetworkMonitorSwiftUIView()
}
