import { BangumiListDataModel,BangumiItemModel } from "../../models/bangumi/BangumiList";
import Api from "../common/Api";
import { httpC } from "../utils/Http";
import { JSON } from "@kit.ArkTS";


interface GeneratedObjectLiteralInterface_1 {
  "st": number;
  "order": number;
  "season_version": number;
  "spoken_language_type": number;
  "area": number;
  "is_finish": number;
  "copyright": number;
  "season_status": number;
  "season_month": number;
  "year": number;
  "style_id": number;
  "sort": number;
  "season_type": number;
  "pagesize": number;
  "type": number;
  "page": number;
}
interface BangunmiResponse {
  code:number
  data?: BangumiListDataModel
  message:string
}
export class BangumiHttp {
  static async getList(seasonVersion:number= -1, spokenLanguageType:number = -1, page:number =1):Promise<BangunmiResponse>{
    const params: GeneratedObjectLiteralInterface_1 = {
      "st": 1,
      "order": 3,
      "season_version": seasonVersion,  // 全部 -1 正片1 电影2 其他3
      "spoken_language_type": spokenLanguageType, // 全部 -1 原生1 中文配音2
      "area": -1,
      "is_finish": -1,
      "copyright": -1,
      "season_status": -1,
      "season_month": -1,
      "year": -1,
      "style_id": -1,
      "sort": 0,
      "season_type":1,
      "pagesize": 20,
      "type": 1,
      "page":page
    }
    try {
      const resp = await httpC.get({url:Api.bangumiList, extraData:params, headerUa:null})
      const result = resp.result as BangunmiResponse
      return result
    } catch (e) {
      console.error("番剧getList，解析失败", e)
      return e
    }


  }
}