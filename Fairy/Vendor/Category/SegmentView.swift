//
//  SegmentView.swift
//  Icncde
//
//  Created by dssj on 2020/6/5.
//  Copyright © 2020 dssj. All rights reserved.
//

import Segmentio

extension Segmentio {
    
    static func initWithTitles(titles:[String],frame:CGRect) -> Segmentio {
        let segmet = Segmentio.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 44))
        segmet.selectedSegmentioIndex = 0
        
        //
        var content = [SegmentioItem]()
        for title in titles {
            let item = SegmentioItem(
                title: title,
                image: nil
            )
            content.append(item)
        }
        
        //
        let indicatorOptions = SegmentioIndicatorOptions(type: .bottom, ratio: 0.4, height: 2, color: ThemeColorBlue)
        
        //
        let normal = SegmentioState(backgroundColor: .clear, titleFont: .systemFont(ofSize: 15), titleTextColor: ThemeColorBlack, titleAlpha: 1.0)
        let select = SegmentioState(backgroundColor: .clear, titleFont: .systemFont(ofSize: 18), titleTextColor: ThemeColorBlue, titleAlpha: 1.0)
        let state = SegmentioStates(defaultState: normal,selectedState: select,highlightedState: select)
        
        let options = SegmentioOptions(
            backgroundColor: .clear,
            segmentPosition: SegmentioPosition.dynamic,
            scrollEnabled: true,
            indicatorOptions: indicatorOptions,
            horizontalSeparatorOptions: nil,
            verticalSeparatorOptions: nil,
            imageContentMode: .center,
            labelTextAlignment: .center,
            segmentStates: state
        )
        
        segmet.setup(content: content, style: SegmentioStyle.onlyLabel, options: options)
        
        return segmet
    }
    
}
