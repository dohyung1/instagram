//
//  FormTableViewCell.swift
//  instagram
//
//  Created by Administrator on 12/9/20.
//

import UIKit

protocol  FormTableViewCellDelegate : AnyObject{
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel)
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {

    static let identifier = "FormTableViewCell"
    private var model: EditProfileFormModel?
    
    public weak var delegate: FormTableViewCellDelegate?
    
    private let formLabel:UILabel = {
       
        let formLabel = UILabel()
        formLabel.textColor = .label
        formLabel.numberOfLines = 1
        return formLabel
    }()
    
    private let field:UITextField = {
       
        let field = UITextField()
        
        field.returnKeyType = .done
        
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        field.delegate = self
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: EditProfileFormModel){
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Assign frames
        formLabel.frame = CGRect(x: 5,
                                 y: 0,
                                 width: contentView.width/3,
                                 height: contentView.height)
        
        field.frame = CGRect(x: formLabel.right + 5,
                             y: 0,
                             width: contentView.width - 10 - formLabel.width,
                             height: contentView.height)
    }
    
    //MARK: - Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        model?.value = textField.text
        guard let model = model else{
            return true
        }
        
        delegate?.formTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        
        return true
    }
    
}
