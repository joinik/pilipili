export class ModelUserInfo {
  isLogin: boolean
  email_verified: number = 0
  face: string = ''
  level_info: Object
  mid: number = 0
  mobile_verified: number = 0
  money: number = 0 //硬笔数
  moral: number = 0 //节操值
  official: Object
  officialVerify: Object
  pendant: Object
  scores: number = 0
  uname: string = ''
  vipDueDate: number = 0
  vipStatus: number = 0
  vipType: number = 0
  vip_pay_type: number = 0
  vip_theme_type: number = 0
  vip_lable: Object
  vip_avatar_subscript: number = 0
  vip_nickname_color: string = ''
  wallet: Object
  has_shop: boolean
  shop_url: string = ''
  allowance_count: number = 0
  answer_status: number = 0
  is_senior_member: number = 0
  wbi_img: Object
  is_jury: boolean

  constructor(
    isLogin: boolean ,
    email_verified: number = 0,
    face: string = '',
    level_info: Object ,
    mid: number = 0,
    mobile_verified: number = 0,
    money: number = 0,
    moral: number = 0,
    official: Object ,
    officialVerify: Object ,
    pendant: Object ,
    scores: number = 0,
    uname: string = '',
    vipDueDate: number = 0,
    vipStatus: number = 0,
    vipType: number = 0,
    vip_pay_type: number = 0,
    vip_theme_type: number = 0,
    vip_lable: Object ,
    vip_avatar_subscript: number = 0,
    vip_nickname_color: string = '',
    wallet: Object ,
    has_shop: boolean ,
    shop_url: string = '',
    allowance_count: number = 0,
    answer_status: number = 0,
    is_senior_member: number = 0,
    wbi_img: Object ,
    is_jury: boolean
  ) {
    this.isLogin = isLogin
    this.email_verified = email_verified
    this.face = face
    this.level_info = level_info
    this.mid = mid
    this.mobile_verified = mobile_verified
    this.money = money
    this.moral = moral
    this.official = official
    this.officialVerify = officialVerify
    this.pendant = pendant
    this.scores = scores
    this.uname = uname
    this.vipDueDate = vipDueDate
    this.vipStatus = vipStatus
    this.vipType = vipType
    this.vip_pay_type = vip_pay_type
    this.vip_theme_type = vip_theme_type
    this.vip_lable = vip_lable
    this.vip_avatar_subscript = vip_avatar_subscript
    this.vip_nickname_color = vip_nickname_color
    this.wallet = wallet
    this.has_shop = has_shop
    this.shop_url = shop_url
    this.allowance_count = allowance_count
    this.answer_status = answer_status
    this.is_senior_member = is_senior_member
    this.wbi_img = wbi_img
    this.is_jury = is_jury
  }


}