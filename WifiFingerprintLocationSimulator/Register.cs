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
    }
}
