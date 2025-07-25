import { GuideParams } from "guide";

@ObservedV2
export class CustomGuideParams implements GuideParams{
  @Trace
  count:number=0;
}