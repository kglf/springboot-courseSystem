<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>学生选课系统后台管理页面</title>
    <link href="/static/bootstrap3/css/bootstrap.css" rel="stylesheet">
    <script src="/static/bootstrap3/js/jquery-1.11.2.min.js"></script>
    <script src="/static/bootstrap3/js/bootstrap.min.js"></script>
    <style>
        body {
            padding-top: 70px;
        }

        /*个人信息*/
        table {
            width: 800px;
            height: 600px;
            border-radius: 5px;
            top: 50%;
            left: 50%;
            position: absolute;
            margin-left: -400px;
            margin-top: -200px;
            padding: 20px;
        }


    </style>
</head>

<body>
<nav class="navbar navbar-default navbar-fixed-top" style="padding: 0 20px;">
    <div class="container-fluid active">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/admin/main.do">首页</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="/admin/courseList.do">开课情况</a></li>
                <li><a href="/admin/queryCourseList.do">选课情况</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a>欢迎登录，</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                       aria-expanded="false">${admin.aname} <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="/admin/update.do">修改密码</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div style="padding:20px;">
    <div class="info">
        <table style="table-layout:fixed;">
            <tr>
                <td width="150px" height="200px" align="center">
                    <img src="" width="120px" height="180px"/>
                </td>
                <td style="padding: 20px;font-family: '宋体';font-size: x-large;line-height: 40px;">
                    姓名:${admin.aname}<br>
                    账号:${admin.ano}<br>
                    性别:${admin.agender}<br>
                    电话:${admin.aphone}<br>
                    住址:${admin.aaddress}
                </td>
            </tr>
            <tr>
                <td colspan="2"
                    style="padding: 20px;font-family: '宋体';font-size: x-large;vertical-align: top;line-height: 40px;word-wrap:break-word;word-break:break-all;">
                    个人简介:${admin.aintroduction}
                </td>
            </tr>
        </table>
    </div>

</div>
</body>

</html>