//
//  ViewModel.swift
//  BHomeWork
//
//  Created by Oh june Kwon on 2021/09/14.
//

import Foundation
import RxSwift
import Alamofire


enum ApiString: String  {
    case firstUrl = "https://www.googleapis.com/youtube/v3/search?&videoType=any&videoDefinition=any&part=snippet&videoDimension=any&type=video&videoDuration=any&maxResults=10&language=kr&q=RxSwift&key=AIzaSyAvrOqByyRs8L_iEQ_sNhwsGXaXYXViCNc"
    case secondUrl =  "https://www.googleapis.com/youtube/v3/search?&videoType=any&videoDefinition=any&part=snippet&videoDimension=any&type=video&videoDuration=any&maxResults=10&language=kr&q=ReactorKit&key=AIzaSyAvrOqByyRs8L_iEQ_sNhwsGXaXYXViCNc"
    
}

protocol ViewModelProtocol : AnyObject
{
    func getResult(url: ApiString, completion: @escaping (String?, Error?) -> Void) -> AsyncBlockOperation
    func getNetworkResult(url: ApiString) -> Observable<String>
    func presentAlert(vc: UIViewController)
    func createPieChart(items: [CoinModel]) -> UIView
}

class ViewModel : ViewModelProtocol {
    
    func presentAlert(vc: UIViewController) {
        let alert = UIAlertController(title: nil, message: "Hello World!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    func getResult(url: ApiString, completion: @escaping (String?, Error?) -> Void) -> AsyncBlockOperation {
        let block = AsyncBlockOperation() { operation in
            operation.state = .executing
            guard let destination = URL(string: url.rawValue) else { return }
            URLSession.init(configuration: .default)
                .dataTask(with: URLRequest.init(url: destination), completionHandler: { data, response, error in
                    operation.state = .finished
                    if error != nil {
                        completion(nil, error)
                    } else {
                        guard let d = data else { return }
                        completion( String(data: d, encoding: .utf8), nil)
                    }
            }).resume()
            
        }
        return block
        
    }
    
    func getNetworkResult(url: ApiString) -> Observable<String> {
        return Observable.create { obs -> Disposable in
            AF.request( url.rawValue, method: .get ).responseJSON { response in
                
                if let error = response.error {
                    obs.onError(error)
                } else {
                    if let data = response.data {
                        let value = String(data: data, encoding: .utf8) ?? ""
                        print("value : \(value)")
                        obs.onNext(value)
                        obs.onCompleted()
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func createPieChart(items: [CoinModel]) -> UIView {
        return PieChartView(frame: .zero).update(items)
    }
    
}


