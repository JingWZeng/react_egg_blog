import React, {useEffect, useState} from 'react';
import {marked} from 'marked'
import '../static/css/AddArticle.css'
import { Row, Col ,Input, Select ,Button ,DatePicker,message } from 'antd'
import axios from "axios";
import servicePath from "../config/apiUrl";

const { Option } = Select;
const { TextArea } = Input

const AddArticle = (props)=> {

    useEffect(()=>{
        getTypeInfo()
        //获得文章ID
        let tmpId = props.match.params.id
        if(tmpId){
            setArticleId(tmpId)
            getArticleById(tmpId)
        }
    },[])

    marked.setOptions({
        renderer: new marked.Renderer(),
        gfm: true,
        pedantic: false,
        sanitize: false,
        tables: true,
        breaks: false,
        smartLists: true,
        smartypants: false,
    });

    const [articleId,setArticleId] = useState(0)  // 文章的ID，如果是0说明是新增加，如果不是0，说明是修改
    const [articleTitle,setArticleTitle] = useState('')   //文章标题
    const [articleContent , setArticleContent] = useState('')  //markdown的编辑内容
    const [markdownContent, setMarkdownContent] = useState('预览内容') //html内容
    const [introducemd,setIntroducemd] = useState()            //简介的markdown内容
    const [introducehtml,setIntroducehtml] = useState('等待编辑') //简介的html内容
    const [showDate,setShowDate] = useState()   //发布日期
    const [updateDate,setUpdateDate] = useState() //修改日志的日期
    const [typeInfo ,setTypeInfo] = useState([]) // 文章类别信息
    const [selectedType,setSelectType] = useState('请选择类型') //选择的文章类别

    const changeContent = ({target:{value}}) =>{
        setArticleContent(value)
        let html = marked(value)
        setMarkdownContent(html)
    }

    const changeIntroduce = ({target:{value}})=>{
        setIntroducemd(value)
        let html=marked(value)
        setIntroducehtml(html)
    }


    //选择类别改变选择内容
    const selectTypeHandler =(value)=>{
        setSelectType(value)
    }

    const saveArticle = ()=>{
        if(!selectedType){
            message.error('必须选择文章类别')
            return false
        }else if(!articleTitle){
            message.error('文章名称不能为空')
            return false
        }else if(!articleContent){
            message.error('文章内容不能为空')
            return false
        }else if(!introducemd){
            message.error('简介不能为空')
            return false
        }else if(!showDate){
            message.error('发布日期不能为空')
            return false
        }
        let dataProps={}   //传递到接口的参数
        dataProps.type_id = selectedType
        dataProps.title = articleTitle
        dataProps.article_content =articleContent
        dataProps.introduce =introducemd
        dataProps.addTime = new Date(showDate).getTime()

        if(articleId===0){
            dataProps.view_count =Math.ceil(Math.random()*100)+1000
            axios({
                method:'post',
                url:servicePath.addArticle,
                data:dataProps,
                withCredentials:true,
                headers:{
                    'Access-Control-Allow-Origin':'*',
                    'Authorization':`${localStorage.getItem('token')}`
                },
            }).then(res=>{
                setArticleId(res.data.insertId)
                if(res.data.isScuccess){
                    message.success('文章保存成功')
                }else{
                    message.error("文章保存失败")
                }
            })

        }
        else {
            dataProps.id = articleId
            axios({
                method:'post',
                url:servicePath.updateArticle,
                data:dataProps,
                withCredentials:true,
                headers:{
                    'Access-Control-Allow-Origin':'*',
                    'Authorization':`${localStorage.getItem('token')}`
                },
            }).then(res=>{
                setArticleId(res.data.insertId)
                if(res.data.isScuccess){
                    message.success('文章保存成功')
                }else{
                    message.error("文章保存失败")
                }
            })
        }

    }

    // 从中台得到文章的类别信息
    const getTypeInfo = ()=>{
        axios({
            method: "get",
            url: servicePath.getTypeInfo,
            headers:{
                'Access-Control-Allow-Origin':'*',
                'Authorization':`${localStorage.getItem('token')}`
            },
            withCredentials:true
        }).then(res=>{
            if (res.data.data === '没有登录'){
                localStorage.removeItem('openId')
                props.history.push('/')
            }else{
                setTypeInfo(res.data.data)
            }
        })
    }
    const getArticleById = (id)=>{
        axios(servicePath.getArticleById+id,{
            withCredentials: true,
            headers:{
                'Access-Control-Allow-Origin':'*',
                'Authorization':`${localStorage.getItem('token')}`
            }
        }).then(
            res=>{
                setArticleTitle(res.data.data[0].title)
                setArticleContent(res.data.data[0].article_content)
                let html=marked(res.data.data[0].article_content)
                setMarkdownContent(html)
                setIntroducemd(res.data.data[0].introduce)
                let tmpInt = marked(res.data.data[0].introduce)
                setIntroducehtml(tmpInt)
                setShowDate(res.data.data[0].addTime)
                setSelectType(res.data.data[0].typeId)

            }
        )
    }

    return (
        <div>
            <Row gutter={5}>
                <Col span={18}>
                    <Row gutter={10}>
                        <Col span={20}>
                            <Input
                                value={articleTitle}
                                placeholder="博客标题"
                                size="large"
                                onChange={e=>{
                                    setArticleTitle(e.target.value);
                                }}
                            >
                            </Input>
                        </Col>
                            <Col span={4}>
                                &nbsp;
                                <Select size="large"  defaultValue={selectedType} value={selectedType} onChange={selectTypeHandler}>
                                    {
                                        typeInfo.map((item,idnex)=>{
                                            return( <Option value={item.id} key={idnex}>{item.typeName}</Option>)
                                        })
                                    }
                                </Select>
                            </Col>
                    </Row>
                    <br />
                    <Row span={10}>
                        <Col span={12}>
                                <TextArea
                                    className="markdown-content"
                                    rows={35}
                                    onChange={changeContent}
                                    onPressEnter={changeContent}
                                    placeholder="文章内容"
                                    value={articleContent}
                                />
                        </Col>
                        <Col span={12}>
                            <div
                                className="show-html"
                                dangerouslySetInnerHTML={{__html:markdownContent}}
                            >
                            </div>
                        </Col>
                    </Row>
                </Col>
                <Col span={6}>
                    <Row>
                        <Col span={24}>
                            <Button size="large" type="primary" ghost>暂存文章</Button>&nbsp;
                            <Button size="large"
                                    danger
                                    onClick={saveArticle}
                            >发布文章</Button>
                            <br/>
                        </Col>
                        <Col span={24}>
                            <br/>
                            <TextArea
                                rows={4}
                                placeholder="文章简介"
                                onChange={changeIntroduce}
                                onPressEnter={changeIntroduce}
                                value={introducemd}
                            />
                            <br/><br/>
                            <div  className="introduce-html" dangerouslySetInnerHTML={{__html: '文章简介:' + introducehtml}}/>
                        </Col>

                        <Col span={12}>
                            <div className="date-select">
                                <DatePicker
                                    onChange={(date,dateString)=>setShowDate(dateString)}
                                    placeholder="发布日期"
                                    size="large"
                                />
                            </div>
                        </Col>
                    </Row>
                </Col>
            </Row>
        </div>
    );
}

export default AddArticle;
