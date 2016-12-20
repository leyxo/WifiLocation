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

            // 控件提示弹窗初始化
            toolTip_Graph.SetToolTip(panel_Graph, "点击以切换大图模式");
        }

        private void ToolStripMenuItem_Exit_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("确定要退出系统?", "提示", MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                try
                {
                    Environment.Exit(0);
                }
                catch
                {
                    MessageBox.Show("系统正忙，请点击注销按钮退回到主菜单后退出系统 !");
                }
            }
        }

        private void ToolStripMenuItem_Help_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start("http://leyxo.site");
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

                CurrentUserInfo.Name = "";
                CurrentUserInfo.Type = "";
            }
        }

        private void toolStripMenuItem_MapManage_Click(object sender, EventArgs e)
        {
            panel_EnvironmentSettings.Show();
            panel_EnvironmentSettings.BringToFront();
            tabControl_EnvironmentSettings.SelectedIndex = 0;
        }

        private void toolStripMenuItem_APManage_Click(object sender, EventArgs e)
        {
            panel_EnvironmentSettings.Show();
            panel_EnvironmentSettings.BringToFront();
            tabControl_EnvironmentSettings.SelectedIndex = 1;
        }

        private void toolStripMenuItem_FPManage_Click(object sender, EventArgs e)
        {
            panel_EnvironmentSettings.Show();
            panel_EnvironmentSettings.BringToFront();
            tabControl_EnvironmentSettings.SelectedIndex = 2;
        }

        private void toolStripMenuItem_RSSInfo_Click(object sender, EventArgs e)
        {
            panel_EnvironmentSettings.Show();
            panel_EnvironmentSettings.BringToFront();
            tabControl_EnvironmentSettings.SelectedIndex = 3;
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

// ***********************************************************************************
// *图像绘制(位于panel_Graph) ********************************************************
// ***********************************************************************************

        // 图像绘制
        // 被场景配置的载入按钮、AP和FP的刷新按钮调用
        // CurrentUserInfo中有地图时绘制地图，信息为空时绘制空白背景
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

            // 绘制
            graphics.Clear(Color.FromArgb(255, 240, 240, 240));
            graphics.DrawLine(new Pen(Color.Black, 2), x1, y1, x2, y2);
            graphics.DrawLine(new Pen(Color.Black, 2), x2, y2, x3, y3);
            graphics.DrawLine(new Pen(Color.Black, 2), x3, y3, x4, y4);
            graphics.DrawLine(new Pen(Color.Black, 2), x4, y4, x1, y1);            
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
                string sql = "select ap_x, ap_y from ap_info where map_id ='" + CurrentUserInfo.MapID + "'";

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

                    // 计算点实际坐标
                    x = ap_x * (x2 - x1) / CurrentUserInfo.MapWidth + x1;
                    y = ap_y * (y3 - y2) / CurrentUserInfo.MapHeight + y1;

                    // 绘制AP节点
                    Rectangle rect = new Rectangle((int)x-4, (int)y-4, 8, 8);
                    graphics.DrawEllipse(new Pen(Color.Blue), rect);
                    graphics.FillEllipse(new SolidBrush(Color.Black), rect);
                    Rectangle rect2 = new Rectangle((int)x - 8, (int)y - 8, 16, 16);
                    graphics.DrawEllipse(new Pen(Color.Black), rect2);
                    Rectangle rect3 = new Rectangle((int)x - 20, (int)y - 20, 40, 40);
                    graphics.DrawEllipse(new Pen(Color.LightGray), rect3);
                    Rectangle rect4 = new Rectangle((int)x - 50, (int)y - 50, 100, 100);
                    graphics.DrawEllipse(new Pen(Color.LightGray), rect4);
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

                    // 绘制AP节点
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
                string sql = "select map_id, map_name, map_width, map_height, map_info, reg_date from map_info";

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
            draw();
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
                string sql = "delete from map_info where map_name = '" + MapName + "'";

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
            // 清空该地图AP数据
            ap_delete();

            // 清空该地图FP数据
            fp_delete();

            // 清空该地图RSS数据
            rss_delete();

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
            textBox_fp_distance.Text = "";
            textBox_fp_receivegain.Text = "";

            // 执行一遍刷新
            button_ap_refresh_Click(new object(), new EventArgs());
            button_fp_refresh_Click(new object(), new EventArgs());
            button_rss_refresh_Click(new object(), new EventArgs());
            button_map_refresh_Click(new object(), new EventArgs());
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
                string sql = "select * from map_info where map_name = '" + textBox_map_name.Text + "'";
               
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
                    string sql = "insert into map_info (map_name, map_width, map_height, map_info, reg_date) values('" + textBox_map_name.Text + "','" + textBox_map_width.Text + "','" + textBox_map_height.Text + "','" + textBox_map_note.Text + "','" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "')";
                    string sql_check = "select * from map_info where map_name = '" + textBox_map_name.Text + "'";

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

                            MessageBox.Show("地图 " + textBox_map_name.Text + " 数据已更新! 实验数据已清除!");
                            CurrentUserInfo.MapWidth = Convert.ToInt32(textBox_map_width.Text);
                            CurrentUserInfo.MapHeight = Convert.ToInt32(textBox_map_height.Text);
                        }
                        // 仅修改备注
                        else
                        {
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
                        string ap_id = sdr.GetString(sdr.GetOrdinal("ap_id"));
                        string ap_x = sdr.GetString(sdr.GetOrdinal("ap_x"));
                        string ap_y = sdr.GetString(sdr.GetOrdinal("ap_y"));
                        string ap_sendpower = sdr.GetString(sdr.GetOrdinal("ap_sendpower"));
                        string ap_sendgain = sdr.GetString(sdr.GetOrdinal("ap_sendgain"));
                        string reg_date = sdr.GetString(sdr.GetOrdinal("reg_date"));


                        ListViewItem item = new ListViewItem(ap_id);
                        item.SubItems.Add(ap_x);
                        item.SubItems.Add(ap_y);
                        item.SubItems.Add(ap_sendpower);
                        item.SubItems.Add(ap_sendgain);
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
                draw();
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
            textBox_ap_x.Text = listView_ap.SelectedItems[0].SubItems[1].Text;
            textBox_ap_y.Text = listView_ap.SelectedItems[0].SubItems[2].Text;
            textBox_ap_sendpower.Text = listView_ap.SelectedItems[0].SubItems[3].Text;
            textBox_ap_sendgain.Text = listView_ap.SelectedItems[0].SubItems[4].Text;
            CurrentUserInfo.ApID = listView_ap.SelectedItems[0].SubItems[0].Text;

            button_ap_refresh_Click(new object(), new EventArgs());
            button_ap_modify.Enabled = true;
        }

        // 环境配置-AP节点配置 清空按钮
        private void button_ap_deleteall_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("确定要删除地图 " + textBox_map_name.Text + " 的所有AP节点数据?", "提示", MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                ap_delete();
                MessageBox.Show("所有节点已删除!");
            }
        }

        // 环境配置-AP节点配置 添加按钮
        private void button_ap_add_Click(object sender, EventArgs e)
        {
            if (textBox_ap_x.Text == "")
                MessageBox.Show("请输入AP节点x坐标");
            else if (textBox_ap_y.Text == "")
                MessageBox.Show("请输入AP节点y坐标");
            else if (textBox_ap_sendpower.Text == "")
                MessageBox.Show("请输入AP节点发送功率");
            else if (textBox_ap_sendgain.Text == "")
                MessageBox.Show("请输入AP节点发送增益");
            else if (Convert.ToInt32(textBox_ap_x.Text) < 0 || Convert.ToInt32(textBox_ap_x.Text) > CurrentUserInfo.MapWidth || Convert.ToInt32(textBox_ap_y.Text) < 0 || Convert.ToInt32(textBox_ap_y.Text) > CurrentUserInfo.MapHeight)
                MessageBox.Show("请输入地图范围内的坐标值(0<x<" + CurrentUserInfo.MapWidth + ", 0<y<" + CurrentUserInfo.MapHeight + ")");
            else
            {
                //try
                {
                    // SQL
                    string sql = "insert into ap_info (map_id, ap_x, ap_y, ap_sendpower, ap_sendgain, reg_date) values('"+ CurrentUserInfo.MapID + "','" + textBox_ap_x.Text + "','" + textBox_ap_y.Text + "','" + textBox_ap_sendpower.Text + "','" + textBox_ap_sendgain.Text + "','" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "')";
                    
                    // DataRead Process
                    MySqlConnection conn = new MySqlConnection(MySqlHelper.Conn);
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand(sql, conn);
                    int i = 0;
                    i = cmd.ExecuteNonQuery();

                    if (i > 0)
                    {
                        MessageBox.Show("节点数据添加成功!");
                    }
                    else
                    {
                        MessageBox.Show("添加失败！");
                    }
                    conn.Close();
                }
                //catch
                {
                //    MessageBox.Show("Error !");
                }

                button_ap_refresh_Click(new object(), new EventArgs());
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
                button_ap_refresh_Click(new object(), new EventArgs());
                
            }
            catch
            {
                MessageBox.Show("Error !");
            }
        }

        // 环境配置-AP节点配置 删除按钮
        private void button_ap_delete_Click(object sender, EventArgs e)
        {
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
                        MessageBox.Show("节点已删除!");
                    }
                    else
                    {
                        MessageBox.Show("删除失败！");
                    }

                    conn.Close();
                    button_ap_refresh_Click(new object(), new EventArgs());
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
                draw();
            }
            else
            {
                listView_fp.Items.Clear();
            }
        }

        // 环境配置-指纹节点配置 生成节点库按钮
        private void button_fp_autoadd_Click(object sender, EventArgs e)
        {
            if (textBox_fp_distance.Text == "")
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

                button_fp_refresh_Click(new object(), new EventArgs());
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
            }
            else
            {
                listView_rss.Items.Clear();
            }
        }

        // 环境配置-生成RSS库按钮
        private void button_rss_generate_Click(object sender, EventArgs e)
        {

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
        }

