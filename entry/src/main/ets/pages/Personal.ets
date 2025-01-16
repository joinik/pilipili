@ComponentV2
export default struct Personal {
  build() {
    NavDestination() {
      Row() {
        Text($r('app.string.personal')).fontSize(45)
      }
    }
  }
}