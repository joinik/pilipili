import type { RcmdVideoItemModel } from '../../models/RecVideoItem';
import Api from '../common/Api'
import { httpC } from '../utils/Http';
import { http } from '@kit.NetworkKit';
import { HotVideoItem } from '../../models/HotVideoItem';
import json from '@ohos.util.json';

interface DataRcmdVideoList {
  item: Array<RcmdVideoItemModel>;
}

interface DataHotVideoList {
  list: Array<HotVideoItem>
}

interface VideoResponse<T> {
  code: number,
  message: string,
  ttl?: number,
  data?: T;
}

export {
  VideoResponse, DataRcmdVideoList, DataHotVideoList
}

export default class VideoHttp {
  // 最热视频
  static async getHotVideoList(pn: number, ps: number): Promise<VideoResponse<DataHotVideoList>> {
    try {
      const params: Record<string, number> = {
        'pn': pn, 'ps': ps
      }
      const resp: http.HttpResponse = await httpC.get(Api.hotList, params,
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1823.58')
      const result = resp.result as VideoResponse<DataHotVideoList>
      if (result.code === 0 && (result.data as DataHotVideoList).list) {
        let ownSet = new Set<number>();
        (result.data as DataHotVideoList).list = (result.data as DataHotVideoList).list.filter(cur => {
          if (typeof cur.owner?.mid === 'number' && !ownSet.has(cur.owner.mid)) {
            ownSet.add(cur.owner.mid);
            return true;
          }
          return false;
        })
      }
      return result
    } catch (e) {
      console.error("获取最热视频失败", e)
      return e
    }
  }

  // 首页推荐视频
  static async getRcmdVideoList(freshIdx: number = 1, ps: number = 20): Promise<VideoResponse<DataRcmdVideoList>> {
    const params: Record<string, string | number> = {
      'version': 1,
      'feed_version': 'V8',
      'homepage_ver': 1,
      'ps': ps,
      'fresh_idx': freshIdx,
      'brush': freshIdx,
      'fresh_type': 4
    };

    try {
      let resp: http.HttpResponse = await httpC.get(Api.recommendListWeb, params)
      let result = resp.result as VideoResponse<DataRcmdVideoList>
      if (result.code === 0 && (result.data as DataRcmdVideoList).item) {
        // 过滤掉live与ad，以及拉黑用户
        (result.data as DataRcmdVideoList).item =
          (result.data as DataRcmdVideoList).item.filter(item => item.goto === 'av' && item.owner !== null);
      }
      return result
    } catch (e) {
      console.error("首页推荐，解析失败", e)
      return e
    }

  }
}