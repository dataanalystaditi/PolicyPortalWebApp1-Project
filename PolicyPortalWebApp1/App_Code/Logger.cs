using System;
using System.IO;
using System.Web;

public static class Logger
{
    public static void Write(string message)
    {
        try
        {
            string basePath = @"C:\PIP 2025 Learnings\3_Policy_Portal_Project\PolicyPortalWebApp1\Logs";
            if (!Directory.Exists(basePath))
                Directory.CreateDirectory(basePath);

            string fileName;

            // Create or reuse the session-based log file
            if (HttpContext.Current.Session["LogFileName"] == null)
            {
                string timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                fileName = $"Log_{timestamp}.txt";
                HttpContext.Current.Session["LogFileName"] = fileName;
            }
            else
            {
                fileName = HttpContext.Current.Session["LogFileName"].ToString();
            }

            string fullPath = Path.Combine(basePath, fileName);

            using (StreamWriter writer = new StreamWriter(fullPath, true))
            {
                writer.WriteLine($"{DateTime.Now:yyyy-MM-dd HH:mm:ss} - {message}");
            }
        }
        catch
        {
            // Fail silently to avoid crashing app
        }
    }
}
