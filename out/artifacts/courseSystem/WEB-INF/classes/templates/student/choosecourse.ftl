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
            $("#option3").attr("selected", false);
            $("#option4").attr("selected", false);
            $("#option5").attr("selected", false);
            $("#option${pageSize}").attr("selected", true);

            if (${pageNum}==1
        )
            {
                $("#first").attr("disabled", true);
                $("#previous").attr("disabled", true);
            }
            if (${pageNum} == ${totalPage}) {
                $("#last").attr("disabled", true);
                $("#next").attr("disabled", true);
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

        function pickCourse(sno, cno, crestnum, scollege, ccollege, sgrade, cgrade) {
            /**
             * RegExp(A).test(B) ：测试字符串B中是否包含字符串A
             */
            if (!RegExp(scollege).test(ccollege)) {
                alert("学院不在选课学院限制的范围内，选课失败！");
            } else if (!RegExp(sgrade).test(cgrade)) {
                alert("年级不在选课年级限制的范围内，选课失败！");
            } else {
                $.post("/student/pickCourse.do",{"sno": sno, "cno": cno,"crestnum": crestnum },
                        function (res) {
                            alert(res);
                            location.reload();
                        }
                );
            }
        }

        function retiredCourse(sno, cno) {
            $.post("/student/retiredCourse.do",{ "sno": sno,"cno": cno},
                    function (flag) {
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
                //var startTimes = Date.parse(startTime)/3600/1000;//parse() 方法可解析一个日期时间字符串，并返回 1970/1/1 午夜距离该日期时间的毫秒数。
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
        body {
            padding: 70px;
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
                <li class="active"><a href="" onclick="checkTime()" id="gotocs">学生选课中心</a></li>
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
            <span class="glyphicon glyphicon-check" aria-hidden="true"></span> 查询课程
        </span>
        </h2>
    </div>
    <form action="/student/queryCourseList.do" method="post" class="form-inline">
        <div class="form-group">
            <label>课程编号</label>&nbsp;
            <input type="text" class="form-control" id="cno" name="cno" value="" placeholder="请输入课程代码"
                   onchange="condChange()">
        </div>&emsp;&emsp;
        <div class="form-group">
            <label>课程名称</label>&nbsp;
            <input type="text" class="form-control" id="cname" name="cname" value="" placeholder="请输入课程名称"
                   onchange="condChange()">
        </div>&emsp;&emsp;
        <div class="form-group">
            <label>任课老师</label>&nbsp;
            <input type="text" class="form-control" id="cteacher" name="cteacher" value="" placeholder="请输入任课老师"
                   onchange="condChange()">
        </div>

        <p></p>

        <div class="form-group">
            <label>选课学院</label>&nbsp;
            <input type="text" class="form-control" id="ccollege" name="ccollege" value="" placeholder="请输入选课学院"
                   onchange="condChange()">
        </div>&emsp;&emsp;
        <div class="form-group">
            <label>选课年级</label>&nbsp;
            <input type="text" class="form-control" id="cgrade" name="cgrade" value="" placeholder="请输入选课年级"
                   onchange="condChange()">
        </div>&emsp;&emsp;
        <input type="text" id="pageNum" name="pageNum" value="${pageNum}" hidden>
        <input type="text" id="pageSize" name="pageSize" value="${pageSize}" hidden>
        <input type="submit" class="btn btn-primary" id="query" value="筛选" style="width: 260px;">
    </form>
</div>

<hr>

<div style="padding: 0 20px;">
    <table class="table table-striped table-hover">
        <thead>
        <th>课程编号</th>
        <th>课程名称</th>
        <th>任课老师</th>
        <th>班级人数</th>
        <th>剩余人数</th>
        <th>选课学院</th>
        <th>选课年级</th>
        <th>操作</th>
        </thead>
        <tbody>
            <#list courses as course>
            <tr>
                <td>${course.cno}</td>
                <td>${course.cname}</td>
                <td>${course.cteacher}</td>
                <td>${course.ctotalnum}</td>
                <td>${course.crestnum}</td>
                <td>${course.ccollege}</td>
                <td>${course.cgrade}</td>
                <td>
                    <#if course.state == 0 >
                        <input type="button" id="pick" class="btn btn-success btn-sm" name="pick" value="选课"
                               onclick="pickCourse('${student.sno}','${course.cno}','${course.crestnum}','${student.scollege}','${course.ccollege}','${student.sgrade}','${course.cgrade}')">
                        <input type="button" id="retired" class="btn btn-danger btn-sm" name="retired" value="退课"
                               style="visibility: hidden" onclick="deleteCourse(${course.cno}','${course.cname}')">
                    <#elseif course.state == 1>
                        <input type="button" id="pick" class="btn btn-warning btn-sm" name="pick" value="选课" disabled
                               onclick="pickCourse('${student.sno}','${course.cno}','${course.crestnum}','${student.scollege}','${course.ccollege}','${student.sgrade}','${course.cgrade}')">
                        <input type="button" id="retired" class="btn btn-danger btn-sm" name="retired" value="退课"
                               style="visibility: hidden" onclick="deleteCourse(${course.cno}','${course.cname}')">
                    <#elseif course.state == 2>
                        <input type="button" id="pick" class="btn btn-info btn-sm" name="pick" value="已选" disabled
                               onclick="pickCourse('${student.sno}','${course.cno}','${course.crestnum}','${student.scollege}','${course.ccollege}','${student.sgrade}','${course.cgrade}')">
                        <input type="button" id="retired" class="btn btn-danger btn-sm" name="retired" value="退课"
                               onclick="retiredCourse('${student.sno}','${course.cno}')">
                    </#if>
                </td>
            </tr>
            </#list>
        </tbody>
    </table>
</div>

<div style="width: 60%;height:40px;margin: auto;padding: 0 20px;">
    <div style="float: left;margin: 0 20px;">
        <form action="/student/queryCourseList.do" method="post" id="pageForm">
            <select class="form-control" style="width: 60px" name="pageSize" onchange="submitPageForm()">
                <option id="option3" value="3" selected>3</option>
                <option id="option4" value="4">4</option>
                <option id="option5" value="5">5</option>
            </select>
            <input type="text" id="pageNum" name="pageNum" value="${pageNum}" style="width: 20px;" hidden>
            <input type="text" id="cnoCond" name="cno" value="${cno}" hidden>
            <input type="text" id="cnameCond" name="cname" value="${cname}" hidden>
            <input type="text" id="cteacherCond" name="cteacher" value="${cteacher}" hidden>
            <input type="text" id="ccollegeCond" name="ccollege" value="${ccollege}" hidden>
            <input type="text" id="cgradeCond" name="cgrade" value="${cgrade}" hidden>
        </form>
    </div>
    <div style="float: left;margin: 0 20px;">
        <form action="/student/queryCourseList.do" method="post">
            <button class="btn btn-default" id="first" name="PageNum" value="1">首页</button>
            <input type="text" id="pageSize" name="pageSize" value="${pageSize}" style="width: 20px;" hidden>
            <input type="text" id="cnoCond" name="cno" value="${cno}" hidden>
            <input type="text" id="cnameCond" name="cname" value="${cname}" hidden>
            <input type="text" id="cteacherCond" name="cteacher" value="${cteacher}" hidden>
            <input type="text" id="ccollegeCond" name="ccollege" value="${ccollege}" hidden>
            <input type="text" id="cgradeCond" name="cgrade" value="${cgrade}" hidden>
        </form>
    </div>
    <div style="float: left;margin: 0 20px;">
        <form action="/student/queryCourseList.do" method="post" onsubmit="previousPage()">
            <button class="btn btn-default" id="previous" name="pageNum" value="">上一页</button>
            <input type="text" id="pageSize" name="pageSize" value="${pageSize}" style="width: 20px;" hidden>
            <input type="text" id="cnoCond" name="cno" value="${cno}" hidden>
            <input type="text" id="cnameCond" name="cname" value="${cname}" hidden>
            <input type="text" id="cteacherCond" name="cteacher" value="${cteacher}" hidden>
            <input type="text" id="ccollegeCond" name="ccollege" value="${ccollege}" hidden>
            <input type="text" id="cgradeCond" name="cgrade" value="${cgrade}" hidden>
        </form>
    </div>
    <div style="float: left;margin: 0 20px;">
        <form class="form-inline" action="/student/queryCourseList.do" method="post" id="inputForm">
            <div class="form-group">
                <label>第</label>
                <input class="form-control" type="text" id="pageNo" name="pageNum" value="${pageNum}"
                       style="width: 40px;text-align: center;" onchange="submitInputForm()">
                <label>页 共${totalPage}页</label>
            </div>
            <input type="text" id="pageSize" name="pageSize" value="${pageSize}" style="width: 20px;" hidden>
            <input type="text" id="cnoCond" name="cno" value="${cno}" hidden>
            <input type="text" id="cnameCond" name="cname" value="${cname}" hidden>
            <input type="text" id="cteacherCond" name="cteacher" value="${cteacher}" hidden>
            <input type="text" id="ccollegeCond" name="ccollege" value="${ccollege}" hidden>
            <input type="text" id="cgradeCond" name="cgrade" value="${cgrade}" hidden>
        </form>
    </div>
    <div style="float: left;margin: 0 20px;">
        <form action="/student/queryCourseList.do" method="post" onsubmit="nextPage()">
            <button class="btn btn-default" id="next" name="pageNum" value="">下一页</button>
            <input type="text" id="pageSize" name="pageSize" value="${pageSize}" style="width: 20px;" hidden>
            <input type="text" id="cnoCond" name="cno" value="${cno}" hidden>
            <input type="text" id="cnameCond" name="cname" value="${cname}" hidden>
            <input type="text" id="cteacherCond" name="cteacher" value="${cteacher}" hidden>
            <input type="text" id="ccollegeCond" name="ccollege" value="${ccollege}" hidden>
            <input type="text" id="cgradeCond" name="cgrade" value="${cgrade}" hidden>
        </form>
    </div>
    <div style="float: left;margin: 0 20px;">
        <form action="/student/queryCourseList.do" method="post">
            <button class="btn btn-default" id="last" name="pageNum" value="${totalPage}">尾页</button>
            <input type="text" id="pageSize" name="pageSize" value="${pageSize}" style="width: 20px;" hidden>
            <input type="text" id="cnoCond" name="cno" value="${cno}" hidden>
            <input type="text" id="cnameCond" name="cname" value="${cname}" hidden>
            <input type="text" id="cteacherCond" name="cteacher" value="${cteacher}" hidden>
            <input type="text" id="ccollegeCond" name="ccollege" value="${ccollege}" hidden>
            <input type="text" id="cgradeCond" name="cgrade" value="${cgrade}" hidden>
        </form>
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
        $("#previous").attr("value", pageNum);
        return true;
    }

    function nextPage() {
        var pageNum = ${pageNum}+1;
        $("#next").attr("value", pageNum);
        return true;
    }

    function lastPage() {
        return true;
    }

    function condChange() {
        var cno = $("#cno").val();
        $("#cnoCond").attr("value", cno);
        var cname = $("#cname").val();
        $("#cnameCond").attr("value", cname);
        var cteacher = $("#cteacher").val();
        $("#cteacherCond").attr("value", cteacher);
        var ccollege = $("#ccollege").val();
        $("#ccollegeCond").attr("value", ccollege);
        var cgrade = $("#cgrade").val();
        $("#cgradeCond").attr("value", cgrade);
    }
</script>
</body>
</html>