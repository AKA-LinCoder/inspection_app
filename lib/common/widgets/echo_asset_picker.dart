/// FileName echo_asset_picker
///
/// @Author LinGuanYu
/// @Date 2023/3/15 18:35
///
/// @Description TODO

import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';




///存在bug,来不及改

// 最大数量
const int _maxAssets = 9;
// 录制视频最长时长, 默认为 15 秒，可以使用 `null` 来设置无限制的视频录制
const Duration _maximumRecordingDuration = Duration(seconds: 15);
// 一行显示几个
const int _lineCount = 3;
// 每个GridView item间距(GridView四周与内部item间距在此统一设置)
const double _itemSpace = 5.0;
// 右上角删除按钮大小
const double _deleteBtnWH = 20.0;

// 默认背景色
const Color _bgColor = Colors.transparent;

enum AssetType {
  image,
  video,
  imageAndVideo,
}

class EchoAssetPicker extends StatefulWidget {
  const EchoAssetPicker({Key? key,
    this.assetType = AssetType.image,
    this.maxAssets = _maxAssets,
    this.lineCount = _lineCount,
    this.itemSpace = _itemSpace,
    this.maximumRecordingDuration = _maximumRecordingDuration,
    this.bgColor = _bgColor,
    this.callBack,
    this.oldAssets,}) : super(key: key);

  final AssetType assetType; // 资源类型
  final List<AssetEntity>? oldAssets;
  final int maxAssets; // 最大数量
  final int lineCount; // 一行显示几个
  final double itemSpace; // 每个GridView item间距(GridView四周与内部item间距在此统一设置)
  final Duration? maximumRecordingDuration; // 录制视频最长时长, 默认为 15 秒，可以使用 `null` 来设置无限制的视频录制
  final Color bgColor; // 背景色
  final Function(List<AssetEntity> assetEntityList)? callBack; // 选择回调
  @override
  State<EchoAssetPicker> createState() => _EchoAssetPickerState();
}

class _EchoAssetPickerState extends State<EchoAssetPicker> {

  // List<AssetEntity> _selectedAssets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    echoLog("图片绘制");
    // if(widget.oldAssets!=null){
    //   echoLog("这是获取到的旧图片${widget.oldAssets?.length}");
    //   _selectedAssets.addAll(widget.oldAssets!);
    // }
    return _body();
  }

  _body(){
    var allCount = (widget.oldAssets?.length??0) + 1;
    return Container(
      color: widget.bgColor,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // 可以直接指定每行（列）显示多少个Item
          crossAxisCount: widget.lineCount, // 一行的Widget数量
          crossAxisSpacing: widget.itemSpace, // 水平间距
          mainAxisSpacing: widget.itemSpace, // 垂直间距
          childAspectRatio: 1.0, // 子Widget宽高比例
        ),
        // GridView内边距
        padding: EdgeInsets.all(widget.itemSpace),
        itemCount: (widget.oldAssets?.length??0) == widget.maxAssets ? (widget.oldAssets?.length??0) : allCount,
        itemBuilder: (context, index) {
          if ((widget.oldAssets?.length??0) == widget.maxAssets) {
            return _itemWidget(index);
          }
          if (index == allCount - 1) {
            return _addBtnWidget();
          } else {
            return _itemWidget(index);
          }
        },
      ),
    );
  }

  Widget _addBtnWidget() {
    return GestureDetector(
      child: Container(
          color: Colors.grey[100],
          width: 100.w,
          height: 100.w,
          child: Icon(
            Icons.add,
            color: Colors.green,
            size: 30.w,
          )),
      onTap: () => selectAssets(),
    );
  }

  Future<void> selectAssets() async {
    final List<AssetEntity>? result = await ImagePickerHelper.camera(
        maxAssetsCount:widget.maxAssets,
        handleResult: (BuildContext context, AssetEntity result) {
          Navigator.of(context).pop(<AssetEntity>[
            ...((widget.oldAssets) ?? []),
            result
          ]);
        })
        .method(
        context, (widget.oldAssets) ?? []);
    if (result != null) {
      widget.oldAssets?.clear();
      widget.oldAssets?.addAll(List<AssetEntity>.from(result)) ;
      // = List<AssetEntity>.from(result);
      // 选择回调
      widget.callBack?.call((widget.oldAssets) ?? []);
      if (mounted) {
        setState(() {
          // controller.text = controller.text;
        });
      }
    }
  }


  _itemWidget(index){
    return GestureDetector(
      onTap: () => _clickAsset(index),
      child: Stack(
        children: [
          Positioned.fill(
              child: Container(
                  width: 100.w,
                  height: 100.w,
                  child: Image(
                    image: AssetEntityImageProvider(
                        ((widget.oldAssets) ?? [])[index],
                        isOriginal: false),
                    fit: BoxFit.cover,
                  ))),
          AnimatedPositioned(
              top: 6,
              right: 6,
              duration: const Duration(milliseconds: 200),
              child: GestureDetector(
                onTap: () => _deleteAsset(index),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.grey,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: _deleteBtnWH,
                  ),
                ),
              ))
        ],
      ),
    );
  }



  void _deleteAsset(index) {
    setState(() {
      ((widget.oldAssets) ?? []).removeAt(index);
      echoLog("删除完了还有${widget.oldAssets?.length}");
      // 选择回调
      widget.callBack?.call((widget.oldAssets) ?? []);
    });
  }

  // 全屏查看
  void _clickAsset(index) {
    AssetPickerViewer.pushToViewer(
      context,
      currentIndex: index,
      previewAssets: (widget.oldAssets) ?? [],
      themeData: AssetPicker.themeData(Colors.white),
    );
  }

}

class ImagePickerHelper {
  final Future<List<AssetEntity>?> Function(
      BuildContext context,

      List<AssetEntity> selectedAssets,
      ) method;
  ImagePickerHelper({required this.method});

  factory ImagePickerHelper.camera({
    required int maxAssetsCount,
    required Function(BuildContext, AssetEntity) handleResult,
  }) {
    return ImagePickerHelper(
        method: (BuildContext context, List<AssetEntity> assets) {
          return AssetPicker.pickAssets(
            context,
            pickerConfig: AssetPickerConfig(
              maxAssets: maxAssetsCount,
              selectedAssets: assets,
              requestType: RequestType.common,
              ///当相册没有图片时，展示拍摄item
              // allowSpecialItemWhenEmpty: true,
              specialItemPosition: SpecialItemPosition.prepend,
              specialItemBuilder: (BuildContext context,asset,index) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    final AssetEntity? result = await CameraPicker.pickFromCamera(
                      context,
                      pickerConfig: const CameraPickerConfig(enableTapRecording: true),
                    );
                    if (result != null) {
                      handleResult(context, result);
                    }
                  },
                  child: const Center(
                    child: Icon(Icons.camera_enhance, size: 42.0),
                  ),
                );
              },
            ),

          );
        });
  }
}