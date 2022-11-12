//
//  GifImage.swift
//  bonsai
//
//  Created by antuan.khoanh on 15/09/2022.
//


import SwiftUI
import WebKit

// thanks to https://github.com/pitt500/GifView-SwiftUI

struct GifImage: UIViewRepresentable {
    private let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        webView.isUserInteractionEnabled = false
        webView.scrollView.isScrollEnabled = false
        loadGif(webView: webView)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        loadGif(webView: uiView)
        uiView.reload()
    }
    
    private func loadGif(webView: WKWebView) {
        if let url = Bundle.main.url(forResource: name, withExtension: "png") {
            let data = try! Data(contentsOf: url)
            webView.load(
                data,
                mimeType: "image/gif",
                characterEncodingName: "UTF-8",
                baseURL: url//.deletingLastPathComponent()
            )
        } else {
            let url = Bundle.main.url(forResource: name, withExtension: "gif")!
            let data = try! Data(contentsOf: url)
            webView.load(
                data,
                mimeType: "image/gif",
                characterEncodingName: "UTF-8",
                baseURL: url//.deletingLastPathComponent()
            )
        }
    }
}


struct GifImage_Previews: PreviewProvider {
    static var previews: some View {
        GifImage("pokeball")
    }
}
