//
//  WorkspaceListTableViewCell.swift
//  Sparkle
//
//  Created by 최민경 on 12/16/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher

final class WorkspaceListTableViewCell: BaseTableViewCell {
    
    private let bgView = UIView().then {
        $0.layer.cornerRadius = 8
    }
    
    private let workspaceImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .black
    }
    
    private let dateLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .gray
    }
    
    private let settingButton = UIButton().then {
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.tintColor = .sparkleBrandBlackColor
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    override func setupSubviews() {
        contentView.addSubview(bgView)
        bgView.addSubview(workspaceImageView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(dateLabel)
        bgView.addSubview(settingButton)
    }

    override func setupLayout() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(6)
        }
        
        workspaceImageView.snp.makeConstraints { make in
            make.leading.equalTo(bgView).offset(16)
            make.centerY.equalTo(bgView)
            make.width.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(workspaceImageView.snp.trailing).offset(8)
            make.top.equalTo(workspaceImageView.snp.top).inset(4)
//            make.trailing.lessThanOrEqualToSuperview().offset(-8)
            make.trailing.equalTo(settingButton.snp.leading)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(workspaceImageView.snp.bottom).offset(-4)
        }
        
        settingButton.snp.makeConstraints { make in
            make.centerY.equalTo(bgView)
            make.trailing.equalTo(bgView).inset(20)
            make.size.equalTo(20)
            
        }
    }
    
    func bind(_ list: WorkspaceListCheckResponse) {
        guard let url = URL(string: "\(BaseURL.baseURL)v1\(list.coverImage)") else { return }
        
        let modifier = AuthenticatedRequestModifier()
        
        workspaceImageView.kf.setImage(
            with: url,
            options: [.requestModifier(modifier)],
            completionHandler: { result in
                switch result {
                case .success(let value):
                    print("✅ 성공: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("❌ 실패: \(error.localizedDescription)❌")
                }
            }
        )
        titleLabel.text = list.name
        dateLabel.text = formatTime(list.createdAt)
    }
    
    private func formatTime(_ dateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] // ISO 8601 형식 지원
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "yy.MM.dd"
        displayFormatter.locale = Locale(identifier: "ko_KR")

        if let date = isoFormatter.date(from: dateString) {
            return displayFormatter.string(from: date)
        }
        return dateString
    }
}
