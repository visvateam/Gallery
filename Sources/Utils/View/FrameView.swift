import UIKit

class FrameView: UIView {

  lazy var label: UILabel = self.makeLabel()
//  lazy var gradientLayer: CAGradientLayer = self.makeGradientLayer()
  lazy var selectedImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Config.Grid.SelectedImage.Width, height: Config.Grid.SelectedImage.Height))
    
  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  private func setup() {
    selectedImageView.layer.addSublayer(makeShareLayer())
    addSubview(selectedImageView)
    selectedImageView.g_pinCenter()
    
    addSubview(label)
    label.g_pinCenter()
  }

  // MARK: - Layout

  override func layoutSubviews() {
    super.layoutSubviews()
    selectedImageView.center = self.center
  }

  // MARK: - Controls

    private func makeShareLayer() -> CAShapeLayer {
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: CGFloat(Config.Grid.SelectedImage.CircleRadius), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = Config.Grid.SelectedImage.CircleFillColor.cgColor
        
        return shapeLayer
    }
    
  private func makeLabel() -> UILabel {
    let label = UILabel()
    label.font = Config.Font.Main.regular//.withSize(40)
    label.textColor = UIColor.white

    return label
  }
//
//  private func makeGradientLayer() -> CAGradientLayer {
//    let layer = CAGradientLayer()
//    layer.colors = [
//      Config.Grid.FrameView.fillColor.withAlphaComponent(0.25).cgColor,
//      Config.Grid.FrameView.fillColor.withAlphaComponent(0.4).cgColor
//    ]
//
//    return layer
//  }
}
