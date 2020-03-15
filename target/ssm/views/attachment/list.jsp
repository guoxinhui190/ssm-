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
        <title>附件列表</title>
</head>
<body>
<nav class="breadcrumb">
    <i class="Hui-iconfont">&#xe67f;</i> 首页
    <span class="c-gray en">&gt;</span> 附件管理
        <span class="c-gray en">&gt;</span> 附件列表
            <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新">
                <i class="Hui-iconfont">&#xe68f;</i>
            </a>
</nav>
<div class="pd-20">
    <form action="<%=path%>/attachment/query.do" id="lookupform" method="post">
    <div class="text-c">
        <span class="select-box inline">
            <select name="sort" class="select">
                <option value="all">全部分类</option>
                <option value="text">文本</option>
                <option value="wps">WPS文档</option>
                <option value="images">图片</option>
                <option value="movies">视频</option>
                <option value="muisc">音频</option>
                <option value="html">网页</option>
                <option value="exe">pc端软件</option>
                <option value="zip">压缩包</option>
                <option value="datesouce">数据库</option>
                <option value="else">其他</option>
            </select>
		</span>
        日期范围：
        <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'logmax\')||\'%y-%M-%d\'}'})" id="logmin" name="sdate" value="${page.sdate}" class="input-text Wdate" style="width:120px;">
        -
        <input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'logmin\')}',maxDate:'%y-%M-%d'})" id="logmax" name="ldate" value="${page.ldate}" class="input-text Wdate" style="width:120px;">
        <input type="text" name="realnamed" id="" value="${page.realnamed2 == "null" ? "" :page.realnamed2}" placeholder="附件名称" style="width:250px" class="input-text">
        <button name="" id="selectfile" class="btn btn-success" type="submit"><i class="Hui-iconfont">&#xe665;</i>搜附件</button>
    </div>
    </form>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
    	<span class="l">
	        <a href="javascript:;" class="btn btn-danger radius" id="batch"><i class="Hui-iconfont">&#xe6e2;</i>批量</a>
	        <a href="javascript:;" class="btn btn-primary radius" id="insert"><i class="Hui-iconfont">&#xe600;</i>添加</a>
	    </span>
        <span class="r">共有数据：<strong>${page.count}</strong> 条</span>
    </div>
        <input type="hidden" id="thispage" name="thispage" value="${page.thispage}" />
        <input type="hidden" id="maxpage" name="maxpage" value="${page.maxpage}">
	<div class="mt-20">
        <table class="table table-border table-bordered table-bg table-hover table-sort">
            <thead>
	            <tr class="text-c">
	                <th width="25"><input type="checkbox" name="" value=""></th>
	                <th width="25">序号</th>
                    <th width="80">名称</th>
	                <th width="80">类型</th>
	                <th width="80">大小</th>
	                <th width="120">上传日期</th>
	                <th width="75">下载次数</th>
	                <th width="60">发布状态</th>
	                <th width="120">操作</th>
	            </tr>
            </thead>
            <tbody>
                <c:forEach var="a" items="${page.list}" varStatus="n">
	            <tr class="text-c">
	                <td><input type="checkbox" name="ids" value="${a.id}"></td>
                    <td>${n.count + start}</td>
	                <td class="text-l">
                        <input type="hidden" value="${a.realname}" />
                        <input type="text" value="${a.realname}" class="input-text" style="border: #ececf0" name="realname"/>
	                    <input type="hidden" value="${a.id}" />
                    </td>
	                <td style="position:relative">
                        <div style="display: inline-block;width:60px;position:absolute;left:40px;top:28%;">
                        ${a.suffix}
                        </div>
                        <div style="display: inline-block;position:absolute;right:30px;top:28%;">
                            <img src="<%=path%>/static/images/suffix/${a.suffix}.png" style="width:20px;height:20px;"
                             onerror="javascript:this.src='<%=path%>/static/images/suffix/file.png'"/>
                        </div>
                    </td>
	                <td>
                        <c:set var="kbsize" value="1024" />
                        <c:set var="mbsize" value="${kbsize*kbsize}" />
                        <c:set var="gbsize" value="${kbsize*mbsize}" />
                        <c:choose>
                        <c:when test="${a.filesize > gbsize}">
                            <span class="label label-default">
                                <f:formatNumber value="${a.filesize/gbsize}" maxFractionDigits="3"/>GB
                            </span>
                        </c:when>
                        <c:when test="${a.filesize > mbsize}">
                            <span class="label label-warning">
                                <f:formatNumber value="${a.filesize/mbsize}" maxFractionDigits="2"/>MB
                            </span>
                        </c:when>
                        <c:when test="${a.filesize > kbsize}">
                            <span class="label label-success">
                                <f:formatNumber value="${a.filesize/kbsize}" maxFractionDigits="1"/>kb
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="label label-primary">
                                  ${a.filesize}B
                            </span>
                        </c:otherwise>
                        </c:choose>
                    </td>
	                <td>
                        <f:formatDate value="${a.createtime}" pattern="yyyy-MM-dd"/>
                    </td>
	                <td>${a.download}</td>
	                <td class="td-status">
                        <c:if test="${a.state == 1}">
                            <span class="label label-danger radius">私有</span>
                        </c:if>
                        <c:if test="${a.state == 0}">
                            <span class="label label-success radius">公开</span>
                        </c:if>
                    </td>
	                <td class="f-14 td-manage">
	                    <a style="text-decoration:none" class="ml-5" href="<%=path%>/attachment/download/${a.id}.do" title="下载"><i class="Hui-iconfont">&#xe640;</i></a>
	                    <a style="text-decoration:none" class="ml-5" href="javascript:ondelete(${a.id});" title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a>
	                </td>
	            </tr>
                </c:forEach>
            </tbody>
            <tfoot>
            <tr>
                <td colspan="8">
                    <div id="page"></div>
                </td>
            </tr>
            </tfoot>
        </table>
    </div>
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
            liNums: 5,//分页的数字按钮数(建议取奇数)
            activeClass: 'activP',
            callBack: function (page) {
                $('#thispage').val(page);
                $('form:first').submit();
            }
        });
        $('[name=realname]').blur(function () {
            var newname = $(this).val();
            var prev = $(this).prev();
            var realname = $(this).prev().val();
            var id = $(this).next().val();
            if ($.trim(newname) != realname) {
                $.post('<%=path%>/attachment/update.do', {id: id, realname: newname}, function (data) {
                    if (data.success) {
                        layer.alert('恭喜，修改成功！');
                        $(prev).val(newname);
                    }
                }, 'json');

            }
        });
        //跳转至文件上传页面
        $('#insert').click(function () {
            window.location.href = '<%=path%>/views/attachment/insert.jsp';
        });
        $('#batch').click(function () {
            var len = $('[name=ids]:checked').length;
            if (len == 0) {
                alert('至少选择一条');
                $('#arrids').val('');
                return;
            }
            //声明一个数组
            var param = [];
            //遍历每个选中的元素并添加到数组
            $('[name=ids]:checked').each(function () {
                param.push($(this).val());
            });
            var rolespath = parent.$('[name=loginname]').eq(0).val();
            var ides = param.toString();
            // $('form:eq(1)').submit();
            layer.confirm('确认要删除吗？', function (index) {
                window.location.href = '<%=path%>/attachment/batch/' + ides + '/' + rolespath + '.do';
            });
        });

        var rolespath = parent.$('[name=loginname]').eq(0).val();
        var lookform = '<%=path%>/attachment/query/'+ rolespath +'.do';
        $('#lookupform').attr('action',lookform);

        function getNow(s) {
            return s < 10 ? '0' + s: s;
        }
        var myDate = new Date();
        var year=myDate.getFullYear();        //获取当前年
        var month=myDate.getMonth()+1;   //获取当前月
        var date=myDate.getDate();            //获取当前日
        var now=year+'-'+getNow(month)+"-"+getNow(date);

        $('#selectfile').click(function () {
            // function getNow(s) {
            //     return s < 10 ? '0' + s: s;
            // }
            // var dateone = new Date($('#logmax').val());
            // var year=myDate.getFullYear();        //获取当前年
            // var month=myDate.getMonth()+1;   //获取当前月
            // var daydate = dateone.getDate() + 1;
            // var selectday = year + '-' + getNow(month) + "-" + getNow(daydate);
            // $('#logmax').val(selectday);
            if($('#logmin').val() == "" && $('#logmax').val() == ""){
                $('#logmin').val('1900-01-01');
                $('#logmax').val(now);
            }else if($('#logmin').val() == "" && $('#logmax').val() != ""){
                $('#logmin').val('1900-01-01');
            }else if($('#logmin').val() != "" && $('#logmax').val() == ""){
                $('#logmax').val(now);
            }
        });

    });
    /*批量-删除*/
    function ondelete(id) {
        var rolespath = parent.$('[name=loginname]').eq(0).val();
        alert(rolespath);
        layer.confirm('确认要删除吗？', function (index) {
            window.location.href = '<%=path%>/attachment/delete/' + id + '/' + rolespath + '.do';
        });
    }
</script>
</body>
</html>