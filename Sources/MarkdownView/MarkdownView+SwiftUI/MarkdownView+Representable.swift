//
//  MarkdownView+Representable.swift
//  MarkdownView
//
//  Created by 秋星桥 on 2026/2/1.
//

import SwiftUI

#if canImport(UIKit)
    import UIKit

    struct MarkdownViewRepresentable: UIViewRepresentable, MarkdownViewRepresentableBase {
        let contentSource: MarkdownView.ContentSource
        let theme: MarkdownTheme
        let isStreaming: Bool?

        func makeUIView(context _: Context) -> MarkdownTextView {
            createMarkdownTextView()
        }

        func updateUIView(_ uiView: MarkdownTextView, context: Context) {
            updateMarkdownTextView(uiView, coordinator: context.coordinator)
        }

        // iOS 16+ 的测量协议。iOS 15 上 SwiftUI 没有 sizeThatFits，走
        // MarkdownTextView 的 intrinsicContentSize（内容重建时主动失效）。
        @available(iOS 16.0, *)
        func sizeThatFits(
            _ proposal: ProposedViewSize,
            uiView: MarkdownTextView,
            context: Context,
        ) -> CGSize? {
            context.coordinator.sizeThatFits(proposal, for: uiView)
        }

        func makeCoordinator() -> MarkdownViewCoordinator {
            MarkdownViewCoordinator()
        }
    }

#elseif canImport(AppKit)
    import AppKit

    struct MarkdownViewRepresentable: NSViewRepresentable, MarkdownViewRepresentableBase {
        let contentSource: MarkdownView.ContentSource
        let theme: MarkdownTheme
        let isStreaming: Bool?

        func makeNSView(context _: Context) -> MarkdownTextView {
            createMarkdownTextView()
        }

        func updateNSView(_ nsView: MarkdownTextView, context: Context) {
            updateMarkdownTextView(nsView, coordinator: context.coordinator)
        }

        func sizeThatFits(
            _ proposal: ProposedViewSize,
            nsView: MarkdownTextView,
            context: Context,
        ) -> CGSize? {
            context.coordinator.sizeThatFits(proposal, for: nsView)
        }

        func makeCoordinator() -> MarkdownViewCoordinator {
            MarkdownViewCoordinator()
        }
    }
#endif
