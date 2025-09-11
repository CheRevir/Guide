/**
 * 引导状态观察对象
 */
@ObservedV2
export class GuideState {
  /**
   * 引导是否显示
   */
  @Trace
  isShow: boolean = false;
}