//
//  ItemDetailsViewController.swift
//  AbdoEl7aty
//
//  Created by mac on 2/25/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit

protocol ItemDetailsViewControllerProtocols :AnyObject{
    
    func setPresenter(presenter:ItemDetailsPresenterController)

}


class ItemDetailsViewController: UIViewController, ItemDetailsViewControllerProtocols{
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDes: UITextView!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    private var presenter: ItemDetailsPresenterController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        itemNameLabel.text = presenter?.getItem().name
        itemPriceLabel.text = "$\(presenter?.getItem().price.description ?? "")"
    }
    
    
    @IBAction func addToOrderButtonPressed(_ sender: UIButton) {
        presenter?.addItem()
    }
    
    func setPresenter(presenter: ItemDetailsPresenterController) {
        self.presenter = presenter
    }
  
}
