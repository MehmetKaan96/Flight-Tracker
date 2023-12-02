//
//  MiniDetailPage.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 2.12.2023.
//

import UIKit
import SnapKit
import MapKit

class MiniDetailPage: UIView {
    lazy var mapView = MKMapView()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
            layoutViews()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupViews()
            layoutViews()
        }

        private func setupViews() {
            mapView.mapType = .standard
            mapView.isZoomEnabled = true
            mapView.isScrollEnabled = true
            addSubview(mapView)
            
        }

        private func layoutViews() {
            // SnapKit kütüphanesiyle arayüz elemanlarını düzenle
            mapView.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
            }
        }
}
