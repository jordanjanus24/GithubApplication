//
//  DetailsViewController.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/4/23.
//

import SwiftUI

class DetailsViewController: UIHostingController<DetailsView>, Storyboarded {
    
    var viewModel: DetailsViewModelProtocol!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView:
            DetailsView()
        )
    }
}
