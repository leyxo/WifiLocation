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
using System.Threading;
using MathWorks.MATLAB.NET.Arrays;
using MathWorks.MATLAB.NET.Utility;
using LocationAlgorithm;

namespace WifiFingerprintLocationSimulator
{
    public partial class Main_User : Form
    {
        public Main_User()
        {
            InitializeComponent();
        }

        private void Main_User_Load(object sender, EventArgs e)
        {
            // 窗口初始化
            toolStripStatusLabel_Date.Text = DateTime.Now.ToString("yyyy-MM-dd");
            toolStripStatusLabel_UserName.Text = CurrentUserInfo.Name;
            ToolStripMenuItem_Logout.Text += (" " + CurrentUserInfo.Name);

            // 各Panel初始化
            panel_EnvironmentSettings.Location = new Point(12, 39);
            panel_Simulate.Location = new Point(12, 39);
            panel_Simulate.Hide();
            panel_EnvironmentSettings.Show();
            panel_EnvironmentSettings.BringToFront();

            // 控件提示弹窗初始化
            toolTip_Graph.SetToolTip(panel_Graph, "点击以切换大图模式");

            // CurrentUserInfo初始化
            CurrentUserInfo.Panel = "EnvironmentSettings";

            // 对一些功能的禁用
            button_ap_modify.Visible = false;

        }

        private void ToolStripMenuItem_Settings_Click(object sender, EventArgs e)
        {
            Settings settings = new Settings();
            settings.ShowDialog();
        }

        private void ToolStripMenuItem_Exit_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("确定要退出系统?", "提示", MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                // Log
                LogHelper.generateLog(CurrentUserInfo.Name + " 注销并退出系统");

                try
                {
                    Application.Exit();
                    //Environment.Exit(0);
                }
                catch
                {
                    MessageBox.Show("系统正忙，请点击注销按钮退回到主菜单后退出系统 !");
                }
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
                Application.OpenForms["Main"].Show();
                this.Hide();

                // Log
                LogHelper.generateLog(CurrentUserInfo.Name + " 已注销");

                // 清空当前登录信息
                CurrentUserInfo.Id = 0;
                CurrentUserInfo.Name = "";
                CurrentUserInfo.Type = "";
                CurrentUserInfo.MapID = "";
                CurrentUserInfo.MapWidth = 0;
                CurrentUserInfo.MapHeight = 0;
                CurrentUserInfo.ApID = "";
                CurrentUserInfo.Panel = "";
            }
        }

        private void toolStripMenuItem_MapManage_Click(object sender, EventArgs e)
        {
            CurrentUserInfo.Panel = "EnvironmentSettings";
            panel_EnvironmentSettings.Show();
            panel_EnvironmentSettings.BringToFront();
            tabControl_EnvironmentSettings.SelectedIndex = 0;
            draw();
        }

        private void toolStripMenuItem_APManage_Click(object sender, EventArgs e)
        {
            CurrentUserInfo.Panel = "EnvironmentSettings";
            panel_EnvironmentSettings.Show();
            panel_EnvironmentSettings.BringToFront();
            tabControl_EnvironmentSettings.SelectedIndex = 1;
            draw();
        }

        private void toolStripMenuItem_FPManage_Click(object sender, EventArgs e)
        {
            CurrentUserInfo.Panel = "EnvironmentSettings";
            panel_EnvironmentSettings.Show();
            panel_EnvironmentSettings.BringToFront();
            tabControl_EnvironmentSettings.SelectedIndex = 2;
            draw();
        }

        private void toolStripMenuItem_RSSInfo_Click(object sender, EventArgs e)
        {
            CurrentUserInfo.Panel = "EnvironmentSettings";
            panel_EnvironmentSettings.Show();
            panel_EnvironmentSettings.BringToFront();
            tabControl_EnvironmentSettings.SelectedIndex = 3;
            draw();
        }

        private void toolStripMenuItem_SimuTrial_Click(object sender, EventArgs e)
        {
            CurrentUserInfo.Panel = "Simulate";
            panel_Simulate.Show();
            panel_Simulate.BringToFront();
            tabControl_Simulate.SelectedIndex = 0;
            draws();
        }

        private void toolStripMenuItem_SimuStart_Click(object sender, EventArgs e)
        {
            CurrentUserInfo.Panel = "Simulate";
            panel_Simulate.Show();
            panel_Simulate.BringToFront();
            tabControl_Simulate.SelectedIndex = 1;
            draws();
        }


// ***********************************************************************************
// *对于正整数数据的textBox输入限制 **************************************************
// ***********************************************************************************

        private void textBox_map_width_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != '\b')//这是允许输入退格键  
            {
                int len = textBox_map_width.Text.Length;
                if (len < 1 && e.KeyChar == '0')
                {
                    e.Handled = true;
                }
                else if ((e.KeyChar < '0') || (e.KeyChar > '9'))//这是允许输入0-9数字  
                {
                    e.Handled = true;
                }
            }
        }

        private void textBox_map_height_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != '\b')//这是允许输入退格键  
            {
                int len = textBox_map_height.Text.Length;
                if (len < 1 && e.KeyChar == '0')
                {
                    e.Handled = true;
                }
                else if ((e.KeyChar < '0') || (e.KeyChar > '9'))//这是允许输入0-9数字  
                {
                    e.Handled = true;
                }
            }
        }

        private void textBox_ap_x_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != '\b')//这是允许输入退格键  
            {
                int len = textBox_ap_x.Text.Length;
                if (textBox_ap_x.Text == "0" && e.KeyChar == '0')
                {
                    e.Handled = true;
                }
                else if ((e.KeyChar < '0') || (e.KeyChar > '9'))//这是允许输入0-9数字  
                {
                    e.Handled = true;
                }
            }
        }

        private void textBox_ap_y_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != '\b')//这是允许输入退格键  
            {
                int len = textBox_ap_y.Text.Length;
                if (textBox_ap_y.Text == "0" && e.KeyChar == '0')
                {
                    e.Handled = true;
                }
                else if ((e.KeyChar < '0') || (e.KeyChar > '9'))//这是允许输入0-9数字  
                {
                    e.Handled = true;
                }
            }
        }

        private void textBox_ap_sendpower_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != '\b')//这是允许输入退格键  
            {
                int len = textBox_ap_sendpower.Text.Length;
                if (len < 1 && e.KeyChar == '0')
                {
                    e.Handled = true;
                }
                else if ((e.KeyChar < '0') || (e.KeyChar > '9'))//这是允许输入0-9数字  
                {
                    e.Handled = true;
                }
            }
        }

        private void textBox_ap_sendgain_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != '\b')//这是允许输入退格键  
            {
                int len = textBox_ap_sendgain.Text.Length;
                if (len < 1 && e.KeyChar == '0')
                {
                    e.Handled = true;
                }
                else if ((e.KeyChar < '0') || (e.KeyChar > '9'))//这是允许输入0-9数字  
                {
                    e.Handled = true;
                }
            }
        }

        private void textBox_ap_receiverefer_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != '\b')//这是允许输入退格键  
            {
                int len = textBox_ap_sendgain.Text.Length;
                if (len < 1 && e.KeyChar == '0')
                {
                    e.Handled = true;
                }
                else if (e.KeyChar == '-')
                {
                    e.Handled = false;
                }
                else if ((e.KeyChar < '0') || (e.KeyChar > '9'))//这是允许输入0-9数字  
                {
                    e.Handled = true;
                }
            }
        }

        private void textBox_fp_distance_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != '\b')//这是允许输入退格键  
            {
                int len = textBox_fp_distance.Text.Length;
                if (len < 1 && e.KeyChar == '0')
                {
                    e.Handled = true;
                }
                else if ((e.KeyChar < '0') || (e.KeyChar > '9'))//这是允许输入0-9数字  
                {
                    e.Handled = true;
                }
            }
        }

        private void textBox_fp_receivegain_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != '\b')//这是允许输入退格键  
            {
                int len = textBox_fp_receivegain.Text.Length;
                if (len < 1 && e.KeyChar == '0')
                {
                    e.Handled = true;
                }
                else if ((e.KeyChar < '0') || (e.KeyChar > '9'))//这是允许输入0-9数字  
                {
                    e.Handled = true;
                }
            }
        }

        private void textBox_simu_point_x_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != '\b')//这是允许输入退格键  
            {
                int len = textBox_simu_point_x.Text.Length;
                if (len < 1 && e.KeyChar == '0')
                {
                    e.Handled = true;
                }
                else if ((e.KeyChar < '0') || (e.KeyChar > '9'))//这是允许输入0-9数字  
                {
                    e.Handled = true;
                }
            }
        }

        private void textBox_simu_point_y_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != '\b')//这是允许输入退格键  
            {
                int len = textBox_simu_point_y.Text.Length;
                if (len < 1 && e.KeyChar == '0')
                {
                    e.Handled = true;
                }
                else if ((e.KeyChar < '0') || (e.KeyChar > '9'))//这是允许输入0-9数字  
                {
                    e.Handled = true;
                }
            }
        }

