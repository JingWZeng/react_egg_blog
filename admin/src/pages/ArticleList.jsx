import React, {useState, useEffect, Fragment} from 'react';
import {  Modal ,message ,Button,Table,Tag,Space} from 'antd';
import axios from 'axios'
import  servicePath  from '../config/apiUrl'
import dayjs from "dayjs";
const { confirm } = Modal;
const { Column } = Table


const ArticleList = (props)=> {
    const [list,setList] = useState([])
    useEffect(()=>{
        getList()
    },[])
    //得到文章列表
    const getList = ()=>{
        axios({
            method:'get',
            url: servicePath.getArticleList,
            withCredentials: true,
            headers:{
                'Access-Control-Allow-Origin':'*',
                'Authorization':`${localStorage.getItem('token')}`
            },
        }).then(
            res=>{
                setList(()=>{
                    return  res.data.list
                })
            }
        )
    }


//删除文章的方法
    const delArticle = (id)=>{
        confirm({
            title: '确定要删除这篇博客文章吗?',
            content: '如果你点击OK按钮，文章将会永远被删除，无法恢复。',
            onOk() {

                axios(`${servicePath.delArticle}/${id}`,{
                    withCredentials: true,
                    headers:{
                        'Access-Control-Allow-Origin':'*',
                        'Authorization':`${localStorage.getItem('token')}`
                    },}).then(
                    res=>{
                        message.success('文章删除成功')
                        getList()
                    }
                )
            },
            onCancel() {
                message.success('没有任何改变')
            },
        });

    }
    //修改文章
    const updateArticle = (id,checked)=>{
        props.history.push('/index/add/'+id)

    }
    return (
        <div>
            <Table dataSource={list} bordered pagination={false} rowKey={item=>item.id}>
                <Column title="标题" dataIndex="title" key="title" align='center'/>
                <Column
                    title="类别"
                    dataIndex="typeName"
                    key="typeName"
                    align='center'
                    render={typeName => (
                        <Fragment key="typeName">
                            {
                                <Tag color="blue">
                                    {typeName}
                                </Tag>
                            }
                        </Fragment>
                    )}
                />
                <Column
                    title="发布时间"
                    dataIndex="addTime"
                    key="addTime"
                    align='center'
                    render={addTime=>(
                        <Fragment key="addTime">
                            {
                                addTime ? dayjs(+addTime).format('YYYY-MM-DD') : '-'
                            }
                        </Fragment>
                    )}

                />
                <Column
                    title="浏览量"
                    dataIndex="view_count"
                    key="view_count"
                    align='center'
                    render={view_count=>(
                        <Fragment key="view_count">
                            {
                                view_count ? view_count : 0
                            }
                        </Fragment>
                    )}

                />
                <Column
                    title="操作"
                    key="action"
                    align='center'
                    render={(_, record) => (
                        <Space size="middle">
                            <Button type="primary" onClick={()=>updateArticle(record.id)}>修改</Button>&nbsp;
                            <Button onClick={()=>{delArticle(record.id)}}>删除 </Button>
                        </Space>
                    )}
                />
            </Table>
        </div>
    );
}

export default ArticleList;