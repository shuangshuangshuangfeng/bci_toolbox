# BCI_ToolBox使用文档


## 安装使用
0. 实验数据下载：San Diego Square Joint Frequnecy-Phase Modulation SSVEP (ftp://sccn.ucsd.edu/pub/cca_ssvep)
1. 首先在matlab中加入项目路径，具体操作：命令行输入``pathtool``->添加文件夹->保存
2. 用matlab打开后，在命令行窗口输入cd('项目根目录')，切换到项目根目录下
3. 执行``setup.m``
4. 在根目录下创建``datasets``文件夹，并在它下面创建``epochs``文件夹
5. 将下载的是s1-s10的数据复制到``datasets``文件夹下面
6. 命令行输入如下: 
```
% 数据长度和带通滤波
epoch_length = [0 4000];
filter_band = [5 40];
dataio_create_epochs_SM_SanDiego(epoch_length, filter_band)
```
7. 如果第六步操作完成，则可以执行``define_approach_SSVEP.m``



## 详情
1. 
set.model = 'SM': single model
set.model = 'BM': batch model











