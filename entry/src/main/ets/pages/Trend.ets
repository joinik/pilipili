@ComponentV2
export default struct Trend {
  @Local message: string = '动态';

  build() {
    NavDestination() {
      Text(this.message)
        .id('TrendHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}