import B2Kit

// Fill in your account-id and application-key
let ACCOUNT_ID = "..."
let APPLICATION_KEY = "..."
let b2 = B2.sharedInstance()

func fetchOrCreatebucket(named name: String, for account: B2Account) throws -> B2Bucket {
    return try b2.listBuckets(for: account, bucketId: nil, bucketName: nil, bucketTypes: .all).first ??
        b2.createBucket(withBucketName: name, account: account, bucketType: .allPrivate, info: [:], lifeCycleRules: [])
}

do {
    let account = try b2.authorizeAccount(withAccountId: ACCOUNT_ID, applicationKey: APPLICATION_KEY)
    let bucket = try fetchOrCreatebucket(named: "B2Kit-Playground-Test-Bucket", for: account)
    let files = try b2.listFiles(withBucketId: bucket.bucketId, account: account, startFileName: nil, maxFileCount: nil, prefix: nil)
    print(files)
    try b2.deleteBucket(withBucketId: bucket.bucketId, account: account)
} catch {
    print(error)
}

