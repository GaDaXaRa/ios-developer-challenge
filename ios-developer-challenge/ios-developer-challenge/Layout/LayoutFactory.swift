//
//  LayoutFactory.swift
//  ios-developer-challenge
//
//  Created by Miguel Santiago Rodríguez on 7/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

class LayoutFactory: NSObject {

    static func listLayout() -> UICollectionViewFlowLayout {
        let margins: CGFloat = 40.0
        let spacing: CGFloat = 20.0
        let numRows = 4
        let aspectRatio: CGFloat = 100/150
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: margins, left: margins, bottom: margins, right: margins)
        let itemHeight = (UIScreen.main.bounds.height - spacing * CGFloat(numRows) - 2 * margins) / CGFloat(numRows)
        let itemWidth = itemHeight * aspectRatio
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
