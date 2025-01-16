/**
 * 将秒数转换为 HMS 格式
 */
export const videoHMS = (numStr: string): string => {
  // 将字符串分割成整数部分和小数部分
  let parts = numStr.split('.');

  // 确保整数部分至少有两位，不足两位时补0
  let integerPart = parts[0].padStart(2, '0');

  // 如果没有小数部分，设置为 "00"
  let decimalPart = parts[1] ? parts[1] : "00";

  // 将两部分用冒号连接起来
  let result = integerPart + ':' + decimalPart;
  return result
}

/**
 * 将时间戳转换为 HMS 格式
 */
export const timestampTranslate = (ts: number): string => {
  const date = new Date(ts * 1000)
  const month = date.getMonth() + 1
  const day = date.getDate()
  const hours = date.getHours()
  const minutes = date.getMinutes()
  const formattedDate = `${month.toString().padStart(2, '0')}月${day.toString().padStart(2, '0')}日 ${hours.toString()
    .padStart(2, '0')}:${minutes.toString().padStart(2, '0')}`;
  return formattedDate
}

export const viewTranslate = (num: number): string => {
  if (num < 10000) {
    return num.toString()
  } else if (num < 100000000) {
    return (num / 10000).toFixed(1) + '万'
  } else {
    return (num / 100000000).toFixed(1) + '亿'
  }
}
