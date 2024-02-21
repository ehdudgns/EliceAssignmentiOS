//
//  ViewController.swift
//  EliceAssignmentiOS
//
//  Created by 도영훈 on 2024/02/17.
//
import Combine
import UIKit
import Then
import SnapKit

class HomeViewController: UIViewController {
    
    enum Text {
        static let freeCourseTitle: String = "무료 과목"
        static let recommendedCourseTitle: String = "추천 과목"
        static let myCourseTitle: String = "내 과목"
    }
    
    let viewModel = HomeViewModel()
    private var offset: Int = 0
    private var cancelBag = Set<AnyCancellable>()
    
      
    let freeCourseListView = HomeContentView(titleMessage: Text.freeCourseTitle)
    
    var freeCourseList: [Course] = []
    
    
    let recommendedCourseListView = HomeContentView(titleMessage: Text.recommendedCourseTitle)
    var recommendedCourseList: [Course] = []
    
    let myCourseListView = HomeContentView(titleMessage: Text.myCourseTitle)
    
    let labelCData: [String] = ["this", "is", "my", "course", "1", "2", "3", "4", "5", "6", "7", "8"]

    let headerView = HomeHeaderView()
    
    let scrollView: UIScrollView = UIScrollView()
    
    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 16
    }
    
    private func setupConstraints() {
        self.view.addSubview(self.headerView)
        
        self.headerView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        self.view.addSubview(self.scrollView)
        
        
        self.scrollView.snp.makeConstraints {
            $0.top.equalTo(self.headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        
        
        self.scrollView.addSubview(self.freeCourseListView)

        self.freeCourseListView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.width.equalToSuperview()
            $0.height.equalTo(292)
        }
        
        self.scrollView.addSubview(self.recommendedCourseListView)
        
        self.recommendedCourseListView.snp.makeConstraints {
            $0.top.equalTo(self.freeCourseListView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(292)
        }
        
        self.scrollView.addSubview(self.myCourseListView)
        
        self.myCourseListView.snp.makeConstraints {
            $0.top.equalTo(self.recommendedCourseListView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(292)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        self.setException()
        self.view.backgroundColor = .white
        self.scrollView.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    func setException() {
        self.headerView.searchButton.addTarget(self, action: #selector(tapSearch), for: .touchDown)
    }
    
    @objc func tapSearch() {
        let alert = UIAlertController(title: "서비스 준비 중입니다..", message: nil, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "확인", style: .destructive, handler : nil)
        
        alert.addAction(cancel)
        
        self.present(alert, animated: false, completion: nil)
    }
    
    private func bindViewModel() {
        self.freeCourseListView.collectionView.delegate = self
        self.freeCourseListView.collectionView.dataSource = self
        self.recommendedCourseListView.collectionView.delegate = self
        self.recommendedCourseListView.collectionView.dataSource = self
        self.myCourseListView.collectionView.delegate = self
        self.myCourseListView.collectionView.dataSource = self
        
        
        viewModel.$freeCourseList.dropFirst().receive(on: DispatchQueue.main).sink(receiveValue: {[weak self] _ in
            guard let sself = self else { return }
            sself.configData()
        }).store(in: &cancelBag)
        
        viewModel.$recommendedCourseList.dropFirst().receive(on: DispatchQueue.main).sink(receiveValue: {[weak self] _ in
            guard let sself = self else { return }
            sself.configData()
            
        }).store(in: &cancelBag)
    }
    
    private func configData() {
        self.freeCourseList = viewModel.freeCourseList
        self.freeCourseListView.collectionView.reloadData()
        
        self.recommendedCourseList = viewModel.recommendedCourseList
        print(recommendedCourseList)
        self.recommendedCourseListView.collectionView.reloadData()
        
    }

}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var id = ""
        switch collectionView {
        case self.freeCourseListView.collectionView:
            id = "\(self.freeCourseList[indexPath.item].id)"
        case self.recommendedCourseListView.collectionView:
            id = "\(self.recommendedCourseList[indexPath.item].id)"
        case self.myCourseListView.collectionView:
            id = "\(self.labelCData[indexPath.item])"
        default:
            break
        }
        let vc = CourseDetailViewController()
        vc.viewModel = CourseDetailViewModel(id: id)
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let contentWidth = scrollView.contentSize.width
        let width = scrollView.frame.size.width
        
        if offsetX > contentWidth - width {
            switch scrollView {
                case self.freeCourseListView.collectionView:
                    self.freeCourseListView.collectionView.reloadData()
                case self.recommendedCourseListView.collectionView:
                    self.recommendedCourseListView.collectionView.reloadData()
                case self.myCourseListView.collectionView:
                    self.myCourseListView.collectionView.reloadData()
                default:
                    return
            }
        }
        
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 220)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CourseCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CourseCell else { return UICollectionViewCell() }
        switch collectionView {
            case self.freeCourseListView.collectionView:
                cell.configureData(model: self.freeCourseList[indexPath.item])
            case self.recommendedCourseListView.collectionView:
                cell.configureData(model: self.recommendedCourseList[indexPath.item])
            case self.myCourseListView.collectionView:
                cell.setData(title: self.labelCData[indexPath.item])
            default:
                cell.setData(title: "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case self.freeCourseListView.collectionView:
                return self.freeCourseList.count
            case self.recommendedCourseListView.collectionView:
                return self.recommendedCourseList.count
            case self.myCourseListView.collectionView:
                return self.labelCData.count
            default:
                return 0
        }
    }
}
