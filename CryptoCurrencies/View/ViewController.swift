
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var highlightedCollectionView: UICollectionView!
    private var cryptoListViewModel: CryptoListViewModel!
    private var cryptoFeaturedViewModel: CryptoFeaturedViewModel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sloganLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.highlightedCollectionView.delegate = self
        self.highlightedCollectionView.dataSource = self
        
        getData()
        getFeaturedData()
    
        }
   
    
 private func getData() {
    
    // API KEY
          
     let url = URL(string: "https://api.nomics.com/v1/exchange-rates?key=b0380e9e0acbdd60c579c95f1b7dfa78")!
    
     Webservice().downloadCurrencies(url: url) { cryptos in
         
         if let cryptos = cryptos {
             
             self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
             
             DispatchQueue.main.async {
                 self.tableView.reloadData()
             }
         }
     }
     
 }
    
    private func getFeaturedData() {
       
       // API KEY
             
        let url = URL(string: "https://api.nomics.com/v1/exchange-rates?key=b0380e9e0acbdd60c579c95f1b7dfa78")!
       
        
        WebserviceFeatured().downloadCurrenciesDetails(url: url) { cryptos in
            
            if let cryptos = cryptos {
                
                self.cryptoFeaturedViewModel = CryptoFeaturedViewModel(cryptoCurrencyFeatured: cryptos)
                
                DispatchQueue.main.async {
                    self.highlightedCollectionView.reloadData()
                }
            }
        }
        
    }
    
 
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
 }
 
 
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
     
     let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
     
     cell.priceText.text = cryptoViewModel.name
     cell.currencyText.text = cryptoViewModel.price

     return cell
 }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
       return self.cryptoFeaturedViewModel == nil ? 0 : self.cryptoFeaturedViewModel.numberOfRowsInSection()
        
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let detailCell = highlightedCollectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as! CryptoCollectionViewCell
        
        let cryptoFeaturedViewModel = self.cryptoFeaturedViewModel.cryptoAtIndex(indexPath.row)
        
        
        detailCell.detailCurrency.text = cryptoFeaturedViewModel.name
        detailCell.detailRate.text = cryptoFeaturedViewModel.price
        
           return detailCell
           
       }
    
}

