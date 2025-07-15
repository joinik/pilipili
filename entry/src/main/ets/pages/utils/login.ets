import { CryptoJS } from '@ohos/crypto-js'
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { buffer, util } from '@kit.ArkTS';
import json from '@ohos.util.json';

/**
 * 清理公钥或私钥字符串
 * @param keyStr 原始的公钥或私钥字符串
 * @returns 清理后的公钥或私钥字符串
 */
function cleanKey(keyStr: string): string {
  return keyStr.replace(/-----BEGIN.*KEY-----|-----END.*KEY-----|\s/g, '');
}

// 字符串转成字节流
function stringToUint8Array(str: string) {
  return new Uint8Array(buffer.from(str, 'utf-8').buffer);
}

/**
 * 使用RSA非对称密钥（PKCS1模式）加密
 * @param message 要加密的明文数据
 * @returns 加密后的字符串，base64编码
 */
export async function encryptRSA(pubKeyStr: string, message: string) {

  let KeyStr = cleanKey(pubKeyStr);

  // 手动补全Base64填充
  let paddingNeeded = (4 - (KeyStr.length % 4)) % 4;
  KeyStr += '='.repeat(paddingNeeded);

  console.log("KeyStr", KeyStr.length)
  // 初始化Base64工具实例
  let base64Helper = new util.Base64Helper();
  // 公钥转换为Uint8Array，然后包装为DataBlob类型
  let pubKeyBlob: cryptoFramework.DataBlob = { data: base64Helper.decodeSync(KeyStr) };
  try {
    console.info('Decoded public key data:', base64Helper.decodeSync(KeyStr).byteLength);
  }catch (e) {
    console.error(`convertKey failed, ${e.code}, ${e.message}`); // 捕获并打印具体错误
  }
  // 创建RSA key生成器
  let rsaGenerator = cryptoFramework.createAsyKeyGenerator('RSA1024');
  // 将公钥包装数据pubKeyBlob转换成密钥对类型KeyPair
  let keyPair: cryptoFramework.KeyPair = await rsaGenerator.convertKey(pubKeyBlob, null)

  console.log('keyPair', JSON.stringify(keyPair))
  // 创建 Cipher对象
  let cipher = cryptoFramework.createCipher('RSA1024|PKCS1');
  // // 初始化加密模式，指定密钥keyPair.pubKey
  cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, keyPair.pubKey, null)
    .then((res) =>{
      console.log('cipher success')
    })
    .catch((error:Error)=>{
      console.log('cipher', json.stringify(error))
    })
  // // 包装要加密的明文
  let plainTextBlob: cryptoFramework.DataBlob = { data: new Uint8Array(buffer.from(message, 'utf-8').buffer) };
  // // 传入明文，获取加密后的数据
  let encryptBlob = await cipher.doFinal(plainTextBlob);
  console.log("进入encryptRsa", json.stringify(encryptBlob.data))
  // // 返回加密后的字符串
  return base64Helper.encodeToString(encryptBlob.data);
  // return buffer.from(encryptBlob.data).toString('base64')

}

