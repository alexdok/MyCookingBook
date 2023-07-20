
import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var url = "https://journal.tinkoff.ru/chto-poest/"
    var progressView = UIProgressView()
    var webView = WKWebView(frame: CGRect(origin: .zero, size: .zero))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        self.progressView.progress = 0
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.estimatedProgress),
                            options: .new,
                            context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    private func setupUI() {
        webView.frame.size.width = view.frame.width
        webView.frame.size.height = view.frame.height

        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        webView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.heightAnchor.constraint(equalToConstant: 5),
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            progressView.leadingAnchor.constraint(equalTo: webView.leadingAnchor, constant: 5),
            progressView.trailingAnchor.constraint(equalTo: webView.trailingAnchor, constant: -5)
        ])
    }
    
     func showProgressView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.alpha = 1
        }, completion: nil)
    }
    
     func hideProgressView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.alpha = 0
        }, completion: nil)
    }
}
