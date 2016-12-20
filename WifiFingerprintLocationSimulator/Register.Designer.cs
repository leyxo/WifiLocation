namespace WifiFingerprintLocationSimulator
{
    partial class Register
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Register));
            this.textBox_UserPass = new System.Windows.Forms.TextBox();
            this.textBox_UserName = new System.Windows.Forms.TextBox();
            this.label_UserPass = new System.Windows.Forms.Label();
            this.label_UserName = new System.Windows.Forms.Label();
            this.textBox_UserPassCheck = new System.Windows.Forms.TextBox();
            this.label_UserPassCheck = new System.Windows.Forms.Label();
            this.button_Register = new System.Windows.Forms.Button();
            this.button_cancel = new System.Windows.Forms.Button();
            this.textBox_UserEmail = new System.Windows.Forms.TextBox();
            this.label_UserEmail = new System.Windows.Forms.Label();
            this.label_Hint_UserEmail = new System.Windows.Forms.Label();
            this.label_UserType = new System.Windows.Forms.Label();
            this.comboBox_UserType = new System.Windows.Forms.ComboBox();
            this.label_Hint_UserName = new System.Windows.Forms.Label();
            this.label_Hint_UserPassCheck = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // textBox_UserPass
            // 
            this.textBox_UserPass.Location = new System.Drawing.Point(108, 79);
            this.textBox_UserPass.MaxLength = 20;
            this.textBox_UserPass.Name = "textBox_UserPass";
            this.textBox_UserPass.Size = new System.Drawing.Size(100, 21);
            this.textBox_UserPass.TabIndex = 2;
            this.textBox_UserPass.UseSystemPasswordChar = true;
            // 
            // textBox_UserName
            // 
            this.textBox_UserName.Location = new System.Drawing.Point(108, 37);
            this.textBox_UserName.MaxLength = 10;
            this.textBox_UserName.Name = "textBox_UserName";
            this.textBox_UserName.Size = new System.Drawing.Size(100, 21);
            this.textBox_UserName.TabIndex = 1;
            this.textBox_UserName.TextChanged += new System.EventHandler(this.textBox_UserName_TextChanged);
            this.textBox_UserName.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.textBox_UserName_KeyPress);
            // 
            // label_UserPass
            // 
            this.label_UserPass.AutoSize = true;
            this.label_UserPass.Location = new System.Drawing.Point(58, 82);
            this.label_UserPass.Name = "label_UserPass";
            this.label_UserPass.Size = new System.Drawing.Size(53, 12);
            this.label_UserPass.TabIndex = 13;
            this.label_UserPass.Text = "密  码：";
            // 
            // label_UserName
            // 
            this.label_UserName.AutoSize = true;
            this.label_UserName.Location = new System.Drawing.Point(58, 40);
            this.label_UserName.Name = "label_UserName";
            this.label_UserName.Size = new System.Drawing.Size(53, 12);
            this.label_UserName.TabIndex = 12;
            this.label_UserName.Text = "用户名：";
            // 
            // textBox_UserPassCheck
            // 
            this.textBox_UserPassCheck.Location = new System.Drawing.Point(109, 121);
            this.textBox_UserPassCheck.MaxLength = 20;
            this.textBox_UserPassCheck.Name = "textBox_UserPassCheck";
            this.textBox_UserPassCheck.Size = new System.Drawing.Size(100, 21);
            this.textBox_UserPassCheck.TabIndex = 3;
            this.textBox_UserPassCheck.UseSystemPasswordChar = true;
            this.textBox_UserPassCheck.TextChanged += new System.EventHandler(this.textBox_UserPassCheck_TextChanged);
            // 
            // label_UserPassCheck
            // 
            this.label_UserPassCheck.AutoSize = true;
            this.label_UserPassCheck.Location = new System.Drawing.Point(48, 124);
            this.label_UserPassCheck.Name = "label_UserPassCheck";
            this.label_UserPassCheck.Size = new System.Drawing.Size(65, 12);
            this.label_UserPassCheck.TabIndex = 16;
            this.label_UserPassCheck.Text = "确认密码：";
            // 
            // button_Register
            // 
            this.button_Register.Location = new System.Drawing.Point(158, 250);
            this.button_Register.Name = "button_Register";
            this.button_Register.Size = new System.Drawing.Size(75, 23);
            this.button_Register.TabIndex = 6;
            this.button_Register.Text = "注册";
            this.button_Register.UseVisualStyleBackColor = true;
            this.button_Register.Click += new System.EventHandler(this.button_Register_Click);
            // 
            // button_cancel
            // 
            this.button_cancel.Location = new System.Drawing.Point(51, 250);
            this.button_cancel.Name = "button_cancel";
            this.button_cancel.Size = new System.Drawing.Size(75, 23);
            this.button_cancel.TabIndex = 7;
            this.button_cancel.Text = "取消";
            this.button_cancel.UseVisualStyleBackColor = true;
            this.button_cancel.Click += new System.EventHandler(this.button_cancel_Click);
            // 
            // textBox_UserEmail
            // 
            this.textBox_UserEmail.Location = new System.Drawing.Point(109, 163);
            this.textBox_UserEmail.MaxLength = 20;
            this.textBox_UserEmail.Name = "textBox_UserEmail";
            this.textBox_UserEmail.Size = new System.Drawing.Size(100, 21);
            this.textBox_UserEmail.TabIndex = 4;
            this.textBox_UserEmail.TextChanged += new System.EventHandler(this.textBox_UserEmail_TextChanged);
            // 
            // label_UserEmail
            // 
            this.label_UserEmail.AutoSize = true;
            this.label_UserEmail.Location = new System.Drawing.Point(60, 166);
            this.label_UserEmail.Name = "label_UserEmail";
            this.label_UserEmail.Size = new System.Drawing.Size(53, 12);
            this.label_UserEmail.TabIndex = 18;
            this.label_UserEmail.Text = "邮  箱：";
            // 
            // label_Hint_UserEmail
            // 
            this.label_Hint_UserEmail.AutoSize = true;
            this.label_Hint_UserEmail.Location = new System.Drawing.Point(215, 167);
            this.label_Hint_UserEmail.Name = "label_Hint_UserEmail";
            this.label_Hint_UserEmail.Size = new System.Drawing.Size(53, 12);
            this.label_Hint_UserEmail.TabIndex = 19;
            this.label_Hint_UserEmail.Text = "(可选填)";
            // 
            // label_UserType
            // 
            this.label_UserType.AutoSize = true;
            this.label_UserType.Location = new System.Drawing.Point(49, 209);
            this.label_UserType.Name = "label_UserType";
            this.label_UserType.Size = new System.Drawing.Size(65, 12);
            this.label_UserType.TabIndex = 20;
            this.label_UserType.Text = "用户类型：";
            // 
            // comboBox_UserType
            // 
            this.comboBox_UserType.BackColor = System.Drawing.SystemColors.Window;
            this.comboBox_UserType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_UserType.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.comboBox_UserType.FormattingEnabled = true;
            this.comboBox_UserType.Items.AddRange(new object[] {
            "用户",
            "系统管理员"});
            this.comboBox_UserType.Location = new System.Drawing.Point(109, 206);
            this.comboBox_UserType.Name = "comboBox_UserType";
            this.comboBox_UserType.Size = new System.Drawing.Size(100, 20);
            this.comboBox_UserType.TabIndex = 5;
            // 
            // label_Hint_UserName
            // 
            this.label_Hint_UserName.AutoSize = true;
            this.label_Hint_UserName.Location = new System.Drawing.Point(215, 40);
            this.label_Hint_UserName.Name = "label_Hint_UserName";
            this.label_Hint_UserName.Size = new System.Drawing.Size(29, 12);
            this.label_Hint_UserName.TabIndex = 22;
            this.label_Hint_UserName.Text = "null";
            // 
            // label_Hint_UserPassCheck
            // 
            this.label_Hint_UserPassCheck.AutoSize = true;
            this.label_Hint_UserPassCheck.Location = new System.Drawing.Point(215, 124);
            this.label_Hint_UserPassCheck.Name = "label_Hint_UserPassCheck";
            this.label_Hint_UserPassCheck.Size = new System.Drawing.Size(29, 12);
            this.label_Hint_UserPassCheck.TabIndex = 23;
            this.label_Hint_UserPassCheck.Text = "null";
            // 
            // Register
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(294, 301);
            this.ControlBox = false;
            this.Controls.Add(this.label_Hint_UserPassCheck);
            this.Controls.Add(this.label_Hint_UserName);
            this.Controls.Add(this.comboBox_UserType);
            this.Controls.Add(this.label_UserType);
            this.Controls.Add(this.label_Hint_UserEmail);
            this.Controls.Add(this.textBox_UserEmail);
            this.Controls.Add(this.label_UserEmail);
            this.Controls.Add(this.button_Register);
            this.Controls.Add(this.button_cancel);
            this.Controls.Add(this.textBox_UserPassCheck);
            this.Controls.Add(this.label_UserPassCheck);
            this.Controls.Add(this.textBox_UserPass);
            this.Controls.Add(this.textBox_UserName);
            this.Controls.Add(this.label_UserPass);
            this.Controls.Add(this.label_UserName);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "Register";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "新用户注册";
            this.Load += new System.EventHandler(this.Register_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox textBox_UserPass;
        private System.Windows.Forms.TextBox textBox_UserName;
        private System.Windows.Forms.Label label_UserPass;
        private System.Windows.Forms.Label label_UserName;
        private System.Windows.Forms.TextBox textBox_UserPassCheck;
        private System.Windows.Forms.Label label_UserPassCheck;
        private System.Windows.Forms.Button button_Register;
        private System.Windows.Forms.Button button_cancel;
        private System.Windows.Forms.TextBox textBox_UserEmail;
        private System.Windows.Forms.Label label_UserEmail;
        private System.Windows.Forms.Label label_Hint_UserEmail;
        private System.Windows.Forms.Label label_UserType;
        private System.Windows.Forms.ComboBox comboBox_UserType;
        private System.Windows.Forms.Label label_Hint_UserName;
        private System.Windows.Forms.Label label_Hint_UserPassCheck;
    }
}