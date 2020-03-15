<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE HTML>
<html>
	<head>
        <style type="text/css">
            .row div input{ border-top-left-radius:20px;border-bottom-left-radius:20px;
                               border-top-right-radius:20px;border-bottom-right-radius:20px;}
            .row .formControls{
                            margin-bottom:15px;
            }
            .row .formControls{
                position:relative;
                left:35%;
            }
        </style>
		<title>修改附件</title>
		<meta charset="utf-8">
		<meta name="renderer" content="webkit|ie-comp|ie-stand">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<meta http-equiv="Cache-Control" content="no-siteapp" />
		<link href="<%=path%>/static/css/H-ui.min.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/static/css/H-ui.admin.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/static/lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/static/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<div class="pd-20">
			<form action="<%=path%>/user/update.do" method="post" id="updateform" class="form form-horizontal" enctype="multipart/form-data">
                <c:forEach var="user" items="${userpage.list}" varStatus="n">
                <div class="row cl">
                    <input type="text" name="id" value="${user.id}"><!--id-->
                    <div class="formControls col-10">姓名:<input type="text" name="name" value="${user.name}" class="input-text" style="width:300px"></div>
                    <div class="formControls col-10">年龄:<input type="number" name="age" value="${user.age}" class="input-text"style="width:300px"></div>
                    <div class="formControls col-10">性别:
                                    <input type="radio" name="gender"  value="1" ${user.gender == 1?"checked":""} />男
                                    <input type="radio" name="gender"  value="2" ${user.gender == 2?"checked":""} />女
                    </div>
                    <div class="formControls col-10">手机:<input type="text" class="input-text" value="${user.phone}" name="phone" style="width:300px"></div>
                    <div class="formControls col-10">生日:<input type="date" class="input-text" value="<f:formatDate value="${user.birthday}" pattern="yyyy-MM-dd"/>" name="birthday"  style="width:300px"></div>
                    <div class="formControls col-10">住址:<input type="text" value="${user.address}" class="input-text" name="address" style="width:300px"></div>
				</div>
				<div class="row cl">
					<div class="col-10 col-offset-2" style="margin-left:40%">
						<button class="btn btn-primary radius" type="submit"><i class="Hui-iconfont">&#xe632;</i>修改</button>
						<button class="btn btn-default radius" type="reset">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
					</div>
				</div>
                </c:forEach>
            </form>
		</div>
		<script type="text/javascript" src="<%=path%>/static/lib/jquery/1.9.1/jquery.min.js"></script>
		<script type="text/javascript" src="<%=path%>/static/lib/layer/1.9.3/layer.js"></script>
		<script type="text/javascript" src="<%=path%>/static/js/H-ui.js"></script>
		<script type="text/javascript" src="<%=path%>/static/js/H-ui.admin.js"></script>
		<script type="text/javascript">
            $(document).ready(function () {
                var rolespath = parent.$('[name=loginname]').eq(0).val();
                var inserpath = '<%=path%>/user/update/' + rolespath + '.do';
                $('#updateform').attr('action',inserpath);
            });
		</script>
	</body>
</html>