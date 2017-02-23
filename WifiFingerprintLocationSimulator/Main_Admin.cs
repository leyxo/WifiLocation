using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WifiFingerprintLocationSimulator
{
    public partial class Main_Admin : Form
    {
        public Main_Admin()
        {
            InitializeComponent();
        }

        private void Main_Admin_Load(object sender, EventArgs e)
        {
            // 窗口初始化
            toolStripStatusLabel_Date.Text = DateTime.Now.ToString("yyyy-MM-dd");
            toolStripStatusLabel_UserName.Text = CurrentUserInfo.Name;

            // Log初始化
            label_LogPath.Text = LogHelper.logPath;
            button_Log_Refresh_Click(new object(), new EventArgs());

        }

        private void ToolStripMenuItem_Exit_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("确定要退出系统?", "提示", MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                // Log
                LogHelper.generateLog(CurrentUserInfo.Name + " 注销并退出系统");
                Application.Exit();
            }
        }

        private void ToolStripMenuItem_Help_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start("iexplore.exe", "http://leyxo.site");
        }

        private void ToolStripMenuItem_About_Click(object sender, EventArgs e)
        {
            About about = new About();
            about.ShowDialog();
        }

        private void ToolStripMenuItem_Registe_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("确定要注销当前用户?", "提示", MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                // Log
                LogHelper.generateLog(CurrentUserInfo.Name + " 已注销");

                Application.OpenForms["Main"].Show();
                this.Hide();

                CurrentUserInfo.Id = 0;
                CurrentUserInfo.Name = "";
                CurrentUserInfo.Type = "";
            }
        }

        private void ToolStripMenuItem_UserManage_Click(object sender, EventArgs e)
        {
            panel_UserInfoManage.Show();
            panel_UserInfoManage.BringToFront();
        }

        // 刷新用户信息列表
        private void button_UserManage_Refresh_Click(object sender, EventArgs e)
        {
            button_UserManage_Delete.Enabled = false;

            try
            {
                // SQL
                string sql = "select user_id, user_name, user_type, reg_date, user_email from user_info";

                // DataRead Process
                MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                conn.Open();
                MySqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = sql;

                MySqlDataReader sdr = cmd.ExecuteReader();

                listView_UserInfo.Items.Clear();

                while (sdr.Read())
                {
                    string userID = sdr.GetString(sdr.GetOrdinal("user_id"));
                    string userName = sdr.GetString(sdr.GetOrdinal("user_name"));
                    string userType_str = sdr.GetString(sdr.GetOrdinal("user_type"));
                    string regDate = sdr.GetString(sdr.GetOrdinal("reg_date"));
                    string userEmail = sdr.GetString(sdr.GetOrdinal("user_email"));

                    string userType = "";
                    if ("admin" == userType_str)
                        userType = "系统管理员";
                    else if ("user" == userType_str)
                        userType = "用户";

                    if (userName == CurrentUserInfo.Name)
                        userName += "(自己)";

                    ListViewItem item = new ListViewItem(userID);
                    item.SubItems.Add(userName);
                    item.SubItems.Add(userType);
                    item.SubItems.Add(regDate);
                    item.SubItems.Add(userEmail);
                    listView_UserInfo.Items.Add(item);
                }
                conn.Close();
            }
            catch
            {
                MessageBox.Show("Error !");
            }
        }

        // 增加一条用户信息
        private void button_UserManage_AddUser_Click(object sender, EventArgs e)
        {
            Register register = new Register();
            register.ShowDialog();
        }

        // 删除一条用户信息
        private void button_UserManage_Delete_Click(object sender, EventArgs e)
        {
            string UserName = listView_UserInfo.SelectedItems[0].SubItems[0].Text;

            try
            {
                // SQL
                string sql = "delete from user_info where user_name = '" + UserName + "'";
                string sql_map = "delete from map_info where user_id = " + Convert.ToInt32(listView_UserInfo.SelectedItems[0].Text);

                // DataRead Process
                MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(sql, conn);

                if (MessageBox.Show("确定要删除?", "提示", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    int i = 0;
                    i = cmd.ExecuteNonQuery();

                    if (i > 0)
                    {
                        MessageBox.Show("用户 " + UserName + " 记录已删除!");
                    }
                    else
                    {
                        MessageBox.Show("删除失败！");
                    }

                    conn.Close();
                    button_UserManage_Refresh_Click(new object(), new EventArgs());
                    button_UserManage_Delete.Enabled = false;
                }
            }
            catch
            {
                MessageBox.Show("Error !");
            }
        }

        // listView布局初始化时载入用户信息
        private void listView_UserInfo_Layout(object sender, LayoutEventArgs e)
        {
            button_UserManage_Refresh_Click(new object(), new EventArgs());
        }

        // listView选中时激活删除按钮
        // 选中自己时不激活删除按钮
        private void listView_UserInfo_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listView_UserInfo.SelectedItems.Count > 0 && listView_UserInfo.SelectedItems[1].Text != CurrentUserInfo.Name + "(自己)")
            {
                button_UserManage_Delete.Enabled = true;
            }
            else
            {
                button_UserManage_Delete.Enabled = false;
            }
        }

        // 日志 - 清空
        private void button_Log_Clean_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("确定要清空系统日志?", "提示", MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                System.IO.File.WriteAllText(LogHelper.logPath, "");
                button_Log_Refresh_Click(new object(), new EventArgs());
            }
        }

        // 日志 - 刷新
        private void button_Log_Refresh_Click(object sender, EventArgs e)
        {
            textBox_Log.Text = System.IO.File.ReadAllText(LogHelper.logPath);
        }

        // 日志 - 导出
        private void button_Log_Export_Click(object sender, EventArgs e)
        {
            SaveFileDialog saveFileDialog = new SaveFileDialog();
            saveFileDialog.Filter = "日志文件(*.log)|*.log";
            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                StreamWriter sw = new StreamWriter(saveFileDialog.FileName, true);
                //向创建的文件中写入内容
                sw.WriteLine(textBox_Log.Text);
                //关闭当前文件写入流
                sw.Close();
            }
        }

        // 点击路径打开文件夹
        private void label_LogPath_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start("Explorer.exe", LogHelper.logPathFolder);
        }

        private void label_LogPath_MouseEnter(object sender, EventArgs e)
        {
            label_LogPath.ForeColor = Color.Blue;
        }

        private void label_LogPath_MouseLeave(object sender, EventArgs e)
        {
            label_LogPath.ForeColor = Color.Black;
        }
    }
}
