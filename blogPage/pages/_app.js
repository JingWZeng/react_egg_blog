// 放全局的css
import 'antd/dist/antd.css'
import '../static/style/pages/global.css'
import '../static/style/pages/detailed.css'
import '../static/style/pages/index.css'

function MyApp({ Component, pageProps }) {
  return <Component {...pageProps} />
}

export default MyApp
