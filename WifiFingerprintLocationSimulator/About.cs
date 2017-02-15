using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WifiFingerprintLocationSimulator
{
    public partial class About : Form
    {
        public About()
        {
            InitializeComponent();
        }

        private void About_Load(object sender, EventArgs e)
        {
            button_Awful.Visible = false;
            label_ProjectName.Text = "室内定位仿真平台 v" + System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString();
            label_CopyRight.Text = "Copyright © 2017 Mike Liang.";
            label_Author.Text = "梁尔越 2013201109";
        }

        private void button_Gorgeous_Click(object sender, EventArgs e)
        {
            MessageBox.Show("哈哈! 谢谢支持! 0.0", "良心软件");
            this.Hide();
        }

        private void button_Awful_Click(object sender, EventArgs e)
        {
            MessageBox.Show("抓到又能怎样？ →_→");
            Random rd = new Random();
            int newX, newY;
            newX = rd.Next(10, 205);
            newY = rd.Next(10, 193);

            button_Awful.Location = new Point(newX, newY);
        }

        private void button_Awful_MouseEnter(object sender, EventArgs e)
        {
            Random rd = new Random();
            int newX, newY;
            newX = rd.Next(10, 205);
            newY = rd.Next(10, 193);
            button_Awful.Location = new Point(newX, newY);
        }

        private void label_ProjectName_Click(object sender, EventArgs e)
        {
            MessageBox.Show("这是软件的名字，嗯，很土，我们也没办法。", "软件的名字很棒");
        }

        private void pictureBox_Logo_DoubleClick(object sender, EventArgs e)
        {
            MessageBox.Show("这是一棵圣诞树，嗯，没什么特别的\n这也是本软件的Logo\n希望你看到它就会开心 ^.^\n(...这个Logo象征着基站 ?? )\n                                 --- Mike Liang", "恭喜你发现了这个彩蛋！");
        }

        private void pictureBox_Awful_MouseEnter(object sender, EventArgs e)
        {
            Random rd = new Random();
            int newX, newY;
            newX = rd.Next(10, 205);
            newY = rd.Next(10, 193);
            pictureBox_Awful.Location = new Point(newX, newY);
        }
    }
}
