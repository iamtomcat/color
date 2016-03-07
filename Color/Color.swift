//
//  Color.swift
//
//  Created by Tom Clark on 2015-04-22.
//  Copyright (c) 2015 FluidDynamics. All rights reserved.
//

#if os(iOS)
  import UIKit
  public typealias OSColor = UIColor
#else
  import Cocoa
  public typealias OSColor = NSColor
#endif

public protocol OSColorProtocol {
  var toOSColor: OSColor { get }
}

protocol ColorData {
  var toRGB: RGB { get }
  var toHSL: HSL { get }
  var toHSV: HSV { get }
}

extension Color: OSColorProtocol {
  public var toOSColor: OSColor {
    let hsv = data.toHSV
    return OSColor(hue: hsv.v, saturation: hsv.s, brightness: hsv.v, alpha: hsv.a)
  }
}

extension Color: Equatable {}

public func ==(lhs: Color, rhs: Color) -> Bool {
  return lhs.rgb == rhs.rgb
}

public struct Color {
  private let data: ColorData

  public init (h360: CGFloat, s: CGFloat, v: CGFloat, a: CGFloat=1.0) {
    let h = h360.clamp(0.0, max: 360.0) / 360.0
    self.data = HSV(h: h, s: s, v: v, a: a)
  }

  public init(h: CGFloat, s: CGFloat, v: CGFloat, a: CGFloat=1.0) {
    self.data = HSV(h: h, s: s, v: v, a: a)
  }

  public init (h360: CGFloat, s: CGFloat, l: CGFloat, a: CGFloat=1.0) {
    let h = h360.clamp(0.0, max: 360.0) / 360.0
    self.data = HSL(h: h, s: s, l: l, a: a)
  }

  public init(h: CGFloat, s: CGFloat, l: CGFloat, a: CGFloat=1.0) {
    self.data = HSL(h: h, s: s, l: l, a: a)
  }

  public init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat=1.0) {
    self.data = RGB(r: r, g: g, b: b, a: a)
  }

  public var rgb: RGB {
    return data.toRGB
  }

  public var hsl: HSL {
    return data.toHSL
  }

  public var hsv: HSV {
    return data.toHSV
  }
}
