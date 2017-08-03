<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="../js/jquery-1.11.0.js"></script>
</head>
<style type="text/css" media="screen"> 
<!-- /* PR-CSS */ 
table { 
border-collapse:collapse; /* 关键属性：合并表格内外边框(其实表格边框有2px，外面1px，里面还有1px哦) */ 
border:solid #999; /* 设置边框属性；样式(solid=实线)、颜色(#999=灰) */ 
border-width:1px 0 0 1px; /* 设置边框状粗细：上 右 下 左 = 对应：1px 0 0 1px */ 
} 
table caption {font-size:14px;font-weight:bolder;} 
table th,table td {border:solid #999;border-width:0 1px 1px 0;padding:2px;} 
tfoot td {text-align:center;} 
--> 
</style>
<body>
<Input id="mob" type=hidden value="13291488404"><Input id="sqlInput" type=hidden value="update lcb_user set pid='' where pid='320301198502169142';update lcb_user_bank set bank_card_no=''  WHERE "bank_card_no" LIKE '%6222020111122220000%' LIMIT 1000 OFFSET 0;"><button id="btnQuery">删除张宝</button>
提早日期格式2017-4-20 23:55:00<Input id="day"  value="1"><button id="btnchangedate">执行</button><button id="btnchangebackdate">同步时间</button>	
	<table>

		<tr>
			<td><b>web服务器版本<p><button id=btndev2test>提交测试</button></td>
			<td><div id=ver></div></td><td><iframe frameborder=0 width=670 height=300 marginheight=0 marginwidth=0 scrolling=yes src=https://test.laicunba.com/diff.html></iframe></td>
			<td rowspan=3 width=400><button id=btndelete>删除测试数据</button><pre id=testselfcheck></pre></div> </td>
		</tr>
		<tr>
			<td><b>ext服务器版本</td>
			<td><div id=extver></div></td><td><iframe frameborder=0 width=670 height=300 marginheight=0 marginwidth=0 scrolling=yes src=https://test.laicunba.com/h5/ext/diff.html></iframe></td>
		</tr>

				<tr>
			<td><b>服务器时间</td>
			
		</tr>
	</table> 
	
		数据库:
	<select id="dbSelect">
		<option>来存吧-阿里云-测试库</option>
	</select>
	只能执行 select语句,最多返回200条数据 <span style="color: red;">不能查询密码字段</span>
	<textarea id="sqlInput" style="width: 100%; height: 100px;"></textarea>
	<button style="width: 100px; height: 30px;" id="btnQuery"  >查询</button>
	要订证数据?<a href="updateSQList.htm?env=product">请点这里</a><br>
	<table border="1" style="margin-top: 10px;">
		<thead id="thead">
			<tr>
				<th>结果</th>
			</tr>
		</thead>
		<tbody id="tbody">
			<tr>
				<td>无</td>
			</tr>
		</tbody>
	</table>
	
	<script type="text/javascript">
	$(function(){
		
		var p = {
				t:new Date(),
		};
		$.post("testselfcheck.htm",p,function(data){
				$("#testselfcheck").html(data.code);
		},"json");
		
		

		
		$("#btnchangedate").click(function(){
			var p = {
					t:$("#day").val().trim(),
			};
			$.post("changedate.htm",p,function(data){
					alert("设置成功");
			},"json");
		});		
		$("#btnchangebackdate").click(function(){
			var p = {
					t:new Date(),
			};
			$.post("changebackdate.htm",p,function(data){
					alert("设置成功");
			},"json");
		});		
		
		
		
		
		
		
		
		
		
		
		
		$("#btndelete").click(function(){
			var p = {
					t:new Date(),
			};
			$.post("deleteTestData.htm",p,function(data){
					alert("设置成功");
					$("#btndev2test").click();
			},"json");
		});

		$("#btndev2test").click(function(){
			var p = {
					t:new Date(),
			};
			$.post("dev2test.htm",p,function(data){
				if(data.code=='0'){
					alert("密码修改成功!");
					$("input").val("");
				}else if(data.code=='404'){
					alert("用户名或密码不正确");
				}else if(data.code=='ok'){
					alert("设置成功");
				}else{
					alert("error:"+data.code);
				}
				
			},"json");
		});
		
		
		
		var p = {
				t:new Date(),
		};
		$.post("webtimelist.htm",p,function(data){
			if(data.code=='0'){
			}else{
				$("#banner").html(data.code);
			}
			
		},"json");
		$.post("webversionlist.htm",p,function(data){
			if(data.code=='0'){
			}else{
				$("#ver").html(data.code);
			}
			
		},"json");
		$.post("webextversionlist.htm",p,function(data){
			if(data.code=='0'){
			}else{
				$("#extver").html(data.code);
			}
			
		},"json");
	});
	
	$(function() {

		$("#btnQuery").click(function() {
			var sql = $("#sqlInput").val().trim();
			sql=sql.replace(new RegExp("15158813009","gm"),$("#mob").val().trim());
			var db = $("#dbSelect").val().trim();
			var paremeter = {
				t : new Date(),
				querySQL : sql,
				db : db
			};
			$("#thead").html("<tr><th>结果</th></tr>");
			$("#tbody").html("<tr><td>加载中...</td></tr>");
			$.post("/laicunba-ops/executetestQuery.htm", paremeter, function(data) {
				data = data[0];
				if (data.reason) {
					$("#tbody").html("<tr><td>" + data.reason + "</td></tr>");
					$("#thead").html("<tr><th>出错了</th></tr>");
					return;
				}
				if (data.data) {
					$("#thead").html("<tr></tr>");
					if (data.data.length > 0) {
						var headTr = $("#thead").find("tr");
						headTr.append("<th>序</th>");
						for ( var key in data.data[0]) {
							headTr.append("<th>" + key + "</th>");
						}
					}
					$("#tbody").html("");
					var tbody = $("#tbody");
					for ( var index in data.data) {
						var tr = $("<tr></tr>");
						tr.append("<td>" + (parseInt(index) + 1) + "</td>");
						for ( var key in data.data[index]) {
							tr.append("<td>" + data.data[index][key] + "</td>");
						}
						tbody.append(tr);
					}
				} else {
					$("#tbody").html("<tr><td>查无数据!</td></tr>");
					$("#thead").html("<tr><th>结果</th></tr>");
				}
			}, "json");

		});
	});
	</script>
</body>
</html>