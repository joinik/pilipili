import { http } from '@kit.NetworkKit';

class Header {
  public contentType: string;

  constructor(contentType: string) {
    this.contentType = contentType;
  }
}

let httpRequest = http.createHttp();


class Axios{
  private baseurl:string = "www.baidu.com"
  private timeout:number = 20000

  public get<T>(url:string, params?:object){
    return httpRequest.request(this.baseurl+url, {
      method:http.RequestMethod.GET,
      connectTimeout:this.timeout,
    })
  }
  public post<T>(url:string, data?:object){
    return httpRequest.request(this.baseurl+url, {
      method:http.RequestMethod.POST,
      connectTimeout:this.timeout,
      header: new Header('application/json'),
      extraData:data,
    })
  }
  public put<T>(url:string, data?:object){
    return httpRequest.request(this.baseurl+url, {
      method:http.RequestMethod.GET,
      connectTimeout:this.timeout,
      extraData:data,
    })
  }
  public delete<T>(url:string, params?:object){
    return httpRequest.request(this.baseurl+url, {
      method:http.RequestMethod.GET,
      connectTimeout:this.timeout,
    })
  }
}

export const axios = new Axios();