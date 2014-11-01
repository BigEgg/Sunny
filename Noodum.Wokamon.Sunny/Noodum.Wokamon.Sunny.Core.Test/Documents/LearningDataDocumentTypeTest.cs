using Microsoft.VisualStudio.TestTools.UnitTesting;
using Noodum.Wokamon.Sunny.Core.Algorithms;
using Noodum.Wokamon.Sunny.Core.Documents;
using Noodum.Wokamon.Sunny.Core.Models;
using System;
using System.IO;

namespace Noodum.Wokamon.Sunny.Core.Test.Documents
{
    [TestClass]
    public class LearningDataDocumentTypeTest
    {
        [TestCleanup]
        public void TestCleanup()
        {
            if (Directory.Exists(LearningDataDocumentType.FileRootPath))
            {
                Directory.Delete(LearningDataDocumentType.FileRootPath, true);
            }
        }

        [TestMethod]
        public void GeneralTest()
        {
            Assert.IsNotNull(LearningDataDocumentType.FileRootPath);
            Assert.IsFalse(String.IsNullOrWhiteSpace(LearningDataDocumentType.FileRootPath));
            Assert.IsTrue(Path.IsPathRooted(LearningDataDocumentType.FileRootPath));
        }

        [TestMethod]
        public void GetFilePathTest_WithPhoneType()
        {
            var filePath = LearningDataDocumentType.GetFilePath(PhoneType.iPhone4S, AlgorithmType.COS, ANNLogicType.MoveDetailType);

            var folder = Path.GetDirectoryName(filePath);
            var fileName = Path.GetFileNameWithoutExtension(filePath);
            var extension = Path.GetExtension(filePath);

            Assert.AreEqual(LearningDataDocumentType.FileRootPath, folder);
            Assert.AreEqual("iPhone4S_COS_MoveDetailType", fileName);
            Assert.AreEqual(".learning", extension);
        }

        [TestMethod]
        public void GetFilePathTest_WithoutPhoneType()
        {
            var filePath = LearningDataDocumentType.GetFilePath(AlgorithmType.COS, ANNLogicType.MoveDetailType);

            var folder = Path.GetDirectoryName(filePath);
            var fileName = Path.GetFileNameWithoutExtension(filePath);
            var extension = Path.GetExtension(filePath);

            Assert.AreEqual(LearningDataDocumentType.FileRootPath, folder);
            Assert.AreEqual("COS_MoveDetailType", fileName);
            Assert.AreEqual(".learning", extension);
        }

        [TestMethod]
        public void NewTest()
        {
            var document = LearningDataDocumentType.New();
            Assert.IsNotNull(document);
        }

        [TestMethod]
        public void SaveTest_WithPhoneType()
        {
            var learningData = new LearningData();
            learningData.InputData.Add(1);
            learningData.InputData.Add(1);
            learningData.OutputData.Add(2);
            var document = LearningDataDocumentType.New();
            document.Data.Add(learningData);
            LearningDataDocumentType.Save(document, PhoneType.iPhone4S, AlgorithmType.COS, ANNLogicType.MoveDetailType);

            var filePath = LearningDataDocumentType.GetFilePath(PhoneType.iPhone4S, AlgorithmType.COS, ANNLogicType.MoveDetailType);
            Assert.IsTrue(File.Exists(filePath));
        }

        [TestMethod]
        public void SaveTest_WithoutPhoneType()
        {
            var learningData = new LearningData();
            learningData.InputData.Add(1);
            learningData.InputData.Add(1);
            learningData.OutputData.Add(2);
            var document = LearningDataDocumentType.New();
            document.Data.Add(learningData);
            LearningDataDocumentType.Save(document, AlgorithmType.COS, ANNLogicType.MoveDetailType);

            var filePath = LearningDataDocumentType.GetFilePath(AlgorithmType.COS, ANNLogicType.MoveDetailType);
            Assert.IsTrue(File.Exists(filePath));
        }

    }
}
