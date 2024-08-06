# AutoDisable_Clash_ManualProxy
关机忘记关闭Clash For Windows的手动设置代理服务器的简单解决方案-自动化关闭电脑的手动代理
一开始是想执行powershell命令（CheckClashAndResetProxy.ps1），关机前监测clash是否运行，从而重置代理，但是在我的虚拟机和计算机上，gpedit.msc（组策略编辑器）创建关机执行脚本，均无法运行成功。
然后有了更加好的想法，关机前检测计算机手动代理设置是否打开，如果是打开状态，将其禁用即可，于是利用ChatGPT编写了powershell命令（DisableManualProxy.ps1），使用taskschd.msc（任务计划程序）完成自动化。
创建 DisableManualProxy.xml 的步骤：
   1、 win + r 打开运行程序，输入 taskschd.msc ，点击确定
   
   ![image](https://github.com/user-attachments/assets/7f63d217-5bd4-44d5-a4f7-023c49f9a28b)
   
   2、在【任务计划程序】中点击右边(任务计划程序库)下的(创建任务）
   
   ![image](https://github.com/user-attachments/assets/4ad67f41-2ae3-49a2-b016-423690c6352d)

  3、任务名称，我命名为DisableManualProxy，并将【使用最高权限运行】勾选上
  
  ![image](https://github.com/user-attachments/assets/93c4a2a0-3d95-4538-aa71-0370f0752d11)

  4、点击第二项【触发器】，在界面中点击【新建】

  ![image](https://github.com/user-attachments/assets/cd451c07-2b9d-46ea-8a9c-68ced87c7238)

  新出现界面中，开始任务 选择【发生事件时】; 日志 拉到最下方选择【系统】；事件ID填写1074（用户发起关机或重启事件）

  ![image](https://github.com/user-attachments/assets/0833ac3e-f009-47a8-b0d2-dd94cb2c0df5)

  6006为系统正常关闭事件，6008为系统非正常关闭事件，希望计划更加完善可以自行添加，我感觉关机或重启已经够用了。

  5、点击第三项【操作】，在界面中点击【新建】
  在 程序或脚本 输入 powershell ,而在添加参数中填写 -File "‪C:\script\DisableManualProxy.ps1" ,后面这里是你的脚本所在文件位置

  ![image](https://github.com/user-attachments/assets/cbf5494f-9005-4ef3-920b-5d4068651b95)

  6、条件和设置按自己需要的来，附上我自己的界面

  ![条件](https://github.com/user-attachments/assets/0ddb56a9-24a2-4f24-b3cd-5d2fb67bbd14)


  ![image](https://github.com/user-attachments/assets/069f82b1-9130-430d-a5e6-c10725b3ed9e)

  7、输入密码

  ![image](https://github.com/user-attachments/assets/e0c000b8-f054-4486-b8d3-30d075e3d8fd)

  这里的密码不是你电脑的开机密码，是你的微软账户密码！！！

  至此，任务创建完毕，可以不关闭Clash代理重启试试效果。
  然后，我发现两年前已经有人上传了解决此问题的方法，所以我借用了一下他的代码，附上链接：https://github.com/Sicheng-Wei/Clash_Proxy_AutoDisable?tab=readme-ov-file

  附上所借用的代码：
  ```
  reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /d 0 /t REG_DWORD /f 
  ```
 利用此代码创建一个bat文件，在第5步操作中将 程序或脚本 选择为创建的批处理文件【DisableManualProxy.bat】
 其他操作不变，也是可以实现关机时禁用手动设置代理。

如果嫌每一步设置太麻烦，可以下载【DisableManualProxy.xml】文件，点击 任务计划程序中的 【导入任务】

![image](https://github.com/user-attachments/assets/4e004152-edf0-4844-b4e0-f9a982721b79)

选中【DisableManualProxy.xml】并导入，但是导入后，选中此任务，点击【属性】

![image](https://github.com/user-attachments/assets/7e596ae3-1af7-46df-8b64-9c10ece81831)

将 常规 中的账户更改为自己计算机用户名（不确定不改行不行，反正改了可以）

![image](https://github.com/user-attachments/assets/c9b52a3f-dcda-40e1-8fef-4c04f35d5c26)

将 操作 中的路径改为自己的bat文件或者ps1文件路径

![image](https://github.com/user-attachments/assets/4b8e189a-640c-4493-8e14-749509745717)