// ***********************************************************************************
// *图像绘制(位于panel_Graph) ********************************************************
// ***********************************************************************************

        // 图像绘制：

        // 配置图像绘制
        // 被场景配置的载入按钮、AP和FP的刷新按钮调用
        // CurrentUserInfo中有地图时绘制地图，信息为空时绘制空白背景
        // 包含draw_map()，draw_ap()，draw_fp()
        private void draw()
        {
            if (CurrentUserInfo.MapID != "")
            {
                draw_map();
                draw_ap();
                draw_fp();
            }
            else
            {
                draw_init();
            }
        }

        // 实验图像绘制
        // 包含draw_map()，darw_init()，draw_real()
        private void draws()
        {
            if (CurrentUserInfo.MapID != "")
            {
                draw_map();
                draw_real();
                draw_simu();
            }
            else
            {
                draw_init();
            }
        }

        // 图像绘制子模块：

        // 图像绘制-绘制地图
        private void draw_map()
        {
            Graphics graphics = panel_Graph.CreateGraphics();

            // 定点定义
            float x1 = 0;
            float y1 = 0;
            float x2 = 0;
            float y2 = 0;
            float x3 = 0;
            float y3 = 0;
            float x4 = 0;
            float y4 = 0;

            // 地图绘图区域大小 220*400, 矩形左上、右上、右下、左下依次为点p1, p2, p3, p4

            // 确定矩形四个顶点坐标
            if ((float)CurrentUserInfo.MapHeight / (float)CurrentUserInfo.MapWidth > (float)panel_Graph.Height / (float)panel_Graph.Width)
            {
                // 地图特别高 上下顶格
                y1 = 2;
                y2 = 2;
                y3 = panel_Graph.Height - 2;
                y4 = panel_Graph.Height - 2;

                float x = (float)panel_Graph.Height * (float)CurrentUserInfo.MapWidth / (float)CurrentUserInfo.MapHeight;
                x1 = (float)panel_Graph.Width / 2 - x / 2;
                x2 = (float)panel_Graph.Width / 2 + x / 2;
                x3 = (float)panel_Graph.Width / 2 + x / 2;
                x4 = (float)panel_Graph.Width / 2 - x / 2;
            }
            else
            {
                // 地图特别宽 左右顶格
                x1 = 2;
                x2 = panel_Graph.Width - 2;
                x3 = panel_Graph.Width- 2;
                x4 = 2;

                float y = (float)panel_Graph.Width * (float)CurrentUserInfo.MapHeight / (float)CurrentUserInfo.MapWidth;
                y1 = (float)panel_Graph.Height / 2 - y / 2;
                y2 = (float)panel_Graph.Height / 2 - y / 2;
                y3 = (float)panel_Graph.Height / 2 + y / 2;
                y4 = (float)panel_Graph.Height / 2 + y / 2;
            }

            // 绘制边框
            graphics.Clear(Color.FromArgb(255, 240, 240, 240));
            graphics.DrawLine(new Pen(Color.Black, 2), x1, y1, x2, y2);
            graphics.DrawLine(new Pen(Color.Black, 2), x2, y2, x3, y3);
            graphics.DrawLine(new Pen(Color.Black, 2), x3, y3, x4, y4);
            graphics.DrawLine(new Pen(Color.Black, 2), x4, y4, x1, y1);

            // 绘制坐标轴
            if (true == CurrentUserInfo.settings_showCoord)
            {
                Font font = new Font("宋体", 10, FontStyle.Regular);
                Brush bush = new SolidBrush(Color.DarkGray);
                graphics.DrawString("0", font, bush, x1 + 2, y1 + 2);
                graphics.DrawString((CurrentUserInfo.MapWidth / 2).ToString(), font, bush, x1 + (x2 - x1) / 2 - 10, y1 + 2);
                graphics.DrawString(CurrentUserInfo.MapWidth.ToString(), font, bush, x2 - 30, y1 + 2);
                graphics.DrawString("x", font, bush, x2 - 12, y1 - 15);
                graphics.DrawString((CurrentUserInfo.MapHeight / 2).ToString(), font, bush, x1 + 2, y1 + (y4 - y1) / 2 - 5);
                graphics.DrawString(CurrentUserInfo.MapHeight.ToString(), font, bush, x1 + 2, y4 - 14);
                graphics.DrawString("y", font, bush, x1 + 2, y4);
            }

            // 绘制场景图片
            //graphics.DrawImage(global::WifiFingerprintLocationSimulator.Properties.Resources._800400, x1, y1, x2-x1, y3-y2);
        }

        // 图像绘制-绘制AP
        private void draw_ap()
        {
            Graphics graphics = panel_Graph.CreateGraphics();

            // 定义点
            float x = 0;
            float y = 0;
            float x1 = 0;
            float y1 = 0;
            float x2 = 0;
            float y2 = 0;
            float x3 = 0;
            float y3 = 0;
            float x4 = 0;
            float y4 = 0;

            // 确定矩形四个顶点坐标
            if ((float)CurrentUserInfo.MapHeight / (float)CurrentUserInfo.MapWidth > (float)panel_Graph.Height / (float)panel_Graph.Width)
            {
                // 地图特别高 上下顶格
                y1 = 0;
                y2 = 0;
                y3 = panel_Graph.Height;
                y4 = panel_Graph.Height;

                float x0 = (float)panel_Graph.Height * (float)CurrentUserInfo.MapWidth / (float)CurrentUserInfo.MapHeight;
                x1 = (float)panel_Graph.Width / 2 - x0 / 2;
                x2 = (float)panel_Graph.Width / 2 + x0 / 2;
                x3 = (float)panel_Graph.Width / 2 + x0 / 2;
                x4 = (float)panel_Graph.Width / 2 - x0 / 2;
            }
            else
            {
                // 地图特别宽 左右顶格
                x1 = 0;
                x2 = panel_Graph.Width;
                x3 = panel_Graph.Width;
                x4 = 0;

                float y0 = (float)panel_Graph.Width * (float)CurrentUserInfo.MapHeight / (float)CurrentUserInfo.MapWidth;
                y1 = (float)panel_Graph.Height / 2 - y0 / 2;
                y2 = (float)panel_Graph.Height / 2 - y0 / 2;
                y3 = (float)panel_Graph.Height / 2 + y0 / 2;
                y4 = (float)panel_Graph.Height / 2 + y0 / 2;
            }

            try
            {
                // SQL
                string sql = "select ap_isrefer, ap_x, ap_y from ap_info where map_id ='" + CurrentUserInfo.MapID + "'";

                // DataRead Process
                MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                conn.Open();
                MySqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = sql;
                MySqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    float ap_x = (float)Convert.ToInt32(sdr.GetString(sdr.GetOrdinal("ap_x")));
                    float ap_y = (float)Convert.ToInt32(sdr.GetString(sdr.GetOrdinal("ap_y")));
                    string ap_isrefer = sdr.GetString(sdr.GetOrdinal("ap_isrefer"));

                    // 计算点实际坐标
                    x = ap_x * (x2 - x1) / CurrentUserInfo.MapWidth + x1;
                    y = ap_y * (y3 - y2) / CurrentUserInfo.MapHeight + y1;

                    // 绘制AP节点
                    if ("是" == ap_isrefer) // 参考节点
                    {
                        Rectangle rect = new Rectangle((int)x - 4, (int)y - 4, 8, 8);
                        graphics.DrawEllipse(new Pen(Color.Blue), rect);
                        graphics.FillEllipse(new SolidBrush(Color.Red), rect);
                        if (true == CurrentUserInfo.settings_showAPRadio)
                        {
                            Rectangle rect2 = new Rectangle((int)x - 8, (int)y - 8, 16, 16);
                            graphics.DrawEllipse(new Pen(Color.Red), rect2);
                            Rectangle rect3 = new Rectangle((int)x - 20, (int)y - 20, 40, 40);
                            graphics.DrawEllipse(new Pen(Color.MediumVioletRed), rect3);
                            Rectangle rect4 = new Rectangle((int)x - 50, (int)y - 50, 100, 100);
                            graphics.DrawEllipse(new Pen(Color.PaleVioletRed), rect4);
                        }
                    }
                    else // 其他节点
                    {
                        Rectangle rect = new Rectangle((int)x - 4, (int)y - 4, 8, 8);
                        graphics.DrawEllipse(new Pen(Color.Blue), rect);
                        graphics.FillEllipse(new SolidBrush(Color.Black), rect);
                        if (true == CurrentUserInfo.settings_showAPRadio)
                        {
                            Rectangle rect2 = new Rectangle((int)x - 8, (int)y - 8, 16, 16);
                            graphics.DrawEllipse(new Pen(Color.Black), rect2);
                            Rectangle rect3 = new Rectangle((int)x - 20, (int)y - 20, 40, 40);
                            graphics.DrawEllipse(new Pen(Color.LightGray), rect3);
                            Rectangle rect4 = new Rectangle((int)x - 50, (int)y - 50, 100, 100);
                            graphics.DrawEllipse(new Pen(Color.LightGray), rect4);
                        }
                    }
                }
                conn.Close();
            }
            catch
            {
                MessageBox.Show("Error !");
            }
        }

        // 图像绘制-绘制FP
        private void draw_fp()
        {
            Graphics graphics = panel_Graph.CreateGraphics();

            // 定义点
            float x = 0;
            float y = 0;
            float x1 = 0;
            float y1 = 0;
            float x2 = 0;
            float y2 = 0;
            float x3 = 0;
            float y3 = 0;
            float x4 = 0;
            float y4 = 0;

            // 确定矩形四个顶点坐标
            if ((float)CurrentUserInfo.MapHeight / (float)CurrentUserInfo.MapWidth > (float)panel_Graph.Height / (float)panel_Graph.Width)
            {
                // 地图特别高 上下顶格
                y1 = 0;
                y2 = 0;
                y3 = panel_Graph.Height;
                y4 = panel_Graph.Height;

                float x0 = (float)panel_Graph.Height * (float)CurrentUserInfo.MapWidth / (float)CurrentUserInfo.MapHeight;
                x1 = (float)panel_Graph.Width / 2 - x0 / 2;
                x2 = (float)panel_Graph.Width / 2 + x0 / 2;
                x3 = (float)panel_Graph.Width / 2 + x0 / 2;
                x4 = (float)panel_Graph.Width / 2 - x0 / 2;
            }
            else
            {
                // 地图特别宽 左右顶格
                x1 = 0;
                x2 = panel_Graph.Width;
                x3 = panel_Graph.Width;
                x4 = 0;

                float y0 = (float)panel_Graph.Width * (float)CurrentUserInfo.MapHeight / (float)CurrentUserInfo.MapWidth;
                y1 = (float)panel_Graph.Height / 2 - y0 / 2;
                y2 = (float)panel_Graph.Height / 2 - y0 / 2;
                y3 = (float)panel_Graph.Height / 2 + y0 / 2;
                y4 = (float)panel_Graph.Height / 2 + y0 / 2;
            }

            try
            {
                // SQL
                string sql = "select fp_x, fp_y from fp_info where map_id ='" + CurrentUserInfo.MapID + "'";

                // DataRead Process
                MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                conn.Open();
                MySqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = sql;
                MySqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    float fp_x = (float)Convert.ToInt32(sdr.GetString(sdr.GetOrdinal("fp_x")));
                    float fp_y = (float)Convert.ToInt32(sdr.GetString(sdr.GetOrdinal("fp_y")));

                    // 计算点实际坐标
                    x = fp_x * (x2 - x1) / CurrentUserInfo.MapWidth + x1;
                    y = fp_y * (y3 - y2) / CurrentUserInfo.MapHeight + y1;

                    // 绘制FP节点
                    Rectangle rect = new Rectangle((int)x - 1, (int)y - 1, 2, 2);
                    graphics.DrawEllipse(new Pen(Color.DarkGreen), rect);
                    graphics.FillEllipse(new SolidBrush(Color.Black), rect);

                }
                conn.Close();
            }
            catch
            {
                MessageBox.Show("Error !");
            }
        }

        // 图像绘制-绘制空白背景
        private void draw_init()
        {
            Graphics graphics = panel_Graph.CreateGraphics();
            graphics.Clear(Color.FromArgb(255, 240, 240, 240));
        }

        // 图像绘制-绘制实际路线
        private void draw_real()
        {
            Graphics graphics = panel_Graph.CreateGraphics();

            // 定义点
            float x = 0;
            float y = 0;
            float x1 = 0;
            float y1 = 0;
            float x2 = 0;
            float y2 = 0;
            float x3 = 0;
            float y3 = 0;
            float x4 = 0;
            float y4 = 0;

            // 确定矩形四个顶点坐标
            if ((float)CurrentUserInfo.MapHeight / (float)CurrentUserInfo.MapWidth > (float)panel_Graph.Height / (float)panel_Graph.Width)
            {
                // 地图特别高 上下顶格
                y1 = 0;
                y2 = 0;
                y3 = panel_Graph.Height;
                y4 = panel_Graph.Height;

                float x0 = (float)panel_Graph.Height * (float)CurrentUserInfo.MapWidth / (float)CurrentUserInfo.MapHeight;
                x1 = (float)panel_Graph.Width / 2 - x0 / 2;
                x2 = (float)panel_Graph.Width / 2 + x0 / 2;
                x3 = (float)panel_Graph.Width / 2 + x0 / 2;
                x4 = (float)panel_Graph.Width / 2 - x0 / 2;
            }
            else
            {
                // 地图特别宽 左右顶格
                x1 = 0;
                x2 = panel_Graph.Width;
                x3 = panel_Graph.Width;
                x4 = 0;

                float y0 = (float)panel_Graph.Width * (float)CurrentUserInfo.MapHeight / (float)CurrentUserInfo.MapWidth;
                y1 = (float)panel_Graph.Height / 2 - y0 / 2;
                y2 = (float)panel_Graph.Height / 2 - y0 / 2;
                y3 = (float)panel_Graph.Height / 2 + y0 / 2;
                y4 = (float)panel_Graph.Height / 2 + y0 / 2;
            }

            try
            {
                // SQL
                string sql = "select real_x, real_y from simu_info where map_id ='" + CurrentUserInfo.MapID + "'";

                // DataRead Process
                MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                conn.Open();
                MySqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = sql;
                MySqlDataReader sdr = cmd.ExecuteReader();

                // 暂存上一顶点
                float lastpoint_x = 0;
                float lastpoint_y = 0;

                while (sdr.Read())
                {
                    float real_x = (float)Convert.ToInt32(sdr.GetString(sdr.GetOrdinal("real_x")));
                    float real_y = (float)Convert.ToInt32(sdr.GetString(sdr.GetOrdinal("real_y")));

                    // 计算点实际坐标
                    x = real_x * (x2 - x1) / CurrentUserInfo.MapWidth + x1;
                    y = real_y * (y3 - y2) / CurrentUserInfo.MapHeight + y1;

                    // 绘制实验坐标点
                    Rectangle rect = new Rectangle((int)x - 2, (int)y - 2, 4, 4);
                    graphics.DrawEllipse(new Pen(Color.DarkGreen), rect);
                    graphics.FillEllipse(new SolidBrush(Color.Black), rect);

                    if (0 != lastpoint_x)
                    {
                        // 绘制实验路径
                        graphics.DrawLine(new Pen(Color.Red, 1), x, y, lastpoint_x, lastpoint_y);
                    }

                    lastpoint_x = x;
                    lastpoint_y = y;
                }
                conn.Close();
            }
            catch
            {
                MessageBox.Show("Error !");
            }
        }

        // 图像绘制-绘制仿真路线
        private void draw_simu()
        {

        }