// ***********************************************************************************
// *点击场景切换大图模式 *************************************************************
// ***********************************************************************************

        // 点击panel_Graph在两种尺寸中切换
        private void panel_Graph_Click(object sender, EventArgs e)
        {
            tabControl_EnvironmentSettings.Visible = false;
            if (groupBox_Graph.Location == new Point(494, 16))
            {
                for (int i = 0; i <= 500; i += 10)
                {
                    groupBox_Graph.Location = new Point(500 - i, 16 - i / 30);
                    groupBox_Graph.Size = new Size(240 + i, 422 + i / 26);
                    panel_Graph.Size = new Size(220 + i, 400 + i/26);
                    draw_map();
                    draw_ap();
                }
                //groupBox_Graph.Location = new Point(0, 0);
                //groupBox_Graph.Size = new Size(737, 441);
                //panel_Graph.Size = new Size(717, 419);
            }
            else
            {
                for (int i = 480; i >= 0; i -= 10)
                {
                    groupBox_Graph.Location = new Point(494 - i, 16 - i / 30);
                    groupBox_Graph.Size = new Size(240 + i, 422 + i / 26);
                    panel_Graph.Size = new Size(220 + i, 400 + i / 26);
                    draw_map();
                    draw_ap();
                }
                //groupBox_Graph.Location = new Point(494, 16);
                //groupBox_Graph.Size = new Size(240, 422);
                //panel_Graph.Size = new Size(220, 400);
            }
            draw();
            tabControl_EnvironmentSettings.Visible = true;
        }

    }
}
