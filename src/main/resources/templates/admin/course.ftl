<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生选课系统后台管理页面</title>
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

            var timeStr = $("#startTimes").val();
            if (timeStr == "") {
                $("#modifyTime").attr("hidden", "hidden");
                $("#deleteTime").attr("hidden", "hidden");
            } else {
                $("#addTime").attr("hidden", "hidden");
            }
        }

        function locking(cno, cname, cteacher, ctotalnum, crestnum, ccollege, cgrade) {
            document.all.tmbj.style.display = "block";
            document.all.tmbj.style.width = document.body.clientWidth;
            document.all.tmbj.style.height = document.body.clientHeight;
            document.all.tmbjct.style.display = 'block';

            $("#scno").attr("value", cno);
            $("#scname").attr("value", cname);
            $("#scteacher").attr("value", cteacher);
            $("#sctotalnum").attr("value", ctotalnum);
            $("#screstnum").attr("value", crestnum);
            $("#sccollege").attr("value", ccollege);
            $("#scgrade").attr("value", cgrade);
            $("#oldtotalnum").attr("value", ctotalnum);
        }

        function Lock_CheckForm(theForm) {
            document.all.tmbj.style.display = 'none';
            document.all.tmbjct.style.display = 'none';
            return false;
        }

        function deleteCourse(cno, cname) {
            var choose = confirm("删除课程：" + cname + "！");
            if (choose) {
                $.post(
                        "/admin/deleteCourse.do",
                        {"cno": cno},
                        function (flag) {
                            console.log(flag.data);
                            location.reload();
                        }
                );
            }
        }

        function checkTime() {
            var startTime = $("#startTime").val();
            var endTime = $("#endTime").val();
            if (startTime != "" && endTime != "") {
                var sTime = Date.parse(startTime.replace("T", " ").replace(/-/g, "/"));
                var eTime = Date.parse(endTime.replace("T", " ").replace(/-/g, "/"));
                if (eTime > sTime) {
                    $("#addTime").attr("action", "/admin/addOpenTime.do")
                    return true;
                } else {
                    alert("选课结束时间必须大于开始时间！");
                    return false;
                }
            } else {
                alert("选课时间不能为空！");
                return false;
            }
        }

        function checkTimes() {
            var startTimes = $("#startTimes").val();
            var endTimes = $("#endTimes").val();
            if (startTimes != "" && endTimes != "") {
                var sTimes = Date.parse(startTimes.replace("T", " ").replace(/-/g, "/"));
                var eTimes = Date.parse(endTimes.replace("T", " ").replace(/-/g, "/"));
                if (eTimes > sTimes) {
                    $("#modifyTime").attr("action", "/admin/modifyOpenTime.do");
                    return true;
                } else {
                    alert("选课结束时间必须大于开始时间！");
                    return false;
                }
            } else {
                alert("选课时间不能为空！");
                return false;
            }
        }

    </script>
    <style>
        body {
            padding-top: 70px;
        }
    </style>
