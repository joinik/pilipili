import http from '@ohos.net.http';
import fs from '@ohos.file.fs';
import preferences from '@ohos.data.preferences';
import utils from '@arkts.utils';
import { UtilsPili } from './utils';
import { url, util } from '@kit.ArkTS';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { domainTag } from '../common/Constants';
import { common, Context } from '@kit.AbilityKit';

// 定义Cookie类型（模拟HTTP Cookie结构）
interface Cookie {
  name: string;
  value: string;
  domain?: string;
  path?: string;
  expires?: Date;
}

// Cookie管理器类
export class CookieManager {
  private static instance: CookieManager; // 单例模式
  private cookieStore: Map<string, Cookie[]> = new Map(); // 内存中缓存Cookie（key: 域名）
  private cookiePath: string = ''; // Cookie存储路径

  // 单例初始化
  static getInstance(): CookieManager {
    if (!CookieManager.instance) {
      CookieManager.instance = new CookieManager();
    }
    return CookieManager.instance;
  }

  // 初始化Cookie管理器（类似Flutter的setCookie方法）
  async init() {
    // 1. 获取Cookie存储路径（鸿蒙应用沙盒路径）
    this.cookiePath = UtilsPili.getCookiePath(); // 自定义工具类获取路径
    await this.loadCookiesFromFile(); // 从本地文件加载Cookie

    // 2. 关联HTTP请求拦截器（鸿蒙需手动处理Cookie）
    this.setupHttpInterceptor();
  }

  // 从本地文件加载Cookie到内存
  private async loadCookiesFromFile() {

    try {
      // 检查文件是否存在
        let arrayBuffer = new ArrayBuffer(1024*1024);
        const file = await fs.open(this.cookiePath, fs.OpenMode.READ_ONLY);
        const readLen = await fs.read(file.fd, arrayBuffer, { length: 1024 * 1024 }); // 最大1MB
        await fs.close(file.fd);
      // 使用 TextDecoder 解析有效字节
      const uint8Array = new Uint8Array(arrayBuffer, 0, readLen);
      const cookieStr = util.TextDecoder.create('utf-8').decodeToString(uint8Array);

      this.cookieStore = new Map(JSON.parse(cookieStr));

    } catch (e) {
      console.error('Failed to load cookies from file:', e);
    }
  }

  // 将内存中的Cookie保存到本地文件
  private async saveCookiesToFile() {
    try {
      const cookieStr = JSON.stringify(Array.from(this.cookieStore.entries()));
      hilog.info(domainTag, 'saveCookiesToFile', cookieStr)
      const file = await fs.open(this.cookiePath, fs.OpenMode.WRITE_ONLY | fs.OpenMode.CREATE);
      const encoder = util.TextEncoder.create('utf-8');
      await fs.write(file.fd, encoder.encodeInto(cookieStr));
      await fs.close(file.fd);
    } catch (e) {
      console.error('Failed to save cookies to file:', e);
    }
  }

  // 设置HTTP请求拦截器（手动处理Cookie的添加和保存）
  private setupHttpInterceptor() {
    // 鸿蒙HTTP请求需手动在请求前添加Cookie，响应后保存Cookie
    // 这里以封装HTTP工具类为例
  }

  // // 向请求头添加Cookie
  getCookiesForUrl(urlStr: string): string {
    const uri = url.URL.parseURL(urlStr);
    const domain = uri.hostname;
    const cookies = this.cookieStore.get(domain) || [];
    return cookies.map(c => `${c.name}=${c.value}`).join('; ');
  }
  //
  // // 从响应头解析并保存Cookie
  saveCookiesFromResponse(urlStr:string = '', resp: http.HttpResponse) {
    const uri = url.URL.parseURL(urlStr);
    const domain = uri.hostname;


    // 获取Set-Cookie头
    let cookies:Array<Cookie|void> = Object.entries(resp.header).map((entry:[string,string[]])=>{
      if (entry[0] === 'set-cookie') {
        const cookies:string[] = entry[1];
        hilog.info(0xff00, 'saveCookiesFromResponse', JSON.stringify(cookies))
        // 遍历Cookie并保存
        cookies.map((cookieStr:string)=>{
          const parts = cookieStr.split(';').map(p => p.trim());

          const partArr:string[] = parts[0].split('='); //[name,value]
          return {name:partArr[0], value:partArr[1]} as Cookie;
        })
      }
    })
    hilog.info(0xff00, 'saveCookiesFromResponse', JSON.stringify(cookies))
    this.cookieStore.set(domain, cookies as Array<Cookie>);
    this.saveCookiesToFile(); // 保存到本地
  }
  //
  // 检查用户登录状态并同步Cookie（类似Flutter逻辑）
  async syncCookieWithUserState(globalContext:common.UIAbilityContext) {
    // 1. 获取本地存储的用户信息（使用preferences）
    const userPref = await preferences.getPreferences(globalContext, 'user_info');
    const userInfo = userPref.get('userInfoCache', null);

    if (userInfo && userInfo.mid) {
      // 2. 检查tUrl的Cookie是否存在
      const tUrl = HttpString.tUrl;
      const uri = new URL(tUrl);
      const tCookies = this.cookieStore.get(uri.hostname) || [];

      if (tCookies.length === 0) {
        // 3. 主动请求tUrl获取Cookie
        try {
          const request = http.createHttp();
          const response = await request.request(tUrl, { method: http.RequestMethod.GET });
          this.saveCookiesFromResponse(tUrl, response.header); // 保存响应中的Cookie
        } catch (e) {
          console.error(`syncCookie error: ${JSON.stringify(e)}`);
        }
      }
    }
  }
}

// 初始化调用（在应用启动时）
async function initCookieManager() {
  const cookieManager = CookieManager.getInstance();
  await cookieManager.init();
  // await cookieManager.syncCookieWithUserState();
}