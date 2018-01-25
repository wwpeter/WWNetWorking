# WWNetWorking
对AFN进行的2次封装，支持post ，get，delete，put，请求，支持post 上传json数据放在body中，方便扩展，方法不够可以对AZRequestGenerator类进行改进


Call API

WWNetWorking API URL is constituted by 4 part:

AZService+AZService Version+API method Name+API Parameters
Custom a CTService

Inherit CTService and follow AZServiceProtocol

@interface GDMapService : AZService <AZServiceProtocol>

Implement all methods of AZServiceProtocol

...
- (NSString *)onlineApiBaseUrl
{
    return @"http://restapi.amap.com";
}
- (NSString *)onlineApiVersion
{
    return @"v3";
}
...

Custom an APIManager

Inherit AZAPIBaseManager and follow AZAPIManager Protocal

@interface TestAPIManager : AZAPIBaseManager <AZAPIManager>

Implement all methods of AZAPIManager

...
- (NSString *)methodName
{
    return @"geocode/regeo";
}

- (NSString *)serviceType
{
    return kAZServiceWZB;
}

- (AZAPIManagerRequestType)requestType
{
    return AZAPIManagerRequestTypePost;
}
...

Call API

Instantiation of API Manager in class

@property (nonatomic, strong) TestAPIManager *testAPIManager;

- (TestAPIManager *)testAPIManager
{
    if (_testAPIManager == nil) {
        _testAPIManager = [[TestAPIManager alloc] init];
        _testAPIManager.delegate = self;
        _testAPIManager.paramSource = self;
    }
    return _testAPIManager;
}

Implement methods of AZAPIManagerParamSource and AZAPIManagerCallBackDelegate

#pragma mark - AZAPIManagerParamSource
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager
{
    return parmas;
}

#pragma mark - AZAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager
{
    //do something
}
- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager
{
    //do something
}

And easy to use

[self.testAPIManager loadData];
