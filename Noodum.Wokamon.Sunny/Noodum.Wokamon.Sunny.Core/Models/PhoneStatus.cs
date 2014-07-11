using System;

namespace Noodum.Wokamon.Sunny.Core.Models
{
    [Flags]
    public enum PhoneStatus
    {
        Stop = 0x000,
        Shake = 0x001,
        Run = 0x010,
        Walk = 0x011,

        Left = 0x0000,
        Right = 0x1000,

        Handheld = 0x00000000,
        HandheldUsing = 0x00010000,
        BackPocket = 0x00100000,
        Handbag = 0x00110000,
        TrousersFrontPocket = 0x01000000,
        TrousersBackPocket = 0x01010000
    }
}