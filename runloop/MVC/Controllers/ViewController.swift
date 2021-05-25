//
//  ViewController.swift
//  runloop
//
//  Created by swamnx on 20.05.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var footballMatchesView: UITableView!
    var footballMatches: [FootballMatch]?
    var footballMatchService: FootballMatchService!
    var timer: DispatchSourceTimer?
    var timerObservers = [String: () -> Void]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        footballMatchesView.delegate = self
        footballMatchesView.dataSource = self
        footballMatches = footballMatchService.loadFootballMatches()
        footballMatchesView.reloadData()
        timerObservers["ViewController"] = getObserver()
        createTimer()
        timer?.resume()
    }
}
//
// MARK: - Table View Data Source
//
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return footballMatches?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommonUtils.FootballMatchIds.cell.rawValue, for: indexPath)
        let match = footballMatches?[indexPath.row]
        cell.textLabel?.text = match?.name
        cell.detailTextLabel?.text = match?.remainingTime
        return cell
    }
}
//
// MARK: - Table View Actions
//
extension ViewController {
    
    func showFootballMatchDetails(match: FootballMatch) {
        guard let footBallMatchViewController = self.storyboard?.instantiateViewController(withIdentifier: "FootballMatchController") as? FootballMatchController else {return}
        footBallMatchViewController.footBallMatch = match
        timerObservers["FootballMatchController"] = footBallMatchViewController.getObserver()
        self.present(footBallMatchViewController, animated: true, completion: nil)
    }
}
//
// MARK: - UITableViewDelegate Actions
//
extension ViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showFootballMatchDetails(match: (footballMatches?[indexPath.row])!)
    }
}
//
// MARK: - Timer And Observer
//
extension ViewController {
    
    func getObserver() -> (() -> Void) {
        return { [weak self] in
            guard let unwrapped = self else { return }
            guard let visibleRowsIndexPaths = unwrapped.footballMatchesView.indexPathsForVisibleRows else { return }
            var updated = false
            for indexPath in visibleRowsIndexPaths where unwrapped.footballMatches?[indexPath.row] != nil {
                 updated = CommonUtils.shared.processFootballMatch(&unwrapped.footballMatches![indexPath.row])
                    || updated
            }
            if updated {
                unwrapped.footballMatchesView.reloadData()
            }
        }
    }
    
    private func createTimer() {
        if timer == nil {
            timer = DispatchSource.makeTimerSource(queue: .main)
            timer?.schedule(deadline: .now(), repeating: 1.0)
            timer?.setEventHandler { [weak self] in
                if let unwrapped = self {
                    for observerFunc in unwrapped.timerObservers.values {
                        observerFunc()
                    }
                }
            }
        }
    }
}
