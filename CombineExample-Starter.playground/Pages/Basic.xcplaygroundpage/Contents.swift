import Combine

check("Empty") {
    Empty<Int, SampleError>()
}

check("Just") {
    Just("Hello SwiftUI")
}


check("Sequence") {
    [1,2,3,4,5]
        .publisher
        .flatMap { nubmer in
            [1,2,3,4,5]
                .publisher
                .map { "\(nubmer)\($0)" }
                .removeDuplicates()
        }
}

check("Fail") {
    Fail<Int, SampleError>(error: .sampleError)
//        .mapError{}
//        .replaceError(with: <#T##Int#>)
}
