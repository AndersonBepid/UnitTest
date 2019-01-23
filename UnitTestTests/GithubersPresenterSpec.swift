//
//  UnitTestTests.swift
//  UnitTestTests
//
//  Created by Anderson Moura de Oliveira on 22/01/19.
//  Copyright © 2019 Zup. All rights reserved.
//

@testable import UnitTest
import Nimble
import Quick

class GithubersPresenterSpec: QuickSpec {
    
    struct Mocked: Error, LocalizedError {
        
        var isSuccess: Bool = true

        var errorDescription: String? {
            return "A Test Error"
        }
        
        var githubersStub: Githubers = [
            Githuber(photo: "", id: 1, name: "Anderson", type: "User")
        ]
    }
    
    class GithubersViewControllerSpy: GithubersPresenterDelegate {
        
        var displayGithubersCalled = false
        
        var displayGithubersResult: Result<Githubers>!

        func displayGithubers(result: Result<Githubers>) {
            self.displayGithubersResult = result
            displayGithubersCalled = true
        }
    }
    
    class GithuberWorkerSpy: GithuberWorker {
        
        var mocked: Mocked!
        
        var fetchCalled = false
        
        override func fetch(_ completion: @escaping (Result<Githubers>) -> Void) {
            fetchCalled = true
            
            if mocked.isSuccess {
                completion(.success(mocked.githubersStub))
            } else {
                completion(.failure(mocked as NSError))
            }
        }
    }

    override func spec() {
        
        describe("A GithubersPresenter") {
            
            var sut: GithubersPresenter!
            var viewControllerSpy: GithubersViewControllerSpy!
            var workerSpy: GithuberWorkerSpy!
            var mocked: Mocked!
            
            beforeEach {
                mocked = Mocked()
                viewControllerSpy = GithubersViewControllerSpy()
                workerSpy = GithuberWorkerSpy()
                sut = GithubersPresenter(delegate: viewControllerSpy, provider: workerSpy)
            }
            
            describe("fetchAllGithubers") {
                
                context("success") {
                    
                    it("should list githubers") {
                        
                        //Given
                        let githubers = mocked.githubersStub
                        mocked.isSuccess = true
                        workerSpy.mocked = mocked
                        
                        //When
                        sut.fetchAllGithubers()
                        
                        //Then
                        expect(viewControllerSpy.displayGithubersCalled).toEventually(beTrue(), timeout: 10.0)
                        expect(workerSpy.fetchCalled).to(beTrue())
                        expect(viewControllerSpy.displayGithubersResult.resource?.hashValue).to(equal(githubers.hashValue))
                    }
                }
                
                context("failure request") {
                 
                    it("should return an error") {
                        
                        //Given
                        let errorDescription = mocked.errorDescription
                        mocked.isSuccess = false
                        workerSpy.mocked = mocked
                        
                        //When
                        sut.fetchAllGithubers()
                        
                        //Then
                        expect(viewControllerSpy.displayGithubersCalled).toEventually(beTrue(), timeout: 10.0)
                        expect(workerSpy.fetchCalled).to(beTrue())
                        expect(viewControllerSpy.displayGithubersResult.error?.localizedDescription).to(equal(errorDescription))
                    }
                }
            }
        }
    }
}
