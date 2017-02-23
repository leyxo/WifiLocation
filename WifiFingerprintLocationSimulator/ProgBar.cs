using System;
using System.Windows.Forms;

namespace WifiFingerprintLocationSimulator
{
    public partial class ProgBar : Form
    {
        private int amount = 0;

        public ProgBar()
        {
            InitializeComponent();
        }

        // 构造函数
        // 参数: int amountNum FP节点数与仿真节点数乘积，为仿真实验的数量级 (80000 约 15 秒)
        //       int algo 所用算法 0:所有算法 1:NN 2:KNN 3:WKNN 4:贝叶斯
        public ProgBar(int amountNum, int algo)
        {
            InitializeComponent();
            if (0 == algo)
            {
                amount = amountNum;
            }
            else
            {
                amount = amountNum / 3;
            }
        }

        private void ProgBar_Load(object sender, EventArgs e)
        {

        }

        private void ProgBar_Shown(object sender, EventArgs e)
        {
            progressBar1.Maximum = amount/110; //(15s = 80000/110)
            progressBar1.Value = 0;
            progressBar1.Step = 1;

            for (int i = 0; i <= progressBar1.Maximum; i++)
            {
                progressBar1.Value = i;
                System.Threading.Thread.Sleep(30);
            }

            System.Threading.Thread.Sleep(4000);
            this.Close();
        }
    }
}
