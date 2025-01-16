import loginTest from './login.test'
import MyTabContentTest from './MyTabContent.test'
import localUnitTest from './LocalUnit.test';

export default function testsuite() {
  localUnitTest();
  MyTabContentTest()
  loginTest()
}