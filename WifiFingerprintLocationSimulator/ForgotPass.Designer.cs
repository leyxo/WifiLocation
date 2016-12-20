namespace WifiFingerprintLocationSimulator
{
    partial class ForgotPass
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ForgotPass));
            this.textBox_Code = new System.Windows.Forms.TextBox();
            this.label_Code = new System.Windows.Forms.Label();
            this.button_Register = new System.Windows.Forms.Button();
            this.button_cancel = new System.Windows.Forms.Button();
            this.textBox_UserPassCheck = new System.Windows.Forms.TextBox();
            this.label_UserPassCheck = new System.Windows.Forms.Label();
            this.textBox_UserPass = new System.Windows.Forms.TextBox();
            this.textBox_UserName = new System.Windows.Forms.TextBox();
            this.label_UserPass = new System.Windows.Forms.Label();
            this.label_UserName = new System.Windows.Forms.Label();
            this.label_Hint_UserName = new System.Windows.Forms.Label();
            this.label_Hint_Code = new System.Windows.Forms.Label();
            this.button_Send = new System.Windows.Forms.Button();
            this.label_Note = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // textBox_Code
            // 
            this.textBox_Code.Location = new System.Drawing.Point(108, 79);
            this.textBox_Code.MaxLength = 6;
            this.textBox_Code.Name = "textBox_Code";
            this.textBox_Code.Size = new System.Drawing.Size(100, 21);
            this.textBox_Code.TabIndex = 2;
            this.textBox_Code.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.textBox_Code_KeyPress);
            // 
            // label_Code
            // 
            this.label_Code.AutoSize = true;
            this.label_Code.Location = new System.Drawing.Point(59, 82);
            this.label_Code.Name = "label_Code";
            this.label_Code.Size = new System.Drawing.Size(53, 12);
            this.label_Code.TabIndex = 31;
            this.label_Code.Text = "验证码：";
            // 
            // button_Register
            // 
            this.button_Register.Location = new System.Drawing.Point(162, 221);
            this.button_Register.Name = "button_Register";
            this.button_Register.Size = new System.Drawing.Size(75, 23);
            this.button_Register.TabIndex = 5;
            this.button_Register.Text = "提交";
            this.button_Register.UseVisualStyleBackColor = true;
            this.button_Register.Click += new System.EventHandler(this.button_Register_Click);
            // 
            // button_cancel
            // 
            this.button_cancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.button_cancel.Location = new System.Drawing.Point(55, 221);
            this.button_cancel.Name = "button_cancel";
            this.button_cancel.Size = new System.Drawing.Size(75, 23);
            this.button_cancel.TabIndex = 6;
            this.button_cancel.Text = "取消";
            this.button_cancel.UseVisualStyleBackColor = true;
            this.button_cancel.Click += new System.EventHandler(this.button_cancel_Click);
            // 
            // textBox_UserPassCheck
            // 
            this.textBox_UserPassCheck.Location = new System.Drawing.Point(109, 163);
            this.textBox_UserPassCheck.MaxLength = 20;
            this.textBox_UserPassCheck.Name = "textBox_UserPassCheck";
            this.textBox_UserPassCheck.Size = new System.Drawing.Size(100, 21);
            this.textBox_UserPassCheck.TabIndex = 4;
            this.textBox_UserPassCheck.UseSystemPasswordChar = true;
            // 
            // label_UserPassCheck
            // 
            this.label_UserPassCheck.AutoSize = true;
            this.label_UserPassCheck.Location = new System.Drawing.Point(48, 166);
            this.label_UserPassCheck.Name = "label_UserPassCheck";
            this.label_UserPassCheck.Size = new System.Drawing.Size(65, 12);
            this.label_UserPassCheck.TabIndex = 30;
            this.label_UserPassCheck.Text = "确认密码：";
            // 
            // textBox_UserPass
            // 
            this.textBox_UserPass.Location = new System.Drawing.Point(109, 121);
            this.textBox_UserPass.MaxLength = 20;
            this.textBox_UserPass.Name = "textBox_UserPass";
            this.textBox_UserPass.Size = new System.Drawing.Size(100, 21);
            this.textBox_UserPass.TabIndex = 3;
            this.textBox_UserPass.UseSystemPasswordChar = true;
            // 
            // textBox_UserName
            // 
            this.textBox_UserName.Location = new System.Drawing.Point(108, 37);
            this.textBox_UserName.MaxLength = 10;
            this.textBox_UserName.Name = "textBox_UserName";
            this.textBox_UserName.Size = new System.Drawing.Size(100, 21);
            this.textBox_UserName.TabIndex = 1;
            // 
            // label_UserPass
            // 
            this.label_UserPass.AutoSize = true;
            this.label_UserPass.Location = new System.Drawing.Point(59, 124);
            this.label_UserPass.Name = "label_UserPass";
            this.label_UserPass.Size = new System.Drawing.Size(53, 12);
            this.label_UserPass.TabIndex = 29;
            this.label_UserPass.Text = "新密码：";
            // 
            // label_UserName
            // 
            this.label_UserName.AutoSize = true;
            this.label_UserName.Location = new System.Drawing.Point(58, 40);
            this.label_UserName.Name = "label_UserName";
            this.label_UserName.Size = new System.Drawing.Size(53, 12);
            this.label_UserName.TabIndex = 28;
            this.label_UserName.Text = "用户名：";
            // 
            // label_Hint_UserName
            // 
            this.label_Hint_UserName.AutoSize = true;
            this.label_Hint_UserName.Location = new System.Drawing.Point(214, 40);
            this.label_Hint_UserName.Name = "label_Hint_UserName";
            this.label_Hint_UserName.Size = new System.Drawing.Size(29, 12);
            this.label_Hint_UserName.TabIndex = 33;
            this.label_Hint_UserName.Text = "null";
            // 
            // label_Hint_Code
            // 
            this.label_Hint_Code.AutoSize = true;
            this.label_Hint_Code.Location = new System.Drawing.Point(214, 83);
            this.label_Hint_Code.Name = "label_Hint_Code";
            this.label_Hint_Code.Size = new System.Drawing.Size(23, 12);
            this.label_Hint_Code.TabIndex = 32;
            this.label_Hint_Code.Text = "60s";
            // 
            // button_Send
            // 
            this.button_Send.Location = new System.Drawing.Point(214, 78);
            this.button_Send.Name = "button_Send";
            this.button_Send.Size = new System.Drawing.Size(51, 23);
            this.button_Send.TabIndex = 34;
            this.button_Send.Text = "发送";
            this.button_Send.UseVisualStyleBackColor = true;
            this.button_Send.Click += new System.EventHandler(this.button_Send_Click);
            // 
            // label_Note
            // 
            this.label_Note.AutoSize = true;
            this.label_Note.ForeColor = System.Drawing.SystemColors.AppWorkspace;
            this.label_Note.Location = new System.Drawing.Point(48, 115);
            this.label_Note.Name = "label_Note";
            this.label_Note.Size = new System.Drawing.Size(209, 12);
            this.label_Note.TabIndex = 35;
            this.label_Note.Text = "验证码会发送到你注册时填写的邮箱中";
            // 
            // ForgotPass
            // 
            this.AcceptButton = this.button_Register;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.button_cancel;
            this.ClientSize = new System.Drawing.Size(294, 281);
            this.Controls.Add(this.label_Note);
            this.Controls.Add(this.button_Send);
            this.Controls.Add(this.label_Hint_UserName);
            this.Controls.Add(this.label_Hint_Code);
            this.Controls.Add(this.textBox_Code);
            this.Controls.Add(this.label_Code);
            this.Controls.Add(this.button_Register);
            this.Controls.Add(this.button_cancel);
            this.Controls.Add(this.textBox_UserPassCheck);
            this.Controls.Add(this.label_UserPassCheck);
            this.Controls.Add(this.textBox_UserPass);
            this.Controls.Add(this.textBox_UserName);
            this.Controls.Add(this.label_UserPass);
            this.Controls.Add(this.label_UserName);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.KeyPreview = true;
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(310, 320);
            this.MinimizeBox = false;
            this.MinimumSize = new System.Drawing.Size(310, 190);
            this.Name = "ForgotPass";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "忘记密码！";
            this.Load += new System.EventHandler(this.ForgotPass_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.TextBox textBox_Code;
        private System.Windows.Forms.Label label_Code;
        private System.Windows.Forms.Button button_Register;
        private System.Windows.Forms.Button button_cancel;
        private System.Windows.Forms.TextBox textBox_UserPassCheck;
        private System.Windows.Forms.Label label_UserPassCheck;
        private System.Windows.Forms.TextBox textBox_UserPass;
        private System.Windows.Forms.TextBox textBox_UserName;
        private System.Windows.Forms.Label label_UserPass;
        private System.Windows.Forms.Label label_UserName;
        private System.Windows.Forms.Label label_Hint_UserName;
        private System.Windows.Forms.Label label_Hint_Code;
        private System.Windows.Forms.Button button_Send;
        private System.Windows.Forms.Label label_Note;
    }
}