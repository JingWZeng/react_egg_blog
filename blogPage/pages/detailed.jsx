import React from 'react'
import {Row,Col,Affix,Breadcrumb} from 'antd'
import Head from "next/head";
import marked from 'marked'
import hljs from "highlight.js";
import 'highlight.js/styles/monokai-sublime.css';
import Header from "../components/Header";
import Author from "../components/Author";
import Footer from "../components/Footer"
import {
    CalendarFilled ,
    FolderAddFilled,
    FireFilled
} from '@ant-design/icons'
import fetch from "node-fetch";
import Tocify from "../components/tocify.tsx";
import servicePath from "../config/apiUrl";


const Detailed = (props) => {
    const data = props.data[0]
    const renderer = new marked.Renderer();
    const tocify = new Tocify()

    // 导航部分的
    renderer.heading = function(text, level, raw) {
        const anchor = tocify.add(text, level);
        return `<a id="${anchor}" href="#${anchor}" class="anchor-fix"><h${level}>${text}</h${level}></a>\n`;
    };

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
    let html = marked(data.article_content)


    return (
        <>
            <Head>
                <title>博客详细页</title>
            </Head>
            <Header/>
            <Row  className="comm_main" type="flex" justify="center">
                <Col className="comm_left" xs={24} sm={24} md={16} lg={18} xl={14} >
                    <div>
                        <div className="bread_div">
                            <Breadcrumb>
                                <Breadcrumb.Item><a href="/">首页</a></Breadcrumb.Item>
                                <Breadcrumb.Item>视频列表</Breadcrumb.Item>
                                <Breadcrumb.Item>xxxx</Breadcrumb.Item>
                            </Breadcrumb>
                        </div>

                        <div>
                            <div className="detailed_title">
                                React实战中...
                            </div>
                            <div className="list_icon center">
                                <span><CalendarFilled /> 2019-06-28</span>
                                <span><FolderAddFilled /> 视频教程</span>
                                <span><FireFilled /> 5498人</span>
                            </div>
                            <div className="detailed_content"
                              dangerouslySetInnerHTML={{__html:html}}
                            >
                            </div>

                        </div>
                    </div>
                </Col>
                <Col className="comm_box" xs={0} sm={0} md={7} lg={5} xl={4}>
                    <Author/>
                    <Affix offsetTop={5}>
                    <div className="detailed_nav comm_box">
                        <div className="nav_title">文章目录</div>
                        <div className="toc-list">
                            {tocify && tocify.render()}
                        </div>
                    </div>
                    </Affix>
                </Col>
            </Row>
            <Footer/>
        </>

        )
}


export const getServerSideProps = async ({query:{id}})=>{
    let res = await fetch(`${servicePath.getArticleById}/${id}`)
    let data = res.json()
    return {
        props: data
    }
}
export default Detailed;
