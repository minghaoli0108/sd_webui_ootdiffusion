# 基于官方的PyTorch镜像
FROM pytorch/pytorch:latest

# 更新软件包列表并安装依赖
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libsm6 libxext6 libxrender-dev wget \
    && rm -rf /var/lib/apt/lists/*
 
# 安装Python依赖
COPY requirements.txt .
#RUN conda create -n ootd python==3.10
#RUN conda info | grep -i "base environment"
#RUN /bin/bash -c "source /opt/conda/etc/profile.d/conda.sh"
#RUN conda activate ootd
#RUN pip install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2
RUN pip install -r requirements.txt
 
# 下载模型和其他资源
RUN mkdir /app 
 
# 复制源代码到容器中
COPY . /app
 
# 设置工作目录
WORKDIR /app
 
# 设置环境变量
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
 
# 运行OOTDiffusion模型
CMD ["python", "/install.py"]
