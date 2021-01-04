---
title: 在 Windows Forms 中启用 High DPI
date: 2019-10-27T02:34:26.681Z
description: '在 Windows Forms 中启用 High DPI, WinForms'
tags:
  - WinForms
  - C Sharp
categories:
  - WinForms
toc: false
mathjax: false
---
最近在使用 WinForms 时，发现默认情况下各个控件很模糊。最终找到的解决办法是在项目里的 `App.config` 文件里的 `configuration` 标签内添加如下代码[^1]：

```xml
<System.Windows.Forms.ApplicationConfigurationSection>
  <add key="DpiAwareness" value="PerMonitorV2" />
</System.Windows.Forms.ApplicationConfigurationSection>
```

然后需要在 `Main` 函数中调用 `EnableVisualStyles` [^2]方法： 

```c#
static void Main()
{
    Application.EnableVisualStyles();
    Application.SetCompatibleTextRenderingDefault(false);
    Application.Run(new Form2());
}
```

重新编译即可。


[^1]: [High DPI support in Windows Forms](https://docs.microsoft.com/en-us/dotnet/framework/winforms/high-dpi-support-in-windows-forms)
[^2]:  https://docs.microsoft.com/zh-cn/dotnet/api/system.windows.forms.application.enablevisualstyles?view=netframework-4.8
