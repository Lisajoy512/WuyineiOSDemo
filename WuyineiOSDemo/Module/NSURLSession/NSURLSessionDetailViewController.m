//
//  NSURLSessionDetailViewController.m
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/7/30.
//  Copyright © 2019 wuyine. All rights reserved.
//

#import "NSURLSessionDetailViewController.h"
#define boundary @"zanglitao"
@interface NSURLSessionDetailViewController ()<NSURLSessionDownloadDelegate>

@end

@implementation NSURLSessionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NSURLSession";
    self.dataArray = @[@"nomarl",
                       @"upload",
                       @"download"
                       ];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0: {
            [self normalSessionDataTask];
        }
            break;
        case 1: {
            [self uploadSessionDataTask];
        }
            break;
        case 2: {
            [self downloadSessionDataTask];
        }
            break;
        default:
            break;
    }
}

#pragma mark -- didselect相关
//普通请求
- (void)normalSessionDataTask {
    // 1.请求路径
    NSURL *url = [NSURL URLWithString:@"http://rap2api.taobao.org/app/mock/163155/gaoshilist"];
    // 2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 3.创建 session 对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    // 普通任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse * response, NSError *error) {
        if (error) {
            NSLog(@"NSURLSessionDataTaskerror:%@",error);
            return;
        }
        
        // 解析数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"NSURLSessionDataTaskdic:%@",dic);
        
        //5.解析数据
        NSLog(@"NSURLSessionDataTask:%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    
    // 执行 task
    [dataTask resume];
}

//上传请求
- (void)uploadSessionDataTask {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://localhost/iostest.php"]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [self getDataBody];
    
    [request setValue:[NSString stringWithFormat:@"%d",[self getDataBody].length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data;boundary=%@",boundary] forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:[self getDataBody] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    [task resume];
}

//获取请求体内容
-(NSData *)getDataBody {
    NSMutableData *data = [NSMutableData data];
    
    NSString *top = [NSString stringWithFormat:@"--%@\nContent-Disposition: form-data; name=\"file\"; filename=\"1.png\"\nContent-Type: image/png\n\n",boundary];
    
    NSString *bottom = [NSString stringWithFormat:@"\n--%@--\n\n",boundary];
    
    NSData *content = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"]];
    
    [data appendData:[top dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:content];
    [data appendData:[bottom dataUsingEncoding:NSUTF8StringEncoding]];
    return data;
}

//download session
- (void)downloadSessionDataTask {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/e61190ef76c6a7efc0a0e1ebfffaaf51f2de667c.jpg"]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    //1、第一种不使用completionHandler，则完成后的回调会调用到NSURLSessionDownloadDelegate的方法
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    
    //2、第二针使用completionHandler，完成后的回调则直接执行hanlder,即使实现了delegate方法也不去执行
//    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
//                                                    completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString *dirPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//        NSString *path = [dirPath stringByAppendingPathComponent:@"1.jpg"];
//
//        NSFileManager *manager = [NSFileManager defaultManager];
//        if ([manager fileExistsAtPath:path isDirectory:NO]) {
//            [manager removeItemAtPath:path error:nil];
//        }
//
//        [manager moveItemAtPath:[location path] toPath:path error:nil];
//    }];
    [task resume];
}

#pragma mark -- NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSString *dirPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [dirPath stringByAppendingPathComponent:@"1.jpg"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path isDirectory:NO]) {
        [manager removeItemAtPath:path error:nil];
    }
    [manager moveItemAtPath:[location path] toPath:path error:nil];
}

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
    float percent = (float)fileOffset/expectedTotalBytes;
    NSLog(@"%f",percent);
}

//任务结束
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    NSLog(@"%s",__func__);
}
@end
