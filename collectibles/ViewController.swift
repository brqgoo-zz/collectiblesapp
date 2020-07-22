//
//  ViewController.swift
//  collectibles
//
//  Created by Burak Keceli on 14.07.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit
import CoreNFC
import web3swift
import Network
import BigInt
import CryptoKit

struct Wallet {
    let address: String
    let data: Data
    let name: String
    let isHD: Bool
}

struct HDKey {
    let name: String?
    let address: String
}

class ViewController: UIViewController, NFCNDEFReaderSessionDelegate {
    
    var Userwallet = Wallet(address: "", data: Data(), name: "", isHD: false)
    var userPrivateKeyStr = ""
    var selectedModel:Int = 0
    var collectiblesArray = [[String: Any]]()
    let addCredentialButton = UIButton()
    @IBOutlet weak var CollectiblesTableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        addCredentialButton.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //mint
        /*
        
        var mintuserPrivateKeyStr = "3ecfb7baa9e197062355eca3bef24a04aec308176dd32d2e9597df52d9442330"
        
        let mintkeystore = try! EthereumKeystoreV3(privateKey: Data.fromHex(mintuserPrivateKeyStr)!, password: "")!
        let mintkeyData = try! JSONEncoder().encode(EthereumKeystoreV3(privateKey: Data.fromHex(mintuserPrivateKeyStr)!, password: "")!.keystoreParams)
        let mintkeystoreManager = KeystoreManager([mintkeystore])
        let mintETHAddress = mintkeystore.addresses!.first!.address
        
        let web3 = Web3.InfuraMainnetWeb3()
        web3.addKeystoreManager(mintkeystoreManager)
        
        let value: String = "0.0" // In Ether
           let toAddress = EthereumAddress("0x0000000000b3f879cb30fe243b4dfee438691c04")!
              let contract = web3.contract(Web3.Utils.coldWalletABI, at: toAddress, abiVersion: 2)!
              let amount = Web3.Utils.parseToBigUInt(value, units: .eth)
              var options = TransactionOptions.defaultOptions
              options.value = amount
              options.from = EthereumAddress(mintETHAddress)!
           options.gasPrice = .manual(45000000000)
           options.gasLimit = .manual(40000)
              
              let tx = contract.write(
                  "fallback",
                  parameters: [AnyObject](),
                  extraData: Data(hex: "a0712d680000000000000000000000000000000000000000000000000000000000000001"),

                  
                  transactionOptions: options)!
              
           var TXResult:TransactionSendingResult
           
               TXResult = try! tx.send(password: "")
               
                print("TXResult HASH")
                 print(TXResult.hash)
        
        
        
        
        
        
        
        
        
        */
        
        
        //mint
        
        
        
        
        if UserDefaults.standard.object(forKey: "collectiblesArrayKey") != nil{
            
            collectiblesArray = UserDefaults.standard.object(forKey: "collectiblesArrayKey") as! [[String : Any]]
            
        }
        /////////
        if UserDefaults.standard.object(forKey: "UserPrivateKey") != nil{
            
            userPrivateKeyStr = UserDefaults.standard.object(forKey: "UserPrivateKey") as! String
            
            print("userPrivateKeyStr is")
            print(userPrivateKeyStr)
            
        }
        else {
            
            let randomIntStr = String(Int.random(in: 0 ..< 9999999)*Int.random(in: 0 ..< 9999999)) + String(Int.random(in: 0 ..< 9999999)*Int.random(in: 0 ..< 9999999))
            userPrivateKeyStr = SHA256.hash(data: Data(randomIntStr.utf8)).map { String(format: "%02hhx", $0) }.joined()
            
            
            
            UserDefaults.standard.set(userPrivateKeyStr, forKey: "UserPrivateKey")
            
            print("new userPrivateKeyStr is")
            print(userPrivateKeyStr)
            
            
        }
        
       
         
         let Userkeystore = try! EthereumKeystoreV3(privateKey: Data.fromHex(userPrivateKeyStr)!, password: "")!
         let UserkeyData = try! JSONEncoder().encode(EthereumKeystoreV3(privateKey: Data.fromHex(userPrivateKeyStr)!, password: "")!.keystoreParams)
         let UserkeystoreManager = KeystoreManager([Userkeystore])
         let UserETHAddress = Userkeystore.addresses!.first!.address
         
