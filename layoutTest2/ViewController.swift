// デリゲートを使うことで、TestView が保持している button がタップさ れたあとの処理を ViewController に移譲することができます

import UIKit

// Delegationgをプロトコルとして定義
 protocol TestViewDelegate: class {
    func testViewButtonDidTapped()
 }

// TestView
 class TestView: UIView {
    private var button: UIButton!
    weak var delegate: TestViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        button = UIButton()
        button.addTarget(self, action: #selector(buttonTapped(_:)),
                         for: .touchUpInside)
        addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
 }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        
        button.backgroundColor = UIColor.red  // 赤色
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    }
    @objc private func buttonTapped(_ sender: UIButton) {
        delegate?.testViewButtonDidTapped()
    }
 }

// ViewController
// TestView は button を保持しており、button がタップされると、デリゲートメソッド が呼ばれます。
// ViewController側でDelegateを受け取る処理は以下です。
 class ViewController: UIViewController {
    var testView: TestView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testView = TestView()
        testView.delegate = self
        view.addSubview(testView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        testView.backgroundColor = UIColor.blue  // 青色
        testView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
 }

// ViewControllerにデリゲーションプロトコルを批准させる
 extension ViewController: TestViewDelegate {
    func testViewButtonDidTapped() {
        // testview の button がタップされた
    }
 }
 
 
