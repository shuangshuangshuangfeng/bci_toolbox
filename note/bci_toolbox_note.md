# BCI_ToolBox使用文档


## 安装使用
0. 实验数据下载：San Diego Square Joint Frequnecy-Phase Modulation SSVEP (ftp://sccn.ucsd.edu/pub/cca_ssvep)
1. 首先在matlab中加入项目路径，具体操作：命令行输入``pathtool``->添加文件夹->保存
2. 用matlab打开后，在命令行窗口输入cd('项目根目录')，切换到项目根目录下
3. 执行``setup.m``
4. 在根目录下创建``datasets``文件夹，并在它下面创建``epochs``文件夹
5. 将下载的是s1-s10的数据复制到``datasets``文件夹下面
6. 命令行输入如下: 产生训练集和测试集
```
% 数据长度和带通滤波
epoch_length = [0 4000];
filter_band = [5 40];
dataio_create_epochs_SM_SanDiego(epoch_length, filter_band)
```
7. 如果第六步操作完成，则可以执行``define_approach_SSVEP.m``



## SSVEP详情


### 数据结构

1. 训练数据/测试数据的数据结构
**方法：** ``trainEEG = dataio_read_SSVEP(set,'train')``
**返回：**
```
data : cell{1xN} N subjects in dataset of STRUCT
        data.epochs 1x1 STRUCT 
            data.epochs.signal DOUBLE 3D-matrix [NxMxL]
                [sample channels epochs] of total epochs. 
            data.epochs.events DOUBLE [LxP] [epochs trials]
                a matrix of events description. 事件描述矩阵
            data.epochs.y DOUBLE [LxP] [epochs trials]  a matrix of binary labels. 二进制标签矩阵
            data.phrase STR target phrase. 目标相位
            data.fs DOUBLE sampling rate.
            data.montage 1x1 STRUCT  数据裁剪
                data.montage.clab cell of STR channels labels.
            data.classes cell {1x2} STR classes descriptions target , non_target 数据类别：目标、非目标
            data.paradigm STRUCT 1x1 experimental protocol.
                data.paradigm.title STR paradigm description.  范式名称
                data.paradigm.stimulation DOUBLE stimulation duration in msec  范式刺激
                data.paradigm.isi DOUBLE ISI in msec.
                data.paradigm.repetition DOUBLE stimuli repetition. 刺激重复次数
                data.paradigm.stimuli_count DOUBLE number of stimuli in paradigm experiement.    实验范式中的刺激数
                data.paradigm.type STR  信息传输率
            data.subject STRUCT 1X1
                data.subject.id STR subject id  受试者ID
                data.subject.gender CHAR male or female.  受试者性别
                data.subject.age DOUBLE subject age  受试者年龄
                data.subject.condition STR health condition.  受试者健康状况


```











