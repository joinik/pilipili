import { JSON } from '@kit.ArkTS'
import { LiveItemModel, WatchedShowOb } from '../../models/LiveItem'
import Api from '../common/Api'
import { httpC } from '../utils/Http'
import { VideoResponse } from './Home'
import type { http } from '@kit.NetworkKit'

interface DataLiveList {
  list: LiveItemModel[]
  has_more: boolean
}

export class LiveHttp {
  static async getList(pn: number = 1, ps: number = 30): Promise<VideoResponse<DataLiveList>> {
    try {

      const param: Record<string, number | string> = {
        'page': pn,
        'page_size': ps,
        'platform': 'web'
      }
      const resp: http.HttpResponse = await httpC.get(Api.liveList, param, '', false)
      let result:VideoResponse<DataLiveList> = {
        code: 1,
        message: '获取直播列表失败',
      }
      if (typeof resp.result === 'string'){
        result = JSON.parse(resp.result) as VideoResponse<DataLiveList>
      } else {
        result = resp.result as VideoResponse<DataLiveList>
      }
      return result
    } catch (e) {
      console.error('获取直播列表失败', e)
      return e
    }
  }
}