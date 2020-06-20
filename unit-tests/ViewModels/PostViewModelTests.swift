//
//  PostViewModelTests.swift
//  unit-tests
//
//  Created by Nestor Garcia on 18/06/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import XCTest
@testable import tuit

class PostViewModelTests: XCTestCase {

    var vm: PostsViewModel!
    var typicodeServiceMock: TypicodeServiceMock!
    
    override func setUp() {
        super.setUp()
        typicodeServiceMock = TypicodeServiceMock()
        vm = PostsViewModel(mode: .normal, typicodeService: typicodeServiceMock)
    }
    
    func testIntialState_Normal() {
        XCTAssertEqual(vm.screenTitle, NSLocalizedString("posts-navigation-bar-title"))
        XCTAssertEqual(vm.alertErrorTitle, NSLocalizedString("alert-error-title"))
        XCTAssertEqual(vm.loadingMessage, NSLocalizedString("posts-loading"))
    }
    
    func testIntialState_Filtered() {
        vm = PostsViewModel(mode: .filtered(userId: 123), typicodeService: typicodeServiceMock)
        XCTAssertEqual(vm.screenTitle, "123 " + NSLocalizedString("posts-navigation-bar-title"))
        XCTAssertEqual(vm.alertErrorTitle, NSLocalizedString("alert-error-title"))
        XCTAssertEqual(vm.loadingMessage, NSLocalizedString("posts-loading"))
    }
    
    func testFetchPosts_Success() {
        let posts = [PostMock.sample1, PostMock.sample2, PostMock.sample3]
        typicodeServiceMock.nextFetchPostsResult = .success(posts)
        
        vm.refresh()
        
        XCTAssertNil(vm.errorMessage)
        XCTAssertEqual(vm.cellViewModels?.count, 3)
        XCTAssertEqual(vm.cellViewModels?.compactMap { $0.id }, posts.map { $0.id })
    }
    
    func testFetchPosts_Failure() {
        typicodeServiceMock.nextFetchPostsResult = .failure(.generic(message: "An Error"))
        
        vm.refresh()
        
        XCTAssertEqual(vm.errorMessage, TypicodeError.generic(message: "An Error").description)
        XCTAssertEqual(vm.cellViewModels?.count, 0)
    }
    
    func testFetchPosts_Filter() {
        let posts = [PostMock.sample1, PostMock.sample2, PostMock.sample3]
        typicodeServiceMock.nextFetchPostsResult = .success(posts)
        vm = PostsViewModel(mode: .filtered(userId: 1), typicodeService: typicodeServiceMock)
        
        vm.refresh()
        
        XCTAssertNil(vm.errorMessage)
        XCTAssertEqual(vm.cellViewModels?.count, 1)
        XCTAssertEqual(vm.cellViewModels?.compactMap { $0.id }, [11])
    }
}
