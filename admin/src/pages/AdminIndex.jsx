import React,{useState} from 'react';
import { Layout, Menu, Breadcrumb } from 'antd';
import {
    PieChartTwoTone,
    BankTwoTone,
    ProfileTwoTone,
    MessageTwoTone,
    EditTwoTone,
    RocketTwoTone
} from '@ant-design/icons'
import '../static/css/AdminIndex.css'
import {Route} from 'react-router-dom'
import AddArticle from "./AddArticle";
import ArticleList from "./ArticleList";
const { Header, Content, Footer, Sider } = Layout;
const { SubMenu } = Menu;



const AdminIndex = (props) =>{

    const [collapsed,setCollapsed] = useState(false)

    const onCollapse = collapsed => {
        setCollapsed(collapsed)
    };
    const handleClickArticle = (e)=>{
        if(e.key=='addArticle'){
            props.history.push('/index/add')
        }else{
            console.log(1111)
            props.history.push('/index/list')
        }
    }

    return (
        <Layout style={{ minHeight: '100vh' }}>
            <Sider  collapsible collapsed={collapsed} onCollapse={onCollapse}>
                <div className="logo" >
                    <h2 className="blog-title">Blog System</h2>
                </div>
                <Menu theme="dark" defaultSelectedKeys={['1']} mode="inline">
                    <Menu.Item key="1">
                        <PieChartTwoTone />
                        <span>工作台</span>
                    </Menu.Item>
                    <Menu.Item key="2">
                        <BankTwoTone />
                        <span>添加文章</span>
                    </Menu.Item>
                    <SubMenu
                        key="sub1"
                        onClick={handleClickArticle}
                        title={
                            <span>
                    <ProfileTwoTone />
                  <span>文章管理</span>
                </span>
                        }
                    >
                        <Menu.Item key="addArticle">
                            <RocketTwoTone />
                            <span>添加文章</span>
                        </Menu.Item>
                        <Menu.Item key="articleList">
                            <EditTwoTone />
                            <span>文章列表</span>
                        </Menu.Item>
                    </SubMenu>

                    <Menu.Item key="9">
                        <MessageTwoTone />
                        <span>留言管理</span>
                    </Menu.Item>
                </Menu>
            </Sider>
            <Layout>
                <Header style={{ background: '#dedede', padding: 0,textAlign: 'center' ,fontSize:'20px',fontWeight:'bold'}}>
                    Hei、Hei
                </Header>
                <Content style={{ margin: '0 16px' }}>
                    <Breadcrumb style={{ margin: '16px 0' }}>
                        <Breadcrumb.Item>后台管理</Breadcrumb.Item>
                        <Breadcrumb.Item>工作台</Breadcrumb.Item>
                    </Breadcrumb>
                    <div style={{ padding: 24, background: '#fff', minHeight: '100vh',boxShadow:'rgba(0, 0, 0, 0.24) 0px 3px 8px' }}>
                        <div>
                            <Route path="/index/" exact   component={AddArticle}></Route>
                            <Route path="/index/add/" exact   component={AddArticle} />
                            <Route path="/index/add/:id"  exact   component={AddArticle} />
                            <Route path="/index/list/"   component={ArticleList}></Route>
                        </div>
                    </div>
                </Content>
                <Footer style={{ textAlign: 'center',fontSize: '20px' }}>ZengXPang</Footer>
            </Layout>
        </Layout>
    )

}

export default AdminIndex