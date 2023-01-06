//: [Previous](@previous)

/*
- Use of Defer Keyword:
 - Source: https://blog.logrocket.com/complete-guide-swift-defer-statement/
 
 - Defer Keyword
    - The Swift defer statement is useful for cases where we need something done — no matter what — before exiting the scope.
    - For example, defer can be handy when cleanup actions are performed multiple times, like closing a file or locking a lock, before exiting the scope.
        - Example Usecases:
            - Locking
            - Networking
            - Updating layout
            - Loading indicator
            - Committing changes
    -

*/


import Foundation

/*

// MARK: Locking

func append(_ elements: [Element]) {
    lock.lock()

    defer {
        lock.unlock()
    }

    array.append(contentsOf: elements)
}

// MARK: Networking

func fetchQuotes(from url: URL, completion: @escaping (Result<[Quote], Error>) -> ()) {
    var result: Result<[Quote], Error>

    defer {
        completion(result)
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            result = .failure(error)
        }

        guard let response = response else {
            result = .failure(URLError(.badServerResponse))
        }

        guard let data = data else {
            result = .failure(QuoteFetchError.missingData)
        }

        result = .success(quoteResponse(for: data))
    }
    
    task.resume()
}

// MARK: Updating layout

func reloadAuthorsData() {
    defer {
        self.setNeedsLayout()
    }

    removeAllViews()

    guard let dataSource = quotingDataSource else { return }

    let itemsCount = dataSource.numberOfItems(in: self)

    for index in itemsCount.indices {
        let view: AuthorView = getViewForIndex(index)

        addSubview(view)

        authorViews.append(view)
    }
}

func updateViewContstraints() {
    defer {
        self.layoutIfNeeded()
    }

    // One conditional statement to check for constraint and can return early

    // Another statement to update another constraint
}

// MARK: Loading indicator

func performLogin() {
    shouldShowProgressView = true

    defer {
        shouldShowProgressView = false
    }

    do {
        let _ = try await LoginManager.performLogin()

        DispatchQueue.main.async {
            self.coordinator?.successfulLogin()
        }

    } catch {
        let error = error
        showErrorMessage = true
    }
}

// MARK: Committing changes

func animateUI() {
    CATransaction.begin()

    defer {
       CATransaction.commit()
    }

    // Configurations
    CATransaction.setAnimationDuration(0.5)
    button.layer.opacity = 0.2
    button.layer.backgroundColor = UIColor.green.cgColor
    button.layer.cornerRadius = 16
}

func setupCaptureSession() {
    cameraSession.beginConfiguration()

    defer {
        cameraSession.commitConfiguration()
    }

    // Statement to check for device input, and return if there is any error
    do {
        deviceInput = try AVCaptureDeviceInput(device: device)
    } catch let error {
        print(error.localizedDescription)
        return
    }

    // Statements to update the cameraSession
    cameraSession.addInput(deviceInput)
}

 */
 
//: [Next](@next)
