import { JSON } from '@kit.ArkTS';
import { HttpString } from '../common/Constants';
import { http } from '@kit.NetworkKit';
interface RequestHeader {
  'Content-Type': string;
}

interface RequestParam {
  url: string
  method?: http.RequestMethod
  extraData?: object
}

class Header {
  public contentType: string;
  constructor(contentType: string) {
    this.contentType = contentType;
  }

  // 添加一个方法将 Header 对象转换为网络请求所需的格式
  toRequestHeader(): RequestHeader {
    return { 'Content-Type': this.contentType };
  }
}


export default class HttpClient {

  // 请求拦截器
  private requestInterceptor(params: RequestParam) {
    const httpClient = http.createHttp();
    const resp = httpClient.request(params.url, {
      // 默认为 GET
      method: params.method ?? http.RequestMethod.GET,
      // 默认返回类型为 object 类型
      expectDataType: http.HttpDataType.OBJECT,
      extraData: params.extraData ?? null
    });
    return [httpClient, resp]
  }

  // 响应拦截器
  private responseInterceptor(request:http.HttpRequest, resp: Promise<http.HttpResponse>) {

    return resp.then((value: http.HttpResponse) => {
      if (Number(value.responseCode) == 200) {
        // 终止请求
        request.destroy()
        return value;
      } else {
        console.error('codeError', JSON.stringify(value))
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


  get(url: string, params?: object): Promise<http.HttpResponse> {
    let queryString = ''
    if (params !== undefined) {
      queryString = Object.keys(params)
        .map(key => `${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`)
        .join('&');
    }

    const fullUrl = queryString ? `${HttpString.apiBaseUrl}${url}?${queryString}`: `${HttpString.apiBaseUrl}${url}`

    console.log("fullUrl",fullUrl)
    const rest = this.requestInterceptor({ url: fullUrl });
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