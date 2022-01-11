import React,{useState} from 'react'
import {Row,Col,List} from 'antd'
import Head from 'next/head'
import Link from 'next/link'
import  fetch from 'node-fetch'
import dayjs from "dayjs";
import {
    CalendarFilled ,
    FolderAddFilled,
    FireFilled
} from '@ant-design/icons'
import Header from "../components/Header.jsx";
import Author from "../components/Author";
import Footer from "../components/Footer"
// import Advert from "../components/Advert";
import servicePath from "../config/apiUrl";
import marked from 'marked'
import hljs from "highlight.js";
import 'highlight.js/styles/monokai-sublime.css';


const Home = (list) => {
    const [ mylist , setMylist ] = useState(list.data)
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
                                        <span><CalendarFilled/>{item.addTime
                                            ? dayjs(+item.addTime).format('YYYY-MM-DD')
                                            : dayjs().format('YYYY-MM-DD')}
                                        </span>
                                        <span><FolderAddFilled/>{item.typeName}</span>
                                        <span><FireFilled/>{item.view_count}人</span>
                                    </div>
                                    <div className="list_context"
                                         dangerouslySetInnerHTML={{__html:marked(item.introduce)}}
                                    >
                                    </div>
                                </List.Item>
                            )
                        }
                    />
                </Col>
                <Col className="comm_box" xs={0} sm={0} md={7} lg={5} xl={4}>
                    <Author/>
                    {/*<Advert/>*/}
                </Col>
            </Row>
            <Footer/>
        </div>
        )
}

export const getServerSideProps = async ()=>{
    let res = await fetch(servicePath.getArticleList)
    let data = res.json()
    return {
        props: data
    }
}

export default Home