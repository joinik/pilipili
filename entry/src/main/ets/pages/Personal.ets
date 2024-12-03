@Component
export default struct Personal {
  build() {
    Row(){
      Text($r('app.string.personal')).fontSize(45)
    }
  }
}