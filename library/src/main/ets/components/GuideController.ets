import { MaskRender } from './mask/MaskRender';
import { BuilderNode, FrameNode, NodeController, Size, UIContext } from '@kit.ArkUI';
import { GuideParams } from './GuideParams';
import { GuideState } from './GuideState';

/**
 * 引导控制器
 */
export class GuideController extends NodeController {
  /**
   * 根节点
   */
  private rootNode: FrameNode | null = null;
  /**
   * 引导自定义构建节点
   */
  private builderNode: BuilderNode<[GuideParams]> | null = null;
  /**
   * 引导自定义构建函数
   */
  private wrapBuilder: WrappedBuilder<[GuideParams]> | null = null;
  /**
   * 引导自定义构建函数参数
   */
  private params: GuideParams | undefined;
  /**
   * 引导蒙版
   */
  private mask: MaskRender | null = null;
  /**
   * 蒙版大小
   */
  private maskSize: Size | undefined = undefined;
  /**
   * 引导状态
   */
  state: GuideState = new GuideState();

  aboutToResize(size: Size): void {
    if (this.mask !== null) {
      this.mask.setSize(this.maskSize ?? size);
    }
  }

  makeNode(uiContext: UIContext): FrameNode | null {
    if (this.rootNode === null) {
      this.rootNode = new FrameNode(uiContext);
    } else {
      const render = this.rootNode.getRenderNode();
      render?.clearChildren();
      this.rootNode.clearChildren();
    }
    if (this.mask !== null) {
      const render = this.rootNode.getRenderNode();
      render?.appendChild(this.mask);
    }
    if (this.wrapBuilder !== null) {
      if (this.builderNode === null) {
        this.builderNode = new BuilderNode(uiContext);
      }
      this.builderNode.build(this.wrapBuilder, this.params);
      const frame = this.builderNode.getFrameNode();
      this.rootNode.appendChild(frame);
    }
    return this.rootNode;
  }

  /**
   * 设置蒙版
   * @param mask
   */
  setMask(mask: MaskRender | null): GuideController {
    this.mask = mask;
    return this;
  }

  /**
   * 设置引导内容全局自定义构建函数
   * @param wrapBuilder
   * @returns
   */
  setGuideBuilder<T extends GuideParams>(wrapBuilder: WrappedBuilder<[T]> | null): GuideController {
    this.wrapBuilder = wrapBuilder as WrappedBuilder<[GuideParams]>;
    return this;
  }

  /**
   * 设置引导内容全局自定义构建函数参数
   * @param params
   * @returns
   */
  setGuideBuilderParams<T extends GuideParams>(params: T | undefined): GuideController {
    this.params = params;
    return this;
  }

  /**
   * 设置蒙版大小
   * @param size
   * @returns
   */
  setMaskSize(size: Size | undefined): GuideController {
    this.maskSize = size;
    return this;
  }

  /**
   * 显示
   */
  show() {
    this.state.isShow = true;
  }

  /**
   * 隐藏
   */
  dismiss() {
    if (!this.state.isShow) {
      return;
    }
    this.state.isShow = false;
    this.builderNode?.dispose();
    this.mask?.dispose();
    this.rootNode?.dispose();
    this.builderNode = null;
    this.mask = null;
    this.rootNode = null;
  }
}

export const guideController = new GuideController();