import Api from "../common/Api";
import HttpClient, { httpC } from "../utils/Http";
import LoginUtils, { encryptRSA } from "../utils/login";
import { VideoResponse } from "./Home";
import { cryptoFramework } from "@kit.CryptoArchitectureKit";


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


export class LoginHttp {
  // 极验申请
  static async queryCaptcha(): Promise<VideoResponse<geeTest>> {
    const res =
      (await httpC.get(Api.getCaptcha, null, '', false)).result as VideoResponse<geeTest>;
    if (res.code == 0) {
      return {
        code: 0,
        data: res.data,
        message: 'success'
      }
    } else {
      return {
        code: 1,
        message: 'fail'
      }
    }
  }

  static async sendSmsCode(params: SmsCodeParam) {
    const fromData: Record<string, string | number |undefined> = {
      'cid': params.cid,
      'tel': params.tel,
      'token': params.token,
      'challenge': params.challenge,
      'validate': params.validate,
      'seccode': params.seccode
    }
    const res =
      (await httpC.post(Api.appSmsCode, fromData, '', false)).result
    console.log('sendSmsCode', JSON.stringify(res))

  }

  static async sendwebSmsCode(params: SmsCodeParam) {
    const fromData: Record<string, string | number | undefined> = {
      'cid': params?.cid,
      'tel': params.tel,
      'source': 'main_web',
      'token': params.token,
      'challenge': params.challenge,
      'validate': params.validate,
      'seccode': params.seccode
    }
    const res =
      (await httpC.post(Api.webSmsCode, fromData, '', false)).result
    console.log('login', JSON.stringify(res))
  }

  // 获取盐hash跟PubKey
  static async getWebKey(): Promise<VideoResponse<hashObj>> {
    const data: Record<string, string | number> = { 'disable_rcmd': 0, 'local_id': LoginUtils.generateBuvid() };
    let res = (await httpC.get(Api.getWebKey, data, '', false)).result as VideoResponse<hashObj>;
    if (res.code == 0) {
      return res
    } else {
      return { code: 1, message: res.message, data: res.data };
    }
  }


  // app端密码登录
  static async loginInByMobPwd(params: loginByModPwdParam) {
    // 获取密钥
    let webKey:VideoResponse<hashObj> = await LoginHttp.getWebKey()
    if (webKey.code != 0) {
      return webKey;
    }

    const rhash = webKey?.data?.hash
    const key = webKey?.data?.key

    // 加密消息
    let pwd = await encryptRSA(key as string, (rhash as string) +params.password)

    // 准备请求数据
    const data: Record<string, string | number> = {
      'username': params.tel,
      'password': pwd,
      'local_id': LoginUtils.generateBuvid(),
      'disable_rcmd': '0',
    }
    let res = await httpC.post(
      Api.loginInByPwdApi,
      data,
    );
    console.log(JSON.stringify('app端加密登录：'+res));
    return res;




  }
}



























