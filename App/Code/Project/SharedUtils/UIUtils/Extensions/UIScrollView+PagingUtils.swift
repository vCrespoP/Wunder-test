import UIKit

public extension UIScrollView {
    public var numPages: CGSize {
        guard self.bounds.size.width > 0 && self.bounds.size.height > 0 else { return CGSize.zero }

        return CGSize(width: self.contentSize.width/self.bounds.size.width, height: self.contentSize.height/self.bounds.size.height)
    }

    public func offset(page: CGFloat) -> CGPoint {
        if self.numPages.width > 1 {
            return CGPoint(x: self.bounds.size.width*page, y: 0)
        }
        else {
            return CGPoint(x: 0, y: self.bounds.size.height*page)
        }
    }

    public var currentPage: CGFloat {
        guard self.numPages.width > 0 || self.numPages.height > 0 else { return 0 }

        if self.numPages.width > 1 {
            return self.contentOffset.x/self.bounds.size.width
        }
        else {
            return self.contentOffset.y/self.bounds.size.height
        }
    }
}

