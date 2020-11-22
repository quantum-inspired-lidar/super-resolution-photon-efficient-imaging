# Super-resolution single-photon imaging at 8.2 kilometers
 
This demo includes data and MATLAB codes for the paper "Super-resolution single-photon imaging at 8.2 kilometers"
by Zheng-Ping Li, Xin Huang, Peng-Yu Jiang, Yu Hong, Chao Yu, Yuan Cao, Jun Zhang, Feihu Xu, and Jian-Wei Pan
published in Optics Express 28(3), 4076-4087, 2020 .

How to cite (BibTeX):
@article{li2020super,
  title={Super-resolution single-photon imaging at 8.2 kilometers},
  author={Li, Zheng-Ping and Huang, Xin and Jiang, Peng-Yu and Hong, Yu and Yu, Chao and Cao, Yuan and Zhang, Jun and Xu, Feihu and Pan, Jian-Wei},
  journal={Optics Express},
  volume={28},
  number={3},
  pages={4076--4087},
  year={2020},
  publisher={Optical Society of America}
}
Corresponding author: feihuxu@ustc.edu.cn.

To try the codes, just download the zip and run the "demo_11_20_2020.m" in MATLAB. 
Warning: the code was tested using MATLAB 2017b and it might be incompatible with older versions.  

The datasets are obtained by our single-photon lidar system for a mannequin with 7 postures over 8.2km far away (5 postures at night and 2 postures in the daylight ). 
The implementation codes are used to compute the depth maps of the mannequin from the raw data.

This long-range-tailored super-resolution reconstruction algorithm is a 3D deconvolution convex scheme modified from SPIRAL-TAP by Z.H.Harmany et al. (http://drz.ac/code/spiraltap/).


Instructions for the experimental data:
 -"data_night.mat", it contains raw data for 5 postures captured at night. 
 -"data_daylight.mat", it contains raw data for 2 postures captured in the daylight. 
 For each posture, the ToF information of the arrival photons (unit: ps) is recorded. 




