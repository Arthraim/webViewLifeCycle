//
//  ViewController.swift
//  webViewLifeCycle
//
//  Created by Xuyang Wang on 2018/8/29.
//  Copyright © 2018 Xuyang Wang. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var webView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        let config = WKWebViewConfiguration()
        config.userContentController = WKUserContentController()
        config.userContentController.addUserScript(WKUserScript(source: "console.warn('WKUserScript atDocumentStart')", injectionTime: .atDocumentStart, forMainFrameOnly: true))
        config.userContentController.addUserScript(WKUserScript(source: "console.warn('WKUserScript atDocumentEnd')", injectionTime: .atDocumentEnd, forMainFrameOnly: true))

        webView = WKWebView(frame: view.frame, configuration: config)
        webView?.navigationDelegate = self

        let url = Bundle.main.url(forResource: "demo", withExtension: "html")!
        webView?.loadFileURL(url, allowingReadAccessTo: url)

        view.addSubview(webView!)
    }

}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        webView.evaluateJavaScript("console.warn('webView:(_:didCommit:)')", completionHandler: nil)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webView.evaluateJavaScript("console.warn('webView:(_:didFail:)')", completionHandler: nil)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("console.warn('webView:(_:didFinish:)')", completionHandler: nil)
    }
}
