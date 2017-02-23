using MySql.Data.MySqlClient;
using System;
using System.Windows.Forms;

namespace WifiFingerprintLocationSimulator
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }


        private void label_Register_Click(object sender, EventArgs e)
        {
            Register register = new Register();
            register.ShowDialog();
        }

        private void label_ForgetPass_Click(object sender, EventArgs e)
        {
            //MessageBox.Show("忘记密码？我们也没有办法啊...");
            ForgotPass forgotpass = new ForgotPass();
            forgotpass.ShowDialog();
        }

        private void button_Back_Click(object sender, EventArgs e)
        {
            this.Hide();
        }

        private void button_Login_Click(object sender, EventArgs e)
        {
            //用户类型
            string user_type = "user";
            if (comboBox_UserType.Text == "用户")
                user_type = "user";
            else if (comboBox_UserType.Text == "系统管理员")
                user_type = "admin";

            // SQL
            string sql = "select * from user_info where user_name = '" + textBox_UserName.Text + "' and user_pass = '" + textBox_UserPass.Text + "' and user_type = '" + user_type + "'";

            // DataRead Process
            MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
            conn.Open();
            MySqlCommand cmd = conn.CreateCommand();   
            cmd.CommandText = sql;
            MySqlDataReader sdr = cmd.ExecuteReader();


            if (textBox_UserName.Text == "" || textBox_UserPass.Text == "")
                MessageBox.Show("用户名或密码不能为空！");
            else if (comboBox_UserType.Text == "")
                MessageBox.Show("请选择用户类型");
            else if (sdr.Read())
            {
                CurrentUserInfo.Name = sdr.GetString(sdr.GetOrdinal("user_name")).Replace(" ", "");
                CurrentUserInfo.Type = user_type;
                CurrentUserInfo.Id = Convert.ToInt32(sdr.GetString(sdr.GetOrdinal("user_id")));
                conn.Close();

                MessageBox.Show("欢迎您，" + CurrentUserInfo.Name + "!", "登录成功!");
                Application.OpenForms["Main"].Hide();
                this.Hide();

                // 登录身份
                Main_Admin main_admin = new Main_Admin();
                Main_User main_user = new Main_User();

                if (CurrentUserInfo.Type == "admin")
                    main_admin.Show();
                else if (CurrentUserInfo.Type == "user")
                    main_user.Show();

                // Log
                LogHelper.generateLog(CurrentUserInfo.Name + " 登录");
            }
            else
                MessageBox.Show("对不起，你输入的账号或者密码错误！");
        }
    }
}
