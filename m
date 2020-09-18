Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F92A26F73A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 09:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgIRHmp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 03:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgIRHmh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 03:42:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F75C06178B;
        Fri, 18 Sep 2020 00:42:37 -0700 (PDT)
Date:   Fri, 18 Sep 2020 07:42:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600414954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7GwwrGZpW75jWgusOJdBv4xKPvUmC1eByWupe/aoRfQ=;
        b=GRucL5yPCdm2rLE2DxgcF89T7hnQHQQzeennrR4/JBvoIgvP+fXKo4ef1+YkYH19xWrQ1m
        19BmTRrrN0npefbjQgRuf3b2xdbnQGDUF3a/5uqNrh4gJV2atntG9/4ARx0EqA6WN4qf/Z
        eMrbyAAs+UUiNFjyKkfuQJScwr6wJbnHAflz4kvMYtH6//igQtf+U0+bTqmd8sVMLTQr1H
        wWMLSnZ4VUQ/vecSZpgln3DdPSe8xtOrurShnVxyart4ekpAodXJvuihaVIper7sFSyPkX
        xbir4V2S65DToOOz/D1W6OuDbDVO7tYrUTXDsXRjm5Ys80K5S/dppsTffXbQSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600414954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7GwwrGZpW75jWgusOJdBv4xKPvUmC1eByWupe/aoRfQ=;
        b=M1fXNz/wNs2AxDhFqmx5Tta5bBLXbUgH3u28dL2s59hE91AOLynOML71Ugo16I6OFvVDhi
        YVxM5b7A3qxes5CA==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] iommu/vt-d: Change flags type to unsigned int in binding mm
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600187413-163670-3-git-send-email-fenghua.yu@intel.com>
References: <1600187413-163670-3-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <160041495386.15536.13013142702886328640.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     2a5054c6e7b16906984ac36a7363ca46b8d99ade
Gitweb:        https://git.kernel.org/tip/2a5054c6e7b16906984ac36a7363ca46b8d99ade
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Tue, 15 Sep 2020 09:30:06 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 17 Sep 2020 19:21:30 +02:00

iommu/vt-d: Change flags type to unsigned int in binding mm

"flags" passed to intel_svm_bind_mm() is a bit mask and should be
defined as "unsigned int" instead of "int".

Change its type to "unsigned int".

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lkml.kernel.org/r/1600187413-163670-3-git-send-email-fenghua.yu@intel.com
---
 drivers/iommu/intel/svm.c   | 7 ++++---
 include/linux/intel-iommu.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index e78a74a..fc90a07 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -446,7 +446,8 @@ out:
 
 /* Caller must hold pasid_mutex, mm reference */
 static int
-intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
+intel_svm_bind_mm(struct device *dev, unsigned int flags,
+		  struct svm_dev_ops *ops,
 		  struct mm_struct *mm, struct intel_svm_dev **sd)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
@@ -1033,7 +1034,7 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
 	struct iommu_sva *sva = ERR_PTR(-EINVAL);
 	struct intel_svm_dev *sdev = NULL;
-	int flags = 0;
+	unsigned int flags = 0;
 	int ret;
 
 	/*
@@ -1042,7 +1043,7 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 	 * and intel_svm etc.
 	 */
 	if (drvdata)
-		flags = *(int *)drvdata;
+		flags = *(unsigned int *)drvdata;
 	mutex_lock(&pasid_mutex);
 	ret = intel_svm_bind_mm(dev, flags, NULL, mm, &sdev);
 	if (ret)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 7322073..9c3e833 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -765,7 +765,7 @@ struct intel_svm {
 	struct mm_struct *mm;
 
 	struct intel_iommu *iommu;
-	int flags;
+	unsigned int flags;
 	u32 pasid;
 	int gpasid; /* In case that guest PASID is different from host PASID */
 	struct list_head devs;