// ***********************************************************************************
// *环境配置-场景配置 ****************************************************************
// ***********************************************************************************

        // 环境配置-场景配置 listView布局初始化时载入用户信息
        private void listView_map_Layout(object sender, LayoutEventArgs e)
        {
            button_map_refresh_Click(new object(), new EventArgs());
        }

        // 环境配置-场景配置 刷新按钮
        private void button_map_refresh_Click(object sender, EventArgs e)
        {
            button_map_delete.Enabled = false;
            button_map_load.Enabled = false;
            button_map_modify.Enabled = false;

            try
            {
                // SQL
                string sql = "select map_id, map_name, map_width, map_height, map_info, reg_date from map_info where user_id = " + CurrentUserInfo.Id;

                // DataRead Process
                MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                conn.Open();
                MySqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = sql;

                MySqlDataReader sdr = cmd.ExecuteReader();

                listView_map.Items.Clear();

                while (sdr.Read())
                {
                    string map_name = sdr.GetString(sdr.GetOrdinal("map_name"));
                    string map_width = sdr.GetString(sdr.GetOrdinal("map_width"));
                    string map_height = sdr.GetString(sdr.GetOrdinal("map_height"));
                    string map_info = sdr.GetString(sdr.GetOrdinal("map_info"));
                    string reg_date = sdr.GetString(sdr.GetOrdinal("reg_date"));


                    ListViewItem item = new ListViewItem(map_name);
                    item.SubItems.Add(map_width);
                    item.SubItems.Add(map_height);
                    item.SubItems.Add(map_info);
                    item.SubItems.Add(reg_date);
                    listView_map.Items.Add(item);
                }
                conn.Close();
            }
            catch
            {
                MessageBox.Show("Error !");
            }

            // 地图绘制
            // 如果是通过载入地图进入的，则跳过绘制地图过程
            if (sender.ToString() != "System.Object")
            {
                draw();
            }
        }

        // 环境配置-场景配置 listView选中时激活按钮
        private void listView_map_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listView_map.SelectedItems.Count > 0)
            {
                button_map_delete.Enabled = true;
                button_map_load.Enabled = true;
                button_map_modify.Enabled = false;
            }
            else
            {
                button_map_delete.Enabled = false;
                button_map_load.Enabled = false;
                button_map_modify.Enabled = false;
            }
        }

        // 环境配置-场景配置 删除地图信息
        private void map_delete()
        {
            string MapName = listView_map.SelectedItems[0].SubItems[0].Text;

            try
            {
                // SQL
                string sql = "delete from map_info where map_name = '" + MapName + "' and user_id = " + CurrentUserInfo.Id;

                // DataRead Process
                MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(sql, conn);

                if (MessageBox.Show("确定要删除地图 " + MapName + " 及其所有数据?", "提示", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    int i = 0;
                    i = cmd.ExecuteNonQuery();

                    MessageBox.Show("地图 " + MapName + " 已删除!");

                    conn.Close();
                    button_map_refresh_Click(new object(), new EventArgs());
                }
            }
            catch
            {
                MessageBox.Show("Error !");
            }
        }

        // 环境配置-场景配置 删除按钮
        private void button_map_delete_Click(object sender, EventArgs e)
        {
            // Log
            LogHelper.generateLog("[场景配置] " + CurrentUserInfo.Name + " 删除了地图 " + textBox_map_name.Text + "及其实验数据");

            // 清空该地图AP数据
            ap_delete();

            // 清空该地图FP数据
            fp_delete();

            // 清空该地图RSS数据
            rss_delete();

            // 清空地图实验数据
            simu_delete();

            // 清空地图数据 (一定要最后进行，之前需要用到CurrentUserInfo信息)
            map_delete();

            // 清空CurrentUserInfo记录信息
            CurrentUserInfo.MapID = "";
            CurrentUserInfo.MapWidth = 0;
            CurrentUserInfo.MapHeight = 0;
            CurrentUserInfo.ApID = "";

            // 清空所有控件内的显示内容
            textBox_map_name.Text = "";
            textBox_ap_map.Text = "";
            textBox_fp_map.Text = "";
            textBox_rss_map.Text = "";
            textBox_map_width.Text = "";
            textBox_map_height.Text = "";
            textBox_map_note.Text = "";

            textBox_ap_x.Text = "";
            textBox_ap_y.Text = "";
            textBox_ap_sendpower.Text = "";
            textBox_ap_sendgain.Text = "";
            textBox_ap_receiverefer.Text = "";
            textBox_fp_distance.Text = "";
            textBox_fp_receivegain.Text = "";

            textBox_simu_lastpoint_x.Text = "";
            textBox_simu_lastpoint_y.Text = "";
            textBox_simu_mapsize_x.Text = "";
            textBox_simu_mapsize_y.Text = "";
            textBox_simu_point_x.Text = "";
            textBox_simu_point_y.Text = "";


            // 执行一遍刷新
            button_ap_refresh_Click(new object(), new EventArgs());
            button_fp_refresh_Click(new object(), new EventArgs());
            button_rss_refresh_Click(new object(), new EventArgs());
            button_map_refresh_Click(new object(), new EventArgs());

            draw();
        }

        // 环境配置-场景配置 载入按钮
        private void button_map_load_Click(object sender, EventArgs e)
        {
            // 填写当前地图信息到相应textView
            textBox_map_name.Text = listView_map.SelectedItems[0].SubItems[0].Text;
            textBox_ap_map.Text = listView_map.SelectedItems[0].SubItems[0].Text;
            textBox_fp_map.Text = listView_map.SelectedItems[0].SubItems[0].Text;
            textBox_rss_map.Text = listView_map.SelectedItems[0].SubItems[0].Text;
            textBox_map_width.Text = listView_map.SelectedItems[0].SubItems[1].Text;
            textBox_map_height.Text = listView_map.SelectedItems[0].SubItems[2].Text;
            textBox_map_note.Text = listView_map.SelectedItems[0].SubItems[3].Text;
            textBox_simu_mapsize_x.Text = listView_map.SelectedItems[0].SubItems[1].Text;
            textBox_simu_mapsize_y.Text = listView_map.SelectedItems[0].SubItems[2].Text;

            // 清空其余textView
            textBox_ap_x.Text = "";
            textBox_ap_y.Text = "";
            textBox_ap_sendpower.Text = "";
            textBox_ap_sendgain.Text = "";
            textBox_fp_distance.Text = "";
            textBox_fp_receivegain.Text = "";

            // 将当前载入地图数据存入CurrentUserInfo
            try
            {
                // SQL
                string sql = "select * from map_info where map_name = '" + textBox_map_name.Text + "' and user_id = " + CurrentUserInfo.Id;
               
                // DataRead Process
                MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                
                MySqlDataReader sdr = cmd.ExecuteReader();
                sdr.Read();
                CurrentUserInfo.MapID = sdr.GetString(sdr.GetOrdinal("map_id"));
                CurrentUserInfo.MapWidth = Convert.ToInt32(sdr.GetString(sdr.GetOrdinal("map_width")));
                CurrentUserInfo.MapHeight = Convert.ToInt32(sdr.GetString(sdr.GetOrdinal("map_height")));
                conn.Close();

                // Log
                LogHelper.generateLog("[场景配置] " + "地图 " + textBox_map_name.Text + " 已载入");
                //MessageBox.Show("载入成功！");
            }
            catch
            {
                MessageBox.Show("Error !");
            }

            // 数据库操作
            // 载入AP节点列表
            button_ap_refresh_Click(new object(), new EventArgs());
            // 载入指纹节点列表
            button_fp_refresh_Click(new object(), new EventArgs());
            // 载入RSS信息列表
            button_rss_refresh_Click(new object(), new EventArgs());
            // 载入实验数据列表
            button_simu_refresh_Click(new object(), new EventArgs());

            // 地图绘制
            draw();

            button_map_refresh_Click(new object(), new EventArgs());
            button_map_modify.Enabled = true;
        }

        // 环境配置-场景配置 listView双击 载入地图
        private void listView_map_ItemActivate(object sender, EventArgs e)
        {
            button_map_load_Click(new object(), new EventArgs());
        }

        // 环境配置-场景配置 添加按钮
        private void button_map_add_Click(object sender, EventArgs e)
        {
            if (textBox_map_name.Text == "")
                MessageBox.Show("地图名不能为空");
            else if (textBox_map_width.Text == "")
                MessageBox.Show("请输入地图宽度");
            else if (textBox_map_height.Text == "")
                MessageBox.Show("请输入地图高度");
            else
            {
                // 用户类型字符串
                string MapName = textBox_map_name.Text;

                try
                {
                    // SQL
                    string sql = "insert into map_info (map_name, map_width, map_height, map_info, reg_date, user_id) values('" + textBox_map_name.Text + "','" + textBox_map_width.Text + "','" + textBox_map_height.Text + "','" + textBox_map_note.Text + "','" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "'," + CurrentUserInfo.Id + ")";
                    string sql_check = "select * from map_info where map_name = '" + textBox_map_name.Text + "' and user_id = " + CurrentUserInfo.Id;

                    // DataRead Process
                    MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                    MySqlConnection conn_check = new MySqlConnection(MySqlHelper.Conn);
                    conn.Open();
                    conn_check.Open();
                    MySqlCommand cmd = new MySqlCommand(sql, conn);
                    MySqlCommand cmd_check = new MySqlCommand(sql_check, conn_check); // 检查该地图名是否存在

                    MySqlDataReader sdr = cmd_check.ExecuteReader();
                    if (!sdr.Read()) // 数据库中无此地图名
                    {
                        int i = 0;
                        i = cmd.ExecuteNonQuery();

                        if (i > 0)
                        {
                            // Log
                            LogHelper.generateLog("[场景配置] " + CurrentUserInfo.Name + " 添加了地图 " + textBox_map_name.Text);

                            MessageBox.Show("地图 " + textBox_map_name.Text + " 添加成功!");
                        }
                        else
                        {
                            MessageBox.Show("添加失败！");
                        }
                    }
                    else
                    {
                        MessageBox.Show("该地图已存在！");
                    }

                    conn.Close();
                }
                catch
                {
                    MessageBox.Show("Error !");
                }

                button_map_refresh_Click(new object(), new EventArgs());
            }
        }

        // 环境配置-场景配置 修改按钮可用时 停用地图名称编辑
        private void button_map_modify_EnabledChanged(object sender, EventArgs e)
        {
            if (button_map_modify.Enabled == false)
                textBox_map_name.Enabled = true;
            else if (button_map_modify.Enabled == true)
                textBox_map_name.Enabled = false;
        }

        // 环境配置-场景配置 修改按钮
        private void button_map_modify_Click(object sender, EventArgs e)
        {
            try
            {
                // SQL
                string sql = "update map_info set map_width = " + textBox_map_width.Text + ", map_height = " + textBox_map_height.Text + ", map_info ='" + textBox_map_note.Text + "', reg_date = '" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "' where map_name = '" + textBox_map_name.Text + "'";

                // DataRead Process
                MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(sql, conn);

                if (MessageBox.Show("确定要修改地图 " + textBox_map_name.Text + " 的信息吗? 如果修改了地图尺寸，该地图记录的实验数据会被清空!", "提示", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    int i = 0;
                    i = cmd.ExecuteNonQuery();

                    if (i > 0)
                    {
                        // 修改了尺寸
                        if (Convert.ToInt32(textBox_map_width.Text) != CurrentUserInfo.MapWidth || Convert.ToInt32(textBox_map_height.Text) != CurrentUserInfo.MapHeight)
                        {
                            // 清除当前地图数据
                            ap_delete();
                            fp_delete();
                            rss_delete();

                            // Log
                            LogHelper.generateLog("[场景配置] " + CurrentUserInfo.Name + " 修改了地图 " + textBox_map_name.Text + "的数据");

                            MessageBox.Show("地图 " + textBox_map_name.Text + " 数据已更新! 实验数据已清除!");
                            CurrentUserInfo.MapWidth = Convert.ToInt32(textBox_map_width.Text);
                            CurrentUserInfo.MapHeight = Convert.ToInt32(textBox_map_height.Text);
                        }
                        // 仅修改备注
                        else
                        {
                            // Log
                            LogHelper.generateLog("[场景配置] " + CurrentUserInfo.Name + " 修改了地图 " + textBox_map_name.Text + "的备注信息");

                            MessageBox.Show("地图 " + textBox_map_name.Text + " 备注信息修改成功!");
                        }
                    }
                    else
                    {
                        MessageBox.Show("更新失败！");
                    }
                }
                conn.Close();
                button_map_refresh_Click(new object(), new EventArgs());
                button_ap_refresh_Click(new object(), new EventArgs());
                button_fp_refresh_Click(new object(), new EventArgs());
                button_rss_refresh_Click(new object(), new EventArgs());

            }
            catch
            {
                MessageBox.Show("Error !");
            }
        }


// ***********************************************************************************
// *环境配置-AP节点配置 **************************************************************
// ***********************************************************************************

        // 环境配置-AP节点配置 刷新按钮
        private void button_ap_refresh_Click(object sender, EventArgs e)
        {
            if (CurrentUserInfo.MapID != "")
            {
                button_ap_delete.Enabled = false;
                button_ap_modify.Enabled = false;

                try
                {
                    string MapName = textBox_map_name.Text;

                    // SQL
                    string sql = "select * from ap_info where map_id ='" + CurrentUserInfo.MapID + "'";

                    // DataRead Process
                    MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                    conn.Open();
                    MySqlCommand cmd = conn.CreateCommand();
                    cmd.CommandText = sql;

                    MySqlDataReader sdr = cmd.ExecuteReader();

                    listView_ap.Items.Clear();

                    while (sdr.Read())
                    {
                        string ap_isrefer = "";
                        string ap_receiverefer = "";

                        string ap_id = sdr.GetString(sdr.GetOrdinal("ap_id"));
                        if (!sdr.IsDBNull(sdr.GetOrdinal("ap_isrefer")))
                        {
                            ap_isrefer = sdr.GetString(sdr.GetOrdinal("ap_isrefer"));
                        }
                        string ap_x = sdr.GetString(sdr.GetOrdinal("ap_x"));
                        string ap_y = sdr.GetString(sdr.GetOrdinal("ap_y"));
                        string ap_sendpower = sdr.GetString(sdr.GetOrdinal("ap_sendpower"));
                        string ap_sendgain = sdr.GetString(sdr.GetOrdinal("ap_sendgain"));
                        if (!sdr.IsDBNull(sdr.GetOrdinal("ap_receiverefer")))
                        {
                            ap_receiverefer = sdr.GetString(sdr.GetOrdinal("ap_receiverefer"));
                        }
                        string reg_date = sdr.GetString(sdr.GetOrdinal("reg_date"));


                        ListViewItem item = new ListViewItem(ap_id);
                        item.SubItems.Add(ap_isrefer);
                        item.SubItems.Add(ap_x);
                        item.SubItems.Add(ap_y);
                        item.SubItems.Add(ap_sendpower);
                        item.SubItems.Add(ap_sendgain);
                        item.SubItems.Add(ap_receiverefer);
                        item.SubItems.Add(reg_date);
                        listView_ap.Items.Add(item);
                    }
                    conn.Close();
                }
                catch
                {
                    MessageBox.Show("Error !");
                }

                // 地图绘制
                // 如果是通过载入地图进入的，则跳过绘制地图过程
                if (sender.ToString() != "System.Object")
                {
                    draw();
                }
            }
            else
            {
                listView_ap.Items.Clear();
            }
        }

        // 环境配置-AP节点配置 listView布局初始化时停用修改删除按钮
        private void listView_ap_Layout(object sender, LayoutEventArgs e)
        {
            button_ap_delete.Enabled = false;
            button_ap_modify.Enabled = false;
        }

        // 环境配置-AP节点配置 listView选中时激活按钮
        private void listView_ap_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listView_ap.SelectedItems.Count > 0)
            {
                button_ap_delete.Enabled = true;
                button_ap_modify.Enabled = false;
            }
            else
            {
                button_ap_delete.Enabled = false;
                button_ap_modify.Enabled = false;
            }
        }

        // 环境配置-AP节点配置 listView双击 载入ap节点信息
        private void listView_ap_ItemActivate(object sender, EventArgs e)
        {
            if ("" == listView_ap.SelectedItems[0].SubItems[1].Text)
            {
                checkBox_ap_isrefer.CheckState = CheckState.Unchecked;
            }
            else
            {
                checkBox_ap_isrefer.CheckState = CheckState.Checked;
            }
            textBox_ap_x.Text = listView_ap.SelectedItems[0].SubItems[2].Text;
            textBox_ap_y.Text = listView_ap.SelectedItems[0].SubItems[3].Text;
            textBox_ap_sendpower.Text = listView_ap.SelectedItems[0].SubItems[4].Text;
            textBox_ap_sendgain.Text = listView_ap.SelectedItems[0].SubItems[5].Text;
            textBox_ap_receiverefer.Text = listView_ap.SelectedItems[0].SubItems[6].Text;
            CurrentUserInfo.ApID = listView_ap.SelectedItems[0].SubItems[0].Text;

            // 使参数为非 new object()，触发刷新
            object o = new Button();
            button_ap_refresh_Click(o, new EventArgs());
            button_ap_modify.Enabled = true;
        }

        // 环境配置-AP节点配置 清空按钮
        private void button_ap_deleteall_Click(object sender, EventArgs e)
        {
            if (textBox_map_name.Text == "")
                MessageBox.Show("请先载入地图！");
            else if (MessageBox.Show("确定要删除地图 " + textBox_map_name.Text + " 的所有AP节点数据?", "提示", MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                ap_delete();

                // Log
                LogHelper.generateLog("[AP节点配置] " + CurrentUserInfo.Name + " 清空了地图 " + textBox_map_name.Text + " 的所有节点");

                MessageBox.Show("所有节点已删除!");
            }
        }

        // 环境配置-AP节点配置 添加按钮
        private void button_ap_add_Click(object sender, EventArgs e)
        {
            if(textBox_map_name.Text == "")
                MessageBox.Show("请先载入地图！");
            else if (textBox_ap_x.Text == "")
                MessageBox.Show("请输入AP节点x坐标");
            else if (textBox_ap_y.Text == "")
                MessageBox.Show("请输入AP节点y坐标");
            else if (textBox_ap_sendpower.Text == "")
                MessageBox.Show("请输入AP节点发送功率");
            else if (textBox_ap_sendgain.Text == "")
                MessageBox.Show("请输入AP节点发送增益");
            else if (Convert.ToInt32(textBox_ap_x.Text) < 0 || Convert.ToInt32(textBox_ap_x.Text) > CurrentUserInfo.MapWidth || Convert.ToInt32(textBox_ap_y.Text) < 0 || Convert.ToInt32(textBox_ap_y.Text) > CurrentUserInfo.MapHeight)
                MessageBox.Show("请输入地图范围内的坐标值(0<x<" + CurrentUserInfo.MapWidth + ", 0<y<" + CurrentUserInfo.MapHeight + ")");
            else if (0 == listView_ap.Items.Count && CheckState.Unchecked == checkBox_ap_isrefer.CheckState)
                MessageBox.Show("请先添加一个参考节点");
            else if (checkBox_ap_isrefer.CheckState == CheckState.Unchecked &&  textBox_ap_receiverefer.Text == "")
                MessageBox.Show("请输入节点接收参考节点的信号强度");
            else
            {
                // ***参考节点***
                if (CheckState.Checked == checkBox_ap_isrefer.CheckState)
                {
                    //try
                    {
                        // SQL
                        string sql = "insert into ap_info (ap_isrefer, map_id, ap_x, ap_y, ap_sendpower, ap_sendgain, reg_date) values('" + "是" + "','" + CurrentUserInfo.MapID + "','" + textBox_ap_x.Text + "','" + textBox_ap_y.Text + "','" + textBox_ap_sendpower.Text + "','" + textBox_ap_sendgain.Text + "','" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "')";
                        string sql_check = "select * from ap_info where map_id = '" + CurrentUserInfo.MapID + "' and ap_isrefer = '" + "是" + "'";

                        // DataRead Process
                        MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                        MySqlConnection conn_check = new MySqlConnection(MySqlHelper.Conn);
                        conn.Open();
                        conn_check.Open();
                        MySqlCommand cmd = new MySqlCommand(sql, conn);
                        MySqlCommand cmd_check = new MySqlCommand(sql_check, conn_check); // 检查是否已有参考节点

                        MySqlDataReader sdr = cmd_check.ExecuteReader();
                        if (!sdr.Read()) // 数据库中无参考节点
                        {
                            int i = 0;
                            i = cmd.ExecuteNonQuery();

                            if (i > 0)
                            {
                                // Log
                                LogHelper.generateLog("[AP节点配置] " + CurrentUserInfo.Name + " 在地图 " + textBox_map_name.Text + " 中增加了参考节点");

                                MessageBox.Show("参考节点添加成功!");
                            }
                            else
                            {
                                MessageBox.Show("添加失败！");
                            }
                        }
                        else
                        {
                            MessageBox.Show("已经添加了一个参考节点！");
                        }

                        conn.Close();
                    }
                    //catch
                    {
                    //    MessageBox.Show("Error !");
                    }
                }
                // ***其他节点***
                else
                {
                    try
                    {
                        // SQL
                        string sql = "insert into ap_info (map_id, ap_x, ap_y, ap_sendpower, ap_sendgain, ap_receiverefer, reg_date) values('" + CurrentUserInfo.MapID + "','" + textBox_ap_x.Text + "','" + textBox_ap_y.Text + "','" + textBox_ap_sendpower.Text + "','" + textBox_ap_sendgain.Text + "','" + textBox_ap_receiverefer.Text + "','" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "')";

                        // DataRead Process
                        MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                        conn.Open();
                        MySqlCommand cmd = new MySqlCommand(sql, conn);
                        int i = 0;
                        i = cmd.ExecuteNonQuery();

                        if (i > 0)
                        {
                            // Log
                            LogHelper.generateLog("[AP节点配置] " + CurrentUserInfo.Name + " 在地图 " + textBox_map_name.Text + " 中增加了一个节点");
                            MessageBox.Show("节点添加成功!");
                        }
                        else
                        {
                            MessageBox.Show("添加失败！");
                        }
                        conn.Close();
                    }
                    catch
                    {
                        MessageBox.Show("Error !");
                    }
                }

                // 使参数为非 new object()，触发刷新
                object o = new Button();
                button_ap_refresh_Click(o, new EventArgs());
            }
        }

        // 环境配置-AP节点配置 清空AP数据(当前地图)
        private void ap_delete()
        {
            try
            {
                // SQL
                string sql = "delete from ap_info where map_id = '" + CurrentUserInfo.MapID + "'";

                // DataRead Process
                MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(sql, conn);

                int i = 0;
                i = cmd.ExecuteNonQuery();

                conn.Close();
                // 使参数为非 new object()，触发刷新
                object o = new Button();
                button_ap_refresh_Click(o, new EventArgs());
                
            }
            catch
            {
                MessageBox.Show("Error !");
            }
        }

        // 环境配置-AP节点配置 删除按钮
        private void button_ap_delete_Click(object sender, EventArgs e)
        {
            if (textBox_map_name.Text == "")
                MessageBox.Show("请先载入地图！");
            else
                try
            {
                // SQL
                string sql = "delete from ap_info where ap_id = '" + listView_ap.SelectedItems[0].SubItems[0].Text + "'";

                // DataRead Process
                MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(sql, conn);

                if (MessageBox.Show("确定要删除AP节点 " + listView_ap.SelectedItems[0].SubItems[0].Text + " ?", "提示", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    int i = 0;
                    i = cmd.ExecuteNonQuery();

                    if (i > 0)
                    {
                        // Log
                        LogHelper.generateLog("[AP节点配置] " + CurrentUserInfo.Name + " 在地图 " + textBox_map_name.Text + " 中删除了节点" + listView_ap.SelectedItems[0].SubItems[0].Text);
                        MessageBox.Show("节点已删除!");
                    }
                    else
                    {
                        MessageBox.Show("删除失败！");
                    }

                    conn.Close();
                    // 使参数为非 new object()，触发刷新
                    object o = new Button();
                    button_ap_refresh_Click(o, new EventArgs());
                }
            }
            catch
            {
                MessageBox.Show("Error !");
            }
        }

        // 环境配置-AP节点配置 修改按钮
        private void button_ap_modify_Click(object sender, EventArgs e)
        {
            if (textBox_map_name.Text == "")
                MessageBox.Show("请先载入地图！");
            else
                try
            {
                // SQL
                string sql = "update ap_info set ap_x = " + textBox_ap_x.Text + ", ap_y = " + textBox_ap_y.Text + ", ap_sendpower =" + textBox_ap_sendpower.Text + ", ap_sendgain =" + textBox_ap_sendgain.Text + ", reg_date = '" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "' where ap_id = '" + CurrentUserInfo.ApID + "'";

                // DataRead Process
                MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(sql, conn);

                int i = 0;
                i = cmd.ExecuteNonQuery();

                if (i > 0)
                {
                    // Log
                    LogHelper.generateLog("[AP节点配置] " + CurrentUserInfo.Name + " 在地图 " + textBox_map_name.Text + " 中修改了节点" + CurrentUserInfo.ApID);
                    MessageBox.Show("节点 " + CurrentUserInfo.ApID + " 数据已更新!");
                }
                else
                {
                    MessageBox.Show("更新失败！");
                }

                conn.Close();
                button_ap_refresh_Click(new object(), new EventArgs());

            }
            catch
            {
                MessageBox.Show("Error !");
            }
        }

        // 环境配置-AP节点配置 是否参考节点CheckBox
        private void checkBox_ap_isrefer_CheckedChanged(object sender, EventArgs e)
        {
            if (checkBox_ap_isrefer.CheckState == CheckState.Unchecked)
            {
                textBox_ap_receiverefer.Enabled = true;
                checkBox_ap_isrefer.Text = "否";
            }
            else
            {
                textBox_ap_receiverefer.Enabled = false;
                textBox_ap_receiverefer.Text = "";
                checkBox_ap_isrefer.Text = "是";
            }
        }

// ***********************************************************************************
// *环境配置-指纹节点配置 ************************************************************
// ***********************************************************************************

        // 环境配置-指纹节点配置 刷新按钮
        private void button_fp_refresh_Click(object sender, EventArgs e)
        {
            if (CurrentUserInfo.MapID != "")
            {
                try
                {
                    // SQL
                    string sql = "select * from fp_info where map_id ='" + CurrentUserInfo.MapID + "'";

                    // DataRead Process
                    MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                    conn.Open();
                    MySqlCommand cmd = conn.CreateCommand();
                    cmd.CommandText = sql;

                    MySqlDataReader sdr = cmd.ExecuteReader();

                    listView_fp.Items.Clear();

                    while (sdr.Read())
                    {
                        string fp_id = sdr.GetString(sdr.GetOrdinal("fp_id"));
                        string fp_x = sdr.GetString(sdr.GetOrdinal("fp_x"));
                        string fp_y = sdr.GetString(sdr.GetOrdinal("fp_y"));
                        string fp_receivegain = sdr.GetString(sdr.GetOrdinal("fp_receivegain"));
                        string reg_date = sdr.GetString(sdr.GetOrdinal("reg_date"));


                        ListViewItem item = new ListViewItem(fp_id);
                        item.SubItems.Add(fp_x);
                        item.SubItems.Add(fp_y);
                        item.SubItems.Add(fp_receivegain);
                        item.SubItems.Add(reg_date);
                        listView_fp.Items.Add(item);
                    }
                    conn.Close();
                }
                catch
                {
                    MessageBox.Show("Error !");
                }

                // 地图绘制
                // 如果是通过载入地图进入的，则跳过绘制地图过程
                if (sender.ToString() != "System.Object")
                {
                    draw();
                }
            }
            else
            {
                listView_fp.Items.Clear();
            }
        }

        // 环境配置-指纹节点配置 生成节点库按钮
        private void button_fp_autoadd_Click(object sender, EventArgs e)
        {
            if (textBox_map_name.Text == "")
                MessageBox.Show("请先载入地图！");
            else if (textBox_fp_distance.Text == "")
                MessageBox.Show("请输入节点间距");
            else if (textBox_fp_receivegain.Text == "")
                MessageBox.Show("请输入接收增益");
            else if (CurrentUserInfo.MapHeight > CurrentUserInfo.MapWidth ? Convert.ToInt32(textBox_fp_distance.Text) > CurrentUserInfo.MapWidth / 2 : Convert.ToInt32(textBox_fp_distance.Text) > CurrentUserInfo.MapHeight / 2)
                MessageBox.Show("所选节点间距过大，会影响实验结果，请重新输入。");
            else if (CurrentUserInfo.MapHeight > CurrentUserInfo.MapWidth ? Convert.ToInt32(textBox_fp_distance.Text) < CurrentUserInfo.MapWidth / 100 : Convert.ToInt32(textBox_fp_distance.Text) < CurrentUserInfo.MapHeight / 100)
                MessageBox.Show("所选节点间距过小，会影响系统性能，请重新输入。");
            else
            {
                // 清空之前所有指纹节点数据
                fp_delete();

                // 生成指纹节点坐标数组
                for (int i = Convert.ToInt32(textBox_fp_distance.Text); i < CurrentUserInfo.MapWidth; i += Convert.ToInt32(textBox_fp_distance.Text))
                    for (int j = Convert.ToInt32(textBox_fp_distance.Text); j < CurrentUserInfo.MapHeight; j += Convert.ToInt32(textBox_fp_distance.Text))
                    {
                        try
                        {
                            // SQL
                            string sql = "insert into fp_info (map_id, fp_x, fp_y, fp_receivegain, reg_date) values('" + CurrentUserInfo.MapID + "'," + i + "," + j + ",'" + textBox_fp_receivegain.Text + "','" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "')";

                            // DataRead Process
                            MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                            conn.Open();
                            MySqlCommand cmd = new MySqlCommand(sql, conn);
                            int k = 0;
                            k = cmd.ExecuteNonQuery();

                            if (k > 0)
                            {
                                // Log
                                LogHelper.generateLog("[指纹节点配置] " + CurrentUserInfo.Name + " 在地图 " + textBox_map_name.Text + " 中生成了指纹节点");

                                //  MessageBox.Show("已自动生成指纹节点!");
                            }
                            else
                            {
                                MessageBox.Show("生成失败！");
                            }
                            conn.Close();
                        }
                        catch
                        {
                                MessageBox.Show("Error !");
                        }
                    }

                // 使参数为非 new object()，触发刷新
                object o = new Button();
                button_fp_refresh_Click(o, new EventArgs());
            }
        }

        // 环境配置-指纹节点配置 清空指纹节点库(当前地图)
        private void fp_delete()
        {
            try
            {
                // SQL
                string sql = "delete from fp_info where map_id = '" + CurrentUserInfo.MapID + "'";

                // DataRead Process
                MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.ExecuteNonQuery();

                conn.Close();
            }
            catch
            {
                MessageBox.Show("Error !");
            }

            // 使参数为非 new object()，触发刷新
            object o = new Button();
            button_fp_refresh_Click(o, new EventArgs());
        }

// ***********************************************************************************
// *环境配置-RSS信息 *****************************************************************
// ***********************************************************************************

        // 环境配置-刷新按钮
        private void button_rss_refresh_Click(object sender, EventArgs e)
        {
            if (CurrentUserInfo.MapID != "")
            {
                try
                {
                    // SQL
                    string sql = "select * from rss_info where map_id ='" + CurrentUserInfo.MapID + "'";

                    // DataRead Process
                    MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                    conn.Open();
                    MySqlCommand cmd = conn.CreateCommand();
                    cmd.CommandText = sql;

                    MySqlDataReader sdr = cmd.ExecuteReader();

                    listView_rss.Items.Clear();

                    while (sdr.Read())
                    {
                        string rss_id = sdr.GetString(sdr.GetOrdinal("rss_id"));
                        string fp_id = sdr.GetString(sdr.GetOrdinal("fp_id"));
                        string ap_id = sdr.GetString(sdr.GetOrdinal("ap_id"));
                        string rss_receivepower = sdr.GetString(sdr.GetOrdinal("rss_receivepower"));
                        string reg_date = sdr.GetString(sdr.GetOrdinal("reg_date"));

                        ListViewItem item = new ListViewItem(rss_id);
                        item.SubItems.Add(fp_id);
                        item.SubItems.Add(ap_id);
                        item.SubItems.Add(rss_receivepower);
                        item.SubItems.Add(reg_date);
                        listView_rss.Items.Add(item);
                    }
                    conn.Close();
                }
                catch
                {
                    MessageBox.Show("Error !");
                }

                // 地图绘制
                // 如果是通过载入地图进入的，则跳过绘制地图过程
                if (sender.ToString() != "System.Object")
                {
                    draw();
                }
            }
            else
            {
                listView_rss.Items.Clear();
            }
        }

        // 环境配置-生成RSS库按钮
        private void button_rss_generate_Click(object sender, EventArgs e)
        {
            if (textBox_map_name.Text == "")
                MessageBox.Show("请先载入地图！");
            else {

            }
        }

        // 环境配置-指纹节点配置 清空RSS库(当前地图)
        private void rss_delete()
        {
            try
            {
                // SQL
                string sql = "delete from rss_info where map_id = '" + CurrentUserInfo.MapID + "'";

                // DataRead Process
                MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.ExecuteNonQuery();

                conn.Close();
            }
            catch
            {
                MessageBox.Show("Error !");
            }
            // 使参数为非 new object()，触发刷新
            object o = new Button();
            button_rss_refresh_Click(o, new EventArgs());
        }

// ***********************************************************************************
// *仿真实验-路线设置 ****************************************************************
// ***********************************************************************************

        // 路线设置-添加顶点按钮
        private void button_simu_add_Click(object sender, EventArgs e)
        {
            if (textBox_map_name.Text == "")
                MessageBox.Show("请先载入地图！");
            else if ("" == textBox_simu_point_x.Text || "" == textBox_simu_point_y.Text)
                MessageBox.Show("请输入完整的路径顶点信息!");
            else if (Convert.ToInt32(textBox_simu_point_x.Text) < 0 || Convert.ToInt32(textBox_simu_point_x.Text) > CurrentUserInfo.MapWidth || Convert.ToInt32(textBox_simu_point_y.Text) < 0 || Convert.ToInt32(textBox_simu_point_y.Text) > CurrentUserInfo.MapHeight)
                MessageBox.Show("请输入地图范围内的坐标值(0<x<" + CurrentUserInfo.MapWidth + ", 0<y<" + CurrentUserInfo.MapHeight + ")");
            // 输入顶点坐标数据有效
            else
            {
                // 有上一坐标，则生成区间点数据
                if ("" != textBox_simu_lastpoint_x.Text)
                {
                    // 此段路径两顶点坐标
                    int x_last = Convert.ToInt32(textBox_simu_lastpoint_x.Text);
                    int y_last = Convert.ToInt32(textBox_simu_lastpoint_y.Text);
                    int x = Convert.ToInt32(textBox_simu_point_x.Text);
                    int y = Convert.ToInt32(textBox_simu_point_y.Text);

                    // 路径距离
                    double distance = Math.Pow((x - x_last) * (x - x_last) + (y - y_last) * (y - y_last), 0.5);

                    // 生成的段中间点数(切分的段数-1)
                    int segment = (int)distance / 100;

                    // 生成路径节点坐标数组
                    for (int i = 1; i <= segment + 1; i ++)
                    {
                        // 新节点坐标
                        int x_new = 0;
                        int y_new = 0;

                        // 最后一个点应为输入的端点，或分段为0
                        if (i == segment + 1 || 0 == segment)
                        {
                            x_new = x;
                            y_new = y;
                        }
                        // 正常求解点坐标
                        else
                        {
                            x_new = x_last + (x - x_last) / segment * i;
                            y_new = y_last + (y - y_last) / segment * i;
                        }

                        // 如果最后一个中间点距离顶点太近，则不添加该点
                        if (i <= segment && Math.Pow((x - x_new) * (x - x_new) + (y - y_new) * (y - y_new), 0.5) <= 50)
                        {
                            continue;
                        }

                        try
                        {
                            // SQL
                            string sql = "insert into simu_info (map_id, real_x, real_y, reg_date) values('" + CurrentUserInfo.MapID + "'," + x_new + "," + y_new + ",'" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "')";

                            // DataRead Process
                            MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                            conn.Open();
                            MySqlCommand cmd = new MySqlCommand(sql, conn);
                            int k = 0;
                            k = cmd.ExecuteNonQuery();

                            if (k < 0)
                            {
                                MessageBox.Show("添加失败！");
                            }
                            conn.Close();
                        }
                        catch
                        {
                            MessageBox.Show("Error !");
                        }
                    }
                }
                // 没有上一坐标(无实验数据)，则仅创建一个新的点
                else
                {
                    try
                    {
                        // SQL
                        string sql = "insert into simu_info (map_id, real_x, real_y, reg_date) values('" + CurrentUserInfo.MapID + "','" + textBox_simu_point_x.Text + "','" + textBox_simu_point_y.Text + "','" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "')";

                        // DataRead Process
                        MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                        conn.Open();
                        MySqlCommand cmd = new MySqlCommand(sql, conn);
                        int i = 0;
                        i = cmd.ExecuteNonQuery();

                        if (i < 0)
                        {
                            MessageBox.Show("添加失败！");
                        }
                        conn.Close();
                    }
                    catch
                    {
                        MessageBox.Show("Error !");
                    }
                }

                // 替换上一顶点数据
                textBox_simu_lastpoint_x.Text = textBox_simu_point_x.Text;
                textBox_simu_lastpoint_y.Text = textBox_simu_point_y.Text;
                textBox_simu_point_x.Text = "";
                textBox_simu_point_y.Text = "";

                // Log
                LogHelper.generateLog("[路线设置] " + CurrentUserInfo.Name + " 在地图 " + textBox_map_name.Text + " 中添加了路线顶点(" + textBox_simu_mapsize_x.Text + "," + textBox_simu_lastpoint_y.Text + ")");

                // 刷新
                // 使参数为非 new object()，触发刷新
                object o = new Button();
                button_simu_refresh_Click(o, new EventArgs());
            }
        }

        // 路线设置-清空实验数据(当前地图)
        private void simu_delete()
        {
            try
            {
                // SQL
                string sql = "delete from simu_info where map_id = '" + CurrentUserInfo.MapID + "'";

                // DataRead Process
                MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(sql, conn);

                int i = 0;
                i = cmd.ExecuteNonQuery();

                conn.Close();
                // 使参数为非 new object()，触发刷新
                object o = new Button();
                button_simu_refresh_Click(o, new EventArgs());

            }
            catch
            {
                MessageBox.Show("Error !");
            }
        }

        // 路线设置-清空路线按钮
        private void button_simu_deleteall_Click(object sender, EventArgs e)
        {
            if (textBox_map_name.Text == "")
                MessageBox.Show("请先载入地图！");
            else if (MessageBox.Show("确定要清空地图 " + textBox_map_name.Text + " 的仿真数据?", "提示", MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                simu_delete();
                textBox_simu_lastpoint_x.Text = "";
                textBox_simu_lastpoint_y.Text = "";
                textBox_simu_point_x.Text = "";
                textBox_simu_point_y.Text = "";

                // Log
                LogHelper.generateLog("[AP节点配置] " + CurrentUserInfo.Name + " 在地图 " + textBox_map_name.Text + " 中清空了仿真路线");

                MessageBox.Show("实验数据已删除!");
            }
        }

        // 路线设置-刷新列表按钮
        private void button_simu_refresh_Click(object sender, EventArgs e)
        {
            // 清空上一坐标
            textBox_simu_lastpoint_x.Text = "";
            textBox_simu_lastpoint_y.Text = "";

            if (CurrentUserInfo.MapID != "")
            {
                //try
                {
                    // SQL
                    string sql = "select * from simu_info where map_id ='" + CurrentUserInfo.MapID + "'";

                    // DataRead Process
                    MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                    conn.Open();
                    MySqlCommand cmd = conn.CreateCommand();
                    cmd.CommandText = sql;

                    MySqlDataReader sdr = cmd.ExecuteReader();

                    listView_simu.Items.Clear();

                    while (sdr.Read())
                    {
                        string simu_x = "";
                        string simu_y = "";

                        string simu_id = sdr.GetString(sdr.GetOrdinal("simu_id"));
                        string real_x = sdr.GetString(sdr.GetOrdinal("real_x"));
                        string real_y = sdr.GetString(sdr.GetOrdinal("real_y"));
                        if (!sdr.IsDBNull(sdr.GetOrdinal("simu_x")))
                        {
                            simu_x = sdr.GetString(sdr.GetOrdinal("simu_x"));
                        }
                        if (!sdr.IsDBNull(sdr.GetOrdinal("simu_y")))
                        {
                            simu_y = sdr.GetString(sdr.GetOrdinal("simu_y"));
                        }
                        string reg_date = sdr.GetString(sdr.GetOrdinal("reg_date"));

                        ListViewItem item = new ListViewItem(simu_id);
                        item.SubItems.Add(real_x);
                        item.SubItems.Add(real_y);
                        item.SubItems.Add(simu_x);
                        item.SubItems.Add(simu_y);
                        item.SubItems.Add(reg_date);
                        listView_simu.Items.Add(item);

                        // 填入上一坐标，此法始终保持上一坐标填写内容为当前最后一个坐标
                        textBox_simu_lastpoint_x.Text = real_x;
                        textBox_simu_lastpoint_y.Text = real_y;
                    }
                    conn.Close();
                }
                //catch
                {
                //    MessageBox.Show("Error !");
                }

                // 地图绘制
                // 如果是通过载入地图进入的，则跳过绘制地图过程
                if (sender.ToString() != "System.Object")
                {
                    draws();
                }
            }
            else
            {
                listView_simu.Items.Clear();
            }
        }

// ***********************************************************************************
// *仿真实验-仿真实验 ****************************************************************
// ***********************************************************************************

        // 仿真实验-开始仿真按钮
        private void button_simu_start_Click(object sender, EventArgs e)
        {
            if (textBox_map_name.Text == "")
                MessageBox.Show("请先载入地图！");
            else if ("" == comboBox_simu_algorithm.Text)
                MessageBox.Show("请选择算法!");
            else
            {
                // Log
                LogHelper.generateLog("[仿真实验] " + CurrentUserInfo.Name + " 在地图 " + textBox_map_name.Text + " 中开始进行仿真(" + comboBox_simu_algorithm.Text + ")");

                usingMatLabFunction(1, getAlgoID());
            }
        }

        // 仿真实验-MatLab数据分析按钮
        private void button_simu_matlab_Click(object sender, EventArgs e)
        {
            if (textBox_map_name.Text == "")
                MessageBox.Show("请先载入地图！");
            else if ("" == comboBox_simu_algorithm.Text)
                MessageBox.Show("请选择算法!");
            else
            {
                // Log
                LogHelper.generateLog("[仿真实验] " + CurrentUserInfo.Name + " 在地图 " + textBox_map_name.Text + " 中开始进行MatLab数据分析(" + comboBox_simu_algorithm.Text + ")");

                usingMatLabFunction(2, getAlgoID());
            }
        }

        // 获取所调用算法
        // 返回值: 0:所有算法 1:NN 2:KNN 3:WKNN 4:贝叶斯
        private int getAlgoID()
        {
            int Algod = 0;
            if ("所有算法" == comboBox_simu_algorithm.Text || "" == comboBox_simu_algorithm.Text)
                Algod = 0;
            else if ("NN" == comboBox_simu_algorithm.Text)
                Algod = 1;
            else if ("KNN" == comboBox_simu_algorithm.Text)
                Algod = 2;
            else if ("WKNN" == comboBox_simu_algorithm.Text)
                Algod = 3;
            else if ("贝叶斯概率" == comboBox_simu_algorithm.Text)
                Algod = 4;

            CurrentUserInfo.algo = Algod;
            return Algod;
        }

        // 调用MatLab的main函数
        // 参数列表:
        // Task 1:仿真实验 2:CDF曲线
        // Algo 0:所有算法 1:NN 2:KNN 3:WKNN 4:贝叶斯
        private void usingMatLabFunction(int Task, int Algo = 0)
        {
            // 显示进度条
            Thread thread_code_process = new Thread(new ThreadStart(processer));
            thread_code_process.Start();

            // 待传入数据参数***************************************************
            // ***MAP***
            int Map_X = CurrentUserInfo.MapWidth;
            int Map_Y = CurrentUserInfo.MapHeight;
            // ***AP***
            int AP_Num = listView_ap.Items.Count;           // AP节点个数         
            double[] APx = new double[AP_Num];              // AP节点横坐标
            double[] APy = new double[AP_Num];              // AP节点纵坐标          
            int[] AP_Power = new int[AP_Num];               // AP节点发送功率
            int[] AP_Gain = new int[AP_Num];                // AP节点发送增益
            int[] AP_ReceiveRefer = new int[AP_Num - 1];    // 非参考AP接收参考AP信号强度
            // ***FP*** 
            int FP_Num = listView_fp.Items.Count;           // 指纹节点个数
            double[] FPx = new double[FP_Num];              // FP节点横坐标
            double[] FPy = new double[FP_Num];              // FP节点纵坐标
            int FP_Gain = 0;                                // FP节点接收增益
            // ***路线***
            int Simu_Num = listView_simu.Items.Count;       // 路线节点个数
            double[] Realx = new double[Simu_Num];          // 路径节点横坐标
            double[] Realy = new double[Simu_Num];          // 路径节点纵坐标

            // 获取数据
            for (int i = 0; i < AP_Num; i++)
            {
                APx[i] = Convert.ToDouble(listView_ap.Items[i].SubItems[2].Text) / 100;
                APy[i] = Convert.ToDouble(listView_ap.Items[i].SubItems[3].Text) / 100;
                AP_Power[i] = Convert.ToInt32(listView_ap.Items[i].SubItems[4].Text);
                AP_Gain[i] = Convert.ToInt32(listView_ap.Items[i].SubItems[5].Text);
            }
            for (int i = 0; i < FP_Num; i++)
            {
                FPx[i] = Convert.ToDouble(listView_fp.Items[i].SubItems[1].Text) / 100;
                FPy[i] = Convert.ToDouble(listView_fp.Items[i].SubItems[2].Text) / 100;
                FP_Gain = Convert.ToInt32(listView_fp.Items[i].SubItems[3].Text);
            }
            for (int i = 0; i < Simu_Num; i++)
            {
                Realx[i] = Convert.ToDouble(listView_simu.Items[i].SubItems[1].Text) / 100;
                Realy[i] = Convert.ToDouble(listView_simu.Items[i].SubItems[2].Text) / 100;
            }
            int j = 0;
            for (int i = 0; i < AP_Num; i++)
            {
                if ("是" != listView_ap.Items[i].SubItems[1].Text)
                {
                    AP_ReceiveRefer[j] = Convert.ToInt32(listView_ap.Items[i].SubItems[6].Text);
                    j++;
                }
            }
            // *****************************************************************


            // 传入matlab
            try
            {
                MWArray Taskd = Task;
                MWArray Algod = Algo;
                MWArray Map_Xd = (float)Map_X / 100;
                MWArray Map_Yd = (float)Map_Y / 100;
                MWArray AP_Numd = AP_Num;
                MWNumericArray APxd = APx;
                MWNumericArray APyd = APy;
                MWNumericArray AP_Powerd = AP_Power;
                MWNumericArray AP_Gaind = AP_Gain;
                MWNumericArray AP_ReceiveReferd = AP_ReceiveRefer;
                MWArray FP_Numd = FP_Num;
                MWNumericArray FPxd = FPx;
                MWNumericArray FPyd = FPy;
                MWArray FP_Gaind = FP_Gain;
                MWArray Simu_Numd = Simu_Num;
                MWNumericArray Realxd = Realx;
                MWNumericArray Realyd = Realy;

                LocationAlgorithm.LocationAlgorithm l = new LocationAlgorithm.LocationAlgorithm();
                l.main(Taskd, Algod, Map_Xd, Map_Yd, AP_Numd, APxd, APyd, AP_Powerd, AP_Gaind, AP_ReceiveReferd, FP_Numd, FPxd, FPyd, FP_Gaind, Simu_Numd, Realxd, Realyd);
                
            }
            catch (System.FormatException)
            {

            }
        }

        // 仿真实验-MatLab数据分析-进度条
        private void processer()
        {
            int FP_Num = listView_fp.Items.Count;           // 指纹节点个数
            int Simu_Num = listView_simu.Items.Count;       // 路线节点个数
            int amount = FP_Num * Simu_Num;                 // 数量级

            
            ProgBar progBar = new ProgBar(amount, CurrentUserInfo.algo);
            progBar.ShowDialog();
        }

        // 仿真实验-实验算法选择项发生改变
        private void comboBox_simu_algorithm_SelectedIndexChanged(object sender, EventArgs e)
        {
            if ("所有算法" == comboBox_simu_algorithm.Text || "" == comboBox_simu_algorithm.Text || "NN" == comboBox_simu_algorithm.Text || "贝叶斯概率" == comboBox_simu_algorithm.Text)
            {
                label_simu_k.Visible = false;
                label_simu_info.Visible = false;
                comboBox_simu_k.Visible = false;
            }
            else if ("KNN" == comboBox_simu_algorithm.Text || "WKNN" == comboBox_simu_algorithm.Text)
            {
                label_simu_k.Visible = true;
                label_simu_info.Visible = true;
                comboBox_simu_k.Visible = true;
            }
        }


// ***********************************************************************************
// *点击场景切换大图模式 *************************************************************
// ***********************************************************************************

        // 点击panel_Graph在两种尺寸中切换
        // 用CurrentUserInfo.Panel区分当前所处Panel
        private void panel_Graph_Click(object sender, EventArgs e)
        {
            if ("" != CurrentUserInfo.MapID)
            {
                tabControl_EnvironmentSettings.Visible = false;
                panel_Simulate.Visible = false;
                if (groupBox_Graph.Location == new Point(494, 16))
                {
                    if ("local" == MySqlHelper.ConnStatus) // 本地连接，显示动画
                    {
                        for (int i = 0; i <= 500; i += 10)
                        {
                            groupBox_Graph.Location = new Point(500 - i, 16 - i / 30);
                            groupBox_Graph.Size = new Size(240 + i, 422 + i / 26);
                            panel_Graph.Size = new Size(220 + i, 400 + i / 26);
                            //if ("EnvironmentSettings" == CurrentUserInfo.Panel)
                            {
                                
                                //draw_ap();
                            }
                            draw_map();
                        }
                    }
                    else
                    {
                        groupBox_Graph.Location = new Point(0, 0);
                        groupBox_Graph.Size = new Size(737, 441);
                        panel_Graph.Size = new Size(717, 419);
                    }
                }
                else
                {
                    if ("local" == MySqlHelper.ConnStatus) // 本地连接，显示动画
                    {
                        for (int i = 480; i >= 0; i -= 10)
                        {
                            groupBox_Graph.Location = new Point(494 - i, 16 - i / 30);
                            groupBox_Graph.Size = new Size(240 + i, 422 + i / 26);
                            panel_Graph.Size = new Size(220 + i, 400 + i / 26);
                            //if ("EnvironmentSettings" == CurrentUserInfo.Panel)
                            {
                                
                                //draw_ap();
                            }
                            draw_map();
                        }
                    }
                    else
                    {
                        groupBox_Graph.Location = new Point(494, 16);
                        groupBox_Graph.Size = new Size(240, 422);
                        panel_Graph.Size = new Size(220, 400);
                    }

                    panel_Simulate.Visible = true;
                    tabControl_EnvironmentSettings.Visible = true;
                }
                if ("EnvironmentSettings" == CurrentUserInfo.Panel)
                {
                    draw();
                }
                else if ("Simulate" == CurrentUserInfo.Panel)
                {
                    draws();
                }
            }
        }

        
    }
}
