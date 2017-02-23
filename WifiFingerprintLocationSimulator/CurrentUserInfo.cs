namespace WifiFingerprintLocationSimulator
{
    public class CurrentUserInfo
    {
        // 当前用户信息
        public static int       Id = 0;
        public static string    Name = "";
        public static string    Type = "";      // "user", "admin"

        // 当前载入地图信息
        public static string    MapID = "";     // 当前载入地图ID
        public static int       MapWidth = 0;   // 当前载入地图宽度
        public static int       MapHeight = 0;  // 当前载入地图高度

        // 当前载入AP节点信息
        public static string    ApID = "";      // 当前载入AP节点ID

        // 当前所在Panel，确定放大图示显示内容
        public static string    Panel = "";     // EnvironmentSettings或Simulate

        // 当前环境设置选项
        public static bool      settings_showCoord = true;      // 显示坐标轴
        public static bool      settings_showAPRadio = true;    // 显示AP节点辐射图示
        
        // 临时存储调用算法，供其他线程创建的private void processer()使用
        public static int       algo = 0;

    }
}
