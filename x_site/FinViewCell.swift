import UIKit

class FinViewCell : UITableViewCell{
    
    private var model:FinStruct!;
    
    private var fullStar:Bool = false;
    
    private let emptyStarImg = UIImage(named: "emptyStar");
    private let fullStarImg = UIImage(named: "fullStar");
    
    private func adaptViews(){
        //Show needed texts
        label(byIdx: 0).text = model.asset;
        label(byIdx: 1).text = model.name;
        label(byIdx: 2).text = model.time;
        //Show star - empty by default
        toggleStar();
    }
    //toggle empty - full star image
    func toggleStar(){
        image(byIdx: 3).image = fullStar ? fullStarImg : emptyStarImg;
        fullStar = !fullStar;
    }
    //reused in adaptViews
    private func label(byIdx i: Int)->UILabel{
        return contentView.subviews[i] as! UILabel;
    }
    //Currently I have only one there - but I prefer to have this method
    private func image(byIdx i: Int)->UIImageView{
        return contentView.subviews[i] as! UIImageView;
    }
    func setModel(model: FinStruct){
        self.model = model;
        adaptViews();
    }
}
