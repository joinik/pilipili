import Api from "../common/Api";
import { Header, httpC } from "../utils/Http";
import LoginUtils, { encryptRSA } from "../utils/login";
import { VideoResponse } from "./Home";
import { domainTag, HttpString } from "../common/Constants";
import { hilog } from "@kit.PerformanceAnalysisKit";
import { url } from "@kit.ArkTS";


// 盐和pubkey类型
interface hashObj {
  hash: string
  key: string
}

interface geeTest {
  type: string
  token: string
  geetest: Record<string, string> | null
  tencent: Record<string, string>
}


interface ResponseQr{
  url:string;
  refresh_token:string;
  timestamp:number;
  code:number;
  message:string;
}

interface SmsCodeParam {
  tel: string
  token: string
  challenge: string
  validate: string
  seccode: string
  cid?: string
}

interface loginByModPwdParam {
  tel: string
  password: string
}

interface loginByWebPwdParam {
  go_url: string | null;
  keep: number | null;
  source: string | null
  username: number
  password: string
  token: string
  challenge: string
  validate: string
  seccode: string
}

interface ResponseQrCode {
  url:string;
  qrcode_key:string
}

export class LoginHttp {
  static timerId: number = 0
  // 获取盐hash跟PubKey
  static async getWebKey(): Promise<VideoResponse<hashObj>> {
    const data: Record<string, string | number> = { 'disable_rcmd': 0, 'local_id': LoginUtils.generateBuvid() };
    let res = (await httpC.get({url:Api.getWebKey, extraData:data, headerUa:null}, false)).result as VideoResponse<hashObj>;
    if (res.code == 0) {
      return res
    } else {
      return { code: 1, message: res.message, data: res.data };
    }
  }


  // todo app端密码登录
  static async loginInByMobPwd(params: loginByModPwdParam) {
    // 获取密钥
    let webKey: VideoResponse<hashObj> = await LoginHttp.getWebKey()
    if (webKey.code != 0) {
      return webKey;
    }

    const rhash = webKey?.data?.hash
    const key = webKey?.data?.key

    // 加密消息
    let pwd = await encryptRSA(key as string, (rhash as string) + params.password)

    // 准备请求数据
    const data: Record<string, string | number> = {
      'username': params.tel,
      'password': pwd,
      'local_id': LoginUtils.generateBuvid(),
      'disable_rcmd': '0',
    }
    let res = await httpC.post({
      url: Api.loginInByPwdApi,
      extraData: data,
      headerUa:null
    }
    );
    console.log("app端加密登录", JSON.stringify(res.result));
    return res;
  }


  // web端密码登录
  static async loginInByWebPwd(user:number, pwd: string) {
    //
    let params:loginByWebPwdParam = {
      username : user,
      password: pwd,
      source : 'main-fe-header',
      keep : 0,
      go_url : HttpString.baseUrl,
      token:'',
      challenge:'',
      validate:'',
      seccode:'',

    }


    // 拼接成formData数据格式 xxx=xxx&xxx=xxx&xxx=xxx
    let formData = new url.URLParams(JSON.stringify(params))


  }
  // web端登录二维码
  static async loginByQr(): Promise<VideoResponse<ResponseQrCode>> {
    let res = (await httpC.get({url:Api.qrCodeApi, extraData:null, headerUa:null}, false)).result as VideoResponse<ResponseQrCode>
    hilog.info(0xff00, 'loginByQr', 'res:' + JSON.stringify(res))
    if (res.code == 0){
      let seconds:number = 180
      LoginHttp.timerId = setInterval(async () => {
        if (seconds < 0) {
          LoginHttp.loginByQr()
          clearInterval(LoginHttp.timerId)
        }
        seconds -=1
        let result = await LoginHttp.queryWebQrcodeStatus((res?.data?.qrcode_key) as  string)
        if (result.data && result.data.code == 0) {
          // LoginHttp.getUserInfo()
          clearInterval(LoginHttp.timerId)
        }
      }, 1000)
      return res
    } else {
      let err = {
        code: -1,
        message: res.message
      } as VideoResponse<ResponseQrCode>
      return err
    }
  }

  // web端轮询获取二维码状态
  static async queryWebQrcodeStatus(qrcodeKey: string): Promise<VideoResponse<ResponseQr>> {
    let params:Record<string,string> = {
      "qrcode_key": qrcodeKey
    }


    let res = (await httpC.get({url:Api.loginInByQrcode, extraData:params, headerUa:null}, false)).result as VideoResponse<ResponseQr>
    hilog.info(0xff00, 'queryWebQrcodeStatus', 'res:' + JSON.stringify(res))
    if (res.code == 0){
      return res
    } else {
      hilog.error(domainTag, 'queryWebQrcodeStatus', 'res.message:' + res.message)
      return res
    }
  }
}



























