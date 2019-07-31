<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生选课系统后台管理页面</title>
    <link href="/static/bootstrap3/css/bootstrap.css" rel="stylesheet">
    <script src="/static/bootstrap3/js/jquery-1.11.2.min.js"></script>
    <script src="/static/bootstrap3/js/bootstrap.min.js"></script>
    <!-- import Vue.js -->
    <script src="//vuejs.org/js/vue.min.js"></script>
    <!-- import stylesheet -->
    <link rel="stylesheet" href="//unpkg.com/iview/dist/styles/iview.css">
    <!-- import iView -->
    <script src="//unpkg.com/iview/dist/iview.min.js"></script>
    <style>
    	body {
				padding-top: 70px;
			}

    	input[type=password] {
            width: 200px;
            height: 40px;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        
    	input[type=submit] {
            width: 75%;
            height: 50px;
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type=submit]:hover {
            background-color: #45a049;
        }

        #pwd {
            width: 400px;
            height: 240px;
            border-radius: 5px;
            background-color:rgba(242,242,242,0.5);
            text-align: center;
            top: 50%;
            left: 50%;
            position: absolute;
            margin-left: -200px;
            margin-top: -120px;
            padding: 20px;
           
        }
        
        p{
        	font-size: large;
        	color: black;
     
        }
    </style>
</head>
<body>
	<div id="Layer1" style="position:fixed;z-index: -1; left:0px; top:0px; width:100%; height:100%">
        <img src="/static/images/modifypwd_back.jpg" width="100%" height="100%"/>
    </div>

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
                    <li><a href="/admin/queryCourseList.do">选课情况</a></li>
                </ul>

                <ul class="nav navbar-nav navbar-right">
                    <li><a>欢迎登录，</a></li>
                    <li class="dropdown active">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${admin.aname} <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/admin/update.do">修改密码</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
<div id="pwd" align="center">
    <form action="/admin/modifypwd.do" method="post">
        <p>
          	原&nbsp;密&nbsp;码&nbsp;&nbsp;
            <input id="oldApwd" name="oldApwd" type="password" placeholder="请输入原密码" value="">
        </p>
        <p>
            新&nbsp;密&nbsp;码&nbsp;&nbsp;
            <input id="newApwd" name="newApwd" type="password" placeholder="请输入新密码" value="">
        </p>
        <p><input type="submit" value="修&nbsp;改&nbsp;密&nbsp;码"></p>
        <p><font color="red" id="error">${errorApwd }</font></p>
    </form>
</div>

</body>
</html>