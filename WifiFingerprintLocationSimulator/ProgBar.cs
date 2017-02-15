using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
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
        public ProgBar(int amountNum)
        {
            InitializeComponent();
            amount = amountNum;
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

            System.Threading.Thread.Sleep(5000);
            this.Close();
        }
    }
}
