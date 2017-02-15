namespace WifiFingerprintLocationSimulator
{
    partial class Login
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Login));
            this.textBox_UserPass = new System.Windows.Forms.TextBox();
            this.textBox_UserName = new System.Windows.Forms.TextBox();
            this.label_UserPass = new System.Windows.Forms.Label();
            this.label_UserName = new System.Windows.Forms.Label();
            this.button_Login = new System.Windows.Forms.Button();
            this.button_Back = new System.Windows.Forms.Button();
            this.label_Register = new System.Windows.Forms.Label();
            this.label_UserType = new System.Windows.Forms.Label();
            this.comboBox_UserType = new System.Windows.Forms.ComboBox();
            this.label_ForgetPass = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // textBox_UserPass
            // 
            this.textBox_UserPass.Location = new System.Drawing.Point(108, 79);
            this.textBox_UserPass.MaxLength = 20;
            this.textBox_UserPass.Name = "textBox_UserPass";
            this.textBox_UserPass.Size = new System.Drawing.Size(100, 21);
            this.textBox_UserPass.TabIndex = 2;
            this.textBox_UserPass.Text = "950216";
            this.textBox_UserPass.UseSystemPasswordChar = true;
            // 
            // textBox_UserName
            // 
            this.textBox_UserName.Location = new System.Drawing.Point(108, 37);
            this.textBox_UserName.MaxLength = 10;
            this.textBox_UserName.Name = "textBox_UserName";
            this.textBox_UserName.Size = new System.Drawing.Size(100, 21);
            this.textBox_UserName.TabIndex = 1;
            this.textBox_UserName.Text = "Dison";
            // 
            // label_UserPass
            // 
            this.label_UserPass.AutoSize = true;
            this.label_UserPass.Location = new System.Drawing.Point(58, 82);
            this.label_UserPass.Name = "label_UserPass";
            this.label_UserPass.Size = new System.Drawing.Size(53, 12);
            this.label_UserPass.TabIndex = 9;
            this.label_UserPass.Text = "密  码：";
            // 
            // label_UserName
            // 
            this.label_UserName.AutoSize = true;
            this.label_UserName.Location = new System.Drawing.Point(58, 40);
            this.label_UserName.Name = "label_UserName";
            this.label_UserName.Size = new System.Drawing.Size(53, 12);
            this.label_UserName.TabIndex = 8;
            this.label_UserName.Text = "用户名：";
            // 
            // button_Login
            // 
            this.button_Login.Location = new System.Drawing.Point(158, 176);
            this.button_Login.Name = "button_Login";
            this.button_Login.Size = new System.Drawing.Size(75, 23);
            this.button_Login.TabIndex = 4;
            this.button_Login.Text = "登录";
            this.button_Login.UseVisualStyleBackColor = true;
            this.button_Login.Click += new System.EventHandler(this.button_Login_Click);
            // 
            // button_Back
            // 
            this.button_Back.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.button_Back.Location = new System.Drawing.Point(51, 176);
            this.button_Back.Name = "button_Back";
            this.button_Back.Size = new System.Drawing.Size(75, 23);
            this.button_Back.TabIndex = 5;
            this.button_Back.Text = "返回";
            this.button_Back.UseVisualStyleBackColor = true;
            this.button_Back.Click += new System.EventHandler(this.button_Back_Click);
            // 
            // label_Register
            // 
            this.label_Register.AutoSize = true;
            this.label_Register.Cursor = System.Windows.Forms.Cursors.Hand;
            this.label_Register.ForeColor = System.Drawing.SystemColors.AppWorkspace;
            this.label_Register.Location = new System.Drawing.Point(210, 220);
            this.label_Register.Name = "label_Register";
            this.label_Register.Size = new System.Drawing.Size(65, 12);
            this.label_Register.TabIndex = 12;
            this.label_Register.Text = "新用户注册";
            this.label_Register.Click += new System.EventHandler(this.label_Register_Click);
            // 
            // label_UserType
            // 
            this.label_UserType.AutoSize = true;
            this.label_UserType.Location = new System.Drawing.Point(58, 124);
            this.label_UserType.Name = "label_UserType";
            this.label_UserType.Size = new System.Drawing.Size(53, 12);
            this.label_UserType.TabIndex = 13;
            this.label_UserType.Text = "身  份：";
            // 
            // comboBox_UserType
            // 
            this.comboBox_UserType.BackColor = System.Drawing.SystemColors.Window;
            this.comboBox_UserType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_UserType.FormattingEnabled = true;
            this.comboBox_UserType.Items.AddRange(new object[] {
            "用户",
            "系统管理员"});
            this.comboBox_UserType.Location = new System.Drawing.Point(108, 121);
            this.comboBox_UserType.Name = "comboBox_UserType";
            this.comboBox_UserType.Size = new System.Drawing.Size(100, 20);
            this.comboBox_UserType.TabIndex = 3;
            // 
            // label_ForgetPass
            // 
            this.label_ForgetPass.AutoSize = true;
            this.label_ForgetPass.Cursor = System.Windows.Forms.Cursors.Hand;
            this.label_ForgetPass.ForeColor = System.Drawing.SystemColors.AppWorkspace;
            this.label_ForgetPass.Location = new System.Drawing.Point(150, 220);
            this.label_ForgetPass.Name = "label_ForgetPass";
            this.label_ForgetPass.Size = new System.Drawing.Size(53, 12);
            this.label_ForgetPass.TabIndex = 14;
            this.label_ForgetPass.Text = "忘记密码";
            this.label_ForgetPass.Click += new System.EventHandler(this.label_ForgetPass_Click);
            // 
            // Login
            // 
            this.AcceptButton = this.button_Login;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.button_Back;
            this.ClientSize = new System.Drawing.Size(284, 241);
            this.ControlBox = false;
            this.Controls.Add(this.label_ForgetPass);
            this.Controls.Add(this.comboBox_UserType);
            this.Controls.Add(this.label_UserType);
            this.Controls.Add(this.label_Register);
            this.Controls.Add(this.textBox_UserPass);
            this.Controls.Add(this.textBox_UserName);
            this.Controls.Add(this.label_UserPass);
            this.Controls.Add(this.label_UserName);
            this.Controls.Add(this.button_Login);
            this.Controls.Add(this.button_Back);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.KeyPreview = true;
            this.MaximumSize = new System.Drawing.Size(300, 280);
            this.MinimumSize = new System.Drawing.Size(300, 280);
            this.Name = "Login";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "登录";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox textBox_UserPass;
        private System.Windows.Forms.TextBox textBox_UserName;
        private System.Windows.Forms.Label label_UserPass;
        private System.Windows.Forms.Label label_UserName;
        private System.Windows.Forms.Button button_Login;
        private System.Windows.Forms.Button button_Back;
        private System.Windows.Forms.Label label_Register;
        private System.Windows.Forms.Label label_UserType;
        private System.Windows.Forms.ComboBox comboBox_UserType;
        private System.Windows.Forms.Label label_ForgetPass;
    }
}