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
              
       if let url = Bundle.main.url(forResource: name, withExtension: "png") {
          let data = try! Data(contentsOf: url)
          webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
          )
          webView.scrollView.isScrollEnabled = false
          return webView
       } else {
          let url = Bundle.main.url(forResource: name, withExtension: "gif")!
          let data = try! Data(contentsOf: url)
          webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
          )
          webView.scrollView.isScrollEnabled = false
          return webView
       }
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }

}


struct GifImage_Previews: PreviewProvider {
    static var previews: some View {
        GifImage("pokeball")
    }
}
