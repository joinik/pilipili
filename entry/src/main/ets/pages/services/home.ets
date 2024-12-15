import type { RecVideoItemModel } from '../../models/RecVideoItem';
import Api from '../common/api'
import { httpC } from '../utils/http';
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

interface RcmdVideoResponse {
  code: number,
  message: string,
  ttl: number,
  data: GeneratedTypeLiteralInterface_1;
}


export default class VideoHttp {
  // 首页推荐视频
  static async getRcmdVideoList(ps: number, freshIdx: number = 1): Promise<RecVideoItemModel[]> {
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
      let resp = await httpC.get(Api.recommendListWeb, params)
      if (resp) {
        let resultStr = `${resp.result}`;
        let result: RcmdVideoResponse = JSON.parse(resultStr);
        // 过滤掉live与ad，以及拉黑用户
        return result.data.item.filter(item => item.goto === 'av' && item.owner !== null);
      } else {
        throw new Error('Unexpected response type');
      }
    }catch (e){
      console.error("首页推荐，解析失败", e)
      return []
    }

  }
}