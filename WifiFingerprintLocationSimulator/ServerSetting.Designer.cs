namespace WifiFingerprintLocationSimulator
{
    partial class ServerSetting
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ServerSetting));
            this.button_Save = new System.Windows.Forms.Button();
            this.button_cancel = new System.Windows.Forms.Button();
            this.textBox_server_password = new System.Windows.Forms.TextBox();
            this.label_server_password = new System.Windows.Forms.Label();
            this.textBox_server_userid = new System.Windows.Forms.TextBox();
            this.label_server_username = new System.Windows.Forms.Label();
            this.label_server_charset = new System.Windows.Forms.Label();
            this.textBox_server_database = new System.Windows.Forms.TextBox();
            this.label_server_databasename = new System.Windows.Forms.Label();
            this.comboBox_server_charset = new System.Windows.Forms.ComboBox();
            this.textBox_server_ip_1 = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label_server_dot1 = new System.Windows.Forms.Label();
            this.label_server_dot2 = new System.Windows.Forms.Label();
            this.label_server_dot3 = new System.Windows.Forms.Label();
            this.textBox_server_ip_2 = new System.Windows.Forms.TextBox();
            this.textBox_server_ip_3 = new System.Windows.Forms.TextBox();
            this.textBox_server_ip_4 = new System.Windows.Forms.TextBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.checkBox_server_isLocalServer = new System.Windows.Forms.CheckBox();
            this.label_server_pooling = new System.Windows.Forms.Label();
            this.comboBox_server_pooling = new System.Windows.Forms.ComboBox();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // button_Save
            // 
            this.button_Save.Location = new System.Drawing.Point(215, 377);
            this.button_Save.Name = "button_Save";
            this.button_Save.Size = new System.Drawing.Size(75, 23);
            this.button_Save.TabIndex = 12;
            this.button_Save.Text = "保存";
            this.button_Save.UseVisualStyleBackColor = true;
            this.button_Save.Click += new System.EventHandler(this.button_Save_Click);
            // 
            // button_cancel
            // 
            this.button_cancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.button_cancel.Location = new System.Drawing.Point(108, 377);
            this.button_cancel.Name = "button_cancel";
            this.button_cancel.Size = new System.Drawing.Size(75, 23);
            this.button_cancel.TabIndex = 11;
            this.button_cancel.Text = "取消";
            this.button_cancel.UseVisualStyleBackColor = true;
            // 
            // textBox_server_password
            // 
            this.textBox_server_password.Location = new System.Drawing.Point(126, 110);
            this.textBox_server_password.Name = "textBox_server_password";
            this.textBox_server_password.Size = new System.Drawing.Size(127, 21);
            this.textBox_server_password.TabIndex = 8;
            this.textBox_server_password.UseSystemPasswordChar = true;
            // 
            // label_server_password
            // 
            this.label_server_password.AutoSize = true;
            this.label_server_password.Location = new System.Drawing.Point(61, 113);
            this.label_server_password.Name = "label_server_password";
            this.label_server_password.Size = new System.Drawing.Size(41, 12);
            this.label_server_password.TabIndex = 14;
            this.label_server_password.Text = "密码：";
            // 
            // textBox_server_userid
            // 
            this.textBox_server_userid.Location = new System.Drawing.Point(126, 75);
            this.textBox_server_userid.Name = "textBox_server_userid";
            this.textBox_server_userid.Size = new System.Drawing.Size(127, 21);
            this.textBox_server_userid.TabIndex = 7;
            // 
            // label_server_username
            // 
            this.label_server_username.AutoSize = true;
            this.label_server_username.Location = new System.Drawing.Point(61, 78);
            this.label_server_username.Name = "label_server_username";
            this.label_server_username.Size = new System.Drawing.Size(53, 12);
            this.label_server_username.TabIndex = 12;
            this.label_server_username.Text = "用户名：";
            // 
            // label_server_charset
            // 
            this.label_server_charset.AutoSize = true;
            this.label_server_charset.Location = new System.Drawing.Point(61, 150);
            this.label_server_charset.Name = "label_server_charset";
            this.label_server_charset.Size = new System.Drawing.Size(53, 12);
            this.label_server_charset.TabIndex = 18;
            this.label_server_charset.Text = "字符集：";
            // 
            // textBox_server_database
            // 
            this.textBox_server_database.Location = new System.Drawing.Point(126, 39);
            this.textBox_server_database.Name = "textBox_server_database";
            this.textBox_server_database.Size = new System.Drawing.Size(127, 21);
            this.textBox_server_database.TabIndex = 6;
            // 
            // label_server_databasename
            // 
            this.label_server_databasename.AutoSize = true;
            this.label_server_databasename.Location = new System.Drawing.Point(61, 42);
            this.label_server_databasename.Name = "label_server_databasename";
            this.label_server_databasename.Size = new System.Drawing.Size(65, 12);
            this.label_server_databasename.TabIndex = 16;
            this.label_server_databasename.Text = "数据库名：";
            // 
            // comboBox_server_charset
            // 
            this.comboBox_server_charset.BackColor = System.Drawing.SystemColors.Window;
            this.comboBox_server_charset.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_server_charset.FormattingEnabled = true;
            this.comboBox_server_charset.Items.AddRange(new object[] {
            "utf8",
            "gb2312",
            "gbk",
            "gb18030"});
            this.comboBox_server_charset.Location = new System.Drawing.Point(126, 147);
            this.comboBox_server_charset.Name = "comboBox_server_charset";
            this.comboBox_server_charset.Size = new System.Drawing.Size(127, 20);
            this.comboBox_server_charset.TabIndex = 9;
            // 
            // textBox_server_ip_1
            // 
            this.textBox_server_ip_1.Location = new System.Drawing.Point(98, 36);
            this.textBox_server_ip_1.MaxLength = 3;
            this.textBox_server_ip_1.Name = "textBox_server_ip_1";
            this.textBox_server_ip_1.Size = new System.Drawing.Size(30, 21);
            this.textBox_server_ip_1.TabIndex = 2;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(36, 39);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(53, 12);
            this.label1.TabIndex = 22;
            this.label1.Text = "服务器：";
            // 
            // label_server_dot1
            // 
            this.label_server_dot1.AutoSize = true;
            this.label_server_dot1.Location = new System.Drawing.Point(132, 42);
            this.label_server_dot1.Name = "label_server_dot1";
            this.label_server_dot1.Size = new System.Drawing.Size(11, 12);
            this.label_server_dot1.TabIndex = 23;
            this.label_server_dot1.Text = ".";
            // 
            // label_server_dot2
            // 
            this.label_server_dot2.AutoSize = true;
            this.label_server_dot2.Location = new System.Drawing.Point(178, 42);
            this.label_server_dot2.Name = "label_server_dot2";
            this.label_server_dot2.Size = new System.Drawing.Size(11, 12);
            this.label_server_dot2.TabIndex = 24;
            this.label_server_dot2.Text = ".";
            // 
            // label_server_dot3
            // 
            this.label_server_dot3.AutoSize = true;
            this.label_server_dot3.Location = new System.Drawing.Point(225, 42);
            this.label_server_dot3.Name = "label_server_dot3";
            this.label_server_dot3.Size = new System.Drawing.Size(11, 12);
            this.label_server_dot3.TabIndex = 25;
            this.label_server_dot3.Text = ".";
            // 
            // textBox_server_ip_2
            // 
            this.textBox_server_ip_2.Location = new System.Drawing.Point(143, 36);
            this.textBox_server_ip_2.MaxLength = 3;
            this.textBox_server_ip_2.Name = "textBox_server_ip_2";
            this.textBox_server_ip_2.Size = new System.Drawing.Size(30, 21);
            this.textBox_server_ip_2.TabIndex = 3;
            // 
            // textBox_server_ip_3
            // 
            this.textBox_server_ip_3.Location = new System.Drawing.Point(190, 36);
            this.textBox_server_ip_3.MaxLength = 3;
            this.textBox_server_ip_3.Name = "textBox_server_ip_3";
            this.textBox_server_ip_3.Size = new System.Drawing.Size(30, 21);
            this.textBox_server_ip_3.TabIndex = 4;
            // 
            // textBox_server_ip_4
            // 
            this.textBox_server_ip_4.Location = new System.Drawing.Point(237, 36);
            this.textBox_server_ip_4.MaxLength = 3;
            this.textBox_server_ip_4.Name = "textBox_server_ip_4";
            this.textBox_server_ip_4.Size = new System.Drawing.Size(30, 21);
            this.textBox_server_ip_4.TabIndex = 5;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.label_server_pooling);
            this.groupBox1.Controls.Add(this.comboBox_server_pooling);
            this.groupBox1.Controls.Add(this.label_server_databasename);
            this.groupBox1.Controls.Add(this.label_server_username);
            this.groupBox1.Controls.Add(this.textBox_server_userid);
            this.groupBox1.Controls.Add(this.label_server_password);
            this.groupBox1.Controls.Add(this.textBox_server_password);
            this.groupBox1.Controls.Add(this.textBox_server_database);
            this.groupBox1.Controls.Add(this.label_server_charset);
            this.groupBox1.Controls.Add(this.comboBox_server_charset);
            this.groupBox1.Location = new System.Drawing.Point(36, 126);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(325, 230);
            this.groupBox1.TabIndex = 29;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "数据库连接配置";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.label1);
            this.groupBox2.Controls.Add(this.textBox_server_ip_1);
            this.groupBox2.Controls.Add(this.textBox_server_ip_4);
            this.groupBox2.Controls.Add(this.label_server_dot1);
            this.groupBox2.Controls.Add(this.textBox_server_ip_3);
            this.groupBox2.Controls.Add(this.label_server_dot2);
            this.groupBox2.Controls.Add(this.textBox_server_ip_2);
            this.groupBox2.Controls.Add(this.label_server_dot3);
            this.groupBox2.Location = new System.Drawing.Point(36, 31);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(325, 80);
            this.groupBox2.TabIndex = 30;
            this.groupBox2.TabStop = false;
            // 
            // checkBox_server_isLocalServer
            // 
            this.checkBox_server_isLocalServer.AutoSize = true;
            this.checkBox_server_isLocalServer.Location = new System.Drawing.Point(45, 31);
            this.checkBox_server_isLocalServer.Name = "checkBox_server_isLocalServer";
            this.checkBox_server_isLocalServer.Size = new System.Drawing.Size(156, 16);
            this.checkBox_server_isLocalServer.TabIndex = 1;
            this.checkBox_server_isLocalServer.Text = "本地服务器 (Localhost)";
            this.checkBox_server_isLocalServer.UseVisualStyleBackColor = true;
            this.checkBox_server_isLocalServer.CheckedChanged += new System.EventHandler(this.checkBox_server_isLocalServer_CheckedChanged);
            // 
            // label_server_pooling
            // 
            this.label_server_pooling.AutoSize = true;
            this.label_server_pooling.Location = new System.Drawing.Point(61, 185);
            this.label_server_pooling.Name = "label_server_pooling";
            this.label_server_pooling.Size = new System.Drawing.Size(53, 12);
            this.label_server_pooling.TabIndex = 20;
            this.label_server_pooling.Text = "连接池：";
            // 
            // comboBox_server_pooling
            // 
            this.comboBox_server_pooling.BackColor = System.Drawing.SystemColors.Window;
            this.comboBox_server_pooling.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_server_pooling.FormattingEnabled = true;
            this.comboBox_server_pooling.Items.AddRange(new object[] {
            "true",
            "false"});
            this.comboBox_server_pooling.Location = new System.Drawing.Point(126, 182);
            this.comboBox_server_pooling.Name = "comboBox_server_pooling";
            this.comboBox_server_pooling.Size = new System.Drawing.Size(127, 20);
            this.comboBox_server_pooling.TabIndex = 10;
            // 
            // ServerSetting
            // 
            this.AcceptButton = this.button_Save;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.button_cancel;
            this.ClientSize = new System.Drawing.Size(404, 421);
            this.ControlBox = false;
            this.Controls.Add(this.checkBox_server_isLocalServer);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.button_Save);
            this.Controls.Add(this.button_cancel);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximumSize = new System.Drawing.Size(420, 460);
            this.MinimumSize = new System.Drawing.Size(420, 460);
            this.Name = "ServerSetting";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "服务器设置";
            this.Load += new System.EventHandler(this.ServerSetting_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button button_Save;
        private System.Windows.Forms.Button button_cancel;
        private System.Windows.Forms.TextBox textBox_server_password;
        private System.Windows.Forms.Label label_server_password;
        private System.Windows.Forms.TextBox textBox_server_userid;
        private System.Windows.Forms.Label label_server_username;
        private System.Windows.Forms.Label label_server_charset;
        private System.Windows.Forms.TextBox textBox_server_database;
        private System.Windows.Forms.Label label_server_databasename;
        private System.Windows.Forms.ComboBox comboBox_server_charset;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label_server_dot1;
        private System.Windows.Forms.Label label_server_dot2;
        private System.Windows.Forms.Label label_server_dot3;
        private System.Windows.Forms.TextBox textBox_server_ip_2;
        private System.Windows.Forms.TextBox textBox_server_ip_3;
        private System.Windows.Forms.TextBox textBox_server_ip_4;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.CheckBox checkBox_server_isLocalServer;
        private System.Windows.Forms.Label label_server_pooling;
        private System.Windows.Forms.ComboBox comboBox_server_pooling;
        private System.Windows.Forms.TextBox textBox_server_ip_1;
    }
}