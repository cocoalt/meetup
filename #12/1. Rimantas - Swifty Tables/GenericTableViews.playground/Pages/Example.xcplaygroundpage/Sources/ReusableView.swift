import UIKit

public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public protocol NibLoadable: class {
    static var nib: UINib { get }
}

public extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

public typealias NibReusable = Reusable & NibLoadable

public extension UITableView {
    func register<T: UITableViewCell>(_: T) where T: NibReusable {
        self.register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: Reusable {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
           fatalError("Failed to dequeue a cell with identifier \(T.reuseIdentifier)")
        }

        return cell
    }
}
