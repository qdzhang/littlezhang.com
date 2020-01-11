---
title: 用VS Code调试C++程序
date: 2019-12-23T02:14:42.471Z
description: 'vs code,如何使用vs code调试程序'
tags:
  - vscode
categories:
  - 杂记
toc: true
mathjax: false
---
为什么要用 VS Code 来调试 C++ 程序呢？原因很简单，因为 VS Code 配置好了之后可以**单文件调试**，其他 IDE 都只能建立一个项目再进行调试（也可能是我没有发现这个功能）。如果只是编写一些简单的、无关联的小程序，比如说刷算法题等等，**单文件调试**既能编译程序，又能下断点debug，很是方便。

调试有两步，一是编译，二是把编译后的可执行文件传递给调试器进行调试。以下的过程都在一个打开的文件夹里操作。

## 一、配置 task.json

通过配置 task.json，来配置编译过程。点击菜单栏上的“终端” --> “配置任务...”，选择“使用模板创建 task.json 文件”，再选择“Others”，就可以在当前目录下创建一个 `.vscode` 文件夹，里面包含一个 task.json 文件了。

{{< video src="https://res.cloudinary.com/dny1wymwm/video/upload/v1578747255/task.av1_d3s44k.mp4">}}

复制下面的内容，全部替换自动生成的 task.json 文件的内容。鼠标放在每一项上，都可以看到 VS Code 给出的提示，可以根据自己的需要进行修改。

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "g++.exe build active file",
            "type": "shell",
            "command": "g++",
            "args": [
                "-g",
                "${file}",
                "-o",
                "${fileDirname}\\${fileBasenameNoExtension}.exe"
            ],
            "group": {
                "kind": "build",
                "isDefault": true
            }
        }  
    ]
}
```

点击菜单栏上的“终端” --> “运行生成任务”，就可以对当前文件进行编译，会在当前目录下生成一个 exe 文件。

## 二、配置 launch.json

点击菜单栏上的“调试” --> “添加配置（或是打开配置）”，会在 `.vscode` 目录下创建一个 launch.json 文件。

{{< video src="https://res.cloudinary.com/dny1wymwm/video/upload/v1578747451/launch.av1_owzih8.mp4" >}}

复制下面的内容，全部替换自动生成的 launch.json 文件的内容。鼠标放在每一项上，都可以看到 VS Code 给出的提示，可以根据自己的需要进行修改。

```json
{
    // 使用 IntelliSense 了解相关属性。 
    // 悬停以查看现有属性的描述。
    // 欲了解更多信息，请访问: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "g++.exe build and debug active file",
            "type": "cppdbg",
            "request": "launch",
            "program": "${fileDirname}\\${fileBasenameNoExtension}.exe",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "miDebuggerPath": "这里替换成自己的gdb路径",
            "setupCommands": [
                {
                    "description": "为 gdb 启用整齐打印",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ],
            "preLaunchTask": "g++.exe build active file"
        }
    ]
}
```

这两个文件都完成后，就可以按 F5 进行调试了。还有一个小细节需要注意，如果打开了多个文件夹，每个文件夹下都有自己的`.vscode` 配置文件夹，在进行调试时，注意在选择正确的 launch.json 配置文件。

![](https://res.cloudinary.com/dny1wymwm/image/upload/v1577067126/choose_json_m4xkx8.png)
