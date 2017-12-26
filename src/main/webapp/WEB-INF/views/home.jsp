<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AGV测试</title>
    <link rel="stylesheet" href="/static/Element-UI/index.css">
</head>
<body>
    <div id="app">
        <header class="header header-fixed">
            <el-row>
                <el-col :span="4">
                </el-col>
                <el-col :span="20">
                    <el-menu background-color="#545c64" text-color="#fff" active-text-color="#ffd04b" class="el-menu-demo " mode="horizontal" :router="true">
                        <el-menu-item index="/agv/queryAgvAll">Vehicles</el-menu-item>
                        <el-menu-item index="/task/queryTaskAll">Orders</el-menu-item>
                    </el-menu>
                </el-col>
            </el-row>
        </header>
        <div style="position: relative;height: 60px;width: 100%;"></div>
        <main>
            <div class="main-left bottom">
                <el-menu class="el-menu-vertical-demo" :router="true" default-active="/index">
                    <el-menu-item index="/agv/queryAgvAll">Vehicles</el-menu-item>
                    <el-menu-item index="/task/queryTaskAll">Orders</el-menu-item>
                    <el-menu-item index="/formDemo">测试</el-menu-item>
                </el-menu>
            </div>
            <div class="main-right">
                <router-view></router-view>
            </div>
        </main>
    </div>

    <script src="/static/js/vue.js"></script>
    <script src="/static/Element-UI/index.js"></script>
    <script src="/static/js/vue-resource.js"></script>
    <script src="/static/vue-router/dist/vue-router.js"></script>

    <%--查询所有Agv页面--%>
    <template id="allAgv">
        <div>
            <el-row>
                <el-col :span="3">
                    <p>车辆列表</p>
                </el-col>
                <el-col :span="3">
                    <el-button type="primary">添加车辆</el-button>
                </el-col>
            </el-row>
            <el-table ref="multipleTable" :data="agvs" border style="width: 100%" :default-sort="{prop:'agvid',order:'ascending'}">
                <el-table-column type="selection" width="55"></el-table-column>
                <el-table-column prop="agvid" label="ID" width="150" sortable></el-table-column>
                <el-table-column prop="agvName" label="名称" width="100" sortable></el-table-column>
                <el-table-column prop="agvStatus" label="状态" width="100" sortable></el-table-column>
                <el-table-column prop="isUsed" label="在线" width="100" sortable></el-table-column>
                <el-table-column prop="location" label="坐标" width="100"></el-table-column>
                <el-table-column prop="batteryCapacity" label="电量" width="100" sortable></el-table-column>
                <el-table-column prop="agvIP" label="IP" width="150"></el-table-column>
                <el-table-column prop="agvTask" label="订单" width="100"></el-table-column>
                <el-table-column prop="area" label="当前站点" width="100"></el-table-column>
                <%--<el-table-column label="是否为测试" width="150">--%>
                    <%--<template slot-scope="scope">--%>
                        <%--<p v-if="scope.row.isTest==0">是</p>--%>
                        <%--<p v-else>否</p>--%>
                    <%--</template>--%>
                <%--</el-table-column>--%>
                <el-table-column label="操作" width="100">
                    <template slot-scope="scope">
                        <el-button @click="handleClick(scope.row)" type="text" size="small">详细信息</el-button>
                        <el-button type="text" size="small">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
            :current-page="currentPage" :page-sizes="[10, 20, 30, 40]" :page-size="pagesize"
            layout="total, sizes, prev, pager, next, jumper" :total="total">
            </el-pagination>
        </div>
    </template>

    <%--查询任务页面--%>
    <template id="allTask">
        <div>
            <el-row>
                <el-col :span="3">
                    <p>订单列表</p>
                </el-col>
                <el-col :span="3">
                    <el-button type="primary" @click="taskDialogFormVisible=true">添加订单</el-button>
                </el-col>
                <el-col :span="3">
                    <el-button type="primary">添加多订单</el-button>
                </el-col>
            </el-row>
            <el-dialog title="添加订单" :visible.sync="taskDialogFormVisible">
                <el-form :model="taskForm" ref="form" label-width="100px">
                    <el-form-item label="类型">
                        <el-select v-model="taskForm.taskType" placeholder="请选择类型">
                            <el-option label="普通搬运任务(A->B)" value="0"></el-option>
                            <el-option label="拣货任务(A->B->C)" value="1"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="起始站点">
                        <el-input auto-complete="off" v-model="taskForm.beginPoint" suffix-icon="el-icon-edit"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-col :span="4">
                            <el-checkbox label="动作" v-model="taskForm.beginAct"></el-checkbox>
                        </el-col>
                        <el-col :span="8">
                            <el-input :disabled="taskForm.beginAct==false">
                                <template slot="append">动作ID</template>
                            </el-input>
                        </el-col>
                        <el-col :span="8" :offset="4">
                            <el-input :disabled="taskForm.beginAct==false">
                                <template slot="append">动作参数</template>
                            </el-input>
                        </el-col>
                    </el-form-item>
                    <el-form-item label="目标站点">
                        <el-input v-model="taskForm.endPoint" auto-complete="off" suffix-icon="el-icon-edit"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-col :span="4">
                            <el-checkbox label="动作" v-model="taskForm.endAct"></el-checkbox>
                        </el-col>
                        <el-col :span="8">
                            <el-input :disabled="taskForm.endAct==false">
                                <template slot="append">动作ID</template>
                            </el-input>
                        </el-col>
                        <el-col :span="8" :offset="4">
                            <el-input :disabled="taskForm.endAct==false">
                                <template slot="append">动作参数</template>
                            </el-input>
                        </el-col>
                    </el-form-item>
                    <el-form-item label="车辆类型">
                        <el-select v-model="taskForm.viclesType" placeholder="请选择类型">
                            <el-option label="不限" value="0"></el-option>
                            <el-option label="搬运式" value="1"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="指定执行时间">
                        <el-checkbox v-model="taskForm.selectTime"></el-checkbox>
                        <el-date-picker type="datetime" placeholder="选择日期时间" v-model="taskForm.time" :disabled="taskForm.selectTime==false"></el-date-picker>
                        <p>选中复选框可指定该订单的执行时间</p>
                    </el-form-item>
                    <el-form-item label="指定执行车辆">
                        <el-checkbox v-model="taskForm.selectAgv"></el-checkbox>
                        <el-select placeholder="请选择" :disabled="taskForm.selectAgv==false">
                            <el-option label="0" value="0"></el-option>
                            <el-option label="1" value="1"></el-option>
                        </el-select>
                        <p>选中复选框可指定该订单的执行车辆</p>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button @click="taskDialogFormVisible = false">取 消</el-button>
                    <el-button type="primary" @click="taskDialogFormVisible = false">确 定</el-button>
                </div>
            </el-dialog>

            <el-table ref="multipleTable" :data="tasks" border style="width: 100%" :default-sort="{prop:'agvid',order:'ascending'}">
                <el-table-column type="selection" width="55"></el-table-column>
                <el-table-column prop="taskID" label="ID" width="100" sortable></el-table-column>
                <el-table-column prop="taskType" label="类型" width="150" sortable>
                    <template slot-scope="scope">
                        <p v-if="scope.row.taskType==1">拣货任务(A->B->C)</p>
                    </template>
                </el-table-column>
                <el-table-column prop="taskStatus" label="状态" width="150" sortable>
                    <template slot-scope="scope">
                        <p v-if="scope.row.taskStatus==1">FINISHED</p>
                        <p v-else-if="scope.row.taskStatus==2">QUEUEING</p>
                        <p v-else-if="scope.row.taskStatus==3">acFINISHED</p>
                    </template>
                </el-table-column>
                <el-table-column prop="taskStartTime" label="接收时间" width="250" sortable>
                    <template slot-scope="scope">
                        <p>{{new Date(scope.row.taskStartTime) | TodateTime('yyyy-MM-dd hh:mm:ss')}}</p>
                    </template>
                </el-table-column>
                <el-table-column label="车辆ID" width="150">
                    <template slot-scope="scope">
                        <p v-if="scope.row.taskAgvID==null" style="color:red">没有分配车辆</p>
                        <P v-else style="color: green">{{scope.row.taskAgvID}}</P>
                    </template>
                </el-table-column>
                <el-table-column prop="taskFinishTime" label="完成时间" width="250" sortable>
                    <template slot-scope="scope">
                        <p>{{new Date(scope.row.taskFinishTime) | TodateTime('yyyy-MM-dd hh:mm:ss')}}</p>
                    </template>
                </el-table-column>
                <el-table-column label="操作" width="100">
                    <template slot-scope="scope">
                        <el-button @click="handleClick(scope.row)" type="text" size="small">详细信息</el-button>
                        <el-button type="text" size="small">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                           :current-page="currentPage" :page-sizes="[10, 20, 30, 40]" :page-size="pagesize"
                           layout="total, sizes, prev, pager, next, jumper" :total="total">
            </el-pagination>

        </div>
    </template>

    <%--表单demo--%>
    <template id="formDemo">
        <el-form :inline="true" :model="formInline" class="demo-form-inline">
            <el-form-item label="审批人">
                <el-input v-model="formInline.user" placeholder="审批人"></el-input>
            </el-form-item>
            <el-form-item label="活动区域">
                <el-select v-model="formInline.region" placeholder="活动区域">
                    <el-option label="区域一" value="shanghai"></el-option>
                    <el-option label="区域二" value="beijing"></el-option>
                </el-select>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="onSubmit">查询</el-button>
            </el-form-item>
        </el-form>
    </template>

    <script src="/static/js/mainapp.js"></script>
    <style>
        /* 头部导航 */
        header{z-index: 1000;min-width: 1200px;transition: all 0.5s ease;  border-top: solid 4px #3091F2;  background-color: #fff;  box-shadow: 0 2px 4px 0 rgba(0,0,0,.12),0 0 6px 0 rgba(0,0,0,.04);  }
        header.header-fixed{position: fixed;top: 0;left: 0;right: 0;}
        header .el-menu-demo{padding-left: 300px!important;}

        /* 主内容区 */
        main{    display: -webkit-box;  display: -ms-flexbox;  display: flex;  min-height: 800px;  border: solid 40px #E9ECF1;  background-color: #FCFCFC;  }
        main .main-left{text-align: center;width: 200px;float: left;}
        main .main-right{-webkit-box-flex: 1;  -ms-flex: 1;  flex: 1;  background-color: #fff; padding: 50px 70px; }
        main .el-menu{background-color: transparent!important;}
    </style>

</body>
</html>