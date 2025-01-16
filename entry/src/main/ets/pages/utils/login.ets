import { CryptoJS } from '@ohos/crypto-js'
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { buffer, util } from '@kit.ArkTS';

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
export async function encryptRSA(pubKeyStr: string,message: string) {
  // 服务器下发RSA公钥字符串（base64编码）
  // let pubKeyStr = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDFQArGDm5BXM4jHHuZGIb/kUoqrSjXkjqPLgrDmqBFxNyYsyxvyFRO10nStQwdRkQkh5lZ5sqC1G/z6lyDPpEySTBo9S5GLZ2Tj4yinNjcMXmOwiHfyQAQo9LwdlyTedwRchg0fYewWBVTVhGcWPowT1aA+GnQhYwNmaS/iKQsNQIDAQAB";

  let KeyStr = cleanKey(pubKeyStr);

  // 初始化Base64工具实例
  let base64Helper = new util.Base64Helper();
  // 公钥转换为Uint8Array，然后包装为DataBlob类型
  let pubKeyBlob: cryptoFramework.DataBlob = { data: base64Helper.decodeSync(KeyStr)};
  // 创建RSA key生成器
  let rsaGenerator = cryptoFramework.createAsyKeyGenerator('RSA1024');
  // 将公钥包装数据pubKeyBlob转换成密钥对类型KeyPair
  let keyPair: cryptoFramework.KeyPair = await rsaGenerator.convertKey(pubKeyBlob, null)

  // 创建 Cipher对象
  let cipher = cryptoFramework.createCipher('RSA1024|PKCS1');
  // // 初始化加密模式，指定密钥keyPair.pubKey
  await cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, keyPair.pubKey, null);
  // // 包装要加密的明文
  let plainTextBlob: cryptoFramework.DataBlob = { data: new Uint8Array(buffer.from(message, 'utf-8').buffer) };
  // // 传入明文，获取加密后的数据
  let encryptBlob = await cipher.doFinal(plainTextBlob);
  console.log("进入encryptRsa", encryptBlob.data.length)
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



  static buvid(){
    let mac:Array<String> = [];
      try {
        for (let i = 0; i < 6; i++) {
          let min = 0;
          let max = 0xff;
          let num =  Math.random() * 100 + min;
          mac.push(num.toString(16).padStart(2, '0')); // 确保每个部分是两位数
        }

        let macString = mac.join(':');

        let md5Arr:Array<string> = [];
        let md5Str:string = CryptoJS.MD5(macString).toString()
        console.info("calculate file hash succeed:" + md5Str);
        md5Arr = md5Str.split('');

        return `XY${md5Arr[2]}${md5Arr[12]}${md5Arr[22]}${md5Str}`;
      } catch (e) {
        console.error('Error occurred: ', e);
        return '';
      }
  }

  static getUUID4(){
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
}

export default LoginUtils;