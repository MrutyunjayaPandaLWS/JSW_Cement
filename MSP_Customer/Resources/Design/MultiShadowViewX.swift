//class PrimaryButton: UIButton {
//    
//    let cornerRadius: CGFloat = 10
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    convenience init() {
//        self.init(frame: .zero)
//        configure()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        addDropShadow()
//    }
//    
//    private func configure() {
//        backgroundColor = .white;
//        layer.cornerRadius = cornerRadius
//        
//        setTitle("Get Followers", for: .normal)
//        setTitleColor(Colours.buttonTextColour, for: .normal)
//    }
//
//    private func addDropShadow() {
//        let topLayer = createShadowLayer(color: .white, offset: CGSize(width: -6, height: -6))
//        let bottomLayer = createShadowLayer(color: .bl, offset: CGSize(width: 6, height: 6))
//        
//        layer.addSublayer(topLayer)
//        layer.addSublayer(bottomLayer)
//    }
//    
//    private func createShadowLayer(color: UIColor, offset: CGSize) -> CALayer {
//        let shadowLayer = CALayer()
//        shadowLayer.masksToBounds = false
//        shadowLayer.shadowColor = color.cgColor
//        shadowLayer.shadowOpacity = 1
//        shadowLayer.shadowOffset = offset
//        shadowLayer.shadowRadius = 10
//        shadowLayer.shouldRasterize = true
//        shadowLayer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
//        
//        return shadowLayer
//    }
//    
//}
