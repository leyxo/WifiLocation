using MySql.Data.MySqlClient;
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
    public partial class Register : Form
    {
        public Register()
        {
            InitializeComponent();
        }

        private void Register_Load(object sender, EventArgs e)
        {
            label_Hint_UserName.Text = "";
            label_Hint_UserPassCheck.Text = "";
            label_Hint_UserEmail.Text = "(可选填)";

            label_Hint_UserEmail.ForeColor = Color.Gray;
            label_Hint_UserPassCheck.ForeColor = Color.Gray;
            label_Hint_UserEmail.ForeColor = Color.Gray;
        }

        private void button_cancel_Click(object sender, EventArgs e)
        {
            this.Hide();
        }

        private void button_Register_Click(object sender, EventArgs e)
        {
            if (textBox_UserName.Text == "")
                MessageBox.Show("用户名不能为空");
            else if (textBox_UserPass.Text == "")
                MessageBox.Show("请输入密码");
            else if (textBox_UserPassCheck.Text == "")
                MessageBox.Show("请确认密码");
            else if (comboBox_UserType.Text == "")
                MessageBox.Show("请选择新用户类型");
            else if (textBox_UserPass.Text != textBox_UserPassCheck.Text)
                MessageBox.Show("密码有误！");
            else if ((CurrentUserInfo.Type != "admin") && (comboBox_UserType.Text == "系统管理员"))
                MessageBox.Show("您是普通用户，无权限注册系统管理员用户", "提示");
            else
            {
                // 用户类型字符串
                string userType = "user";
                if (comboBox_UserType.Text == "系统管理员")
                    userType = "admin";

                try
                {
                    // SQL
                    string sql = "insert into user_info (user_name, user_pass, user_type, reg_date, user_email) values('" + textBox_UserName.Text + "','" + textBox_UserPass.Text + "','" + userType + "','" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "','" + textBox_UserEmail.Text + "')";
                    string sql_check = "select * from user_info where user_name = '" + textBox_UserName.Text + "'";

                    // DataRead Process
                    MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                    MySqlConnection conn_check = new MySqlConnection(MySqlHelper.Conn);
                    conn.Open();
                    conn_check.Open();
                    MySqlCommand cmd = new MySqlCommand(sql, conn);
                    MySqlCommand cmd_check = new MySqlCommand(sql_check, conn_check); // 检查该用户名是否存在

                    MySqlDataReader sdr = cmd_check.ExecuteReader();
                    if (!sdr.Read()) // 数据库中无此用户名
                    {
                        int i = 0;
                        i = cmd.ExecuteNonQuery();

                        if (i > 0)
                        {
                            MessageBox.Show("用户 " + textBox_UserName.Text + " 注册成功!");
                            this.Hide();
                        }
                        else
                        {
                            MessageBox.Show("添加失败！");
                        }
                    }
                    else
                    {
                        MessageBox.Show("该用户已存在！");
                    }

                    conn.Close();
                }
                catch
                {
                    MessageBox.Show("Error !");
                }
            }

        }

        // 监测输入用户名长度(不少于6个字符)
        private void textBox_UserName_TextChanged(object sender, EventArgs e)
        {
            if (textBox_UserName.TextLength < 6)
                label_Hint_UserName.Text = "*少于6字符";
            else
                label_Hint_UserName.Text = "";
        }

        // 监测密码是否一致
        private void textBox_UserPassCheck_TextChanged(object sender, EventArgs e)
        {
            if (textBox_UserPassCheck.Text != textBox_UserPass.Text)
            {
                label_Hint_UserPassCheck.Text = "*密码不一致";
                label_Hint_UserPassCheck.ForeColor = Color.Gray;
            }
            else
            {
                label_Hint_UserPassCheck.Text = "";
                label_Hint_UserEmail.ForeColor = Color.Gray;
            }
        }

        // 监测邮箱内容是否为空
        private void textBox_UserEmail_TextChanged(object sender, EventArgs e)
        {
            if ("" != textBox_UserEmail.Text)
            {
                label_Hint_UserEmail.Text = "";
            }
            else
            {
                label_Hint_UserEmail.Text = "(可选填)";
            }
        }

// ***********************************************************************************
// *对于textBox输入字符的限制 ********************************************************
// ***********************************************************************************
        private void textBox_UserName_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != '\b')//这是允许输入退格键  
            {
                if ((e.KeyChar < '0') || ((e.KeyChar > '9') && (e.KeyChar < 'A')) || ((e.KeyChar > 'Z') && (e.KeyChar < 'a')) || (e.KeyChar > 'z'))//这是允许输入0-9数字  
                {
                    e.Handled = true;
                }
            }
        }
    }
}
