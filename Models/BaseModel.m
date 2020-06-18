//
//  BaseModel.m
//  LearnFromMJ
//
//  Created by LIANDI on 2018/11/15.
//  Copyright © 2018 LIANDI. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation BaseModel

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    id objc = [[self alloc] init];
    id idSelf = self;
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        // 获取成员属性名
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 处理获取到的变量名（第一位为_需要截取掉）
        NSString *key = [ivarName substringFromIndex:1];
        
        // 当字典中的字段和定义属性名不一致的时候，需要对key进行转换，以取得字典中的数据
        id idKey = [idSelf modelCustomPropertyMapper][key];
        if (idKey == nil) {
            idKey = key;
        }
        
        // 根据key值获取字典中对应的value
        id value = dict[key];
        if (value == nil) {
            continue;
        }
        
        // 获得成员变量的类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        NSLog(@"ivar - %@, type - %@", ivarName, ivarType);
        // 获取到的当前属性名的类型是这种@"@\"User\""，需要转换成@"User"
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        
        // 二级转换:如果字典中还有字典，也需要把对应的字典转换成模型
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            // 根据字符串类名生成类对象
            Class modelClass = NSClassFromString(ivarType);
            if (modelClass) {
                value = [modelClass modelWithDict:value];
            }
            // 三级转换：NSArray中也是字典，把数组中的字典转换成模型
        } else if ([value isKindOfClass:[NSArray class]]) {
            // 判断对应类有没有实现字典数组转模型数组的协议
            if ([self respondsToSelector:@selector(arrayContainModelClass)]) {
                // 获取数组中字典对应的type
                NSString *type = [idSelf arrayContainModelClass][key];
                Class classModel = NSClassFromString(type);
                NSMutableArray *arrM = [NSMutableArray array];
                for (NSDictionary *dict in value) {
                    id model =  [classModel modelWithDict:dict];
                    if (model) {
                        [arrM addObject:model];
                    }
                }
                value = arrM;
            }
        }
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    
    return objc;
}

/**
 * @func 字典里面包含数组的时候，数组里面的对象对应的是什么model，在这里表明，比如users代表的是User模型数组
 * 返回值的格式是@{@"users":@"User"}，其中users是获取的json数据中的字段，User代表的是users数组里面对象对应的模型model
 */
+ (NSDictionary *)arrayContainModelClass {
    return @{@"users":@"User"};
}

/**
 * @func 对获取的json数据中的字段和自己定义的属性名不一致的时候，在这里返回出来
 * @des  返回值的格式是@{@"birthday":@"birth"},birthday表示的是自己定义的属性名，birth是json数据中对应的字段
 */
+(NSDictionary *)modelCustomPropertyMapper {
    //    return @{@"birthday":@"birth"};
    return @{};
}

// 归档
- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar =  ivars[i];
        const char *name = ivar_getName(ivar);
        
        /**也可以用runtime发消息调用getter方法实现取值
         * NSString *ivarName = [NSString stringWithUTF8String:name];
         * SEL getter = NSSelectorFromString([ivarName substringFromIndex:1]);
         * id value = ((id (*)(id, SEL))(void *)objc_msgSend)((id)self, getter);
        */
        [aCoder encodeObject:[self valueForKey:[NSString stringWithUTF8String:name]] forKey:[NSString stringWithUTF8String:name]];
    }
    free(ivars);
}

// 解档
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar =  ivars[i];
            const char *name = ivar_getName(ivar);
            
            id value = [aDecoder decodeObjectForKey:[NSString stringWithUTF8String:name]];
            /**也可以用runtime发消息调用setter方法实现塞值
             * NSString *ivarName = [NSString stringWithUTF8String:name];
             * ivarName = [ivarName substringFromIndex:1];
             * NSString *setterName = ivarName;
             * if (![setterName hasPrefix:@"_"]) {
             * NSString *firstLetter = [NSString stringWithFormat:@"%c", [setterName characterAtIndex:0]];
             * setterName = [setterName substringFromIndex:1];
             * setterName = [NSString stringWithFormat:@"%@%@", firstLetter.uppercaseString, setterName];
             * }
             * setterName = [NSString stringWithFormat:@"set%@:", setterName];
             * SEL setter = NSSelectorFromString(setterName);
             * ((void (*)(id, SEL, id))objc_msgSend)(self, setter, value);
             */
            [self setValue:value forKey:[NSString stringWithUTF8String:name]];
        }
        free(ivars);
    }
    return self;
}

