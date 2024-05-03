//
//  DBError.swift
//  WatchIt
//
//  Created by 김지연 on 5/3/24.
//

import Foundation

enum DBError: String, Error {
    case createError
    case fetchError
    case deleteError
    case searchError
}

extension DBError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .createError:
            return "저장에 실패하였습니다."
        case .fetchError:
            return "불러오는데 실패하였습니다."
        case .deleteError:
            return "취소에 실패하였습니다."
        case .searchError:
            return "데이터를 불러오는데 실패하였습니다."
        }
    }
}
