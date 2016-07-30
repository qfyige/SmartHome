//
//  ChangeSeverDefine.h
//  
//
//  Created by tong lele on 16/7/13.
//
//

#ifndef ChangeSeverDefine_h
#define ChangeSeverDefine_h

//1 为开发环境 2线上环境
#define SERVER_TYPE 1

#if SERVER_TYPE == 1
#define HostUrl @"ws://101.201.209.42:8080/ldnet/evermobws"
#define authkey @"0B51D241121C19364C9D0EC3BC8CA417"

#elif SERVER_TYPE == 2
#define HostUrl @"ws://101.201.209.42:8080/ldnet/evermobws"
#define authkey @"0B51D241121C19364C9D0EC3BC8CA417"

#endif

#endif /* ChangeSeverDefine_h */
