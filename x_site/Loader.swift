
import UIKit
class Loader{
    //There was only one usage for the method, but in the future there is a high potential of reuse
    static func load(fromURL url:String, completion:@escaping (Data?,URLResponse?, Error?)->()){
        URLSession.shared.dataTask(with: URL(string:url)!, completionHandler: completion).resume();
    }
}
