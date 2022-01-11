﻿# Host: localhost  (Version: 5.7.26)
# Date: 2022-01-10 12:22:29
# Generator: MySQL-Front 5.3  (Build 4.234)

/*!40101 SET NAMES utf8 */;

#
# Structure for table "admin_user"
#

DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Data for table "admin_user"
#

/*!40000 ALTER TABLE `admin_user` DISABLE KEYS */;
INSERT INTO `admin_user` VALUES (1,'zengxpang','zengxpang');
/*!40000 ALTER TABLE `admin_user` ENABLE KEYS */;

#
# Structure for table "article"
#

DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `article_content` text,
  `introduce` text,
  `addTime` varchar(255) DEFAULT NULL,
  `view_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

#
# Data for table "article"
#

/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (4,1,'React学习笔记','JSX的语法规则：\n\n1. 定义虚拟Dom的时候，不要写引号\n2. 标签中的JS表达式必须用{}包裹,是表达式不是JS代码，不是JS语句\n\n>区分JS语句【代码】和JS的表达式\n>\n>1. 一个表达式会产生一个值，可以放在任何一个需要值的地方，以下都是表达式\n>\n>​    1、a\n>\n>​    2、a+b\n>\n>​    3、demo(1)\n>\n>​    4、arr.map() // 会返回一个数组\n>\n>​    5、function test() {}\n>\n>2. JS语句\n>\n>  1、if(){}\n>\n>  2、for(){}\n>\n>  3、switch(){case:xxx}\n\n3. 样式的类名指定不要使用class，使用className\n4. 内联样式，要用`style={{key:value}}`的形式去写，第一层的{}代表的是JS表达式，第二层代表是一个对象，所以value\n\n需要使用引号，如果是font-size属性这样的，需要写成fontSize\n\n5. 只有一个根标签\n6. 标签必须闭合或者自闭合\n7. 标签首字母\n\n+ 如果是小写字母开头，则将该标签转为html中的同名元素，如果html中找不到对应的话，就会报错。例如<span>\n+ 如果是大写字母开头，react就去渲染对应的组件，如果组件没有对应，那就报错\n\n##### 函数定义组件\n\n```react\n  function Demo() {\n      console.log(this) // undefined babel编译后开启了严格模式，严格模式下不让this指向window\n      return <h1>我是函数式的组件（适用简单组件的定义）</h1>\n    }\n\n    ReactDOM.render(\n      <Demo />, // 这里要用大写，不然会被当成html里面去找，所以函数也要用大写\n      document.getElementById(\'example\')\n    );\n```\n\n执行` ReactDOM.render(<Demo />....`之后，\n\n1. react解析了组件标签，找到了Demo组件，\n2. 发现组件是使用函数调用的，随后调用该函数，\n3. 将返回的虚拟dom转为真实的dom，最后呈现在页面中。\n\n\n\n##### 类的知识总结\n\n1. 类中的构造器不是必须写的，要对实例进行初始化的操作，如添加指定的属性的时候才写\n2. 如果B类继承了A类，而且B类中写了构造器，那么B类构造器中必须要调用super([xxx]),xxx调用参数写啥，得看A类\n3. 类中定义的方法，都是放在了类的原型对象上，供实例去使用的。但是如果自身写了该方法，那么就不会去找原型对象上面的该方法了\n\n#### 类定义组件\n\n```react\n    class HelloMessage extends React.Component {\n        // render放在了HelloMessage的原型对象上，供实例去使用\n      render() {\n        return <h1>Hello world</h1>;\n      }\n      console.log(this) // 实例对象\n    }\n```\n\n执行` ReactDOM.render(<HelloMessage />....`之后，发生了什么？\n\n1. react解析组件标签，找到了HelloMessage组件\n2. 发现组件是用类定义的，随后new出来该类的实例对象（这里是react帮我做的，表面看不出来），并通过该实例对象调用到原型上的render函数(render函数是定义在HelloMessage类里面的，类里面定义的方法放在了原型对象上面)。\n3. 将render返回的虚拟Dom转成真实的Dom，随后呈现在页面中\n\n##### 类定义组件中的this\n\n```react\n  class Weather extends React.Component {\n      // 构造器调用几次？------ 只是一次\n      constructor(props) {\n        console.log(\'调用了\'); // 只输出一次\n        super(props)\n        // 初始化状态\n        this.state = { isHot: false, wind: \'微风\' }\n        // 2.也可以在这里把原型对象的上的changeWeather复制一份到自身的实例对象上\n        this.changeWeather = this.changeWeather.bind(this) // bind只改变this的指向，返回的是一个新的函数，要用的使用需要重新调用\n        console.log(this);\n      }\n      // render调用几次？----1+n次，1是初始化的那次，n是状态更新的次数\n      render() {\n        console.log(\'render调用了\');\n        // 读取状态\n        const { isHot, wind } = this.state\n        return <h1 onClick={this.changeWeather}>今天的天气{isHot ? \'炎热\' : \'凉爽\'}，{wind}</h1>;\n      }\n      // 1. 可以使用箭头函数拿到实例的this\n      // changeWeather = () => {\n      //   // changeWeather放在了哪里？ ----- Weather的原型对象上，供实例使用\n      //   // 用于changeWeather是作为onClick的回调使用的，所以不是通过实例调用的，而是直接调用\n      //   // 类中的方法默认开启了严格模式，所以changeWeather中的this是undefined，本来是Window的\n      //   console.log(this); // 现在是实例对象\n      // }\n\n      // changeWeather调用几次？ ----- 触发几次方法就调用几次呗\n      // 此时调用的是自身的changeWeather，而不是调用的原型对象上的changeWeather\n      changeWeather() {\n        // changeWeather放在了哪里？ ----- Weather的原型对象上，供实例使用\n        // 用于changeWeather是作为onClick的回调使用的，所以不是通过实例调用的，而是直接调用\n        // 类中的方法默认开启了严格模式，所以changeWeather中的this是undefined，本来是Window的\n\n        // 获取原来的isHot值\n        // 严重注意。状态不能直接更改，这个就是直接更改 this.state.isHot = !isHot\n        const isHot = this.state.isHot\n        // 严重注意，状态必须通过setState进行更新,而且更新是单纯的更新需要变的，不需要变不用动，比如wind\n        this.setState({ isHot: !isHot })\n        console.log(this.state.isHot);\n      }\n    }\n    ReactDOM.render(\n      <Weather />,\n      document.getElementById(\'example\')\n    );\n```\n\n![image-20211228094915134](https://cdn.jsdelivr.net/gh/JingWZeng/markdownImg/img/202112280949247.png)\n\n![image-20211228095657352](https://cdn.jsdelivr.net/gh/JingWZeng/markdownImg/img/202112280956414.png)\n\n简写：赋值语句和箭头函数\n\n```react\n        class Weather extends React.Component {\n            // 初始化状态\n            state = { isHot: false, wind: \'微风\' } // 类中的赋值语句就是让实例对象上添加属性\n            render() {\n                const { isHot, wind } = this.state\n                return <h1 onClick={this.changeWeather}>今天的天气{isHot ? \'炎热\' : \'凉爽\'}，{wind}</h1>;\n            }\n            // 自定义方法\n            changeWeather = () => {\n                console.log(this);\n                const isHot = this.state.isHot\n                this.setState({ isHot: !isHot })\n            }\n            // 报错\n            // changeWeather = function () {\n            //     const isHot = this.state.isHot\n            //     this.setState({ isHot: !isHot })\n            // }\n\n        }\n        ReactDOM.render(\n            <Weather />,\n            document.getElementById(\'example\')\n        );\n```\n\n \n\n##### 啥叫回调函数\n\n1. 是你自己定义的\n2. 不是你调用的\n3. 最终会被其他人调用\n\n\n\n#####  todoList案例\n\n注意点：\n\n```markdown\n\t1.拆分组件、实现静态组件，注意：className、style的写法\n\t2.动态初始化列表，如何确定将数据放在哪个组件的state中？\n\t\t\t\t——某个组件使用：放在其自身的state中\n\t\t\t\t——某些组件使用：放在他们共同的父组件state中（官方称此操作为：状态提升）\n\t3.关于父子之间通信：\n\t\t\t1.【父组件】给【子组件】传递数据：通过props传递\n\t\t\t2.【子组件】给【父组件】传递数据：通过props传递，要求父提前给子传递一个函数\n\t4.注意defaultChecked 和 checked的区别，类似的还有：defaultValue 和 value\n\t5.状态在哪里，操作状态的方法就在哪里\n```\n\n\n\n##### react的代理\n\n在src文件下新建一个setupProxy.js文件\n\n```js\nconst {createProxyMiddleware}= require(\'http-proxy-middleware\')\n\nmodule.exports = function(app){\n    app.use(\n        createProxyMiddleware(\'/api1\',{ //遇见/api1前缀的请求，就会触发该代理配置\n            target:\'http://localhost:5000\', //请求转发给谁\n            changeOrigin:true, //控制服务器收到的请求头中Host的值，欺骗服务器这样子，如果是false，因为我是3000端口请求的，服务器可以知道我是3000，如果写了，那我就变成了5000\n            pathRewrite:{\'^/api1\':\'\'} //重写请求路径(必须) 给服务器的请求地址，一开始带上了api1,这个时候服务器那边就显示我想请求的是api1/xxx,但是真正的请求地址是xxx，不带api1的\n        }),\n        createProxyMiddleware(\'/api2\',{\n            target:\'http://localhost:5001\',\n            changeOrigin:true,\n            pathRewrite:{\'^/api2\':\'\'}\n        }),\n\n    )\n}\n```\n\n> devServe的存在就是说你本地跑的项目的地址，比如是http://localhost:3000。就是你本地它帮你开服务器地址，同时这个路径代表的就是项目里面的public文件夹的路径。而服务器之间是没有跨域的，相当于啥呢，就是浏览器和本地的服务器3000和后端服务器3个人，利用本地的3000服务器来做代理，因为项目（浏览器）也是3000端口，本地的服务器也是3000.所以没有跨域的存在。如果本地请求的东西不存在，就会返回项目里面的pubilc的index.html。\n>\n> 前端路由跳转是不会请求网络数据的，但是如果直接使用多级路由来做每一个组件的路由，当你跳转路由之后刷新页面的话，样式可能会丢失，因为原本的样式请求地址可能被混入了前面那一级的路由。直接就返回了pubilc下的index.html了。\n>\n> **解决多级路径刷新页面样式丢失的问题**\n>\n> 1.public/index.html 中 引入样式时不写 ./ 写 / （常用）\n> 2.public/index.html 中 引入样式时不写 ./ 写 %PUBLIC_URL% （常用）\n> 3.使用HashRouter，因为#号后面的东西都是前端的资源，不会带给本地的服务器的，也不会带给其他服务器。正常是不会用这种方法的。\n\n##### react脚手架配置代理总结\n\n**方法一**\n\n> 在package.json中追加如下配置\n\n```js\n\"proxy\":\"http://localhost:5000\"\n```\n\n说明：\n\n1. 优点：配置简单，前端请求资源时可以不加任何前缀。\n2. 缺点：不能配置多个代理。\n3. 工作方式：上述方式配置代理，当请求了3000不存在的资源时，那么该请求会转发给5000 （优先匹配前端资源）\n\n\n\n**方法二**\n\n1. 第一步：创建代理配置文件\n\n   ```js\n   在src下创建配置文件：src/setupProxy.js\n   ```\n\n2. 编写setupProxy.js配置具体代理规则：\n\n   ```js\n   const proxy = require(\'http-proxy-middleware\')\n   \n   module.exports = function(app) {\n     app.use(\n       proxy(\'/api1\', {  //api1是需要转发的请求(所有带有/api1前缀的请求都会转发给5000)\n         target: \'http://localhost:5000\', //配置转发目标地址(能返回数据的服务器地址)\n         changeOrigin: true, //控制服务器接收到的请求头中host字段的值\n         /*\n         \tchangeOrigin设置为true时，服务器收到的请求头中的host为：localhost:5000\n         \tchangeOrigin设置为false时，服务器收到的请求头中的host为：localhost:3000\n         \tchangeOrigin默认值为false，但我们一般将changeOrigin值设为true\n         */\n         pathRewrite: {\'^/api1\': \'\'} //去除请求前缀，保证交给后台服务器的是正常请求地址(必须配置)\n       }),\n       proxy(\'/api2\', { \n         target: \'http://localhost:5001\',\n         changeOrigin: true,\n         pathRewrite: {\'^/api2\': \'\'}\n       })\n     )\n   }\n   ```\n\n说明：\n\n1. 优点：可以配置多个代理，可以灵活的控制请求是否走代理。\n2. 缺点：配置繁琐，前端请求资源时必须加前缀。\n\n##### github搜索案例\n\n注意点\n\n```markdown\n\t1.设计状态时要考虑全面，例如带有网络请求的组件，要考虑请求失败怎么办。\n\t2.ES6小知识点：解构赋值+重命名\n\t\t\t\tlet obj = {a:{b:1}}\n\t\t\t\tconst {a} = obj; //传统解构赋值\n\t\t\t\tconst {a:{b}} = obj; //连续解构赋值\n\t\t\t\tconst {a:{b:value}} = obj; //连续解构赋值+重命名\n\t3.消息订阅与发布机制\n\t\t\t\t1.先订阅，再发布（理解：有一种隔空对话的感觉）\n\t\t\t\t2.适用于任意组件间通信\n\t\t\t\t3.要在组件的componentWillUnmount中取消订阅\n\t4.fetch发送请求（关注分离的设计思想）\n\t\t\t\ttry {\n\t\t\t\t\tconst response= await fetch(`/api1/search/users2?q=${keyWord}`)\n\t\t\t\t\tconst data = await response.json()\n\t\t\t\t\tconsole.log(data);\n\t\t\t\t} catch (error) {\n\t\t\t\t\tconsole.log(\'请求出错\',error);\n\t\t\t\t}\n```\n\n#### React-route-dom\n\n##### 路由的基本使用\n\n```markdown\n\t\t1.明确好界面中的导航区、展示区\n\t\t2.导航区的a标签改为Link标签\n\t\t\t\t\t<Link to=\"/xxxxx\">Demo</Link>\n\t\t3.展示区写Route标签进行路径的匹配\n\t\t\t\t\t<Route path=\'/xxxx\' component={Demo}/>\n\t\t4.<App>的最外侧包裹了一个<BrowserRouter>或<HashRouter> \n\t\trouter相当于一个路由器，route相当于路由器上面的路由接口，没有路由器的话哪里来的路由接口\n```\n\n##### 路由组件与一般组件\n\n```markdown\n\t\t1.写法不同：\n\t\t\t\t\t一般组件：<Demo/>\n\t\t\t\t\t路由组件：<Route path=\"/demo\" component={Demo}/>\n\t\t2.存放位置不同：\n\t\t\t\t\t一般组件：components\n\t\t\t\t\t路由组件：pages\n\t\t3.接收到的props不同：\n\t\t\t\t\t一般组件：写组件标签时传递了什么，就能收到什么\n\t\t\t\t\t路由组件：接收到三个固定的属性\n\t\t\t\t\t\t\t\t\t\thistory:\n\t\t\t\t\t\t\t\t\t\t\t\t\tgo: ƒ go(n)\n\t\t\t\t\t\t\t\t\t\t\t\t\tgoBack: ƒ goBack()\n\t\t\t\t\t\t\t\t\t\t\t\t\tgoForward: ƒ goForward()\n\t\t\t\t\t\t\t\t\t\t\t\t\tpush: ƒ push(path, state)\n\t\t\t\t\t\t\t\t\t\t\t\t\treplace: ƒ replace(path, state)\n\t\t\t\t\t\t\t\t\t\tlocation:\n\t\t\t\t\t\t\t\t\t\t\t\t\tpathname: \"/about\"\n\t\t\t\t\t\t\t\t\t\t\t\t\tsearch: \"\"\n\t\t\t\t\t\t\t\t\t\t\t\t\tstate: undefined\n\t\t\t\t\t\t\t\t\t\tmatch:\n\t\t\t\t\t\t\t\t\t\t\t\t\tparams: {}\n\t\t\t\t\t\t\t\t\t\t\t\t\tpath: \"/about\"\n\t\t\t\t\t\t\t\t\t\t\t\t\turl: \"/about\"\n```\n\n##### NavLink与封装NavLink\n\n```markdown\n\t\t\t1.NavLink可以实现路由链接的高亮，通过activeClassName指定样式名\n```\n\n##### Switch的使用\n\n```markdown\n\t\t\t1.通常情况下，path和component是一一对应的关系。\n\t\t\t2.Switch可以提高路由匹配效率(单一匹配)。\nSwitch可以让路由匹配到一个路由之后就停下，单一匹配，因为正常情况下的话，路由会去和每一个注册进行检测的\n```\n\n##### 路由的严格匹配与模糊匹配\n\n```markdown\n\t\t\t1.默认使用的是模糊匹配（简单记：【输入的路径】必须包含要【匹配的路径】，且顺序要一致）\n\t\t\t2.开启严格匹配：<Route exact={true} path=\"/about\" component={About}/>\n\t\t\t3.严格匹配不要随便开启，需要再开，有些时候开启会导致无法继续匹配二级路由\n```\n\n##### Redirect的使用\n\n```markdown\n\t\t\t1.一般写在所有路由注册的最下方，当所有路由都无法匹配时，跳转到Redirect指定的路由\n\t\t\t2.具体编码：\n\t\t\t\t\t<Switch>\n\t\t\t\t\t\t<Route path=\"/about\" component={About}/>\n\t\t\t\t\t\t<Route path=\"/home\" component={Home}/>\n\t\t\t\t\t\t<Redirect to=\"/about\"/>\n\t\t\t\t\t</Switch>\n```\n\n##### 嵌套路由\n\n```markdown\n\t\t\t1.注册子路由时要写上父路由的path值\n\t\t\t2.路由的匹配是按照注册路由的顺序进行的\n```\n\n##### 向路由组件传递参数\n\n```markdown\n1.params参数\n    路由链接(携带参数)：<Link to=\'/demo/test/tom/18\'}>详情</Link>\n\t注册路由(声明接收)：<Route path=\"/demo/test/:name/:age\" component={Test}/>\n\t接收参数：this.props.match.params\n\t刷新也可以保留住参数（因为地址栏有显示），地址栏可以看到参数\n2.search参数\n    路由链接(携带参数)：<Link to=\'/demo/test?name=tom&age=18\'}>详情</Link>\n\t注册路由(无需声明，正常注册即可)：<Route path=\"/demo/test\" component={Test}/>\n\t接收参数：this.props.location.search\n\t备注：获取到的search是urlencoded编码字符串，需要借助querystring解析\n\t刷新也可以保留住参数（因为地址栏有显示），地址栏可以看到参数\n3.state参数\n\t路由链接(携带参数)：<Link to={{pathname:\'/demo/test\',state:{name:\'tom\',age:18}}}>详情</Link>\n\t注册路由(无需声明，正常注册即可)：<Route path=\"/demo/test\" component={Test}/>\n    接收参数：this.props.location.state\n    备注：刷新也可以保留住参数、地址栏看不到参数。利用的是浏览器的history对象做的，如果你现在清空浏览器历史记录就看不到了\n```\n\n##### 编程式路由导航\n\n```markdown\n\t\t\t\t借助this.prosp.history对象上的API对操作路由跳转、前进、后退\n\t\t\t\t\t\t-this.prosp.history.push()\n\t\t\t\t\t\t-this.prosp.history.replace()\n\t\t\t\t\t\t-this.prosp.history.goBack()\n\t\t\t\t\t\t-this.prosp.history.goForward()\n\t\t\t\t\t\t-this.prosp.history.go()\n```\n\n##### BrowserRouter与HashRouter的区别\n\n```markdown\n\t\t1.底层原理不一样：\n\t\t\t\t\tBrowserRouter使用的是H5的history API，不兼容IE9及以下版本。\n\t\t\t\t\tHashRouter使用的是URL的哈希值。\n\t\t2.path表现形式不一样\n\t\t\t\t\tBrowserRouter的路径中没有#,例如：localhost:3000/demo/test\n\t\t\t\t\tHashRouter的路径包含#,例如：localhost:3000/#/demo/test\n\t\t3.刷新后对路由state参数的影响\n\t\t\t\t\t(1).BrowserRouter没有任何影响，因为state保存在history对象中。\n\t\t\t\t\t(2).HashRouter刷新后会导致路由state参数的丢失！！！\n\t\t4.备注：HashRouter可以用于解决一些路径错误相关的问题。\n```\n\n#### redux\n\n##### 求和案例_redux精简版\n\n```markdown\n\t(1).去除Count组件自身的状态\n\t(2).src下建立:\n\t\t\t\t\t-redux\n\t\t\t\t\t\t-store.js\n\t\t\t\t\t\t-count_reducer.js\n\n\t(3).store.js：\n\t\t\t\t1).引入redux中的createStore函数，创建一个store\n\t\t\t\t2).createStore调用时要传入一个为其服务的reducer\n\t\t\t\t3).记得暴露store对象\n\n\t(4).count_reducer.js：\n\t\t\t\t1).reducer的本质是一个函数，接收：preState,action，返回加工后的状态\n\t\t\t\t2).reducer有两个作用：初始化状态，加工状态\n\t\t\t\t3).reducer被第一次调用时，是store自动触发的，\n\t\t\t\t\t\t\t\t传递的preState是undefined,\n\t\t\t\t\t\t\t\t传递的action是:{type:\'@@REDUX/INIT_a.2.b.4}\n\n\t(5).在index.js中监测store中状态的改变，一旦发生改变重新渲染<App/>\n\t\t\t备注：redux只负责管理状态，至于状态的改变驱动着页面的展示，要靠我们自己写。\n```\n\n##### 求和案例_redux完整版\n\n```markdown\n\t新增文件：\n\t\t1.count_action.js 专门用于创建action对象\n\t\t2.constant.js 放置容易写错的type值\n```\n\n##### 求和案例_redux异步action版\n\n```markdown\n\t (1).明确：延迟的动作不想交给组件自身，想交给action\n\t (2).何时需要异步action：想要对状态进行操作，但是具体的数据靠异步任务返回。\n\t (3).具体编码：\n\t \t\t\t1).yarn add redux-thunk，并配置在store中\n\t \t\t\t2).创建action的函数不再返回一般对象，而是一个函数，该函数中写异步任务。\n\t \t\t\t3).异步任务有结果后，分发一个同步的action去真正操作数据。\n\t (4).备注：异步action不是必须要写的，完全可以自己等待异步任务的结果了再去分发同步action。\n```\n\n\n\n#### react-redux\n\n##### 求和案例_react-redux基本使用\n\n```markdown\n    (1).明确两个概念：\n\t\t\t\t1).UI组件:不能使用任何redux的api，只负责页面的呈现、交互等。\n\t\t\t\t2).容器组件：负责和redux通信，将结果交给UI组件。\n\t(2).如何创建一个容器组件————靠react-redux 的 connect函数\n\t\t\t\t\tconnect(mapStateToProps,mapDispatchToProps)(UI组件)\n\t\t\t\t\t\t-mapStateToProps:映射状态，返回值是一个对象\n\t\t\t\t\t\t-mapDispatchToProps:映射操作状态的方法，返回值是一个对象\n\t(3).备注1：容器组件中的store是靠props传进去的，而不是在容器组件中直接引入\n\t(4).备注2：mapDispatchToProps，也可以是一个对象\n```\n\n##### 求和案例_react-redux优化\n\n```markdown\n\t\t(1).容器组件和UI组件整合一个文件\n\t\t(2).无需自己给容器组件传递store，给<App/>包裹一个<Provider store={store}>即可。\n\t\t(3).使用了react-redux后也不用再自己检测redux中状态的改变了，容器组件可以自动完成这个工作。\n\t\t(4).mapDispatchToProps也可以简单的写成一个对象\n\t\t(5).一个组件要和redux“打交道”要经过哪几步？\n\t\t\t\t\t\t(1).定义好UI组件---不暴露\n\t\t\t\t\t\t(2).引入connect生成一个容器组件，并暴露，写法如下：\n\t\t\t\t\t\t\t\tconnect(\n\t\t\t\t\t\t\t\t\tstate => ({key:value}), //映射状态\n\t\t\t\t\t\t\t\t\t{key:xxxxxAction} //映射操作状态的方法\n\t\t\t\t\t\t\t\t)(UI组件)\n\t\t\t\t\t\t(4).在UI组件中通过this.props.xxxxxxx读取和操作状态\n```\n\n##### 求和案例_react-redux数据共享版\n\n```markdown\n\t\t(1).定义一个Pserson组件，和Count组件通过redux共享数据。\n\t\t(2).为Person组件编写：reducer、action，配置constant常量。\n\t\t(3).重点：Person的reducer和Count的Reducer要使用combineReducers进行合并，\n\t\t\t\t合并后的总状态是一个对象！！！\n\t\t(4).交给store的是总reducer，最后注意在组件中取出状态的时候，记得“取到位”。\n```\n\n##### 求和案例_react-redux开发者工具的使用\n\n```markdown\n\t\t(1).yarn add redux-devtools-extension\n\t\t(2).store中进行配置\n\t\t\t\timport {composeWithDevTools} from \'redux-devtools-extension\'\n\t\t\t\tconst store = createStore(allReducer,composeWithDevTools(applyMiddleware(thunk)))\n```\n\n##### 求和案例_react-redux最终版\n\n```markdown\n\t\t(1).所有变量名字要规范，尽量触发对象的简写形式。\n\t\t(2).reducers文件夹中，编写index.js专门用于汇总并暴露所有的reducer\n```\n\n\n\n### react扩展\n\n#### setState\n\n##### setState更新状态的2种写法\n\n```markdown\n\t(1). setState(stateChange, [callback])------对象式的setState\n            1.stateChange为状态改变对象(该对象可以体现出状态的更改)\n            2.callback是可选的回调函数, 它在状态更新完毕、界面也更新后(render调用后)才被调用\n\t\t\t\t\t\n\t(2). setState(updater, [callback])------函数式的setState\n            1.updater为返回stateChange对象的函数。\n            2.updater可以接收到state和props。\n            4.callback是可选的回调函数, 它在状态更新、界面也更新后(render调用后)才被调用。\n总结:\n\t\t1.对象式的setState是函数式的setState的简写方式(语法糖)\n\t\t2.使用原则：\n\t\t\t\t(1).如果新状态不依赖于原状态 ===> 使用对象方式\n\t\t\t\t(2).如果新状态依赖于原状态 ===> 使用函数方式\n\t\t\t\t(3).如果需要在setState()执行后获取最新的状态数据, \n\t\t\t\t\t要在第二个callback函数中读取\n```\n\n### lazyLoad\n\n#### 路由组件的lazyLoad\n\n```js\n\t//1.通过React的lazy函数配合import()函数动态加载路由组件 ===> 路由组件代码会被分开打包\n\tconst Login = lazy(()=>import(\'@/pages/Login\'))\n\t\n\t//2.通过<Suspense>指定在加载得到路由打包文件前显示一个自定义loading界面\n\t<Suspense fallback={<h1>loading.....</h1>}>\n        <Switch>\n            <Route path=\"/xxx\" component={Xxxx}/>\n            <Redirect to=\"/login\"/>\n        </Switch>\n    </Suspense>\n```\n\n### 3. Hooks\n\n#### 1. React Hook/Hooks是什么?\n\n```markdown\n(1). Hook是React 16.8.0版本增加的新特性/新语法\n(2). 可以让你在函数组件中使用 state 以及其他的 React 特性\n```\n\n#### 2. 三个常用的Hook\n\n```markdown\n(1). State Hook: React.useState()\n(2). Effect Hook: React.useEffect()\n(3). Ref Hook: React.useRef()\n```\n\n#### 3. State Hook\n\n```markdown\n(1). State Hook让函数组件也可以有state状态, 并进行状态数据的读写操作\n(2). 语法: const [xxx, setXxx] = React.useState(initValue)  \n(3). useState()说明:\n        参数: 第一次初始化指定的值在内部作缓存\n        返回值: 包含2个元素的数组, 第1个为内部当前状态值, 第2个为更新状态值的函数\n(4). setXxx()2种写法:\n        setXxx(newValue): 参数为非函数值, 直接指定新的状态值, 内部用其覆盖原来的状态值\n        setXxx(value => newValue): 参数为函数, 接收原本的状态值, 返回新的状态值, 内部用其覆盖原来的状态值\n```\n\n#### 4. Effect Hook\n\n```markdown\n(1). Effect Hook 可以让你在函数组件中执行副作用操作(用于模拟类组件中的生命周期钩子)\n(2). React中的副作用操作:\n        发ajax请求数据获取\n        设置订阅 / 启动定时器\n        手动更改真实DOM\n(3). 语法和说明: \n        useEffect(() => { \n          // 在此可以执行任何带副作用操作\n          return () => { // 在组件卸载前执行\n            // 在此做一些收尾工作, 比如清除定时器/取消订阅等\n          }\n        }, [stateValue]) // 如果指定的是[], 回调函数只会在第一次render()后执行\n    \n(4). 可以把 useEffect Hook 看做如下三个函数的组合\n        componentDidMount()\n        componentDidUpdate()\n    \tcomponentWillUnmount() \n```\n\n#### 5. Ref Hooks\n\n```markdown\n(1). Ref Hook可以在函数组件中存储/查找组件内的标签或任意其它数据\n(2). 语法: const refContainer = useRef()\n(3). 作用:保存标签对象,功能与React.createRef()一样\n```\n\n### 4. Fragment\n\n#### 使用\n\n```js\n<Fragment><Fragment>\n<></>\n```\n\n#### 作用\n\n> 可以不用必须有一个真实的DOM根标签了\n\n### 5. Context\n\n#### 理解\n\n> 一种组件间通信方式, 常用于【祖组件】与【后代组件】间通信\n\n#### 使用\n\n```js\n1) 创建Context容器对象：\n\tconst XxxContext = React.createContext()  \n\t\n2) 渲染子组时，外面包裹xxxContext.Provider, 通过value属性给后代组件传递数据：\n\t<xxxContext.Provider value={数据}>\n\t\t子组件\n    </xxxContext.Provider>\n    \n3) 后代组件读取数据：\n\n\t//第一种方式:仅适用于类组件 \n\t  static contextType = xxxContext  // 声明接收context\n\t  this.context // 读取context中的value数据\n\t  \n\t//第二种方式: 函数组件与类组件都可以\n\t  <xxxContext.Consumer>\n\t    {\n\t      value => ( // value就是context中的value数据\n\t        要显示的内容\n\t      )\n\t    }\n\t  </xxxContext.Consumer>\n```\n\n### 注意\n\n```markdown\n在应用开发中一般不用context, 一般都它的封装react插件\n```\n\n\n\n### 6. 组件优化\n\n#### Component的2个问题\n\n> 1. 只要执行setState(),即使不改变状态数据, 组件也会重新render()\n> 2. 只当前组件重新render(), 就会自动重新render子组件 ==> 效率低\n\n#### 效率高的做法\n\n> 只有当组件的state或props数据发生改变时才重新render()\n\n#### 原因\n\n> Component中的shouldComponentUpdate()总是返回true\n\n#### 解决\n\n```markdown\n办法1: \n\t重写shouldComponentUpdate()方法\n\t比较新旧state或props数据, 如果有变化才返回true, 如果没有返回false\n办法2:  \n\t使用PureComponent\n\tPureComponent重写了shouldComponentUpdate(), 只有state或props数据有变化才返回true\n\t注意: \n\t\t只是进行state和props数据的浅比较, 如果只是数据对象内部数据变了, 返回false  \n\t\t不要直接修改state数据, 而是要产生新数据\n项目中一般使用PureComponent来优化\n```\n\n### 7. render props\n\n#### 如何向组件内部动态传入带内容的结构(标签)?\n\n```markdown\nVue中: \n\t使用slot技术, 也就是通过组件标签体传入结构  <AA><BB/></AA>\nReact中:\n\t使用children props: 通过组件标签体传入结构\n\t使用render props: 通过组件标签属性传入结构, 一般用render函数属性\n```\n\n#### children props\n\n```markdown\n<A>\n  <B>xxxx</B>\n</A>\n{this.props.children}\n问题: 如果B组件需要A组件内的数据, ==> 做不到 \n```\n\n#### render props\n\n```markdown\n<A render={(data) => <C data={data}></C>}></A>\nA组件: {this.props.render(内部state数据)}\nC组件: 读取A组件传入的数据显示 {this.props.data} \n```\n\n### 8. 错误边界\n\n#### 理解：\n\n错误边界：用来捕获后代组件错误，渲染出备用页面\n\n#### 特点：\n\n只能捕获后代组件生命周期产生的错误，不能捕获自己组件产生的错误和其他组件在合成事件、定时器中产生的错误\n\n#### 使用方式：\n\ngetDerivedStateFromError配合componentDidCatch\n\n```js\n// 生命周期函数，一旦后台组件报错，就会触发\nstatic getDerivedStateFromError(error) {\n    console.log(error);\n    // 在render之前触发\n    // 返回新的state\n    return {\n        hasError: true,\n    };\n}\n\ncomponentDidCatch(error, info) {\n    // 统计页面的错误。发送请求发送到后台去\n    console.log(error, info);\n}\n```\n\n### 9. 组件通信方式总结\n\n#### 方式：\n\n```markdown\n\tprops：\n\t\t(1).children props\n\t\t(2).render props\n\t消息订阅-发布：\n\t\tpubs-sub、event等等\n\t集中式管理：\n\t\tredux、dva等等\n\tconText:\n\t\t生产者-消费者模式\n```\n\n#### 组件间的关系\n\n```markdown\n\t父子组件：props\n\t兄弟组件(非嵌套组件)：消息订阅-发布、集中式管理\n\t祖孙组件(跨级组件)：消息订阅-\n```','#### 学习React整理的知识点','1641772800000',1021);
/*!40000 ALTER TABLE `article` ENABLE KEYS */;

#
# Structure for table "type"
#

DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `typeName` varchar(255) DEFAULT NULL,
  `orderNum` int(11) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Data for table "type"
#

/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` VALUES (1,'视频教程',1,'YoutubeOutlined'),(2,'文档教程',2,'HomeOutlined'),(3,'生活分享',3,'SmileOutlined');
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