         Userwallet = Wallet(address: UserETHAddress, data: UserkeyData, name: "User", isHD: false)

         
        print("UserETHAddress is")
        print(Userwallet.address)
        
        
        
        
        
        
        
 
        title = "My Collectibles"
        
        print("start")
        
        /*
         Guide.ERC20_token_guide
         
         
         let token = ERC721("0x45245bc59219eeaaf6cd3f382e078a461ff9de7b")
         
         
         print("tokenaddresis")
         print(token.transfer(from: "0xe64b7fc9419c1ed5c4a34294dfbcf57ca8e31408", to: "0x45245bc59219eeaAF6cD3f382e078A461FF9De7B", token: BigUInt))
         
         
         
         // balance in wei
         
         // prints: 39824500 BKX
         let address: Address = "0x6a6a0b4aaa60E97386F94c5414522159b45DEdE8"
         let token = ERC20("0x45245bc59219eeaaf6cd3f382e078a461ff9de7b")
         let from: Address = Web3.default.keystoreManager.addresses[0]
         let to: Address = "0x6a6a0b4aaa60E97386F94c5414522159b45DEdE8"
         
         // Sending 0.05 BKX
         let amount = NaturalUnits("0.05")
         
         token.options.from = from
         let transaction = try token.transfer(to: to, amount: amount)
         print(transaction.hash)
         
         */
        
        
        
        
        
        
        
        
        addCredentialButton.addTarget(self, action: #selector(rightButtonTapped(_:)), for: .touchUpInside)
        navigationController!.navigationBar.addSubview(addCredentialButton)
        //rightButton.tag = 1
        addCredentialButton.frame = CGRect(x: self.view.frame.width, y: 0, width: 56, height: 56)
        addCredentialButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        addCredentialButton.tintColor = UIColor(named: "AddCredentialButtonColor")
        
        addCredentialButton.imageEdgeInsets = UIEdgeInsets(
            top: (addCredentialButton.frame.size.height) / 2,
            left: (addCredentialButton.frame.size.width) / 2,
            bottom: (addCredentialButton.frame.size.height) / 2,
            right: (addCredentialButton.frame.size.width) / 2)
        
        let targetView = self.navigationController?.navigationBar
        
        let trailingContraint = NSLayoutConstraint(item: addCredentialButton, attribute:
            .trailingMargin, relatedBy: .equal, toItem: targetView,
                             attribute: .trailingMargin, multiplier: 1.0, constant: -23)
        let bottomConstraint = NSLayoutConstraint(item: addCredentialButton, attribute: .bottom, relatedBy: .equal,
                                                  toItem: targetView, attribute: .bottom, multiplier: 1.0, constant: -16)
        addCredentialButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([trailingContraint, bottomConstraint])
        
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        CollectiblesTableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        CollectiblesTableView.rowHeight = 12.00
        CollectiblesTableView.separatorColor = .red
        CollectiblesTableView.rowHeight = 132.4
        CollectiblesTableView.separatorStyle = .none
        CollectiblesTableView.backgroundColor = UIColor(named: "BackgroundColor")
        CollectiblesTableView.reloadData()
        
   
        
        
    }
    
