import React,{useState,useEffect} from 'react'
import {Row,Col,List,Breadcrumb} from 'antd'
import Head from 'next/head'
import {
    CalendarFilled ,
    FolderAddFilled,
    FireFilled
} from '@ant-design/icons'
import Header from "../components/Header.jsx";
import Author from "../components/Author";
import Footer from "../components/Footer"
import fetch from "node-fetch";
import servicePath from "../config/apiUrl";
import Link from 'next/link';
import dayjs from "dayjs";
import marked from 'marked'
import hljs from "highlight.js";
import 'highlight.js/styles/monokai-sublime.css';

const Lists = (list) => {
    console.log(list)
    const [ mylist , setMylist ] = useState(list.data)
    useEffect(()=>{
        setMylist(list.data)
    })
    const renderer = new marked.Renderer();
    marked.setOptions({
        renderer: renderer,
        gfm: true,
        pedantic: false,
        sanitize: false,
        tables: true,
        breaks: false,
        smartLists: true,
        smartypants: false,
        highlight: function (code) {
            return hljs.highlightAuto(code).value;
        }
    });


    return (
        <div>
            <Head>
                <title>My Blog</title>
            </Head>
            <Header/>
            <Row className="comm_main" type="flex" justify="center">
                <Col className="comm_left" xs={24} sm={24} md={16} lg={18} xl={14}>
                    <div>
                        <div className="bread-div">
                            <Breadcrumb>
                                <Breadcrumb.Item><a href="/">首页</a></Breadcrumb.Item>
                                <Breadcrumb.Item>视频列表</Breadcrumb.Item>
                            </Breadcrumb>
                        </div>
                    <List
                        itemLayout="vertical"
                        dataSource={mylist}
                        renderItem = {
                            item => (
                                <List.Item>
                                    <div className="list_title">
                                        <Link href={{pathname:'/detailed',query:{id:item.id}}}>
                                            <a>{item.title}</a>
                                        </Link>
                                    </div>
                                    <div className="list_icon">
                                        <span><CalendarFilled /> 2019-06-28</span>
                                        <span><FolderAddFilled />{item.addTime
                                            ? dayjs(+item.addTime).format('YYYY-MM-DD')
                                            : dayjs().format('YYYY-MM-DD')}
                                        </span>
                                        <span><FireFilled /> {item.view_count}人</span>
                                    </div>
                                    <div className="list_context"
                                         dangerouslySetInnerHTML={{__html:marked(item.introduce)}}
                                    ></div>
                                </List.Item>
                            )
                        }
                    />
                    </div>
                </Col>
                <Col className="comm_box" xs={0} sm={0} md={7} lg={5} xl={4}>
                    <Author/>
                </Col>
            </Row>
            <Footer/>
        </div>
    )
}

export const getServerSideProps = async ({query:{id}})=>{
    let res = await fetch(`${servicePath.getListById}/${id}`)
    let data = res.json()
    return {
        props: data
    }
}



export default Lists