import Foundation

struct CryptoFeaturedViewModel {
    let cryptoCurrencyFeatured: [CryptoCurrencyDetail]
    
    func numberOfRowsInSection() -> Int {
         return self.cryptoCurrencyFeatured.count
     }
     
    func cryptoAtIndex(_ index: Int) -> CryptoViewModelFeatured {
            let crypto = self.cryptoCurrencyFeatured[index]
            return CryptoViewModelFeatured(crypto)
        }
    
}

struct CryptoViewModelFeatured {
    let CryptoCurrencyDetail: CryptoCurrencyDetail
    
    init(_ crypto: CryptoCurrencyDetail) {
        self.CryptoCurrencyDetail = crypto
    }
    
    var name: String {
        return self.CryptoCurrencyDetail.currency
    }
    
    var price: String {
        return self.CryptoCurrencyDetail.rate
        
    }
}



