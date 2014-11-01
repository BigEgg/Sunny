using Noodum.Wokamon.Sunny.Core.Models;
using Noodum.Wokamon.Sunny.Learning.Models;
using System;
using System.Collections.Generic;

namespace Noodum.Wokamon.Sunny.Learning.Commons
{
    public static class ANNLogicResult
    {
        private static Dictionary<DocumentInfo, double> walkRunResult;
        private static Dictionary<DocumentInfo, double> moveDetailResult;


        static ANNLogicResult()
        {
            walkRunResult = new Dictionary<DocumentInfo, double>();
            moveDetailResult = new Dictionary<DocumentInfo, double>();
            int updateInterval = 5;

            foreach (PhoneType phoneType in Enum.GetValues(typeof(PhoneType)))
            {
                var documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Stop
                };
                walkRunResult.Add(documentInfo, 0);
                moveDetailResult.Add(documentInfo, 0);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Shake | PhoneState.Left
                };
                walkRunResult.Add(documentInfo, 1);
                moveDetailResult.Add(documentInfo, 1);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Shake | PhoneState.Right
                };
                walkRunResult.Add(documentInfo, 1);
                moveDetailResult.Add(documentInfo, 2);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Walk | PhoneState.Left | PhoneState.Handheld
                };
                walkRunResult.Add(documentInfo, 2);
                moveDetailResult.Add(documentInfo, 3);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Walk | PhoneState.Left | PhoneState.Using
                };
                walkRunResult.Add(documentInfo, 2);
                moveDetailResult.Add(documentInfo, 4);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Walk | PhoneState.Left | PhoneState.Pocket
                };
                walkRunResult.Add(documentInfo, 2);
                moveDetailResult.Add(documentInfo, 5);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Walk | PhoneState.Left | PhoneState.Handbag
                };
                walkRunResult.Add(documentInfo, 2);
                moveDetailResult.Add(documentInfo, 6);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Walk | PhoneState.Left | PhoneState.TrousersFrontPocket
                };
                walkRunResult.Add(documentInfo, 2);
                moveDetailResult.Add(documentInfo, 7);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Walk | PhoneState.Left | PhoneState.TrousersBackPocket
                };
                walkRunResult.Add(documentInfo, 2);
                moveDetailResult.Add(documentInfo, 8);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Walk | PhoneState.Right | PhoneState.Handheld
                };
                walkRunResult.Add(documentInfo, 2);
                moveDetailResult.Add(documentInfo, 9);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Walk | PhoneState.Right | PhoneState.Using
                };
                walkRunResult.Add(documentInfo, 2);
                moveDetailResult.Add(documentInfo, 10);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Walk | PhoneState.Right | PhoneState.Pocket
                };
                walkRunResult.Add(documentInfo, 2);
                moveDetailResult.Add(documentInfo, 11);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Walk | PhoneState.Right | PhoneState.Handbag
                };
                walkRunResult.Add(documentInfo, 2);
                moveDetailResult.Add(documentInfo, 12);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Walk | PhoneState.Right | PhoneState.TrousersFrontPocket
                };
                walkRunResult.Add(documentInfo, 2);
                moveDetailResult.Add(documentInfo, 13);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Walk | PhoneState.Right | PhoneState.TrousersBackPocket
                };
                walkRunResult.Add(documentInfo, 2);
                moveDetailResult.Add(documentInfo, 14);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Run | PhoneState.Left | PhoneState.Handheld
                };
                walkRunResult.Add(documentInfo, 3);
                moveDetailResult.Add(documentInfo, 15);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Run | PhoneState.Left | PhoneState.Using
                };
                walkRunResult.Add(documentInfo, 3);
                moveDetailResult.Add(documentInfo, 16);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Run | PhoneState.Left | PhoneState.Pocket
                };
                walkRunResult.Add(documentInfo, 3);
                moveDetailResult.Add(documentInfo, 17);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Run | PhoneState.Left | PhoneState.Handbag
                };
                walkRunResult.Add(documentInfo, 3);
                moveDetailResult.Add(documentInfo, 18);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Run | PhoneState.Left | PhoneState.TrousersFrontPocket
                };
                walkRunResult.Add(documentInfo, 3);
                moveDetailResult.Add(documentInfo, 19);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Run | PhoneState.Left | PhoneState.TrousersBackPocket
                };
                walkRunResult.Add(documentInfo, 3);
                moveDetailResult.Add(documentInfo, 20);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Run | PhoneState.Right | PhoneState.Handheld
                };
                walkRunResult.Add(documentInfo, 3);
                moveDetailResult.Add(documentInfo, 21);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Run | PhoneState.Right | PhoneState.Using
                };
                walkRunResult.Add(documentInfo, 3);
                moveDetailResult.Add(documentInfo, 22);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Run | PhoneState.Right | PhoneState.Pocket
                };
                walkRunResult.Add(documentInfo, 3);
                moveDetailResult.Add(documentInfo, 23);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Run | PhoneState.Right | PhoneState.Handbag
                };
                walkRunResult.Add(documentInfo, 3);
                moveDetailResult.Add(documentInfo, 24);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Run | PhoneState.Right | PhoneState.TrousersFrontPocket
                };
                walkRunResult.Add(documentInfo, 3);
                moveDetailResult.Add(documentInfo, 25);

                documentInfo = new DocumentInfo
                {
                    UpdateInterval = updateInterval,
                    PhoneType = phoneType,
                    PhoneState = PhoneState.Run | PhoneState.Right | PhoneState.TrousersBackPocket
                };
                walkRunResult.Add(documentInfo, 3);
                moveDetailResult.Add(documentInfo, 26);
            }
        }
    }
}
