//
//  AwardsAndCertificationsModel.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/02/2024.
//

import Foundation


public struct  AwardsAndCertificationsModel : Identifiable,Equatable,Hashable {
   public var        id: String = UUID().uuidString
    public let     title:String
    public let     description:String
    public let    date:String
    public let    image:String
}

public let     listOfAwardsAndCertificationsModel = [
    AwardsAndCertificationsModel(title: "Red hat", description: "Ready partner", date: "2019-2020", image: "redhat-partner"),
    AwardsAndCertificationsModel(title: "Oracle Gold Partner", description: "Partner Network", date: "2019", image: "oracle-partner"),
    AwardsAndCertificationsModel(title: "Digital Tech Excellence Awards", description: "Best digital banking solutions providers", date: "2019", image: "digital-tech-award"),
    AwardsAndCertificationsModel(title: "Key Partner Annual Bankers Conference", description: "Appreciation Award from Uganda Bankers Association", date: "2019", image: "abc-key-partner"),
    AwardsAndCertificationsModel(title: "PCI DSS compliant", description: "Certificate of compliance", date: "2020", image: "pci-dss"),
    AwardsAndCertificationsModel(title: "Microsoft Dynamics Industry", description: "Partner of the Year", date: "2020", image: "ms-award"),
]
