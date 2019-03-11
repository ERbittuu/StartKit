//
//  UIStoryboard+UIViewController.swift
//  newproj
//
//  Created by CURRENTUSER on 3/7/19.
//  Copyright © 2019 ORGNAME. All rights reserved.
//

import Foundation

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable { }

let bundle: Bundle? = nil

extension UIStoryboard {

    /// The uniform place where we state all the storyboard we have in our application

    enum Storyboard: String {
        case main       = "Main"
        var filename: String {
            return rawValue
        }
    }

    // MARK: - Convenience Initializers

    convenience init(storyboard: Storyboard) {
        self.init(name: storyboard.filename, bundle: bundle)
    }

    // MARK: - Class Functions

    class func storyboard(_ storyboard: Storyboard) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }

    // MARK: - View Controller Instantiation from Generics

    func instantiate<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }

        return viewController
    }
}

// usage
//let viewController: ArticleViewController = UIStoryboard(storyboard: .news).instantiateViewController()
