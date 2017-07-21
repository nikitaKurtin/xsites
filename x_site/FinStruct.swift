
import Foundation

struct FinStruct{
    let asset:String;
    let name:String;
    let time:String;
    
    init(asset: String){
        //Given asset (float number from CSV)
        self.asset = asset;
        //Show current time
        let formatter  = DateFormatter();
        formatter.dateFormat="dd/MM/yy hh:mm";
        self.time = formatter.string(from: Date());
        //Disregard additional assets
        self.name = "EUR/USD";
    }
}
