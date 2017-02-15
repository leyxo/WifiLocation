using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Threading;
using System.Net.Mail;
using System.Net;
using MySql.Data.MySqlClient;

namespace WifiFingerprintLocationSimulator
{
    // 临时存储忘记密码部分数据的结构体
    public struct forgotInfo
    {
        public static string Email = ""; // 待发送邮箱
        public static string Code = ""; // 当前验证码
    }

    public partial class ForgotPass : Form
    {
        public ForgotPass()
        {
            InitializeComponent();
            // 禁止编译器对跨线程访问做检查
            Control.CheckForIllegalCrossThreadCalls = false;
        }

        private void ForgotPass_Load(object sender, EventArgs e)
        {
            label_Hint_UserName.Text = "";
            label_Hint_Code.Text = "";
            label_UserPass.Visible = false;
            label_UserPassCheck.Visible = false;
            textBox_UserPass.Visible = false;
            textBox_UserPassCheck.Visible = false;
            button_cancel.Visible = false;
            button_Register.Visible = false;

            Size = new Size(310, 190);
        }

        private void button_cancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        // 发送按钮 (先查询数据库有无此人，在查询有无邮箱，若有则发送验证码)
        private void button_Send_Click(object sender, EventArgs e)
        {
            // 生成6位验证码
            Random rd = new Random();
            int num = rd.Next(100000, 1000000);
            forgotInfo.Code = num.ToString();

            if (textBox_UserName.Text == "")
                MessageBox.Show("用户名不能为空");
            else
            {
                //try
                {
                    // SQL
                    string sql = "select user_email from user_info where user_name = '" + textBox_UserName.Text + "'";

                    // DataRead Process
                    MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                    conn.Open();
                    MySqlCommand cmd = conn.CreateCommand();
                    cmd.CommandText = sql;

                    MySqlDataReader sdr = cmd.ExecuteReader();

                    // 有该用户，且该用户填写邮箱
                    if (sdr.Read() && "" != sdr.GetString(sdr.GetOrdinal("user_email")))
                    {
                        // 展开窗口
                        for (int i = 190; i <= 320; i += 2)
                        {
                            Size = new Size(310, i);
                        }
                        label_UserPass.Visible = true;
                        label_UserPassCheck.Visible = true;
                        textBox_UserPass.Visible = true;
                        textBox_UserPassCheck.Visible = true;
                        button_cancel.Visible = true;
                        button_Register.Visible = true;
                        textBox_UserName.Enabled = false;
                        label_Note.Visible = false;

                        // 读取邮件
                        forgotInfo.Email = sdr.GetString(sdr.GetOrdinal("user_email"));

                        // 发送包含验证码的邮件
                        send_email();

                        // Log
                        LogHelper.generateLog("[忘记密码] 向用户 " + textBox_UserName.Text + " 发送了一封验证邮件");

                        // 在新线程中处理60s计数操作
                        Thread thread_code_process = new Thread(new ThreadStart(code_process));
                        thread_code_process.Start();

                        MessageBox.Show("验证码已发送到您的邮箱：" + forgotInfo.Email + "中！");
                    }
                    else
                    {
                        MessageBox.Show("无此用户或该用户未填写邮箱信息！");
                    }
                    conn.Close();
                }
                //catch
                {
                //    MessageBox.Show("Error !");
                }
                
            }
        }

        // 60s后恢复发送验证码按钮
        private void code_process()
        {
            
            button_Send.Visible = false;
            label_Hint_Code.Visible = true;
            for (int i = 60; i > 0; i--)
            {
                label_Hint_Code.Text = i + "s";
                Thread.Sleep(1000);
            }
            button_Send.Visible = true;
            button_Send.Text = "重发";
            label_Hint_Code.Visible = false;
        }

        // 发送包含验证码的邮件
        private void send_email()
        {
            DateTime dt = DateTime.Now;
            var emailAcount = "wifilocation.servi@qq.com"; // System.Text.Encoding.Default.GetString(Convert.FromBase64String("d2lmaWxvY2F0aW9uLnNlcnZpQHFxLmNvbQ==")); // wifilocation.servi@qq.com "d2lmaWxvY2F0aW9uLnNlcnZpQHFxLmNvbQ=="
            var emailPassword = "alivzyvfkuyfdbgi"; // System.Text.Encoding.Default.GetString(Convert.FromBase64String("U2hpbmVpZGluZ3dlaQ==")); // Shineidingwei "U2hpbmVpZGluZ3dlaQ=="
            var reciver = forgotInfo.Email;
            var content = "您的验证码是: " + forgotInfo.Code + "\n\n您的账号正在进行密码修改，请确认是您本人进行操作! \n\n室内定位仿真平台 ver" + System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString() + "\n" + dt.ToString("yyyy/MM/dd HH:mm:ss");
            MailMessage message = new MailMessage();
            //设置发件人,发件人需要与设置的邮件发送服务器的邮箱一致
            MailAddress fromAddr = new MailAddress(emailAcount);
            message.From = fromAddr;
            //设置收件人,可添加多个,添加方法与下面的一样
            message.To.Add(reciver);
            //设置邮件标题
            message.Subject = "室内定位仿真平台 - 忘记密码！";
            //设置邮件内容
            message.Body = content;
            //设置邮件发送服务器,服务器根据你使用的邮箱而不同,可以到相应的 邮箱管理后台查看,下面是QQ的
            SmtpClient client = new SmtpClient("smtp.qq.com", 25);
            //设置发送人的邮箱账号和密码
            client.Credentials = new NetworkCredential(emailAcount, emailPassword);
            //启用ssl,也就是安全发送
            client.EnableSsl = true;
            //发送邮件
            client.Send(message);
        }

        // 提交按钮
        private void button_Register_Click(object sender, EventArgs e)
        {
            if (textBox_Code.Text != forgotInfo.Code)
                MessageBox.Show("验证码不正确！");
            else if (textBox_UserPass.Text == "")
                MessageBox.Show("请输入密码");
            else if (textBox_UserPassCheck.Text == "")
                MessageBox.Show("请确认密码");
            else if (textBox_UserPass.Text != textBox_UserPassCheck.Text)
                MessageBox.Show("密码不一致！");
            else
            {
                try
                {
                    // SQL
                    string sql = "update user_info set user_pass = '" + textBox_UserPass.Text + "' where user_name = '" + textBox_UserName.Text + "'";

                    // DataRead Process
                    MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand(sql, conn);

                    int i = 0;
                    i = cmd.ExecuteNonQuery();

                    if (i > 0)
                    {
                        // Log
                        LogHelper.generateLog("[忘记密码] 用户 " + textBox_UserName.Text + " 重置密码成功");

                        MessageBox.Show("密码重置成功!");
                        this.Close();
                    }
                    else
                    {
                        MessageBox.Show("更新失败！");
                    }
                    conn.Close();
                }
                catch
                {
                    MessageBox.Show("Error !");
                }
            }
        }


// ***********************************************************************************
// *对于正整数数据的textBox输入限制 **************************************************
// ***********************************************************************************

        private void textBox_Code_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != '\b')//这是允许输入退格键  
            {
                if ((e.KeyChar < '0') || (e.KeyChar > '9'))//这是允许输入0-9数字  
                {
                    e.Handled = true;
                }
            }
        }
    }
}