class LoginUtils {
  static async encryptMessagePromise(publicKey: cryptoFramework.PubKey, plainText: cryptoFramework.DataBlob) {
    let cipher = cryptoFramework.createCipher('RSA1024|PKCS1');
    await cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, publicKey, null);
    let encryptData = await cipher.doFinal(plainText);
    return encryptData;
  }

  static buvid() {
    let mac: Array<String> = [];
    try {
      for (let i = 0; i < 6; i++) {
        let min = 0;
        let max = 0xff;
        let num = Math.random() * 100 + min;
        mac.push(num.toString(16).padStart(2, '0')); // 确保每个部分是两位数
      }

      let macString = mac.join(':');

      let md5Arr: Array<string> = [];
      let md5Str: string = CryptoJS.MD5(macString).toString()
      console.info("calculate file hash succeed:" + md5Str);
      md5Arr = md5Str.split('');

      return `XY${md5Arr[2]}${md5Arr[12]}${md5Arr[22]}${md5Str}`;
    } catch (e) {
      console.error('Error occurred: ', e);
      return '';
    }
  }

  static getUUID4() {
    const uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c) => {
      let r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
      return v.toString(16);
    });
    return uuid;
  }

  static generateBuvid() {
    const uuid = LoginUtils.getUUID4() + LoginUtils.getUUID4();
    return `XY${uuid.substring(0, 35).toUpperCase()}`;
  }

  static async comfirmLogin(url:string){
    // let content = '';
    // if (url !== ''){
    //   content = `${content + url}; \n`
    //
    // }
    // try {
    //   await SetCookie.onSet()
    //
    // } catch (e) {
    //   console.error('Error occurred: ', e);
    //   return false;
    // }


  }


}

export default LoginUtils;

/**
 * RSA 加密和解密工具
 */
export class RSAUtil {
  // 公钥
  PUBLIC_KEY: string = `-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4B+BF/N8tuPAHKmfb8Pz
0lkXqwWCDHCZ/mpxSxG+dgYxYwhiZQjX6XikxzB/mm5BuXRVIjk/O7RQeEG1IRO7
bGimWyBe1aAAQREoe8owFnlc066H4kWw+/cqBlQoSJJ1CsVC63yphisyaP/zv6RS
bzEoa1VaZSYoQVNSymQMXlZtJQaOf4VN81hyAqXnrjcpSiOsDdkSOHjjdPZLdiOo
fQ1uw77On7MQEtwPIHlovW7wVHUAFBdtVfy5UAGJXgo9oSxbQWz7Oxr+zeSS3MFl
pYouICE9+gpg/87GiPcaAn7hH7uxB1Vqvl0ZBVDTb7dA3pvV8SfLX0mG9iFaWp91
wQIDAQAB
-----END PUBLIC KEY-----
`


  /**
   * 清理公钥或私钥字符串
   * @param keyStr 原始的公钥或私钥字符串
   * @returns 清理后的公钥或私钥字符串
   */
  cleanKey(keyStr: string): string {
    return keyStr.replace(/-----BEGIN.*KEY-----|-----END.*KEY-----|\s/g, '');
  }

  /**
   * 使用RSA非对称密钥（PKCS1模式）加密
   * @param message 要加密的明文数据
   * @returns 加密后的字符串，base64编码
   */
  encryptRSA(message: string) {
    // 清理公钥字符串
    let pubKeyStr = this.cleanKey(this.PUBLIC_KEY);
    // 初始化Base64工具实例
    let base64Helper = new util.Base64Helper();
    // 公钥转换为Uint8Array，然后包装为DataBlob类型
    let pubKeyBlob: cryptoFramework.DataBlob = { data: base64Helper.decodeSync(pubKeyStr) };
    // 创建RSA key生成器
    let rsaGenerator = cryptoFramework.createAsyKeyGenerator('RSA1024');
    // 将公钥包装数据pubKeyBlob转换成密钥对类型KeyPair
    let keyPair = rsaGenerator.convertKeySync(pubKeyBlob, null);
    // 创建 Cipher对象
    let cipher = cryptoFramework.createCipher('RSA1024|PKCS1');
    // 初始化加密模式，指定密钥keyPair.pubKey
    cipher.initSync(cryptoFramework.CryptoMode.ENCRYPT_MODE, keyPair.pubKey, null);
    // 包装要加密的明文
    let plainTextBlob: cryptoFramework.DataBlob = { data: new Uint8Array(buffer.from(message, 'utf-8').buffer) };
    // 传入明文，获取加密后的数据
    let encryptBlob = cipher.doFinalSync(plainTextBlob);
    // 返回加密后的字符串
    return base64Helper.encodeToStringSync(encryptBlob.data);
  }
}