</head>
<body onload="loadFlag()">
<nav class="navbar navbar-default navbar-fixed-top" style="padding: 0 20px;">
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
            <a class="navbar-brand" href="/admin/main.do">首页</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="/admin/courseList.do">开课情况</a></li>
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
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
<div style="width: 90%;margin: 0 auto;">
    <div style="padding:20px;">
        <div style="height:50px;margin: 0 auto;">
            <h2>
        <span class="label label-primary">
            <span class="glyphicon glyphicon-time" aria-hidden="true"></span> 选课时间
        </span>
            </h2>
        </div>

        <form method="post" class="form-inline" id="addTime" onsubmit="checkTime()">
            <div class="form-group">
                <label>开始时间：</label>
                <input type="datetime-local" class="form-control" id="startTime" name="startTime" value="">
            </div>&emsp;&emsp;
            <div class="form-group">
                <label>结束时间：</label>
                <input type="datetime-local" class="form-control" id="endTime" name="endTime" value="">
            </div>&emsp;&emsp;
            <button class="btn btn-primary">提交</button>
        </form>
        <div>
            <div style="float: left">
                <form method="post" class="form-inline" id="modifyTime" onsubmit="checkTimes()">
                    <div class="form-group">
                        <label>开始时间：</label>
                        <input type="datetime-local" class="form-control" id="startTimes" name="startTimes"
                               value="${startTime}">
                    </div>&emsp;&emsp;
                    <div class="form-group">
                        <label>结束时间：</label>
                        <input type="datetime-local" class="form-control" id="endTimes" name="endTimes"
                               value="${endTime}">
                    </div>&emsp;&emsp;
                    <button class="btn btn-warning">修改</button>
                </form>
            </div>
            <div style="float: left;margin-left: 50px;">
                <form action="/admin/deleteOpenTime.do" id="deleteTime" class="form-inline" method="post">
                    <input type="submit" class="btn btn-danger" value="删除选课时间">
                </form>
            </div>
        </div>
        <hr style="width: 100%;">
        <div style="height:50px;margin: 0 auto;">
            <h2>
        <span class="label label-primary">
            <span class="glyphicon glyphicon-list" aria-hidden="true"></span> 添加课程
        </span>
            </h2>
        </div>

        <form action="/admin/addCourse.do" method="post" class="form-inline">
            <div class="form-group">
                <label>课程编号</label>&nbsp;
                <input type="text" class="form-control" id="cno" name="cno" value="" placeholder="请输入课程代码">
            </div>&emsp;&emsp;
            <div class="form-group">
                <label>课程名称</label>&nbsp;
                <input type="text" class="form-control" id="cname" name="cname" value="" placeholder="请输入课程名称">
            </div>&emsp;&emsp;
            <div class="form-group">
                <label>任课老师</label>&nbsp;
                <input type="text" class="form-control" id="cteacher" name="cteacher" value="" placeholder="请输入任课老师">
            </div>
            <p></p>
            <div class="form-group">
                <label>选课学院</label>&nbsp;
                <input type="text" class="form-control" id="ccollege" name="ccollege" value="" placeholder="请输入选课学院">
            </div>&emsp;&emsp;
            <div class="form-group">
                <label>选课年级</label>&nbsp;
                <input type="text" class="form-control" id="cgrade" name="cgrade" value="" placeholder="请输入选课年级">
            </div>&emsp;&emsp;
            <div class="form-group">
                <label>课堂人数</label>&nbsp;
                <input type="text" class="form-control" id="ctotalnum" name="ctotalnum" value="" placeholder="请输入课程人数">
            </div>&emsp;&emsp;
            <input type="submit" class="btn btn-primary" id="add" value="添加">
        </form>

        <hr style="width: 100%;">


        <table class="table table-striped table-hover">
            <thead>
                <th>课程编号</th><th>课程名称</th><th>任课老师</th><th>人数限制</th>
                <th>剩余人数</th><th>选课学院</th><th>选课年级</th><th>操作</th>
            </thead>
            <tbody>
                <#list courses as course>
                    <tr>
                        <td>${course.cno}</td><td>${course.cname}</td>
                        <td>${course.cteacher}</td><td>${course.ctotalnum}</td>
                        <td>${course.crestnum}</td><td>${course.ccollege}</td>
                        <td>${course.cgrade}</td>
                        <td>
                            <input type="button" class="btn btn-info btn-sm" id="modify" name="modify" value="修改"
                                   onclick="locking('${course.cno}','${course.cname}','${course.cteacher}','${course.ctotalnum}',
                                           '${course.crestnum}','${course.ccollege}','${course.cgrade}')">
                            <input type="button" class="btn btn-danger btn-sm" id="delete" name="delete" value="删除"
                                   onclick="deleteCourse('${course.cno}','${course.cname}')">
                        </td>
                    </tr>
                </#list>
            </tbody>
        </table>
        <div style="width: 60%;height:40px;margin: auto;">
            <div style="float: left;margin: 0 20px;">
                <form action="/admin/courseList.do" method="post" id="pageForm">
                    <select class="form-control" style="width: 60px" name="pageSize" onchange="submitPageForm()">
                        <option id="option3" value="3" selected>3</option>
                        <option id="option4" value="4">4</option>
                        <option id="option5" value="5">5</option>
                    </select>
                    <input type="text" id="pageNum" name="pageNum" value="${pageNum}" style="width: 20px;" hidden>
                </form>
            </div>
            <div style="float: left;margin: 0 20px;">
                <form action="/admin/courseList.do" method="post">
                    <button class="btn btn-default" id="first" name="PageNum" value="1">首页</button>
                    <input type="text" id="pageSize" name="pageSize" value="${pageSize}" style="width: 20px;" hidden>
                </form>
            </div>
            <div style="float: left;margin: 0 20px;">
                <form action="/admin/courseList.do" method="post" onsubmit="previousPage()">
                    <button class="btn btn-default" id="previous" name="pageNum" value="">上一页</button>
                    <input type="text" id="pageSize" name="pageSize" value="${pageSize}" style="width: 20px;" hidden>
                </form>
            </div>
            <div style="float: left;margin: 0 20px;">
                <form class="form-inline" action="/admin/courseList.do" method="post" id="inputForm">
                    <div class="form-group">
                        <label>第</label>
                        <input class="form-control" type="text" id="pageNo" name="pageNum" value="${pageNum}"
                               style="width: 40px;text-align: center"
                               onchange="submitInputForm()">
                        <label>页 共${totalPage}页</label>
                    </div>
                    <input type="text" id="pageSize" name="pageSize" value="${pageSize}" style="width: 20px;" hidden>
                </form>
            </div>
            <div style="float: left;margin: 0 20px;">
                <form action="/admin/courseList.do" method="post" onsubmit="nextPage()">
                    <button class="btn btn-default" id="next" name="pageNum" value="">下一页</button>
                    <input type="text" id="pageSize" name="pageSize" value="${pageSize}" style="width: 20px;" hidden>
                </form>
            </div>
            <div style="float: left;margin: 0 20px;">
                <form action="/admin/courseList.do" method="post">
                    <button class="btn btn-default" id="last" name="pageNum" value="${totalPage}">尾页</button>
                    <input type="text" id="pageSize" name="pageSize" value="${pageSize}" style="width: 20px;" hidden>
                </form>
            </div>
        </div>
        <hr style="width: 100%;">
    </div>
