import UIKit

class FrameView: UIView {

//  lazy var label: UILabel = self.makeLabel()
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
    selectedImageView.image = Config.Grid.SelectedImage.ImageIcon
    addSubview(selectedImageView)
  }

  // MARK: - Layout

  override func layoutSubviews() {
    super.layoutSubviews()
    selectedImageView.center = self.center
  }

  // MARK: - Controls

//  private func makeLabel() -> UILabel {
//    let label = UILabel()
//    label.font = Config.Font.Main.regular//.withSize(40)
//    label.textColor = UIColor.white
//
//    return label
//  }
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
