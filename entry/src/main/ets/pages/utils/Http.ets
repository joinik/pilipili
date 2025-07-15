import { JSON } from '@kit.ArkTS';
import { domainTag, HttpString } from '../common/Constants';
import { http } from '@kit.NetworkKit';
import LoginUtils from './login';
import { CookieManager } from './cookie';
import { hilog } from '@kit.PerformanceAnalysisKit';


export interface RequestParam {
  url: string;
  method?: http.RequestMethod;
  extraData: object | null;
  headerUa: Header | null;
}


// 生成UUID
function generateSimpleUUID() {

  const uuid = LoginUtils.getUUID4()
  // 生成随机数并格式化为五位数字，不足五位前面补0
  const randomNumber = String(Math.floor(Math.random() * 99999) + 1).padStart(5, '0');

  // 组合字符串
  return `${uuid}${randomNumber}infoc`;

}


export class Header {
  public contentType: string;
  public headerUa: string;
  public referer: string = "https://www.bilibili.com";
  public cookie: Record<string, string>

  constructor(headerUa: string, contentType: string = 'application/json',) {
    this.contentType = contentType;
    this.headerUa = headerUa;
    this.cookie = {
      'buvid3': generateSimpleUUID(),
    }
    console.log("header=====", JSON.stringify(this))
  }

  // 添加一个方法将 Header 对象转换为网络请求所需的格式
  toRequestHeader(): Record<string, string> {
    return {
      // 'Content-Type': this.contentType
      'user-agent': this.headerUa
    };

  }
}

type Headers = Record<string, string | number>

export default class HttpClient {
  // 请求拦截器
  private requestInterceptor(params: RequestParam) {
    const httpClient = http.createHttp();
    const header: Headers = params.headerUa ? new Header(params.headerUa.headerUa).toRequestHeader() : {
      'Content-Type': 'application/json'
    }
    // hilog.info(domainTag, 'requestInterceptor', JSON.stringify(params))
    const resp = httpClient.request(params.url, {
      // 默认为 GET
      method: params.method ?? http.RequestMethod.GET,
      // 默认返回类型为 object 类型
      expectDataType: http.HttpDataType.OBJECT,
      extraData: params.extraData,
      header: header,
    });
    return [httpClient, resp]
  }

  // 响应拦截器
  private responseInterceptor(request: http.HttpRequest, resp: Promise<http.HttpResponse>) {

    return resp.then((value: http.HttpResponse) => {
      if (Number(value.responseCode) == 200) {
        // 终止请求
        request.destroy()
        let cookieManager = CookieManager.getInstance()
        cookieManager.saveCookiesFromResponse(HttpString.baseUrl, value)
        return value;
      } else {
        console.error('responseInterError', JSON.stringify(value))
        // 终止请求
        request.destroy()
        return value;
      }
    }).catch((err: Error) => {
      console.error('httpError', JSON.stringify(err.message))
      // 终止请求
      request.destroy()
      throw err;
    });
  }

  /**
   * get请求
   * @param params:RequestParam
   * @param baseurl:boolean 是否使用baseurl
   * @returns Promise<http.HttpResponse>
   */
  get(params: RequestParam, baseurl: boolean = true): Promise<http.HttpResponse> {
    let queryString = ''
    if (params.extraData) {
      queryString = Object.entries(params.extraData)
        .map((entry: [string, string|number]) =>
        `${encodeURIComponent(entry[0])}=${encodeURIComponent(entry[1])}`
        )
        .join('&').trim();
    }
    let fullUrl: string = '';
    if (baseurl) {
      fullUrl = queryString ? `${HttpString.apiBaseUrl}${params.url}?${queryString}` : `${HttpString.apiBaseUrl}${params.url}`
    } else {
      fullUrl = queryString ? `${params.url}?${queryString}` : `${params.url}`
    }


    // hilog.info(domainTag, "fullUrl", JSON.stringify(fullUrl))
    const rest = this.requestInterceptor({
      url: fullUrl, headerUa: params.headerUa,extraData: null
    });
    const r1 = rest[0] as http.HttpRequest
    const r2 = rest[1] as Promise<http.HttpResponse>
    return this.responseInterceptor(r1, r2);
  }

  post(params: RequestParam, baseurl: boolean = true): Promise<http.HttpResponse> {
    const rest = this.requestInterceptor(params);
    const r1 = rest[0] as http.HttpRequest
    const r2 = rest[1] as Promise<http.HttpResponse>
    return this.responseInterceptor(r1, r2);
  }

  // put(url: string, data: object): Promise<http.HttpResponse> {
  //   return httpClient.request(url, {
  //     method: http.RequestMethod.PUT,
  //     readTimeout: 2000,
  //     header: new Header('application/json').toRequestHeader(),
  //     extraData: data,
  //   });
  //
  // }

  // delete(url: string, data: object): Promise<http.HttpResponse> {
  //   return httpClient.request(url, {
  //     method: http.RequestMethod.DELETE,
  //     readTimeout: 2000,
  //     header: new Header('application/json').toRequestHeader(),
  //     extraData: data,
  //   });
  // }
}

export const httpC = new HttpClient();