    @objc func rightButtonTapped(_ sender: UIButton) {
        
        var session: NFCNDEFReaderSession?
        session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: false)
        session?.alertMessage = "Hold your iPhone near an NFC-enabled object to obtain your collectible."
        session?.begin()
        
        
    }
    
    func hex2ascii (_ example: String) -> String {

        var chars = [Character]()

        for c in example {
            chars.append(c)
        }

        let numbers =  stride(from: 0, to: chars.count, by: 2).map{
            strtoul(String(chars[$0 ..< $0+2]), nil, 16)
        }

        var final = ""
        var i = 0

        while i < numbers.count {
            final.append(Character(UnicodeScalar(Int(numbers[i]))!))
            i += 1
        }

        return final
    }

    
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {

        for message in messages {
            for record in message.records {
                
                session.invalidate()
                
                print("record.payload.bytes.count")
                print(record.payload.bytes.count)
                if record.payload.bytes.count >= 100{
                    afterReaderSession(String(decoding: Data(String(record.payload.toHexString().components(separatedBy: "00")[1]).hexaData), as: UTF8.self))
                }
                else {
                    self.alert("Invalid NFC Tag.")
                }
                
            }
        }
    }
    
    func afterReaderSession(_ tagString:String) {
        
                    if(tagString.contains("nft://resolve")){
                        
                        print("yea")
                        print(tagString)
                        
                        if(tagString.contains("symbol=")){
                        }
                        else {
                            self.alert("NFT URI formatted wrong.")
                            return
                        }
                        if(tagString.contains("identifier=")){
                        }
                        else {
                            self.alert("NFT URI formatted wrong.")
                            return
                        }
                        if(tagString.contains("privateKey=")){
                        }
                        else {
                            self.alert("NFT URI formatted wrong.")
                            return
                        }
                        
                    }
                    else {
                        self.alert("Invalid NFC tag.")
                        return
                    }
                    
                    var NFT_SYMBOL = tagString.components(separatedBy: "symbol=")[1]
                    if NFT_SYMBOL.contains("&") {
                        NFT_SYMBOL = NFT_SYMBOL.components(separatedBy: "&")[0]
                    }
                    
                    let NFT_CONTRACT_ADDRESS = self.fetchETHContractAddressFromSymbol(NFT_SYMBOL)
                    
                    if(NFT_CONTRACT_ADDRESS.count != 42){
                        self.alert("Wrong 'NFT_CONTRACT_ADDRESS'")
                        return
                    }
                    
                    var NFT_IDENTIFIER = tagString.components(separatedBy: "identifier=")[1]
                    if NFT_IDENTIFIER.contains("&") {
                        NFT_IDENTIFIER = NFT_IDENTIFIER.components(separatedBy: "&")[0]
                    }
                    
                    var NFT_OWNER_PRIVATE_KEY = tagString.components(separatedBy: "privateKey=")[1]
                    if NFT_OWNER_PRIVATE_KEY.contains("&") {
                        NFT_OWNER_PRIVATE_KEY = NFT_OWNER_PRIVATE_KEY.components(separatedBy: "&")[0]
                    }
                    
                    if(NFT_OWNER_PRIVATE_KEY.count == 64){
                    }
                    else {
                        self.alert("'NFT_OWNER_PRIVATE_KEY' formatted wrong.")
                        return
                    }
                    
                    
                    print("yesdsda")
                    print(tagString.description)
                    
                    print("NFT_SYMBOL is")
                    print(NFT_SYMBOL)
                    
                    print("NFT_CONTRACT_ADDRESS is")
                    print(NFT_CONTRACT_ADDRESS)
                    
                    print("NFT_IDENTIFIER is")
                    print(NFT_IDENTIFIER)
                    
                    print("NFT_OWNER_PRIVATE_KEY is")
                    print(NFT_OWNER_PRIVATE_KEY)


                    let NFTkeystore = try! EthereumKeystoreV3(privateKey: Data.fromHex(NFT_OWNER_PRIVATE_KEY)!, password: "")!
                    let NFTkeyData = try! JSONEncoder().encode(EthereumKeystoreV3(privateKey: Data.fromHex(NFT_OWNER_PRIVATE_KEY)!, password: "")!.keystoreParams)
                    
                    let NFT_OWNER_ETH_ADDRESS_STR = NFTkeystore.addresses!.first!.address
                    
                    print("NFT_OWNER_ETH_ADDRESS is")
                    print(NFT_OWNER_ETH_ADDRESS_STR)
                    
                    let NFTwallet = Wallet(address: NFT_OWNER_ETH_ADDRESS_STR, data: NFTkeyData, name: NFT_IDENTIFIER, isHD: false)
                    
                    let NFTkeystoreManager = KeystoreManager([NFTkeystore])
                    
                    
                    
                    
                    
                    for n in 0..<collectiblesArray.count {
                        if String(NFT_OWNER_ETH_ADDRESS_STR).lowercased() == String(collectiblesArray[n]["FromETHAddress"] as! String).lowercased() {
                            self.alert("You have already added this collectible: #\(NFT_IDENTIFIER)")
                            return
                        }
                    }

                    let monitor = NWPathMonitor()
                    monitor.pathUpdateHandler = { path in
                        if path.status == .satisfied {
                            DispatchQueue.main.async {
                    
  
                    let web3 = Web3.InfuraMainnetWeb3()
                    
                    web3.addKeystoreManager(NFTkeystoreManager)
                    
                    let NFT_OWNER_ETH_ADDRESS = EthereumAddress(NFTwallet.address)! // Address which balance we want to know
                    let balanceResult = try! web3.eth.getBalance(address: NFT_OWNER_ETH_ADDRESS)
                                
                    let balanceETHStr = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .eth)!
                    let balanceWEIStr = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .wei)!
 
    
                        print("balanceWEIStr")
                        print(balanceWEIStr)


                        if(Int(balanceWEIStr)! >= 4850000000000000){
                                
                        }
                        else {
                            self.alert("Unsufficient ethers found in tag: \(balanceETHStr) ETH. Minimum is: 0.00485 ETH")
                            return
                        }

                    
   
                    
                    /*
                    let value: String = "1958969" // In Tokens
                    let toAddress = EthereumAddress("0xcdE4705Cb30A6E1883bdB0dD0B78992E443a8d1D")!
                    let erc721ContractAddress = EthereumAddress("0x06012c8cf97bead5deae237070f9587f8e7a266d")!
                    let contract = web3.contract(Web3.Utils.erc721ABI, at: erc721ContractAddress, abiVersion: 2)!
                    let amount = Web3.Utils.parseToBigUInt(value, units: .wei)
                    var options = TransactionOptions.defaultOptions
                    options.value = amount
                    options.from = walletAddress
                    options.gasPrice = .automatic
                    options.gasLimit = .automatic
                    options.to = toAddress
                    
                    print("optionsare")
                    print(options.value)
                    print(options.from)
                    print(options.to)
                    print(options.gasLimit)
                    print(options.gasPrice)
                    
                    
                    
                    let method = "transfer"
                    let tx = contract.write(
                        method,
                        parameters: [toAddress, amount] as [AnyObject],
                        extraData: Data(),
                        transactionOptions: options)!
                    
                    
                    
                    let result = try! tx.send(password: "")
                    
                    print("result")
                    print(result.hash)
                    
                    */
                    
                    
                    

                                monitor.cancel()
     
                                let semaphore = DispatchSemaphore (value: 0)
                                
                                var request = URLRequest(url: URL(string: "https://api.etherscan.io/api?module=account&action=tokennfttx&contractaddress=\(NFT_CONTRACT_ADDRESS)&address=\(NFT_OWNER_ETH_ADDRESS_STR)&page=1&offset=100&sort=asc&apikey=YTWITIYMMMBHARG216943Z15FSI6I21T2Y")!,timeoutInterval: Double.infinity)
                                
                                request.httpMethod = "GET"
                                
                                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                                    guard let data = data else {
                                        print(String(describing: error))
                                        return
                                    }
                                    
                                    print("datais ")
                                    
                                    print(String(data: data, encoding: .utf8)!)
                                    
                                    let collectibleJSONDecoded: Collectible = try! JSONDecoder().decode(Collectible.self, from: data)
                                    
                                    
                                    if(collectibleJSONDecoded.result.count == 0){
                                        
                                        semaphore.signal()
                                        self.alert("No Collectible found.")
                                        
                                    }
                                    else {
                                        
                                        if collectibleJSONDecoded.result[collectibleJSONDecoded.result.count-1].to.lowercased() == NFT_OWNER_ETH_ADDRESS_STR.lowercased(){
                                            let collectibleIdentifier = collectibleJSONDecoded.result[0].tokenID
                                            
                                            if(NFT_IDENTIFIER.lowercased() == collectibleIdentifier.lowercased()){
                                                
                                                semaphore.signal()
                                                print("hoho")
                                                print(self.Userwallet.address)
                                                
                                                self.addCollectibleUIInit(NFT_SYMBOL, NFT_IDENTIFIER, NFT_OWNER_ETH_ADDRESS_STR, NFT_OWNER_PRIVATE_KEY, web3, self.Userwallet)
                                                
                                            }
                                            else {
                                                
                                                semaphore.signal()
                                                self.alert("Tag NFT identifier (\(NFT_IDENTIFIER)) and found NFT identifier (\(collectibleIdentifier)) conflicts.")
                                                return
                                                
                                            }

                                            
                                        }
                                        else {
                                            semaphore.signal()
                                            self.alert("This tag collectible: #\(collectibleJSONDecoded.result[0].tokenID)\n has already captured.")
                                        }
                                        
                                        
                                    }

                                    
                                }
                                
                                task.resume()
                                semaphore.wait()
                            }
                        } else {
                            DispatchQueue.main.async {
                                monitor.cancel()
                                self.alert("No internet connection.")
                            }
                        }
                    }
                    
                    
                    
                    
                    
                    let queue = DispatchQueue(label: "Monitor")
                    monitor.start(queue: queue)
                    
                    
                    
                    
                }

    
    func alert(_ errorDescription:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: errorDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func warning(_ errorDescription:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Warning", message: errorDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func collectibleSymbolDecode(_ symbol:String)->String{
        
        if(symbol=="CK"){
            return "CryptoKitty"
        }
        else {
            return ""
        }
        
    }
    
    

    func addCollectibleUIInit (_ NFT_SYMBOL:String, _ NFT_IDENTIFIER:String, _ NFT_OWNER_ETH_ADDRESS_STR:String, _ NFT_OWNER_PRIVATE_KEY:String, _ web3:web3, _ Userwallet:Wallet){
        
        DispatchQueue.main.async {
            
            var collectibleImageURL = URL(string: "")
            
            if NFT_SYMBOL == "CK"{
 
                let semaphore = DispatchSemaphore (value: 0)
  
                var request = URLRequest(url: URL(string: "https://public.api.cryptokitties.co/v1/kitties?kittyId=\(NFT_IDENTIFIER)")!,timeoutInterval: Double.infinity)
                request.addValue("HF3rRlVT6fO9ZpsASQuWdu75XUD9B_qFVK6TKIsfVg0", forHTTPHeaderField: "x-api-token")
                request.httpMethod = "GET"
                
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data else {
                        print(String(describing: error))
                        return
                    }
                    
                    print("dataencodedis")
                    print(String(data: data, encoding: .utf8)!)
                    
                    if(String(data: data, encoding: .utf8)! == "Service Unavailable"){
                    }
                    else {
                        let collectibleJSONDecodedCryptoKitty: CryptoKitty = try! JSONDecoder().decode(CryptoKitty.self, from: data)
                        collectibleImageURL = URL(string: collectibleJSONDecodedCryptoKitty.kitties[0].image_url_png)!
                    }

                    semaphore.signal()
                }
                
                task.resume()
                semaphore.wait()
            }
            
            DispatchQueue.main.async {
                
                print("collectibleImageURLis")
                print(collectibleImageURL?.absoluteString)
                
                if(collectibleImageURL?.absoluteString != nil){
                    
                
                let imageView = UIImageView(frame: CGRect(x: 34, y: 45, width: 290, height: 290))
                
                
                func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
                    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
                }
                
                getData(from: collectibleImageURL!) { data, response, error in
                    guard let data = data, error == nil else { return }
                    print(response?.suggestedFilename ?? collectibleImageURL!.lastPathComponent)
                    print("Download Finished")
                    DispatchQueue.main.async() { [weak self] in
                        
                        print("data.count")
                        print(data.count)
                        
                        imageView.image = UIImage(data: data)

                        //imageView.image = UIImage(named: "\(collectibleIdentifier).png")
                        
                        let alertController = UIAlertController(title: "\(self!.collectibleSymbolDecode(NFT_SYMBOL)) Detected!", message: "Do you want to add \(self!.collectibleSymbolDecode(NFT_SYMBOL) + " #" + NFT_IDENTIFIER) to your collectible collection?\n \n \n \n \n \n \n \n \n \n \n \n \n", preferredStyle: .actionSheet)
                        
                        
                        let action1 = UIAlertAction(title: "Add", style: .default) { (action) in
                            if action.isEnabled {
                                
                                
                                
                                
                                let value: String = "0.0" // In Ether
                                let toAddress = EthereumAddress(self!.fetchETHContractAddressFromSymbol(NFT_SYMBOL))!
                                   let contract = web3.contract(Web3.Utils.coldWalletABI, at: toAddress, abiVersion: 2)!
                                   let amount = Web3.Utils.parseToBigUInt(value, units: .eth)
                                   var options = TransactionOptions.defaultOptions
                                   options.value = amount
                                   options.from = EthereumAddress(NFT_OWNER_ETH_ADDRESS_STR)!
                                options.gasPrice = .manual(40000000000)
                                options.gasLimit = .manual(65000)
                                   
                                   let tx = contract.write(
                                       "fallback",
                                       parameters: [AnyObject](),
                                       extraData: Data(hex: self!.txDataEncode(symbol: NFT_SYMBOL, toAddress: Userwallet.address, identifier: NFT_IDENTIFIER)),

                                       
                                       transactionOptions: options)!
                                   
                                var TXResult:TransactionSendingResult
                                
                                do {
                                    TXResult = try tx.send(password: "")
                                    
                                       print("TXResult HASH")
                                      print(TXResult.hash)
                                    
                                    if TXResult.hash.count == 66 {
                                        
                                        print("asama1 suc, 2 gecildi")
                                        
                                        let value: String = "0.002" // In Ether
                                        let toAddress = EthereumAddress(Userwallet.address)!
                                           let contract = web3.contract(Web3.Utils.coldWalletABI, at: toAddress, abiVersion: 2)!
                                           let amount = Web3.Utils.parseToBigUInt(value, units: .eth)
                                           var options = TransactionOptions.defaultOptions
                                           options.value = amount
                                           options.from = EthereumAddress(NFT_OWNER_ETH_ADDRESS_STR)!
                                        options.gasPrice = .manual(40000000000)
                                        options.gasLimit = .manual(21000)
                                           
                                           let tx2 = contract.write(
                                               "fallback",
                                               parameters: [AnyObject](),
                                               extraData: Data(),
                                               transactionOptions: options)!
                                        
                                        var TXResult2:TransactionSendingResult
                                        
                                        do {
                                            print("2 do")
                                            TXResult2 = try tx2.send(password: "")
                                            
                                            if TXResult2.hash.count == 66 {
                                                print("2 do 1")
                                                self!.collectiblesArray.append(["Added" : Date(),  "Symbol" : NFT_SYMBOL, "Identifier" : NFT_IDENTIFIER, "TxID": TXResult.hash, "FromETHAddress": NFT_OWNER_ETH_ADDRESS_STR, "Icon": data, "Tx2ID": TXResult2.hash])
                                                
                                                UserDefaults.standard.set(self?.collectiblesArray, forKey: "collectiblesArrayKey")
                                                self!.viewDidLoad()
          
                                            }
                                            else {
                                                
                                                print("2 do 2")
                                                
                                                self!.warning("Credentials Added, but ETH transaction failed :v2")
                                                
                                                self!.collectiblesArray.append(["Added" : Date(),  "Symbol" : NFT_SYMBOL, "Identifier" : NFT_IDENTIFIER, "TxID": TXResult.hash, "FromETHAddress": NFT_OWNER_ETH_ADDRESS_STR, "Icon": data, "Tx2ID": ""])
                                                
                                                UserDefaults.standard.set(self?.collectiblesArray, forKey: "collectiblesArrayKey")
                                                self!.viewDidLoad()
                                                
                                            }
                                            

                                            
                                        }
                                            
                                        catch {
                                            
                                            print("2 catch")
                                            
                                            self!.warning("Credentials Added, but ETH transaction failed :v1")
                                            
                                            self!.collectiblesArray.append(["Added" : Date(),  "Symbol" : NFT_SYMBOL, "Identifier" : NFT_IDENTIFIER, "TxID": TXResult.hash, "FromETHAddress": NFT_OWNER_ETH_ADDRESS_STR, "Icon": data, "Tx2ID": ""])
                                            
                                            UserDefaults.standard.set(self?.collectiblesArray, forKey: "collectiblesArrayKey")
                                            self!.viewDidLoad()
                                        }
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        

                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                    }
                                    else {
                                        self!.alert("An error occured :a805")
                                    }
                                    
                                }
                                catch {
                                    self!.alert("An error occured! :tx1")
                                }
    
                            }
                            else {
                                self!.alert("Service Unavailable.")
                            }
                        }
                        
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                        alertController.addAction(action1)
                        alertController.addAction(cancelAction)
                        self!.present(alertController, animated: true, completion: nil)
                        alertController.view.addSubview(imageView)
                    }
                }
                
                
                //imageView.image = UIImage(named: "\(collectibleIdentifier).png")
                
                
                
                
                
                }
            }

        
        
        
    }
    
    
}
    
    func  txDataEncode(symbol:String, toAddress:String, identifier:String)->String{
        
        var returnDataStr:String = ""
        
        let identifierInt = Int(identifier)
        let encodedIdentifier =  String(format:"%02X", identifierInt!)
        
        

        
        //1
        if(symbol=="CK"){
            returnDataStr += "a9059cbb"
        }
        
        //2
        returnDataStr += "000000000000000000000000" + toAddress.components(separatedBy: "0x")[1]
        
        //3
        let leaddingZeroCount = 64 - encodedIdentifier.count
        
        for _ in 1...leaddingZeroCount {
            returnDataStr += "0"
        }
        
        returnDataStr += encodedIdentifier
        
        print("returnDataStr is: \(returnDataStr)")
        
        
        return returnDataStr
        
    }
    
    func fetchETHContractAddressFromSymbol(_ symbol:String)-> String{
        
        if symbol == "CK" {
            return "0x06012c8cf97bead5deae237070f9587f8e7a266d"
        }
        
        else {
            self.alert("Symbol '\(symbol)' is not supported.")
            return ""
        }
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destination = segue.destination as? NFTDetailsViewController {

            destination.title = "\(collectiblesArray[selectedModel]["Symbol"]!) #\(collectiblesArray[selectedModel]["Identifier"]!)"
            destination.NFTProperties = collectiblesArray[selectedModel]
            
        }
    }

    
    
}




extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //indexPath.row
       // let credential = credentials[indexPath.row]
        
        
        
            //let vc = NFTDetailViewController()
            //vc.setTitle("naeeer")

            selectedModel = indexPath.row
            addCredentialButton.isHidden = true
            performSegue(withIdentifier: "viewNFTDetails", sender: self)

    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectiblesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CollectiblesTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.TableCellView.layer.cornerRadius = 8
        cell.TitleLabel.text = collectibleSymbolDecode(collectiblesArray[indexPath.row]["Symbol"]! as! String)
        cell.DescriptionLabel.text = "#\(collectiblesArray[indexPath.row]["Identifier"] ?? "")"
        cell.IconView.image = UIImage(data: collectiblesArray[indexPath.row]["Icon"] as! Data)
        cell.TableCellView.layer.shadowColor = UIColor.black.cgColor
        cell.TableCellView.layer.shadowOpacity = 0.05
        cell.TableCellView.layer.shadowOffset = .zero
        cell.TableCellView.layer.shadowRadius = 8
        return cell
    }
    
    
    
    
}

extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}

extension Data {
    public init(hex: String) {
        self.init(_: Array<UInt8>(hex: hex))
    }
}

extension StringProtocol {
    var hexaData: Data { .init(hexa) }
    var hexaBytes: [UInt8] { .init(hexa) }
    private var hexa: UnfoldSequence<UInt8, Index> {
        sequence(state: startIndex) { start in
            guard start < self.endIndex else { return nil }
            let end = self.index(start, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { start = end }
            return UInt8(self[start..<end], radix: 16)
        }
    }
}
