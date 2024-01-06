//
//  NibWrapperView.swift
//  iOS-Test
//
//  Created by Anton Mazur on 06.01.2024.
//

import UIKit

@propertyWrapper 
struct NibWrapped<T: UIView> {
    init(_ type: T.Type) { }
    var wrappedValue: UIView!
    var unwrapped: T { (wrappedValue as! NibWrapperView<T>).contentView }
}

class NibWrapperView<T: UIView>: UIView {
    var contentView: T
    
    required init?(coder: NSCoder) {
        contentView = T.loadFromNib()
        super.init(coder: coder)
        prepareContentView()
    }
    
    override init(frame: CGRect) {
        contentView = T.loadFromNib()
        super.init(frame: frame)
        prepareContentView()
    }
    
    private func prepareContentView() {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        contentView.prepareForInterfaceBuilder()
    }
}
