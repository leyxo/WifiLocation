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
        public ProgBar()
        {
            InitializeComponent();
        }

        private void ProgBar_Load(object sender, EventArgs e)
        {

        }

        private void ProgBar_Shown(object sender, EventArgs e)
        {
            progressBar1.Maximum = 100;
            progressBar1.Value = 0;
            progressBar1.Step = 1;

            for (int i = 0; i <= 100; i++)
            {
                progressBar1.Value = i;
                System.Threading.Thread.Sleep(30);
            }

            System.Threading.Thread.Sleep(2000);
            this.Close();
        }
    }
}
