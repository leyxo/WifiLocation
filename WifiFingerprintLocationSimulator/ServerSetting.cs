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
    public partial class ServerSetting : Form
    {
        public ServerSetting()
        {
            InitializeComponent();
        }

        private void ServerSetting_Load(object sender, EventArgs e)
        {
            // 初始化数据

            // 初始化选中状态
            if ("local" == MySqlHelper.ConnStatus)
            {
                checkBox_server_isLocalServer.CheckState = CheckState.Checked;
                textBox_server_ip_1.Enabled = false;
                textBox_server_ip_2.Enabled = false;
                textBox_server_ip_3.Enabled = false;
                textBox_server_ip_4.Enabled = false;
            }
            else
            {
                checkBox_server_isLocalServer.CheckState = CheckState.Unchecked;
            }

            textBox_server_ip_1.Text = MySqlHelper.datasource1;
            textBox_server_ip_2.Text = MySqlHelper.datasource2;
            textBox_server_ip_3.Text = MySqlHelper.datasource3;
            textBox_server_ip_4.Text = MySqlHelper.datasource4;
            textBox_server_database.Text = MySqlHelper.database;
            textBox_server_userid.Text = MySqlHelper.userid;
            textBox_server_password.Text = MySqlHelper.password;
            comboBox_server_charset.Text = MySqlHelper.charset;
            comboBox_server_pooling.Text = MySqlHelper.pooling;
        }

        private void checkBox_server_isLocalServer_CheckedChanged(object sender, EventArgs e)
        {
            if (checkBox_server_isLocalServer.CheckState == CheckState.Unchecked)
            {
                textBox_server_ip_1.Enabled = true;
                textBox_server_ip_2.Enabled = true;
                textBox_server_ip_3.Enabled = true;
                textBox_server_ip_4.Enabled = true;
            }
            else
            {
                textBox_server_ip_1.Enabled = false;
                textBox_server_ip_2.Enabled = false;
                textBox_server_ip_3.Enabled = false;
                textBox_server_ip_4.Enabled = false;
            }
        }

        private void button_Save_Click(object sender, EventArgs e)
        {
            MySqlHelper.database = textBox_server_database.Text;
            MySqlHelper.userid = textBox_server_userid.Text;
            MySqlHelper.password = textBox_server_password.Text;
            MySqlHelper.charset = comboBox_server_charset.Text;
            MySqlHelper.pooling = comboBox_server_pooling.Text;

            if (checkBox_server_isLocalServer.CheckState == CheckState.Unchecked)
            {
                MySqlHelper.ConnStatus = "remote";
                MySqlHelper.datasource1 = textBox_server_ip_1.Text;
                MySqlHelper.datasource2 = textBox_server_ip_2.Text;
                MySqlHelper.datasource3 = textBox_server_ip_3.Text;
                MySqlHelper.datasource4 = textBox_server_ip_4.Text;
            }
            else
            {
                MySqlHelper.ConnStatus = "local";
                MySqlHelper.datasource1 = "127";
                MySqlHelper.datasource2 = "0";
                MySqlHelper.datasource3 = "0";
                MySqlHelper.datasource4 = "1";
            }

            this.Close();
        }
    }
}
