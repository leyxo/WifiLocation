using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WifiFingerprintLocationSimulator
{
    public abstract class CurrentUserInfo
    {
        public static int Id = 0;
        public static string Name = "";
        public static string Type = ""; // "user", "admin"

        // 当前载入地图信息
        public static string MapID = "";// 当前载入地图ID
        public static int MapWidth = 0;// 当前载入地图宽度
        public static int MapHeight = 0;// 当前载入地图高度

        // 当前载入AP节点信息
        public static string ApID = "";// 当前载入AP节点ID

        // 当前所在Panel，用于区分放大显示图示时的显示内容
        public static string Panel = "";// EnvironmentSettings或Simulate
    }
}
