<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生选课系统个人管理页面</title>
    <link href="/static/bootstrap3/css/bootstrap.css" rel="stylesheet">
    <script src="/static/bootstrap3/js/jquery-1.11.2.min.js"></script>
    <script src="/static/bootstrap3/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        function loadTime() {
            var startTime = $("#startTime").val();
            var endTime = $("#endTime").val();
            if (startTime != "") {
                startTime = startTime.replace("T", " ") + ":00";
                endTime = endTime.replace("T", " ") + ":00";
                var start = document.getElementById("start");
                var end = document.getElementById("end");
                start.innerText = startTime;
                end.innerText = endTime;
            }
        }

        function checkTime() {
            var startTime = document.getElementById("start").innerText.replace(/-/g, "/");
            var endTime = document.getElementById("end").innerText.replace(/-/g, "/");
            if (startTime == "") {
                alert("当前未开放选课！");
            } else {
                var dateTime = new Date().toLocaleString('chinese', {hour12: false});
                var startTimeMS = Date.parse(startTime);//毫秒级时间比较
                var endTimeMS = Date.parse(endTime);
                var dateTimeMS = Date.parse(dateTime);
                if (dateTimeMS < startTimeMS) {
                    alert("选课时间还未开始！");
                } else if (dateTimeMS >= endTimeMS) {
                    alert("选课时间已经结束！");
                } else {
                    $("#gotocs").attr("href", "/student/queryCourseList.do");
                }
            }
        }
    </script>
    <style>
        body {
            padding-top: 70px;
        }
    </style>
</head>
<body onload="loadTime()">
<nav class="navbar navbar-default navbar-fixed-top navbar-inverse" style="padding: 0 20px;">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/student/main.do">主页</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="" onclick="checkTime()" id="gotocs">学生选课中心</a></li>
                <li><a href="/student/personalCourseListPage.do">个人选课情况</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li><a>欢迎登录，</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                       aria-expanded="false">${student.sname} <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="/student/update.do">修改密码</a></li>
                    </ul>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
<div id="Layer1" style="position:fixed;z-index: -1; left:0px; top:0px; width:100%; height:100%">
    <img src="/static/images/modifypwd_back.jpg" width="100%" height="100%"/>
</div>
<div style="width: 90%;margin: 0 auto;">
    <div id="timearea" class="page-header" style="padding: 0 20px;" hidden>
        <h2>选课时间：
            <small>
                <font color="red" id="start"></font>～<font color="red" id="end"></font>
                <input type="text" id="startTime" value="${startTime}" hidden>
                <input type="text" id="endTime" value="${endTime}" hidden>
            </small>
        </h2>
    </div>
    <div style="padding: 0 20px;">
        <div style="height:50px;margin: 0 auto;">
            <h2>
        <span class="label label-primary">
            <span class="glyphicon glyphicon-user" aria-hidden="true"></span> 修改密码
        </span>
            </h2>
        </div>
        <hr>
        <form class="form-horizontal" action="/student/modifypwd.do" method="post">
            <div class="form-group">
                <label style="color: white;font-size: large;" class="col-sm-offset-3 col-sm-2 control-label">原密码</label>
                <div class="col-sm-2">
                    <input class="form-control" id="oldSpwd" name="oldSpwd" type="password"
                           placeholder="请输入原密码" value="">
                </div>
                <div class="col-sm-2">
                    <font style="font-size: large;" color="red" id="error">${errorSpwd }</font>
                </div>
            </div>
            <div class="form-group">
                <label style="color: white;font-size: large;" class="col-sm-offset-3 col-sm-2 control-label">新密码</label>
                <div class="col-sm-2">
                    <input class="form-control" id="newSpwd" name="newSpwd" type="password"
                           placeholder="请输入新密码" value="">
                </div>
            </div>
            <div class="form-group" style="margin: 0 auto;">
                <div class="col-sm-offset-5 col-sm-7">
                    <button type="submit" class="btn btn-default">确定</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>