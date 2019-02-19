/*
 The MIT License (MIT)

 Copyright (c) 2019 Ugur Kilic All rights reserved.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

public enum FlatColor: CaseIterable {
    case turquoise, greenSea, emerald,
    nephritis, peterRiver, belizeHole,
    amethyst, wisteria, wetAsphalt,
    midnightBlue, sunflower, carrot,
    pumpkin, alizarin, pomergranate,
    clouds, silver, concrete, asbestos

    public static var random: UIColor? {
        return FlatColor.allCases.shuffled().first?.value
    }

    public var value: UIColor {
        switch self {
        case .turquoise:
            return UIColor(red: 26, green: 188, blue: 156)
        case .greenSea:
            return UIColor(red: 22, green: 160, blue: 133)
        case .emerald:
            return UIColor(red: 46, green: 204, blue: 113)
        case .nephritis:
            return UIColor(red: 39, green: 174, blue: 96)
        case .peterRiver:
            return UIColor(red: 52, green: 152, blue: 219)
        case .belizeHole:
            return UIColor(red: 41, green: 128, blue: 185)
        case .amethyst:
            return UIColor(red: 155, green: 89, blue: 182)
        case .wisteria:
            return UIColor(red: 142, green: 68, blue: 173)
        case .wetAsphalt:
            return UIColor(red: 52, green: 73, blue: 94)
        case .midnightBlue:
            return UIColor(red: 44, green: 62, blue: 80)
        case .sunflower:
            return UIColor(red: 241, green: 196, blue: 15)
        case .carrot:
            return UIColor(red: 230, green: 126, blue: 34)
        case .pumpkin:
            return UIColor(red: 211, green: 84, blue: 0)
        case .alizarin:
            return UIColor(red: 231, green: 76, blue: 60)
        case .pomergranate:
            return UIColor(red: 192, green: 57, blue: 43)
        case .clouds:
            return UIColor(red: 236, green: 240, blue: 241)
        case .silver:
            return UIColor(red: 189, green: 195, blue: 199)
        case .concrete:
            return UIColor(red: 149, green: 165, blue: 166)
        case .asbestos:
            return UIColor(red: 127, green: 140, blue: 141)
        }
    }
}

extension UIColor {

    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: 1.0)
    }
}
