interface GeneratedObjectLiteralInterface_1 {
  // 27eb53fc9058f8c3  移动端 Android
  // 4409e2ce8ffd12b8  TV端
  StringAppKey: string;

  // 59b43e04ad6965f34319062b478f83dd TV端
  StringAppSec: string;
  StringThirdSign: string;
  StringThirdApi: string;
}

const AppKey: GeneratedObjectLiteralInterface_1 = {
  // 27eb53fc9058f8c3  移动端 Android
  // 4409e2ce8ffd12b8  TV端
  StringAppKey: '4409e2ce8ffd12b8',
  // 59b43e04ad6965f34319062b478f83dd TV端
  StringAppSec: '59b43e04ad6965f34319062b478f83dd',
  StringThirdSign: '04224646d1fea004e79606d3b038c84a',
  StringThirdApi:
  'https://www.mcbbs.net/template/mcbbs/image/special_photo_bg.png',


}

export class HttpString {
  static readonly baseUrl: string = 'https://www.bilibili.com';
  static readonly apiBaseUrl: string = 'https://api.bilibili.com';
  static readonly tUrl: string = 'https://api.vc.bilibili.com';
  static readonly appBaseUrl: string = 'https://app.bilibili.com';
  static readonly liveBaseUrl: string = 'https://api.live.bilibili.com';
  static readonly passBaseUrl: string = 'https://passport.bilibili.com';
  static readonly validateStatusCodes: number[] = [
    302,
    304,
    307,
    400,
    401,
    403,
    404,
    405,
    409,
    412,
    500,
    503,
    504,
    509,
    616,
    617,
    625,
    626,
    628,
    629,
    632,
    643,
    650,
    652,
    658,
    662,
    688,
    689,
    701,
    799,
    8888
  ];
}
export default AppKey