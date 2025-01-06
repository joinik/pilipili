export interface BangumiItemModel {
  badge: string
  badge_type: number
  cover: string
  index_show: string
  is_finish:number

  link: string
  media_id: number
  order: string
  order_type: string
  score: string
  season_id: number
  season_status: number
  season_type: number
  subTitle: string
  title: string
  title_icon: string
}

export interface BangumiListDataModel {
  has_next: number
  list: BangumiItemModel[]
  num: number
  size: number
  total: number
}


