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
            } else {
                $("#timearea").attr("hidden", "hidden");
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
<div style="width: 90%;margin: 0 auto;">
    <div id="timearea" class="page-header" style="padding: 0 20px;">
        <h2>选课时间：
            <small>
                <font color="red" id="start"></font>～<font color="red" id="end"></font>
                <input type="text" id="startTime" value="${startTime}" hidden>
                <input type="text" id="endTime" value="${endTime}" hidden>
            </small>
        </h2>
    </div>

    <div style="font-family: '宋体';font-size: x-large;line-height: 40px;">
        <div class="row">
            <div class="col-sm-offset-3 col-sm-2">
                <img src="" width="120px" height="150px"/>
            </div>
            <div class="col-sm-2">
                <div class="row">姓名:${student.sname}</div>
                <div class="row">学院:${student.scollege}</div>
                <div class="row">性别:${student.sgender}</div>
                <div class="row">住址:${student.saddress}</div>
            </div>
            <div class="col-sm-2">
                <div class="row">学号:${student.sno}</div>
                <div class="row">年级:${student.sgrade}</div>
                <div class="row">电话:${student.sphone}</div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-offset-3 col-sm-9">个人简介:${student.sintroduction}</div>
        </div>
    </div>
</div>
</body>
</html>