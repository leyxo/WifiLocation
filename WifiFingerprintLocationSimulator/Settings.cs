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
    public partial class Settings : Form
    {
        public Settings()
        {
            InitializeComponent();
        }

        private void button_cancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void Settings_Load(object sender, EventArgs e)
        {
            // 初始化选中状态
            //
            if (true == CurrentUserInfo.settings_showCoord)
                checkBox_showCoord.CheckState = CheckState.Checked;
            else
                checkBox_showCoord.CheckState = CheckState.Unchecked;
            //
            if (true == CurrentUserInfo.settings_showAPRadio)
                checkBox_showAPRadio.CheckState = CheckState.Checked;
            else
                checkBox_showAPRadio.CheckState = CheckState.Unchecked;
        }

        private void button_Save_Click(object sender, EventArgs e)
        {
            //
            if (checkBox_showCoord.CheckState == CheckState.Checked)
                CurrentUserInfo.settings_showCoord = true;
            else
                CurrentUserInfo.settings_showCoord = false;
            //
            if (checkBox_showAPRadio.CheckState == CheckState.Checked)
                CurrentUserInfo.settings_showAPRadio = true;
            else
                CurrentUserInfo.settings_showAPRadio = false;


            this.Hide();
        }
    }
}
