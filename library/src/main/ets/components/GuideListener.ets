export interface GuideListener {
  /**
   * 显示状态
   * @param isShow 是否显示
   */
  onState: (isShow: boolean) => void;
}