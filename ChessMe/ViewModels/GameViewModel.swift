import Foundation
import Combine

final class GameViewModel: ObservableObject {
    @Published private(set) var game = ChessGame()

    private let rulesService: ChessRulesService

    var statusText: String {
        rulesService.placeholderMessage + " " + "White to move first."
    }

    init(rulesService: ChessRulesService = ChessRulesService()) {
        self.rulesService = rulesService
    }
}
