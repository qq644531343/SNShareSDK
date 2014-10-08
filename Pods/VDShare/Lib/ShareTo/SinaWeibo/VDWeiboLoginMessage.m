#import "VDWeiboLoginMessage.h"
#import "VDLoginCache.h"

@implementation VDWeiboLoginMessage
@synthesize accessToken = _accessToken,uid = _uid,scope = _scope,expireDate = _expireDate,face = _face,faceBackground = _faceBackground,description =_description;
SYNTHESIZE_SINGLETON_FOR_CLASS(VDWeiboLoginMessage)

- (void) initData
{
    //登录信息
    self.accessToken = nil;
    self.uid = nil;
    self.scope = nil;
    self.expireDate = nil;
    //用户信息
    self.screenName = nil;
    self.name = nil;
    self.description = nil;
    self.url = nil;
    //头像
    self.face = nil;
    self.bigFace = nil;
    self.highFace = nil;
    self.faceBackground = nil;
    //附加部分
    self.followersCount = 0;
    self.friendsCount = 0;
    self.favouritesCount = 0;
    self.verified = 0;
}

- (id)init
{
    if(self == nil)
    {
        self = [super init];
        if(self)
        {
            [self initData];
        }
    }
    
    return self;
}

- (void)initWithLoginMessage:(VDWeiboLoginMessage *) mess
{
//    [self initData];
    self.accessToken = mess.accessToken;
    self.uid = mess.uid;
    self.scope = mess.scope;
    self.expireDate = mess.expireDate;
}

-(void)dealloc
{
    [self initData];
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self != nil)
    {
        //登录信息
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.scope = [aDecoder decodeObjectForKey:@"scope"];
        self.expireDate = [aDecoder decodeObjectForKey:@"expireDate"];
        //用户信息
        self.screenName = [aDecoder decodeObjectForKey:@"screenName"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
        self.description = [aDecoder decodeObjectForKey:@"description"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
        //头像
        self.face = [aDecoder decodeObjectForKey:@"face"];
        self.bigFace = [aDecoder decodeObjectForKey:@"bigFace"];
        self.highFace = [aDecoder decodeObjectForKey:@"highFace"];
        self.faceBackground = [aDecoder decodeObjectForKey:@"faceBackground"];
        //附加部分
        self.followersCount = [aDecoder decodeInt32ForKey:@"followersCount"];
        self.friendsCount = [aDecoder decodeInt32ForKey:@"friendsCount"];
        self.favouritesCount = [aDecoder decodeInt32ForKey:@"favouritesCount"];
        self.verified = [aDecoder decodeBoolForKey:@"verified"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //登录信息
    [aCoder encodeObject:self.accessToken forKey:@"accessToken"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.scope forKey:@"scope"];
    [aCoder encodeObject:self.expireDate forKey:@"expireDate"];
    //用户信息
    [aCoder encodeObject:self.screenName forKey:@"screenName"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeObject:self.description forKey:@"description"];
    [aCoder encodeObject:self.url forKey:@"url"];
    //头像
    [aCoder encodeObject:self.face forKey:@"face"];
    [aCoder encodeObject:self.bigFace forKey:@"bigFace"];
    [aCoder encodeObject:self.highFace forKey:@"highFace"];
    [aCoder encodeObject:self.faceBackground forKey:@"faceBackground"];
    //附加部分
    [aCoder encodeInt32:self.followersCount forKey:@"followersCount"];
    [aCoder encodeInt32:self.friendsCount forKey:@"friendsCount"];
    [aCoder encodeInt32:self.favouritesCount forKey:@"favouritesCount"];
    [aCoder encodeBool:self.verified forKey:@"verified"];
}


- (BOOL)checkLoginExpire
{
    if(!self.expireDate)
    {
        return NO;
    }
    NSComparisonResult result = [self.expireDate compare:[NSDate date]];
    if(result == NSOrderedDescending || result == NSOrderedSame)
    {
        return YES;
    }
    return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"accessToken:%@,expireDate:%@,scope:%@,uid:%@,screenName:%@,name:%@,location:%@,url:%@,followersCount:%d,friendsCount:%d,favouritesCount:%d,face:%@,bigFace:%@,highFace:%@,faceBackground:%@",_accessToken,_expireDate,_scope,_uid,_screenName,_name,_location,_url,_followersCount,_friendsCount,self.favouritesCount,self.face,self.bigFace,self.highFace,self.faceBackground];
}

@end
