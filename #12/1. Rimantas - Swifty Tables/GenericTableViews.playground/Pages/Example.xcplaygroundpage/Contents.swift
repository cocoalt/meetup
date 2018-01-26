import UIKit
import PlaygroundSupport

struct Meetup {
    let number: Int
    let date: String
}

let meetups = [
    Meetup(number: 12, date: "2018-01-17"),
    Meetup(number: 11, date: "2017-11-16"),
    Meetup(number: 10, date: "2017-10-12"),
    Meetup(number: 9, date: "2017-04-19")
]

struct Talk {
    let title: String
    let speaker: String
}

func getTalks(at meetup: Meetup) -> [Talk] {
    let talks = [
            Talk(title: "Building design system", speaker: "Tadas Blantaitis, Darius Sabaliauskas"),
            Talk(title: "Swifty Tables", speaker: "Rimantas Liubertas"),
        ]
    return talks
}

final class MeetupCell: UITableViewCell, Reusable {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TalkCell: UITableViewCell, Reusable {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class ItemsViewController<Item, Cell: UITableViewCell>: UITableViewController  where Cell: Reusable {
    var items: [Item] = []
    var didSelect: (Item) -> () = { _ in }
    var configure: (Cell, Item) -> () = { _, _ in }
    
    init(items: [Item]) {
        super.init(style: .plain)
        self.items = items
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(Cell.self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelect(item)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell: Cell = tableView.dequeueReusableCell(for: indexPath)
        configure(cell, item)
        return cell
    }
}

let meetupsVC = ItemsViewController<Meetup, MeetupCell>(items: meetups)
meetupsVC.title = "Cocoa.lt"

meetupsVC.configure =  { cell, item in
    cell.textLabel?.text = "Cocoa.lt #\(item.number)"
    cell.detailTextLabel?.text = item.date
}

meetupsVC.didSelect = { meetup in
    let talks = getTalks(at: meetup)
    let talksVC = ItemsViewController<Talk, TalkCell>(items: talks)
    talksVC.title = meetup.date
    talksVC.configure = { cell, item in
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.speaker
    }
    meetupsVC.navigationController?.pushViewController(talksVC, animated: true)
}

let nc = UINavigationController(rootViewController: meetupsVC)

nc.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
PlaygroundPage.current.liveView = nc.view
