//
//  ViewController.swift
//  BHomeWork
//
//  Created by Oh june Kwon on 2021/09/14.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


class ViewController: UIViewController {
    
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var viewChartParent: UIView!
    
    let disposeBag = DisposeBag()
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        // 과제 A
        buttonA.addTarget(self, action: #selector(doWorkA), for: .touchUpInside)
        
        // 과제 B
        self.buttonB.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.doWorkB()
        }).disposed(by: self.disposeBag)
        
        self.buttonC.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.doWorkC()
        }).disposed(by: self.disposeBag)
        
    }
    
    @objc func doWorkA() {
        let listener: ((String?, Error?) -> Void) = { [weak self] str, error in
            print("listener \(str)")
        }
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 2
        let op1 = self.viewModel.getResult(url: .firstUrl, completion: listener)
        let op2 = self.viewModel.getResult(url: .secondUrl, completion: listener)
        let final = BlockOperation() {
            DispatchQueue.main.async {
                print("1234")
                self.viewModel.presentAlert(vc: self)
            }
            
        }
        final.addDependency(op1)
        final.addDependency(op2)
        queue.addOperations([op1, op2], waitUntilFinished: true)
        queue.addOperation(final)
    }
    
    func doWorkB() {
        let work1 = self.viewModel.getNetworkResult(url: .firstUrl)
        let work2 = self.viewModel.getNetworkResult(url: .secondUrl)
        Observable.combineLatest(work1, work2).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.presentAlert(vc: self)
        }).disposed(by: self.disposeBag)
        
    }
    
    
    func doWorkC() {
        let items = [ CoinModel(coinName: "비트코인", coinShare: 20.0, coinColor: "#FF0000"),
                      CoinModel(coinName: "이더리움", coinShare: 30.0, coinColor: "#00FF00"),
                      CoinModel(coinName: "리플", coinShare: 40.0, coinColor: "#0000FF"),
                      CoinModel(coinName: "이오스", coinShare: 10.0, coinColor: "#FFFF00") ]
        let view = self.viewModel.createPieChart(items: items)
        
        self.viewChartParent.subviews.forEach{ $0.removeFromSuperview() }
        self.viewChartParent.addSubview(view)
        view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
    }


}

