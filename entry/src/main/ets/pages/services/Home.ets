import type { RecVideoItemModel } from '../../models/RecVideoItem';
import Api from '../common/Api'
import { httpC } from '../utils/Http';
import { http } from '@kit.NetworkKit';

interface GetRcmdVideoListParams {
  version: number;
  feed_version: string;
  homepage_ver: number;
  ps: number;
  fresh_idx: number;
  brush: number;
  fresh_type: number;
}

interface GeneratedTypeLiteralInterface_1 {
  item: Array<RecVideoItemModel>;
}

interface RecmdVideoResponse {
  code: number,
  message: string,
  ttl?: number,
  data?: GeneratedTypeLiteralInterface_1;
}


export default class VideoHttp {
  // 首页推荐视频
  static async getRcmdVideoList(freshIdx: number = 1, ps: number = 20):Promise<RecmdVideoResponse>{
    const params: GetRcmdVideoListParams = {
      version: 1,
      feed_version: 'V8',
      homepage_ver: 1,
      ps: ps,
      fresh_idx: freshIdx,
      brush: freshIdx,
      fresh_type: 4
    };

    try {
      let resp: http.HttpResponse = await httpC.get(Api.recommendListWeb, params)
      let result = resp.result as RecmdVideoResponse
      if (result.code === 0 && result.data?.item){
        // 过滤掉live与ad，以及拉黑用户
        result.data.item = result.data.item.filter(item => item.goto === 'av' && item.owner !== null);
        return result
      } else {
        return result
      }
    } catch (e) {
      console.error("首页推荐，解析失败", e)
      return e
    }

  }
}