void functionForMethod(id self, SEL _cmd) {
    NSLog(@"Hello!");
}

// 动态方法解析
// 给个机会让类添加这个实现这个函数
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selStr = NSStringFromSelector(sel);
    if ([selStr isEqualToString:@"xxxMethod"]) {
        /**类方法的場合
         * Class metaClass = objc_getMetaClass("xxxClass");
         * class_addMethod(metaClass, sel, (IMP)functionForClassMethod, "v@:");
         * return [super resolveClassMethod:sel];
         */
        
        class_addMethod(self, sel, (IMP)functionForMethod, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

// 备用接受者,这个备用接受者只能是一个新的对象，不能是self本身，否则就会出现无限循环。
// 将消息转出某对象,让别的对象去执行这个函数
- (id)forwardingTargetForSelector:(SEL)aSelector {
//    NSString *selectorStr = NSStringFromSelector(aSelector);
//    if ([selectorStr isEqualToString:@"xxxMethod"]) {
//        XxxClass *xxxClass = [[XxxClass alloc] init];
//        return xxxClass;
//    }
    return [super forwardingTargetForSelector:aSelector];
}

// 调用methodSignatureForSelector（函数符号制造器）和forwardInvocation（函数执行器）灵活的将目标函数以其他形式执行
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSString *selStr = NSStringFromSelector(aSelector);
    if ([selStr rangeOfString:@"set"].location == 0) {
        // 动态造一个 setter函数
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    } else {
        // 动态造一个 getter函数
        return [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
}

// 完整消息转发
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSMutableDictionary *data;
    NSString *selStr = NSStringFromSelector([anInvocation selector]);
    if ([selStr rangeOfString:@"set"].location == 0) {
        //setter函数形如 setXXX: 拆掉 set和冒号
        selStr = [[selStr substringWithRange:NSMakeRange(3, [selStr length] - 4)] lowercaseString];
        NSString *obj;
        //从参数列表中找到值
        [anInvocation getArgument:&obj atIndex:2];
        [data setObject:obj forKey:selStr];
    } else {
        NSString *obj = [data objectForKey:selStr];
        [anInvocation setReturnValue:&obj];
    }
}

// 如果都不中，调用doesNotRecognizeSelector抛出异常
- (void)doesNotRecognizeSelector:(SEL)aSelector {
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 1.替换实例方法
        Class clazz = [self class];
        // 2.替换类方法
//        Class clazz = objc_getClass([self class]);
        
        // 源方法的SEL和Method
        SEL originalSel = @selector(originalMethod:);
        Method originalMethod = class_getInstanceMethod(clazz, originalSel);
        // 获取类方法Method
//        Method originalMethod = class_getClassMethod(clazz, originalSel);
        
        // 交换方法的SEL和Method
        SEL targetSel = @selector(targetMethod:);
        Method targetMethod = class_getInstanceMethod(clazz, targetSel);
        
        //先尝试給源方法添加实现，这里是为了避免源方法没有实现的情况
        BOOL isMethodExist = class_addMethod(clazz, originalSel, method_getImplementation(targetMethod), method_getTypeEncoding(targetMethod));
        if (isMethodExist) {
            //添加成功：将源方法的实现替换到交换方法的实现
            class_replaceMethod(clazz, targetSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            //添加失败：说明源方法已经有实现，直接将两个方法的实现交换即可
            method_exchangeImplementations(originalMethod, targetMethod);
        }
    });
}

+ (void)swizzleMethods:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel {
    
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method swizMethod = class_getInstanceMethod(class, swizSel);
    
    BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, swizMethod);
    }
}

@end
