（1）文件名称:
	手机名称_手机系统版本_环境_外部版本号_版本升级号_崩溃名称_用户ID.文本文件后缀
	如：华为_10.2_Debug_2.3.1_10_NSRangeException_1100112.txt

（2）格式：纯文本格式
（3）说明：版本升级号没有则不填写
  (4)  文件内容格式：
	下面红色部分表示客户端写的字符串
========异常错误报告========
name:NSRangeException
reason:
*** -[__NSArray0 objectAtIndex:]: index 0 beyond bounds for empty NSArray
callStackSymbols:
0 CoreFoundation 0x000000018b9991d0 + 148
1 libobjc.A.dylib 0x000000018a3d055c objc_exception_throw + 56
2 CoreFoundation 0x000000018b903bac + 0
3 一码 0x000000010012f3c0 __37+[AppManager setupAppFinishLaunching]_block_invoke + 112
4 libdispatch.dylib 0x000000018a8221bc + 16
5 libdispatch.dylib 0x000000018a82ef94 + 576
6 libdispatch.dylib 0x000000018a83b634 + 204
7 libdispatch.dylib 0x000000018a824160 + 820
8 libdispatch.dylib 0x000000018a826bbc _dispatch_main_queue_callback_4CF + 572
9 CoreFoundation 0x000000018b946810 + 12
10 CoreFoundation 0x000000018b9443fc + 1660
11 CoreFoundation 0x000000018b8722b8 CFRunLoopRunSpecific + 444
12 GraphicsServices 0x000000018d326198 GSEventRunModal + 180
13 UIKit 0x00000001918b97fc + 684
14 UIKit 0x00000001918b4534 UIApplicationMain + 208
15 一码 0x0000000100159990 main + 124
16 libdyld.dylib 0x000000018a8555b8 + 4

