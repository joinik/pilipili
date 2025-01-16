import { JSON } from '@kit.ArkTS';
import { HttpString } from '../common/Constants';
import { http } from '@kit.NetworkKit';


interface RequestParam {
  url: string;
  method?: http.RequestMethod;
  extraData?: object;
  headerUa?: string;
}


// 生成UUID
function generateSimpleUUID() {
  const uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c) => {
    let r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
    return v.toString(16);
  });
  // 生成随机数并格式化为五位数字，不足五位前面补0
  const randomNumber = String(Math.floor(Math.random() * 99999) + 1).padStart(5, '0');

  // 组合字符串
  return `${uuid}${randomNumber}infoc`;

}


class Header {
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
    const header: Headers = params.headerUa ? new Header(params.headerUa).toRequestHeader() : {
      'Content-Type': 'application/json'
    }
    const resp = httpClient.request(params.url, {
      // 默认为 GET
      method: params.method ?? http.RequestMethod.GET,
      // 默认返回类型为 object 类型
      expectDataType: http.HttpDataType.OBJECT,
      extraData: params.extraData ?? null,
      header: header
    });
    return [httpClient, resp]
  }

  // 响应拦截器
  private responseInterceptor(request: http.HttpRequest, resp: Promise<http.HttpResponse>) {

    return resp.then((value: http.HttpResponse) => {
      if (Number(value.responseCode) == 200) {
        // 终止请求
        request.destroy()
        return value;
      } else {
        console.error('responseInterError', JSON.stringify(value))
        // 终止请求
        request.destroy()
        return value;
      }
    }).catch((err: Error) => {
      console.error('httpError', JSON.stringify(err))
      // 终止请求
      request.destroy()
      throw err;
    });
  }


  get(url: string, params: object | null, headerUa: string = '', baseurl: boolean = true): Promise<http.HttpResponse> {
    let queryString = ''
    if (params) {
      queryString = Object.keys(params)
        .map(key => `${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`)
        .join('&');
    }
    let fullUrl: string = '';
    if (baseurl) {
      fullUrl = queryString ? `${HttpString.apiBaseUrl}${url}?${queryString}` : `${HttpString.apiBaseUrl}${url}`
    } else {
      fullUrl = queryString ? `${url}?${queryString}` : `${url}`
    }


    console.log("fullUrl", fullUrl)
    const rest = this.requestInterceptor({
      url: fullUrl, headerUa: headerUa
    });
    const r1 = rest[0] as http.HttpRequest
    const r2 = rest[1] as Promise<http.HttpResponse>
    return this.responseInterceptor(r1, r2);
  }

  // post(url: string, data: object): Promise<http.HttpResponse> {
  //   return httpClient.request(url, {
  //     method: http.RequestMethod.POST,
  //     readTimeout: 2000,
  //     header: new Header('application/json').toRequestHeader(),
  //     extraData: data,
  //   });
  // }

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