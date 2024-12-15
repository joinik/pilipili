import { JSON } from '@kit.ArkTS';
import { HttpString } from '../common/constants';
import { http } from '@kit.NetworkKit';

interface RequestHeader {
  'Content-Type': string;
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


const httpClient = http.createHttp();

export default class HttpClient {
  // 请求拦截器
  private requestInterceptor() {
  }

  // 响应拦截器
  private responseInterceptor(resp: Promise<http.HttpResponse>) {

    return resp.then((value: http.HttpResponse) => {
      if (Number(value.responseCode) == 200) {
        return value;
      } else {
        console.error('codeError', JSON.stringify(value))
        return value;
      }
    }).catch((err: Error) => {
      console.error('httpError', JSON.stringify(err))
      throw err;
    });
  }


  get(url: string, params: object): Promise<void | http.HttpResponse> {
    this.requestInterceptor();
    let fullUrl = `${HttpString.apiBaseUrl}${url}`
    console.log("requestUrl", fullUrl)
    const resp = httpClient.request(fullUrl, {
      method: http.RequestMethod.GET,
      header: new Header('application/json').toRequestHeader(),
      extraData: params,
      // expectDataType: http.HttpDataType.OBJECT,
    });
    return this.responseInterceptor(resp);
  }

  post(url: string, data: object): Promise<http.HttpResponse> {
    return httpClient.request(url, {
      method: http.RequestMethod.POST,
      readTimeout: 2000,
      header: new Header('application/json').toRequestHeader(),
      extraData: data,
    });
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