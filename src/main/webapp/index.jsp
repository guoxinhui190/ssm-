﻿<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE HTML>
<!--修改-->
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <LINK rel="Bookmark" href="favicon.ico">
    <LINK rel="Shortcut Icon" href="favicon.ico"/>
    <link href="static/css/H-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="static/css/H-ui.admin.css" rel="stylesheet" type="text/css"/>
    <link href="static/skin/green/skin.css" rel="stylesheet" type="text/css" id="skin"/>
    <link href="static/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css"/>
    <title>javakc</title>
</head>
<body>
<header class="Hui-header cl"><a class="Hui-logo l" title="JAVAKC" href="/">javakc</a>
    <nav class="mainnav cl" id="Hui-nav">
        <ul>
            <li class="dropDown dropDown_click"><a href="javascript:;" class="dropDown_A"><i class="Hui-iconfont">&#xe600;</i>
                新增 <i class="Hui-iconfont">&#xe6d5;</i></a>
                <ul class="dropDown-menu radius box-shadow">
                    <li>
                        <a href="javascript:;" onclick="article_add('添加附件','add.html')"><i class="Hui-iconfont">&#xe616;</i>
                        附件
                        </a>
                    </li>
                </ul>
            </li>
        </ul>
    </nav>
    <ul class="Hui-userbar">
        <li>超级管理员</li>
        <li class="dropDown dropDown_hover">
            <a href="#" class="dropDown_A">
                <span id="authentication"><security:authentication property="name"/></span>
                <i class="Hui-iconfont">&#xe6d5;</i>
            </a>
            <ul class="dropDown-menu radius box-shadow">
                <li><a href="#">个人信息</a></li>
                <li><a href="${pageContext.request.contextPath}/logout.do">切换账户</a></li>
                <li><a href="${pageContext.request.contextPath}/logout.do">退出</a></li>
            </ul>
        </li>
        <li id="Hui-msg"><a href="#" title="消息"><span class="badge badge-danger">1</span><i class="Hui-iconfont"
                                                                                            style="font-size:18px">&#xe68a;</i></a>
        </li>
        <li id="Hui-skin" class="dropDown right dropDown_hover"><a href="javascript:;" title="换肤"><i
                class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>
            <ul class="dropDown-menu radius box-shadow">
                <li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>
                <li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
                <li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
                <li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
                <li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
                <li><a href="javascript:;" data-val="orange" title="绿色">橙色</a></li>
            </ul>
        </li>
    </ul>
    <a aria-hidden="false" class="Hui-nav-toggle" href="#"></a></header>
<aside class="Hui-aside">
    <input runat="server" id="divScrollValue" type="hidden" value=""/>
    <div class="menu_dropdown bk_2">
        <input type="hidden" name="loginname" />
        <dl id="menu-article">
            <dt><i class="Hui-iconfont">&#xe616;</i> 附件管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a _href="attachment/query/null.do" href="javascript:void(0)" id="allfiles">附件管理</a></li>
                </ul>
            </dd>
        </dl>
        <dl id="attachment-manager">
            <dt><i class="Hui-iconfont">&#xe62b;</i>我的网盘<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li>
                        <input type="hidden" name="id">
                      <a _href="attachment/query/null.do" title="查" id="singnfile">我的附件</a>
                    </li>
                </ul>
            </dd>
        </dl>
        <dl id="user-manager">
            <dt><i class="Hui-iconfont">&#xe62b;</i> 用户管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a _href="user/query.do" id="userquery" href="javascript:void(0)">用户管理</a></li>
                </ul>
            </dd>
        </dl>

    </div>
</aside>
<div class="dislpayArrow"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
    <div id="Hui-tabNav" class="Hui-tabNav">
        <div class="Hui-tabNav-wp">
            <ul id="min_title_list" class="acrossTab cl">
                <li class="active"><span title="我的桌面" data-href="welcome.html">我的桌面</span><em></em></li>
            </ul>
        </div>
        <div class="Hui-tabNav-more btn-group"><a id="js-tabNav-prev" class="btn radius btn-default size-S"
                                                  href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a><a
                id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a>
        </div>
    </div>
    <div id="iframe_box" class="Hui-article">
        <div class="show_iframe">
            <div style="display:none" class="loading"></div>
            <iframe scrolling="yes" frameborder="0" src="welcome.html"></iframe>
        </div>
    </div>
</section>
<script type="text/javascript" src="static/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="static/lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="static/js/H-ui.js"></script>
<script type="text/javascript" src="static/js/H-ui.admin.js"></script>
<script type="text/javascript">
    /*资讯-添加*/
    function article_add(title, url) {
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    $(document).ready(function () {
        var mypan = $("#authentication").html();
        inputname = $('[name=id]').val(mypan)[0].value;

        var loginname = $('[name=loginname]').val(inputname)[0].value;
        var loginnames = 'attachment/query/'+ loginname +'.do';
        $('#singnfile').attr('_href',loginnames);
        $('#allfiles').click(function () {
            var loginname = $('[name=loginname]').val('null')[0].value;
        });
        $('#singnfile').click(function () {
            var loginname = $('[name=loginname]').val(inputname)[0].value;
        });
        var userquery = 'user/query/'+ inputname +'.do'
        $('#userquery').attr('_href',userquery);
    });

</script>
</body>
</html>