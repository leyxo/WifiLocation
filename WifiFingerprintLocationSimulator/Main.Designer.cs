namespace WifiFingerprintLocationSimulator
{
    partial class Main
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要修改
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Main));
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.ToolStripMenuItem_Menu_System = new System.Windows.Forms.ToolStripMenuItem();
            this.ToolStripMenuItem_Login = new System.Windows.Forms.ToolStripMenuItem();
            this.ToolStripMenuItem_Registe = new System.Windows.Forms.ToolStripMenuItem();
            this.ToolStripMenuItem_ServerSetting = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.ToolStripMenuItem_Exit = new System.Windows.Forms.ToolStripMenuItem();
            this.ToolStripMenuItem_Menu_Message = new System.Windows.Forms.ToolStripMenuItem();
            this.暂无消息ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ToolStripMenuItem_Menu_Help = new System.Windows.Forms.ToolStripMenuItem();
            this.ToolStripMenuItem_Help = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.ToolStripMenuItem_About = new System.Windows.Forms.ToolStripMenuItem();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.toolStripStatusLabel_DateLabel = new System.Windows.Forms.ToolStripStatusLabel();
            this.toolStripStatusLabel_Date = new System.Windows.Forms.ToolStripStatusLabel();
            this.menuStrip1.SuspendLayout();
            this.statusStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ToolStripMenuItem_Menu_System,
            this.ToolStripMenuItem_Menu_Message,
            this.ToolStripMenuItem_Menu_Help});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(771, 25);
            this.menuStrip1.TabIndex = 0;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // ToolStripMenuItem_Menu_System
            // 
            this.ToolStripMenuItem_Menu_System.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ToolStripMenuItem_Login,
            this.ToolStripMenuItem_Registe,
            this.ToolStripMenuItem_ServerSetting,
            this.toolStripSeparator1,
            this.ToolStripMenuItem_Exit});
            this.ToolStripMenuItem_Menu_System.Name = "ToolStripMenuItem_Menu_System";
            this.ToolStripMenuItem_Menu_System.Size = new System.Drawing.Size(59, 21);
            this.ToolStripMenuItem_Menu_System.Text = "系统(S)";
            // 
            // ToolStripMenuItem_Login
            // 
            this.ToolStripMenuItem_Login.Name = "ToolStripMenuItem_Login";
            this.ToolStripMenuItem_Login.Size = new System.Drawing.Size(152, 22);
            this.ToolStripMenuItem_Login.Text = "登录...";
            this.ToolStripMenuItem_Login.Click += new System.EventHandler(this.ToolStripMenuItem_Login_Click);
            // 
            // ToolStripMenuItem_Registe
            // 
            this.ToolStripMenuItem_Registe.Name = "ToolStripMenuItem_Registe";
            this.ToolStripMenuItem_Registe.Size = new System.Drawing.Size(152, 22);
            this.ToolStripMenuItem_Registe.Text = "新用户注册...";
            this.ToolStripMenuItem_Registe.Click += new System.EventHandler(this.ToolStripMenuItem_Registe_Click);
            // 
            // ToolStripMenuItem_ServerSetting
            // 
            this.ToolStripMenuItem_ServerSetting.Name = "ToolStripMenuItem_ServerSetting";
            this.ToolStripMenuItem_ServerSetting.Size = new System.Drawing.Size(152, 22);
            this.ToolStripMenuItem_ServerSetting.Text = "服务器设置...";
            this.ToolStripMenuItem_ServerSetting.Click += new System.EventHandler(this.ToolStripMenuItem_ServerSetting_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(149, 6);
            // 
            // ToolStripMenuItem_Exit
            // 
            this.ToolStripMenuItem_Exit.Name = "ToolStripMenuItem_Exit";
            this.ToolStripMenuItem_Exit.Size = new System.Drawing.Size(152, 22);
            this.ToolStripMenuItem_Exit.Text = "退出(E)";
            this.ToolStripMenuItem_Exit.Click += new System.EventHandler(this.ToolStripMenuItem_Exit_Click);
            // 
            // ToolStripMenuItem_Menu_Message
            // 
            this.ToolStripMenuItem_Menu_Message.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.暂无消息ToolStripMenuItem});
            this.ToolStripMenuItem_Menu_Message.Name = "ToolStripMenuItem_Menu_Message";
            this.ToolStripMenuItem_Menu_Message.Size = new System.Drawing.Size(64, 21);
            this.ToolStripMenuItem_Menu_Message.Text = "消息(M)";
            // 
            // 暂无消息ToolStripMenuItem
            // 
            this.暂无消息ToolStripMenuItem.Enabled = false;
            this.暂无消息ToolStripMenuItem.Name = "暂无消息ToolStripMenuItem";
            this.暂无消息ToolStripMenuItem.Size = new System.Drawing.Size(124, 22);
            this.暂无消息ToolStripMenuItem.Text = "暂无消息";
            // 
            // ToolStripMenuItem_Menu_Help
            // 
            this.ToolStripMenuItem_Menu_Help.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ToolStripMenuItem_Help,
            this.toolStripSeparator2,
            this.ToolStripMenuItem_About});
            this.ToolStripMenuItem_Menu_Help.Name = "ToolStripMenuItem_Menu_Help";
            this.ToolStripMenuItem_Menu_Help.Size = new System.Drawing.Size(61, 21);
            this.ToolStripMenuItem_Menu_Help.Text = "帮助(H)";
            // 
            // ToolStripMenuItem_Help
            // 
            this.ToolStripMenuItem_Help.Name = "ToolStripMenuItem_Help";
            this.ToolStripMenuItem_Help.Size = new System.Drawing.Size(216, 22);
            this.ToolStripMenuItem_Help.Text = "查看在线帮助(V)...";
            this.ToolStripMenuItem_Help.Click += new System.EventHandler(this.ToolStripMenuItem_Help_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(213, 6);
            // 
            // ToolStripMenuItem_About
            // 
            this.ToolStripMenuItem_About.Image = global::WifiFingerprintLocationSimulator.Properties.Resources.Icon;
            this.ToolStripMenuItem_About.Name = "ToolStripMenuItem_About";
            this.ToolStripMenuItem_About.Size = new System.Drawing.Size(216, 22);
            this.ToolStripMenuItem_About.Text = "关于 室内定位仿真平台(A)";
            this.ToolStripMenuItem_About.Click += new System.EventHandler(this.ToolStripMenuItem_About_Click);
            // 
            // statusStrip1
            // 
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripStatusLabel_DateLabel,
            this.toolStripStatusLabel_Date});
            this.statusStrip1.Location = new System.Drawing.Point(0, 483);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(771, 22);
            this.statusStrip1.TabIndex = 1;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // toolStripStatusLabel_DateLabel
            // 
            this.toolStripStatusLabel_DateLabel.Name = "toolStripStatusLabel_DateLabel";
            this.toolStripStatusLabel_DateLabel.Size = new System.Drawing.Size(44, 17);
            this.toolStripStatusLabel_DateLabel.Text = "日期：";
            // 
            // toolStripStatusLabel_Date
            // 
            this.toolStripStatusLabel_Date.Name = "toolStripStatusLabel_Date";
            this.toolStripStatusLabel_Date.Size = new System.Drawing.Size(35, 17);
            this.toolStripStatusLabel_Date.Text = "Date";
            // 
            // Main
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackgroundImage = global::WifiFingerprintLocationSimulator.Properties.Resources.Back1;
            this.ClientSize = new System.Drawing.Size(771, 505);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.menuStrip1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MainMenuStrip = this.menuStrip1;
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(787, 544);
            this.MinimumSize = new System.Drawing.Size(787, 544);
            this.Name = "Main";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "室内定位仿真平台";
            this.Load += new System.EventHandler(this.Main_Load);
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem ToolStripMenuItem_Menu_System;
        private System.Windows.Forms.ToolStripMenuItem ToolStripMenuItem_Menu_Message;
        private System.Windows.Forms.ToolStripMenuItem ToolStripMenuItem_Menu_Help;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripMenuItem ToolStripMenuItem_Login;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem ToolStripMenuItem_Exit;
        private System.Windows.Forms.ToolStripMenuItem ToolStripMenuItem_Help;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripMenuItem ToolStripMenuItem_About;
        private System.Windows.Forms.ToolStripMenuItem ToolStripMenuItem_Registe;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel_Date;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel_DateLabel;
        private System.Windows.Forms.ToolStripMenuItem 暂无消息ToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem ToolStripMenuItem_ServerSetting;
    }
}

