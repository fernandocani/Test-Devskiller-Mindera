//
//  CertificateHandler.swift
//  Devskiller
//
//  Created by Fernando Cani on 11/11/2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import Foundation

enum CertificateError: LocalizedError {
    case fileNotFound
    case failedToLoadCertificateData
    case failedToCreateSecCertificate
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Certificate file not found in the bundle."
        case .failedToLoadCertificateData:
            return "Failed to load certificate data."
        case .failedToCreateSecCertificate:
            return "Failed to create SecCertificate from data."
        }
    }
}

struct CertificateHandler {
    private init() { }
    
    static let shared = CertificateHandler()
    
    private func loadCertificate() throws -> SecCertificate {
        guard let certificateURL = Bundle.main.url(forResource: "certificate", withExtension: "cer") else {
            throw CertificateError.fileNotFound
        }
        do {
            let certificateData = try Data(contentsOf: certificateURL)
            guard let certificate = SecCertificateCreateWithData(nil, certificateData as CFData) else {
                throw CertificateError.failedToCreateSecCertificate
            }
            return certificate
        } catch {
            throw CertificateError.failedToLoadCertificateData
        }
    }
    
    func createSessionWithCertificate() async throws -> URLSession {
        let certificate = try self.loadCertificate()
        let sessionConfig = URLSessionConfiguration.default
        let delegate = URLSessionDelegateImplementation(certificate: certificate)
        return URLSession(configuration: sessionConfig, delegate: delegate, delegateQueue: nil)
    }
    
    private class URLSessionDelegateImplementation: NSObject, URLSessionDelegate {
        private let certificate: SecCertificate
        
        init(certificate: SecCertificate) {
            self.certificate = certificate
        }
        
        func urlSession(_ session: URLSession,
                        didReceive challenge: URLAuthenticationChallenge,
                        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust, let serverTrust = challenge.protectionSpace.serverTrust {
                let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0)
                if serverCertificate == self.certificate {
                    let credential = URLCredential(trust: serverTrust)
                    completionHandler(.useCredential, credential)
                } else {
                    completionHandler(.cancelAuthenticationChallenge, nil)
                }
            } else {
                completionHandler(.performDefaultHandling, nil)
            }
        }
    }
}
