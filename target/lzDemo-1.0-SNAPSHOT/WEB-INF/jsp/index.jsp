<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="statics/element/index.css">
</head>
<body>
<body>
<div id="app">
    <el-button  type="primary"  @click="addDialogVisible = true">新增</el-button>
    <el-table  :data="tableData"
               style="width:100%"
    >
        <el-table-column
                prop="username"
                label="用户名"
                width="180">
        </el-table-column>
        <el-table-column
                prop="password"
                label="密码"
                width="180">
        </el-table-column>
        <el-table-column
                prop="rname"
                label="角色">
        </el-table-column>
        <el-table-column
                prop="createDate"
                label="创建日期">
        </el-table-column>
        <el-table-column
                prop="updateDate"
                label="更新日期">
        </el-table-column>
        <el-table-column label="操作" >
            <template slot-scope="scope">
                <el-button  type="primary"  @click="showUpdateMessage(scope.row)">修改</el-button>
                <el-button  type="danger"  @click="showDeleteMessage(scope.row.id,scope.row.username)">删除</el-button>
            </template>
        </el-table-column>
    </el-table>
    <el-pagination
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="currentPage"
            :page-sizes="[5,10,15,20]"
            layout="total,prev, pager, next,jumper"
            :total="total"
            :page-size="pagesize"
    >
    </el-pagination>

    <el-dialog
            title="新增"
            :visible.sync="addDialogVisible"
            width="60%"
            top="50"
    >
        <el-form :model="user"  ref="userForm" label-width="100px" class="demo-ruleForm">
            <el-row :gutter="10">
                <el-col :span="10"><el-form-item label="用户名" prop="username"><el-input
                        placeholder="请输入用户名"
                        v-model="user.username"
                        clearable
                        style="width:500px">
                </el-input></el-form-item></el-col>
            </el-row>
            <el-row :gutter="10">
                <el-col :span="10"><el-form-item label="密码" prop="password"><el-input
                        placeholder="请输入用户名"
                        v-model="user.password"
                        clearable
                        style="width:500px">
                </el-input></el-form-item></el-col>
            </el-row>
            <el-row :gutter="10">
                <el-col :span="10"><el-form-item label="用户角色" prop="rid">
                    <el-select v-model="user.rid"
                               placeholder="请选择DJXN">
                        <el-option
                                v-for="item in options"
                                :label="item.rname"
                                :value="item.id">
                        </el-option>
                    </el-select></el-form-item></el-col>
            </el-row>

            <el-row :gutter="16">
                <el-form-item>
                    <el-button type="primary" @click="addUser">提交</el-button>
                    <el-button type="danger" @click="clearFrom">重置</el-button>
                </el-form-item></el-row>
        </el-form>
    </el-dialog>

    <el-dialog
            title="修改"
            :visible.sync="updateDialogVisible"
            width="60%"
            top="50"
    >
        <el-form :model="updateUser"  ref="updateUserForm" label-width="100px" class="demo-ruleForm">
            <el-row :gutter="10">
                <el-col :span="10"><el-form-item label="用户名" prop="username"><el-input
                        placeholder="请输入用户名"
                        v-model="updateUser.username"
                        clearable
                        style="width:500px">
                </el-input></el-form-item></el-col>
            </el-row>
            <el-row :gutter="10">
                <el-col :span="10"><el-form-item label="密码" prop="password"><el-input
                        placeholder="请输入用户名"
                        v-model="updateUser.password"
                        clearable
                        style="width:500px">
                </el-input></el-form-item></el-col>
            </el-row>
            <el-row :gutter="10">
                <el-col :span="10"><el-form-item label="用户角色" prop="rid">
                    <el-select v-model="updateUser.rid"
                               placeholder="请选择DJXN">
                        <el-option
                                v-for="item in options"
                                :label="item.rname"
                                :value="item.id">
                        </el-option>
                    </el-select></el-form-item></el-col>
            </el-row>
            <el-row :gutter="16">
                <el-form-item>
                    <el-button type="primary" @click="toupdateUser">提交</el-button>
                    <el-button type="danger" @click="clearFrom">重置</el-button>
                </el-form-item></el-row>
        </el-form>
    </el-dialog>
    <el-dialog
            title="提示"
            :visible.sync="deletedialogVisible"
            width="30%"
    >
        <span>确定要删除用户名为{{deleteUser.username}}的用户吗</span>
        <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="deleteById">确 定</el-button>
    <el-button @click="deletedialogVisible = false">取 消</el-button>
  </span>
    </el-dialog>
</div>
</body>
<script src="statics/vue/vue-2.5.16.js"></script>
<script src="statics/jquery/jquery-1.7.2.min.js"></script>
<script src="statics/element/index.js"></script>
<script>
    var vue=new Vue({
        el: '#app',
        data: function () {
            return {
                tableData: [],
                total: 0,
                currentPage: 1,
                pagesize: 2,
                addDialogVisible:false,
                user:{},
                options:[{id:1,rname:"普通用户"},{id:2,rname:"管理员"}],
                updateUser:{},
                updateDialogVisible:false,
                deletedialogVisible:false,
                deleteUser:{}
            }
        },
        methods:{
            page:function(){
                $.ajax({
                    type:"post",
                    url: "/pagingQuery",
                    data:{pageNum:this.currentPage,pageSize:this.pagesize},
                    success: function(result){
                        vue.currentPage=result.pageNum;
                        vue.tableData=result.list;
                        vue.pagesize=result.pageSize;
                        vue.total=result.total;
                    }
                });
            },
            handleSizeChange:function(val){
                this.pagesize=val;
                this.page();
            },
            handleCurrentChange:function(val){
                this.currentPage=val;
                this.page();
            },
            addUser:function(){
                $.ajax({
                    type:"post",
                    contentType: "application/json;charset=UTF-8",
                    url: "/addUser",
                    data:JSON.stringify(this.user),
                    success: function(result){
                        alert(result);
                        vue.addDialogVisible=false;
                        vue.user={};
                        vue.page();
                    }
                });
            },
            clearFrom:function () {
                this.user={};
            },
            showUpdateMessage:function (user) {
                if(user.rid==1){
                    user.rid="普通用户";
                }else if(user.rid==2){
                    user.rid="管理员";
                }
                this.updateUser=user;
                this.updateDialogVisible=true;
            },
            toupdateUser:function () {
                $.ajax({
                    type:"post",
                    contentType: "application/json;charset=UTF-8",
                    url: "/updateUser",
                    data:JSON.stringify(this.updateUser),
                    success: function(result){
                        alert(result);
                        vue.updateDialogVisible=false;
                        vue.updateUser={};
                        vue.page();
                    }
                });
            },
            showDeleteMessage:function (id,username) {
                this.deleteUser.id=id;
                this.deleteUser.username=username;
                this.deletedialogVisible=true;
            },
            deleteById:function () {
                $.ajax({
                    type:"post",
                    url: "/deleteUser",
                    data:{id:this.deleteUser.id},
                    success: function(result){
                        alert(result);
                        vue.deletedialogVisible=false;
                        vue.page();

                    }
                });
            }
        },
        created :function(){
            this.page();
        }
    })
</script>
</body>
</html>