</div>

<div style="width: 100%;height: 30px;line-height: 30px;text-align: center;background-color: #333333;color: white;">
    <span class="glyphicon glyphicon-copyright-mark" aria-hidden="true"></span> designed by 空谷丶临风
</div>


<!-- div+css+ja 弹出层-->
<div id="tmbj"
     style="width:100%;height:100%;position:absolute;top:0px;filter:alpha(opacity=60);-moz-opacity:0.6;opacity: 0.6;background-color:#8C8C8C;z-index:12;left:0px;display:none;"></div>
<div id="tmbjct"
     style="position:fixed;z-index:13;width:400px;height:430px;left:50%;top:50%;margin-top:-215px;margin-left:-200px;background-color:#fff;display:none;">
    <div class="form-group">
        <div class="col-sm-offset-10 col-sm-2">
            <button class="btn btn-default" onclick="Lock_CheckForm(this);" style="width: 50px;">
                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
            </button>
        </div>
    </div>
    <form class="form-horizontal" action="/admin/coursemodify.do" method="post">
        <div class="form-group">
            <label class="col-sm-4 control-label" style="text-align: right;">课程编号</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" id="scno" name="scno" value="" style="width: 180px;" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label">课程名称</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" id="scname" name="scname" value="" style="width: 180px;">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label">任课老师</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" id="scteacher" name="scteacher" value="" style="width: 180px;">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label">人数限制</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" id="sctotalnum" name="sctotalnum" value=""
                       style="width: 180px;">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label">剩余人数</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" id="screstnum" name="screstnum" value="" style="width: 180px;"
                       readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label">学院限制</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" id="sccollege" name="sccollege" value="" style="width: 180px;">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-4 control-label">年级限制</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" id="scgrade" name="scgrade" value="" style="width: 180px;">
            </div>
        </div>
        <input type="text" id="oldtotalnum" name="oldtotalnum" value="" hidden>
        <div class="form-group">
            <div class="col-sm-offset-5 col-sm-7">
                <input type="submit" class="btn btn-default" id="modify" value="确定">
            </div>
        </div>
    </form>
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
</script>
</body>
</html>