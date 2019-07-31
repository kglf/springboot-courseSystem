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
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
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
                <li><a href="/admin/courseList.do">开课情况</a></li>
                <li class="active"><a href="/admin/queryCourseList.do">选课情况</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li><a>欢迎登录，</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${admin.aname} <span class="caret"></span></a>
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
            <span class="glyphicon glyphicon-check" aria-hidden="true"></span> 查询课程
        </span>
            </h2>
        </div>
        <form action="/admin/queryCourseList.do" method="post" class="form-inline">
            <div class="form-group">
                <label>课程编号</label>&nbsp;
                <input type="text" class="form-control" id="cno" name="cno" value="" placeholder="请输入课程代码" onchange="condChange()">
            </div>&emsp;&emsp;
            <div class="form-group">
                <label>课程名称</label>&nbsp;
                <input type="text" class="form-control" id="cname" name="cname" value="" placeholder="请输入课程名称" onchange="condChange()">
            </div>&emsp;&emsp;
            <div class="form-group">
                <label>任课老师</label>&nbsp;
                <input type="text" class="form-control" id="cteacher" name="cteacher" value="" placeholder="请输入任课老师" onchange="condChange()">
            </div>

            <p></p>

            <div class="form-group">
                <label>选课学院</label>&nbsp;
                <input type="text" class="form-control" id="ccollege" name="ccollege" value="" placeholder="请输入选课学院" onchange="condChange()">
            </div>&emsp;&emsp;
            <div class="form-group">
                <label>选课年级</label>&nbsp;
                <input type="text" class="form-control" id="cgrade" name="cgrade" value="" placeholder="请输入选课年级" onchange="condChange()">
            </div>&emsp;&emsp;
            <input type="text" id="pageNum" name="pageNum" value="${pageNum}" hidden>
            <input type="text" id="pageSize" name="pageSize" value="${pageSize}" hidden>
            <input type="submit" class="btn btn-primary" id="query" value="查询" style="width: 260px;">
        </form>
        <div style="width:100%;height:10px;display:table;">
            <div style="width:auto;height:auto;display: table-cell;text-align: center;vertical-align: middle;">
                <div style="height: 5px;"></div>
                <hr style="width: 100%;">
            </div>
        </div>


        <div style="height:50px;margin: 0 auto;">
            <h2>
        <span class="label label-success">
            <span class="glyphicon glyphicon-list" aria-hidden="true"></span> 开课情况
        </span>
            </h2>
        </div>
        <table class="table table-striped table-hover">
            <thead>
                <th>课程编号</th><th>课程名称</th><th>任课老师</th><th>班级人数</th>
                <th>剩余人数</th><th>选课学院</th><th>选课年级</th>
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
                    </tr>
                </#list>
            </tbody>
        </table>
        <div>
            <div style="width: 60%;height:40px;margin: auto;">
                <div style="float: left;margin: 0 20px;">
                    <form action="/admin/queryCourseList.do" method="post" id="pageForm">
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
                    <form action="/admin/queryCourseList.do" method="post">
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
                    <form action="/admin/queryCourseList.do" method="post" onsubmit="previousPage()">
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
                    <form class="form-inline" action="/admin/queryCourseList.do" method="post" id="inputForm">
                        <div class="form-group">
                            <label>第</label>
                            <input class="form-control" type="text" id="pageNo" name="pageNum" value="${pageNum}" style="width: 40px;text-align: center"
                                   onchange="submitInputForm()">
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
                    <form action="/admin/queryCourseList.do" method="post" onsubmit="nextPage()">
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
                    <form action="/admin/queryCourseList.do" method="post">
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