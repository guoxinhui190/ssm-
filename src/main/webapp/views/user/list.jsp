<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link href="<%=path%>/static/css/H-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/static/css/H-ui.admin.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/static/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/static/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/static/css/jquery.page.css" rel="stylesheet" type="text/css"/>
        <title>用户列表</title>
</head>
<body>
<nav class="breadcrumb">
    <i class="Hui-iconfont">&#xe67f;</i> 首页
    <span class="c-gray en">&gt;</span> 用户管理
        <span class="c-gray en">&gt;</span> 用户列表
            <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新">
                <i class="Hui-iconfont">&#xe68f;</i>
            </a>
</nav>
<div class="pd-20">
    <form action="<%=path%>/user/query.do" id="lookuser" method="post">
    <div class="text-c">
        日期范围：
        <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'logmax\')||\'%y-%M-%d\'}'})" id="logmin" name="sdate" value="${userpage.sdate}" class="input-text Wdate" style="width:120px;">
        -
        <input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'logmin\')}',maxDate:'%y-%M-%d'})" id="logmax" name="ldate" value="${userpage.ldate}" class="input-text Wdate" style="width:120px;">
        <input type="text" name="realnamed" id="usernameinput" value="${userpage.realnamed2}" placeholder="用户名称" style="width:250px" class="input-text">
        <button name="" id="selectfile" class="btn btn-success" type="submit"><i class="Hui-iconfont">&#xe665;</i>搜索</button>
    </div>
    </form>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
    	<span class="l">
	        <a href="javascript:;" class="btn btn-danger radius" id="batch"><i class="Hui-iconfont">&#xe6e2;</i>批量</a>
	        <a href="javascript:;" class="btn btn-primary radius" id="insert"><i class="Hui-iconfont">&#xe600;</i>添加</a>
	    </span>
        <span class="r">共有数据：<strong>${page.count}</strong> 条</span>
    </div>
    <form action="<%=path%>/user/batch.do" id="batchform" method="post">
        <input type="hidden" id="thispage" name="thispage" value="${page.thispage}" />
        <input type="hidden" id="maxpage" name="maxpage" value="${page.maxpage}">
	<div class="mt-20">
        <table class="table table-border table-bordered table-bg table-hover table-sort">
            <thead>
	            <tr class="text-c">
	                <th width="25"><input type="checkbox" name="" value=""></th>
	                <th width="25">序号</th>
                    <th width="80">名称</th>
	                <th width="80">年龄</th>
	                <th width="80">性别</th>
	                <th width="120">手机号码</th>
	                <th width="75">出生日期</th>
	                <th width="60">家庭住址</th>
	                <th width="120">操作</th>
	            </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${userpage.list}" varStatus="n">
	            <tr class="text-c">
	                <td><input type="checkbox" name="ides" value="${user.id}"></td>
                    <td>${n.count + start}</td>
	                <td class="text-l">${user.name}</td>
	                <td style="position:relative">${user.age}</td>
	                <td>${user.gender == 1?"男":"女"}</td>
	                <td>${user.phone}</td>
	                <td><f:formatDate value="${user.birthday}" pattern="yyyy-MM-dd"/></td>
	                <td class="td-status">${user.address}</td>
	                <td class="f-14 td-manage">
	                    <a style="text-decoration:none" class="ml-5" href="<%=path%>/user/toupdate/${user.id}.do" title="修改"><i class="Hui-iconfont">&#xe6df;</i></a>
	                    <a style="text-decoration:none" class="ml-5" id="deleteroles" href="javascript:ondelete(${user.id});" title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a>
	                </td>
	            </tr>
                </c:forEach>
            </tbody>
            <tfoot>
            <tr>
                <td colspan="9">
                    <div id="page"></div>
                </td>
            </tr>
            </tfoot>
        </table>
    </div>
</form>
</div>
<script type="text/javascript" src="<%=path%>/static/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/static/lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="<%=path%>/static/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=path%>/static/js/H-ui.js"></script>
<script type="text/javascript" src="<%=path%>/static/js/H-ui.admin.js"></script>
<script type="text/javascript" src="<%=path%>/static/js/jquery.page2.0.js"></script>
<script type="text/javascript">
    //页面初始化完毕后函数
    $(document).ready(function () {
        var thispage = $("#thispage").val();
        var maxpage = $("#maxpage").val();
        //初始化分页控件
        $("#page").page({
            totalPages: maxpage,//分页总数
            initPage: thispage,//初始页数
            liNums:5,//分页的数字按钮数(建议取奇数)
            activeClass: 'activP',
            callBack: function (page) {
              $('#thispage').val(page);
              $('form:first').submit();
            }
        });
        //跳转至文件上传页面
        $('#insert').click(function () {
            window.location.href = '<%=path%>/views/user/insert.jsp';
        });
        var rolespath = parent.$('[name=loginname]').eq(0).val();
        var batchform = '<%=path%>/user/batch/' + rolespath +'.do';
        $('#batchform').attr('action',batchform);
        $('#batch').click(function () {
            var len = $('[name=ides]:checked').length;
            if (len == 0){
                alert('至少选择一条');
                return;
            }
            layer.confirm('确认要删除吗？', function (index) {
                $('#batchform').submit();
            });

        });

        var lookform = '<%=path%>/user/query/'+ rolespath +'.do';
        $('#lookuser').attr('action',lookform);

        function getNow(s) {
            return s < 10 ? '0' + s: s;
        }
        var myDate = new Date();
        var year=myDate.getFullYear();        //获取当前年
        var month=myDate.getMonth()+1;   //获取当前月
        var date=myDate.getDate();            //获取当前日
        var now=year+'-'+getNow(month)+"-"+getNow(date);
        if($('#usernameinput').val() == 'null'){
            $('#usernameinput').val('');
        }
        $('#selectfile').click(function () {
            if($('#logmin').val() == "" && $('#logmax').val() == ""){
                $('#logmin').val('1900-01-01');
                $('#logmax').val(now);
            }else if($('#logmin').val() == "" && $('#logmax').val() != ""){
                $('#logmin').val('1900-01-01');
            }else if($('#logmin').val() != "" && $('#logmax').val() == ""){
                $('#logmax').val(now);
            }
            }
        );
    });

    /*批量-删除*/
    function ondelete(id) {
        var rolespath = parent.$('[name=loginname]').eq(0).val();
        layer.confirm('确认要删除吗？', function (index) {
           window.location.href = '<%=path%>/user/delete/'+ id + '/' + rolespath +'.do';
        });
    }
</script>
</body>
</html>