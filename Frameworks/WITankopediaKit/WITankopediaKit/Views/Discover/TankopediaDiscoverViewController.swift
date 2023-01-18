//
//  TankopediaDiscoverViewController.swift
//  WITankopediaKit
//
//  Created by Michael Artes on 05.12.22.
//

import Combine
import UIKit
import WICoreUIKit

public class TankopediaDiscoverViewController: UIViewController, TabBarItem {
    public static let title = "Tankopedia"
    public static let image = UIImage(systemName: "book.fill")
    
    init() { super.init(nibName: nil, bundle: nil) }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private var subscribers = Set<AnyCancellable>()
    var viewModel: TankopediaDiscoverViewModel?
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<DiscoverSection, DiscoverItem>!
    
    private var hasLoaded = false
    public override func viewDidLoad() {
        super.viewDidLoad()
        guard !hasLoaded else { return }
        hasLoaded = true
        prepare()
    }
    
    public func preload() {
        guard !hasLoaded else { return }
        hasLoaded = true
        prepare()
    }
    
    private func prepare() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: self.createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.frame = view.bounds
        collectionView.delegate = self
        view.addSubview(collectionView)
        self.collectionView = collectionView
        
        collectionView.register(DiscoverChipCell.nib, forCellWithReuseIdentifier: DiscoverChipCell.nibName)
        collectionView.register(DiscoverVehicleCell.nib, forCellWithReuseIdentifier: DiscoverVehicleCell.nibName)
        
        
        guard let viewModel else { return }
        createDataSource()
        viewModel.setup()
        setup(for: viewModel)
        reloadData()
    }
    
    private func setup(for viewModel: TankopediaDiscoverViewModel) {
        subscribers.removeAll()
        viewModel.information
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
            } receiveValue: { _ in
                self.reloadData()
            }
            .store(in: &subscribers)
        viewModel.vehicles
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    break
                }
            } receiveValue: { _ in
                self.reloadData()
            }
            .store(in: &subscribers)
    }
    
    private func setup<T: DiscoverCell>(_ cellType: T.Type, with item: DiscoverItem, for indexPath: IndexPath, using viewModel: TankopediaDiscoverViewModel) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.nibName, for: indexPath) as? T else {
            fatalError("Incorrect cell configuration!")
        }
        cell.setup(for: item, in: indexPath.section, with: viewModel)
        return cell
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<DiscoverSection, DiscoverItem>(collectionView: collectionView) { collectionView, indexPath, item in
            guard let viewModel = self.viewModel else {
                fatalError("Must provide viewModel!")
            }
            let section = viewModel.sections[indexPath.section]
            switch section.type {
            case .chips:
                return self.setup(DiscoverChipCell.self, with: item, for: indexPath, using: viewModel)
            case .results:
                return self.setup(DiscoverVehicleCell.self, with: item, for: indexPath, using: viewModel)
            }
        }
    }
    
    private func reloadData() {
        guard let viewModel = self.viewModel else {
            fatalError("Must provide viewModel!")
        }
        viewModel.generateSections()
        var snapshot = NSDiffableDataSourceSnapshot<DiscoverSection, DiscoverItem>()
        snapshot.appendSections(viewModel.sections)
        for section in viewModel.sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource.apply(snapshot)
    }
    
    private func createCompositionalLayout() -> some UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let viewModel = self.viewModel else {
                fatalError("Must provide viewModel!")
            }
            let section = viewModel.sections[sectionIndex]
            switch section.type {
            case .chips:
                return self.createChipsSection(using: section)
            case .results:
                return self.createResultsSection(using: section)
            }
        }
    }
    
    private func createChipsSection(using section: DiscoverSection) -> NSCollectionLayoutSection {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .estimated(120),
            heightDimension: .absolute(60)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .estimated(layoutSize.heightDimension.dimension * 3),
                heightDimension: layoutSize.heightDimension
            ),
            subitems: [.init(layoutSize: layoutSize)]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
        return section
    }
    
    private func createResultsSection(using section: DiscoverSection) -> NSCollectionLayoutSection {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(192)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(layoutSize.heightDimension.dimension * 3)
            ),
            subitems: [.init(layoutSize: layoutSize)]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        return section
    }
}
