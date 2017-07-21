import UIKit
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let jsonUrl = "http://download.finance.yahoo.com/d/quotes.csv?e=.csv&f=l1&s=EURUSD=X+GBPUSD=X+EURGBP=X";
    
    @IBOutlet weak var header:UILabel!;
    
    @IBOutlet weak var tbl:UITableView!;
    
    @IBOutlet weak var loading: UIActivityIndicatorView!;
    
    private var data: [String] = []
    
    override func viewDidLoad() {
        //giving header a gray border
        header.layer.borderWidth = 1;
        header.layer.borderColor = UIColor.gray.cgColor;
        
        loadCsv();
    }
    
    private func loadCsv(){
        loading.isHidden=false;
        Loader.load(fromURL: jsonUrl, completion: {(d,r,e)in
            AsyncTask(backgroundTask: {(d:Data)->[String]? in
                //Array of string (asset) from loaded CSV - or nil if failed
                return self.buildDataArray(d);
            }, afterTask: {(data)in
                if data != nil{//successfully loaded
                    self.data = data!;
                    self.tbl.reloadData();
                    self.loading.isHidden = true;
                }else{//failed to load
                    print("Failed to load");
                }
            }).execute(d!);
        });
    }
    
    private func buildDataArray(_ d:Data)->[String]?{
        //split by new line separator
        if var arr = String(data: d, encoding: .utf8)?.components(separatedBy: "\n"){
            arr.removeLast();//remove empty string (last)
            return arr;
        }
        return nil;//otherwise return nill
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCell(withIdentifier: "fincellview")as! FinViewCell;
        cell.setModel(model: FinStruct(asset: data[indexPath.row]));
        return cell;
    }
    
    //Empty stars - On click should change to full.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tbl.cellForRow(at: indexPath) as! FinViewCell;
        cell.toggleStar();
    }
    
}
