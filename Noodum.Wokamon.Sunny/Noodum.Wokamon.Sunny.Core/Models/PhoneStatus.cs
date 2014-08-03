using System;

namespace Noodum.Wokamon.Sunny.Core.Models
{
    [Flags]
    public enum PhoneStatus
    {
        None = 0x0,

        Stop = 0x1,
        Shake = 0x2,
        Run = 0x4,
        Walk = 0x8,

        Left = 0x10,
        Right = 0x20,

        Handheld = 0x0100,
        Using = 0x0200,
        BackPocket = 0x0400,
        Handbag = 0x0800,
        TrousersFrontPocket = 0x1000,
        TrousersBackPocket = 0x1100
    }
}