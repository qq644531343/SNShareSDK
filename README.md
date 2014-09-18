SNShareSDK
==========

###分享工程配置指南：
1, 将vdshare目录加入到你的工程中。

2, 添加如下系统库:

![image](https://github.com/qq644531343/iosTool/blob/master/screenshot/share.png)

3, 将目录中TencentOpenApi.framework拖到Build Phases -> Libarary中
确保Build Phases -> Resource中含有TencentOpenApi_iOS_Bundle.bundle文件

4, 找到工程的Build Settings -> Search Paths，确保含有如下信息：
	
	    		
    	* Framework Search Path栏含有  $(PROJECT_DIR)/SNShareSDK/vdshare/res
		* Header Search Path栏含有：
		    "$(SRCROOT)/SNShareSDK/vdshare/include"
		    "$(SRCROOT)/SNShareSDK/vdshare/res/TencentOpenAPI.framework/Headers"
		* Library Search Path含有：$(PROJECT_DIR)/SNShareSDK/vdshare
	
	其中SNShareSDK为你工程目录名，路径为你的相对路径即可，确保含有上述项目即可。
      
5, 找到工程的Info -> URL Types，添加对应的schema

![image](https://github.com/qq644531343/iosTool/blob/master/screenshot/shareConfigInfo.png)