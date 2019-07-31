<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生选课系统个人管理页面</title>
    <link href="/static/bootstrap3/css/bootstrap.css" rel="stylesheet">
    <script src="/static/bootstrap3/js/jquery-1.11.2.min.js"></script>
    <script src="/static/bootstrap3/js/bootstrap.min.js"></script>

    <script language="javascript">
        function loadFlag() {
            $("#option5").attr("selected",false);
            $("#option10").attr("selected",false);
            $("#option15").attr("selected",false);
            $("#option${pageSize}").attr("selected",true);

            if (${pageNum}==1) {
                $("#first").attr("disabled",true);
                $("#previous").attr("disabled",true);
            }
            if (${pageNum} == ${totalPage}){
                $("#last").attr("disabled",true);
                $("#next").attr("disabled",true);
            }

            //loadTime
                var startTime = $("#startTime").val();
                var endTime = $("#endTime").val();
                if (startTime!=""){
                    startTime = startTime.replace("T"," ")+":00";
                    endTime = endTime.replace("T"," ")+":00";
                    var start = document.getElementById("start");
                    var end = document.getElementById("end");
                    start.innerText = startTime;
                    end.innerText = endTime;
                }
            }

        function retiredCourse(sno,cno) {
            $.post(
                    "/student/retiredCourse.do",
                    {
                        "sno":sno,
                        "cno":cno
                    },
                    function (flag){
                        console.log(flag.data);
                        location.reload();
                    }
            );
        }

        function checkTime() {
            var startTime = document.getElementById("start").innerText.replace(/-/g,"/");
            var endTime = document.getElementById("end").innerText.replace(/-/g,"/");
            if (startTime==""){
                alert("当前未开放选课！");
            } else {
                var dateTime = new Date().toLocaleString('chinese', { hour12: false });
                var startTimeMS = Date.parse(startTime);//毫秒级时间比较
                var endTimeMS = Date.parse(endTime);
                var dateTimeMS = Date.parse(dateTime);
                if (dateTimeMS<startTimeMS){
                    alert("选课时间还未开始！");
                } else if (dateTimeMS>=endTimeMS){
                    alert("选课时间已经结束！");
                } else {
                    $("#gotocs").attr("href","/student/queryCourseList.do");
                }
            }
        }
    </script>

    <style>
        body{
            padding-top: 70px;
        }
    </style>
</head>
<body onload="loadFlag()">
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
                <li class="active"><a href="/student/personalCourseListPage.do">个人选课情况</a></li>
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
        <span class="label label-success">
            <span class="glyphicon glyphicon-list" aria-hidden="true"></span> 已选课程表
        </span>
            </h2>
        </div>
    </div>

    <hr>

    <div style="padding: 0 20px;">
        <table class="table table-striped table-hover">
            <thead>
            <th>课程编号</th>
            <th>课程名称</th>
            <th>任课老师</th>
            <th>操作</th>
            </thead>
            <tbody>
            <#list courses as course>
            <tr>
                <td>${course.cno}</td>
                <td>${course.cname}</td>
                <td>${course.cteacher}</td>
                <td>
                    <input type="button" id="retired" class="btn btn-danger btn-sm" name="retired" value="退课" onclick="retiredCourse('${student.sno}','${course.cno}')">
                </td>
            </tr>
            </#list>
            </tbody>
        </table>
    </div>

    <div style="width: 60%;height:40px;margin: auto;padding: 0 20px;">
        <div style="float: left;margin: 0 20px;">
            <form action="/student/personalCourseListPage.do" method="post" id="pageForm">
                <select class="form-control" style="width: 60px" name="pageSize" onchange="submitPageForm()">
                    <option id="option5" value="5" selected>5</option>
                    <option id="option10" value="10">10</option>
                    <option id="option15" value="15">15</option>
                </select>
                <input type="text" id="pageNum" name="pageNum" value="${pageNum}" style="width: 20px;" hidden>
            </form>
        </div>
        <div style="float: left;margin: 0 20px;">
            <form action="/student/personalCourseListPage.do" method="post">
                <button class="btn btn-default" id="first" name="PageNum" value="1" >首页</button>
                <input type="text" id="pageSize" name="pageSize" value="${pageSize}" style="width: 20px;" hidden>
            </form>
        </div>
        <div style="float: left;margin: 0 20px;">
            <form action="/student/personalCourseListPage.do" method="post" onsubmit="previousPage()">
                <button class="btn btn-default" id="previous" name="pageNum" value="" >上一页</button>
                <input type="text" id="pageSize" name="pageSize" value="${pageSize}" style="width: 20px;" hidden>
            </form>
        </div>
        <div style="float: left;margin: 0 20px;">
            <form class="form-inline" action="/student/personalCourseListPage.do" method="post" id="inputForm" style="display: inline">
                <div class="form-group">
                    <label>第</label>
                    <input class="form-control" type="text" id="pageNo" name="pageNum" value="${pageNum}" style="width: 40px;text-align: center;" onchange="submitInputForm()">
                    <label>页 共${totalPage}页</label>
                </div>
                <input type="text" id="pageSize" name="pageSize" value="${pageSize}" style="width: 20px;" hidden>
            </form>
        </div>
        <div style="float: left;margin: 0 20px;">
            <form action="/student/personalCourseListPage.do" method="post" onsubmit="nextPage()">
                <button class="btn btn-default" id="next" name="pageNum" value="" >下一页</button>
                <input type="text" id="pageSize" name="pageSize" value="${pageSize}" style="width: 20px;" hidden>
            </form>
        </div>
        <div style="float: left;margin: 0 20px;">
            <form action="/student/personalCourseListPage.do" method="post">
                <button class="btn btn-default" id="last" name="pageNum" value="${totalPage}" >尾页</button>
                <input type="text" id="pageSize" name="pageSize" value="${pageSize}" style="width: 20px;" hidden>
            </form>
        </div>
    </div>
</div>


<script type="text/javascript">
    function submitPageForm() {
        var form = document.getElementById("pageForm");
        form.submit();
    }

    function submitInputForm() {
        var form = document.getElementById("inputForm");
        form.submit();
    }

    function firstPage() {
        return true;
    }

    function previousPage() {
        var pageNum = ${pageNum}-1;
        $("#previous").attr("value",pageNum);
        return true;
    }

    function nextPage() {
        var pageNum = ${pageNum}+1;
        $("#next").attr("value",pageNum);
        return true;
    }

    function lastPage() {
        return true;
    }

</script>
</body>
</html>