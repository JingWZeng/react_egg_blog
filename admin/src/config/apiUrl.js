const ipUrl = 'http://127.0.0.1:7001/admin/'

const servicePath = {
    checkLogin: ipUrl + 'checkLogin',
    getTypeInfo: ipUrl + 'getTypeInfo',
    addArticle: ipUrl + 'addArticle',
    updateArticle: ipUrl + 'updateArticle',
    getArticleList: ipUrl + 'getArticleList',
    delArticle: ipUrl + 'delArticle',
    getArticleById:ipUrl + 'getArticleById/' ,  //  根据ID获得文章详情
}
export default servicePath