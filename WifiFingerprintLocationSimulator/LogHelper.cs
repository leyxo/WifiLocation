using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WifiFingerprintLocationSimulator
{
    public abstract class LogHelper
    {
        private static string logData;
        public static string logPath = "C:\\Users\\Public\\WifiLocation.log";

        public static void generateLog(string log)
        {
            //如果文件不存在，则创建；存在则覆盖
            //该方法写入字符数组换行显示
            string[] lines = { DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "  " + log };
            //System.IO.File.AppendAllLines(@"C:\WifiLocation.log", lines, Encoding.UTF8);

            //在将文本写入文件前，处理文本行
            //StreamWriter一个参数默认覆盖
            //StreamWriter第二个参数为false覆盖现有文件，为true则把文本追加到文件末尾
            using (System.IO.StreamWriter file = new System.IO.StreamWriter(@logPath, true))
            {
                foreach (string line in lines)
                {
                    file.WriteLine(line);
                }
            }
        }
    }
}
