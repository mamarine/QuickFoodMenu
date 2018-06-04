//
//  AsyncOperation.swift
//  QuickFoodMenu
//
//  Created by maojie on 2/4/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

class AsyncOperation: Operation {
    fileprivate var _executing : Bool
    fileprivate var _finished : Bool
    fileprivate var _isCancelled: Bool
    fileprivate var _isReady: Bool

    override init() {
        _executing = false
        _finished = false
        _isCancelled = false
        _isReady = true
        super.init()
        name = "Async Operation"
    }

    override var isExecuting: Bool {
        get { return _executing }
        set {
            if newValue != _executing {
                update({_executing = newValue}, key: "isExecuting")
            }
        }
    }

    public override var isReady: Bool {
        get { return _isReady }
        set {
            if newValue != _isReady {
                update({ _isReady = newValue }, key: "isReady")
            }
        }
    }

    override var isFinished: Bool {
        get { return _finished }
        set {
            if newValue != _finished {
                update({_finished = newValue}, key: "isFinished")
            }
        }
    }

    public override var isCancelled: Bool {
        get { return _isCancelled }
        set {
            if newValue != _isCancelled {
                update({ _isCancelled = newValue }, key: "isCancelled")
            }
        }
    }

    override var isAsynchronous: Bool {
        get {
            return true
        }
    }

    override func start() {
        if self.isExecuting == false {
            self.isReady = false
            self.isExecuting = true
            self.isFinished = false
            self.isCancelled = false
        }
    }

    private func update(_ change: () -> Void, key: String) {
        willChangeValue(forKey: key)
        change()
        didChangeValue(forKey: key)
    }

    func finish() {
        print("\(self.name!) operation finished.")
        self.isExecuting = false
        self.isFinished = true
    }

    override func cancel() {
        print("\(self.name!) operation cancelled.")
        self.isExecuting = false
        self.isCancelled = true
    }
}
