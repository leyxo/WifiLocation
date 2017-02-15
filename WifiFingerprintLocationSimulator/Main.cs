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
    public partial class Main : Form
    {
        public Main()
        {
            InitializeComponent();
        }

        private void Main_Load(object sender, EventArgs e)
        {
            //窗口初始化
            toolStripStatusLabel_Date.Text = DateTime.Now.ToString("yyyy-MM-dd");
            toolStripStatusLabel_UserName.Text = CurrentUserInfo.Name;

        }

        private void ToolStripMenuItem_About_Click(object sender, EventArgs e)
        {
            About about = new About();
            about.ShowDialog();
        }

        private void ToolStripMenuItem_Exit_Click(object sender, EventArgs e)
        {
            // Log
            LogHelper.generateLog("退出系统");
            Application.Exit();
        }

        private void ToolStripMenuItem_Help_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start("http://leyxo.site");
        }

        private void ToolStripMenuItem_Registe_Click(object sender, EventArgs e)
        {
            Register register = new Register();
            register.ShowDialog();
        }

        private void ToolStripMenuItem_Login_Click(object sender, EventArgs e)
        {
            Login login = new Login();
            login.ShowDialog();
        }

    }
}
