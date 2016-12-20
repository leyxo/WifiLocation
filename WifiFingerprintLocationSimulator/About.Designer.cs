namespace WifiFingerprintLocationSimulator
{
    partial class About
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(About));
            this.button_Awful = new System.Windows.Forms.Button();
            this.label_QuestionContent = new System.Windows.Forms.Label();
            this.button_Gorgeous = new System.Windows.Forms.Button();
            this.label_QuestionTitle = new System.Windows.Forms.Label();
            this.label_Author = new System.Windows.Forms.Label();
            this.label_CopyRight = new System.Windows.Forms.Label();
            this.label_ProjectName = new System.Windows.Forms.Label();
            this.pictureBox_Logo = new System.Windows.Forms.PictureBox();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox_Logo)).BeginInit();
            this.SuspendLayout();
            // 
            // button_Awful
            // 
            this.button_Awful.Location = new System.Drawing.Point(146, 174);
            this.button_Awful.Name = "button_Awful";
            this.button_Awful.Size = new System.Drawing.Size(75, 23);
            this.button_Awful.TabIndex = 19;
            this.button_Awful.TabStop = false;
            this.button_Awful.Text = "太烂了！";
            this.button_Awful.UseVisualStyleBackColor = true;
            this.button_Awful.Click += new System.EventHandler(this.button_Awful_Click);
            this.button_Awful.MouseEnter += new System.EventHandler(this.button_Awful_MouseEnter);
            // 
            // label_QuestionContent
            // 
            this.label_QuestionContent.AutoSize = true;
            this.label_QuestionContent.Location = new System.Drawing.Point(49, 141);
            this.label_QuestionContent.Name = "label_QuestionContent";
            this.label_QuestionContent.Size = new System.Drawing.Size(137, 12);
            this.label_QuestionContent.TabIndex = 18;
            this.label_QuestionContent.Text = "你觉得这个软件怎么样？";
            // 
            // button_Gorgeous
            // 
            this.button_Gorgeous.Location = new System.Drawing.Point(51, 174);
            this.button_Gorgeous.Name = "button_Gorgeous";
            this.button_Gorgeous.Size = new System.Drawing.Size(75, 23);
            this.button_Gorgeous.TabIndex = 17;
            this.button_Gorgeous.Text = "非常好！";
            this.button_Gorgeous.UseVisualStyleBackColor = true;
            this.button_Gorgeous.Click += new System.EventHandler(this.button_Gorgeous_Click);
            // 
            // label_QuestionTitle
            // 
            this.label_QuestionTitle.AutoSize = true;
            this.label_QuestionTitle.Location = new System.Drawing.Point(49, 118);
            this.label_QuestionTitle.Name = "label_QuestionTitle";
            this.label_QuestionTitle.Size = new System.Drawing.Size(77, 12);
            this.label_QuestionTitle.TabIndex = 16;
            this.label_QuestionTitle.Text = "一个小问题：";
            // 
            // label_Author
            // 
            this.label_Author.AutoSize = true;
            this.label_Author.Cursor = System.Windows.Forms.Cursors.Arrow;
            this.label_Author.Location = new System.Drawing.Point(94, 73);
            this.label_Author.Name = "label_Author";
            this.label_Author.Size = new System.Drawing.Size(107, 12);
            this.label_Author.TabIndex = 15;
            this.label_Author.Text = "梁尔越 2013201109";
            // 
            // label_CopyRight
            // 
            this.label_CopyRight.AutoSize = true;
            this.label_CopyRight.Cursor = System.Windows.Forms.Cursors.Arrow;
            this.label_CopyRight.Location = new System.Drawing.Point(94, 50);
            this.label_CopyRight.Name = "label_CopyRight";
            this.label_CopyRight.Size = new System.Drawing.Size(185, 12);
            this.label_CopyRight.TabIndex = 14;
            this.label_CopyRight.Text = "Copyright by Mike Liang (2016)";
            // 
            // label_ProjectName
            // 
            this.label_ProjectName.AutoSize = true;
            this.label_ProjectName.Cursor = System.Windows.Forms.Cursors.Help;
            this.label_ProjectName.Location = new System.Drawing.Point(94, 28);
            this.label_ProjectName.Name = "label_ProjectName";
            this.label_ProjectName.Size = new System.Drawing.Size(131, 12);
            this.label_ProjectName.TabIndex = 13;
            this.label_ProjectName.Text = "室内定位仿真平台 v1.0";
            this.label_ProjectName.Click += new System.EventHandler(this.label_ProjectName_Click);
            // 
            // pictureBox_Logo
            // 
            this.pictureBox_Logo.Image = global::WifiFingerprintLocationSimulator.Properties.Resources.Icon;
            this.pictureBox_Logo.Location = new System.Drawing.Point(15, 20);
            this.pictureBox_Logo.Name = "pictureBox_Logo";
            this.pictureBox_Logo.Size = new System.Drawing.Size(64, 65);
            this.pictureBox_Logo.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox_Logo.TabIndex = 12;
            this.pictureBox_Logo.TabStop = false;
            this.pictureBox_Logo.DoubleClick += new System.EventHandler(this.pictureBox_Logo_DoubleClick);
            // 
            // About
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(284, 217);
            this.ControlBox = false;
            this.Controls.Add(this.button_Awful);
            this.Controls.Add(this.label_QuestionContent);
            this.Controls.Add(this.button_Gorgeous);
            this.Controls.Add(this.label_QuestionTitle);
            this.Controls.Add(this.label_Author);
            this.Controls.Add(this.label_CopyRight);
            this.Controls.Add(this.label_ProjectName);
            this.Controls.Add(this.pictureBox_Logo);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximumSize = new System.Drawing.Size(300, 256);
            this.MinimumSize = new System.Drawing.Size(300, 256);
            this.Name = "About";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "关于";
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox_Logo)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button button_Awful;
        private System.Windows.Forms.Label label_QuestionContent;
        private System.Windows.Forms.Button button_Gorgeous;
        private System.Windows.Forms.Label label_QuestionTitle;
        private System.Windows.Forms.Label label_Author;
        private System.Windows.Forms.Label label_CopyRight;
        private System.Windows.Forms.Label label_ProjectName;
        private System.Windows.Forms.PictureBox pictureBox_Logo;
    }
}