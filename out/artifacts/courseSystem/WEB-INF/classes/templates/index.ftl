<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生选课系统学生登录页面</title>
    <script src="/static/bootstrap3/js/jquery-1.11.2.min.js"></script>
    <script src="/static/bootstrap3/css/bootstrap.min.css"></script>
    <script src="/static/bootstrap3/js/bootstrap.min.js"></script>
    <!-- import Vue.js -->
    <script src="//vuejs.org/js/vue.min.js"></script>
    <!-- import stylesheet -->
    <link rel="stylesheet" href="//unpkg.com/iview/dist/styles/iview.css">
    <!-- import iView -->
    <script src="//unpkg.com/iview/dist/iview.min.js"></script>

    <script type="text/javascript">
        function checkForm() {
            var no = $("#no").val();
            var password = $("#password").val();
            if (no == null || no == "") {
                $("#error").html("账号不能为空！");
                return false;
            }
            if (password == null || password == "") {
                $("#error").html("密码不能为空！");
                return false;
            }
            var identity = $("input[type='radio']:checked").val();
            var url = "/" + identity + "/login.do";
            $("#IdLogin").attr("action", url);
            return true;
        }

    </script>
    <style>
        input[type=radio] {
            width: 16px;
            height: 16px;
        }

        input[type=text] {
            width: 200px;
            height: 40px;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
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
            width: 70%;
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

        #login {
            width: 400px;
            height: 260px;
            border-radius: 5px;
            background-color: rgba(242, 242, 242, 0.5);
            text-align: center;
            top: 50%;
            left: 50%;
            position: absolute;
            margin-left: -200px;
            margin-top: -130px;
            padding: 20px;

        }

        p {
            font-size: large;
            color: black;

        }
    </style>
</head>
<body>
<div id="Layer1" style="position:fixed;z-index: -1; left:0px; top:0px; width:100%; height:100%">
    <img src="/static/images/index_back.png" width="100%" height="100%"/>
</div>
<div id="login" align="center">
    <form id="IdLogin" method="post" onsubmit="return checkForm()">
        <p>
            <input type="radio" name="identity" value="student" checked/>学生登录&nbsp;&nbsp;&nbsp;
            <input type="radio" name="identity" value="admin"/>管理员登录
        </p>
        <p>账&nbsp;号&nbsp;&nbsp;<input id="no" name="no" type="text" placeholder="请输入账号" value=""></p>
        <p>密&nbsp;码&nbsp;&nbsp;<input id="password" name="password" type="password" placeholder="请输入密码" value=""></p>
        <p><input type="submit" value="登&nbsp;&nbsp;&nbsp;&nbsp;录"/></p>
        <p><font color="red" id="error">${errorInfo }</font></p>
    </form>
</div>
</body>
</html>