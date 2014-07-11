using System;

namespace Noodum.Wokamon.Sunny.Core.Models
{
    [Flags]
    public enum PhoneStatus
    {
        Stop = 0x0,

        Shake = 0x1,
        Run = 0x2,
        Walk = 0x4,

        Left = 0x10,
        Right = 0x20,

        Handheld = 0x100,
        HandheldUsing = 0x200,
        BackPocket = 0x400,
        Handbag = 0x800,
        TrousersFrontPocket = 0x1000,
        TrousersBackPocket = 0x2000
    }
}