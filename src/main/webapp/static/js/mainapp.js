Vue.use(VueRouter)

//时间过滤器
Vue.filter('TodateTime',function (value,format) {
    var o={
        "M+": value.getMonth() + 1, // 月份
        "d+": value.getDate(), // 日
        "h+": value.getHours(), // 小时
        "m+": value.getMinutes(), // 分
        "s+": value.getSeconds(), // 秒
    };
    if (/(y+)/.test(format))
        format = format.replace(RegExp.$1, (value.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(format))
            format = format.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return format;
});

const AllAgv=Vue.extend({
    template:'#allAgv',
    data:function () {
        this.$http.get("/agv/allAgv").then(function(response){
            this.$set(this.$data,'agvs',response.data);//注意此处vue1.0的set和vue2.0的set不同
        }).catch(function(response){
            alert("获取服务器端数据错误"+response);
        });
        return{
            agvs:[],
            total:13,
            pagesize:2,
            currentPage:1
        };
    },
    methods:{
        handleSizeChange:function (val) {
            this.pagesize=val;
        },
        handleCurrentChange:function (val) {
            this.currentPage=val;
        }
    }
});

const AllTask=Vue.extend({
    template:'#allTask',
    data:function () {
        this.$http.get("/task/allTask").then(function(response){
            this.$set(this.$data,'tasks',response.data);//注意此处vue1.0的set和vue2.0的set不同
        }).catch(function(response){
            alert("获取服务器端数据错误"+response);
        });
        return{
            tasks:[],
            total:8,
            pagesize:2,
            currentPage:1,
            taskDialogFormVisible:false,
            taskForm:{
                taskType:'',
                beginPoint:'',
                endPoint:'',
                viclesType:'',
                beginAct:false,
                endAct:false,
                selectTime:false,
                time:'',
                selectAgv:false,
            }
        };
    },
    methods:{
        handleSizeChange:function (val) {
            this.pagesize=val;
        },
        handleCurrentChange:function (val) {
            this.currentPage=val;
        }
    }
});

var FormDemo=Vue.extend({
    template:'#formDemo',
    data:function () {
        return{
            formInline:{
                user:'',
                region:''
            },
        }
    },
    methods:{
        onSubmit(){
            console.log('submit!');
        }
    }
});

const Bar = { template: '<div>bar</div>' };

// 定义路由
// 每个路由应该映射一个组件,
const routes = [
    {path:'/agv/queryAgvAll',component:AllAgv},
    {path:'/task/queryTaskAll',component:AllTask},
    {path:'/formDemo',component:FormDemo},
    { path: '/bar', component: Bar }
];

//创建 router 实例，然后传 routes配置
const router = new VueRouter({
    routes // （缩写）相当于 routes: routes
});

//创建和挂载根实例
const app = new Vue({
    router
}).$mount('#app');