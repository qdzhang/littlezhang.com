---
title: "用组件拓展Hugo站点"
date: 2020-04-12
description: "如何利用Hugo Components拓展你的Hugo站点"
tags: ["建站", "Hugo"]
categories: ["Hugo"]
series: ["Hugo建站"]
math: false
markup: md
draft: false
---

这里的组件指的是 Hugo Theme Components[^1]，可以用来给现有的 Theme 增加一些功能、组件等等。通常，这些组件为 Hugo 站点提供 shortcodes 来拓展 Hugo 站点的功能。

使用起来也很简单，在网站根目录下的配置文件 config.toml 中添加如下内容：

```toml
theme = ["my-shortcodes", "base-theme", "hyde"]
```

这是官方文档中的一段示例，其中最后一项 `"hyde"` 为站点使用的主题，前面的两项就是 Theme Components。可以添加任意多个 Theme Components，甚至可以在主题目录下的 config 文件中进行嵌套使用。Hugo 会从左到右对 theme 中的文件系统进行合并。

下面两个 Theme Components 是我自己使用的，感觉很好用。

## hugo-notice  

[hugo-notice](https://github.com/martignoni/hugo-notice) 给 Hugo 网站增加了一组提示框。使用 shortcodes 实现下面的四个等级的提示框。

```
{{</* notice warning */>}}
这是一条警告
{{</* /notice */>}}
```

{{< notice warning >}}
这是一条警告
{{< /notice >}}

```
{{</* notice note */>}}
这是一条注释
{{</* /notice */>}}
```

{{< notice nnote >}}
这是一条注释
{{< /notice >}}

```
{{</* notice info */>}}
这是一条信息
{{</* /notice */>}}
```

{{< notice info >}}
这是一条信息
{{< /notice >}}

```
{{</* notice tip */>}}
这是一条提示
{{</* /notice */>}}
```

{{< notice tip >}}
这是一条提示
{{< /notice >}}

## hugo-cloak-email

[hugo-cloak-email](https://github.com/martignoni/hugo-cloak-email) 可以“隐藏”网页上的电子邮箱地址，当然，是对爬虫来说。使用这个组件提供的 shortcodes，既能把邮箱地址、电话等一些信息公布在页面上，又能尽可能地避免爬虫爬走你的这些信息。

最简单的方法就是在需要显示电子邮箱的地方，用 shortcodes 包住邮箱地址。假设我们的邮箱地址是 `john.doe@example.com`，使用 shortcodes 后为：

```html
{{</* cloakemail address="jane.doe@example.com" */>}}
```

这个项目的作者在 Hugo 论坛中给出了原理的简单解释[^2]：

经过 shortcodes 处理后：
- Hugo 生成的网页中会出现包含反转字符串的标签 `<span class="cloaked-e-mail" data-user="eod.nhoj" data-domain="moc.elpmaxe"></span>`。
- hugo-cloak-mail 中的[这段 CSS](https://github.com/martignoni/hugo-cloak-email/blob/d12c1f03640e1a09941b8209067410f177100bf3/layouts/shortcodes/cloakemail.html#L9-L14) 会还原原本的字符串，并添加@符号。
- [这段 JavaScript](https://github.com/martignoni/hugo-cloak-email/blob/d12c1f03640e1a09941b8209067410f177100bf3/layouts/shortcodes/cloakemail.html#L17-L25) 代码会给上一步生成的邮箱地址字符串加上`<a href=...>`标签，使其变成链接。

我的[关于](/about)页面中的邮箱地址就是使用这段 shortcodes 展示出来的。更多定制选项、使用方法可以查看[项目文档](https://github.com/martignoni/hugo-cloak-email)。


[^1]: https://gohugo.io/hugo-modules/theme-components/
[^2]: https://discourse.gohugo.io/t/cloak-email-shortcode-component/17925/11
