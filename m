Return-Path: <linux-tip-commits+bounces-4727-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11848A7E29B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 16:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3573BE532
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5631F709E;
	Mon,  7 Apr 2025 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JnjKPgXR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1uwz9Xx/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E7846D;
	Mon,  7 Apr 2025 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036304; cv=none; b=J5rFnFFQbj7RfZmaXRNOuPMgM4B+xxhTQQsaulcJ7TYeqfPF/hrAMCOT0c2oMcbmro0hDtCMKJKg+oWC5mqWAUg579gMnMqM1mOVW8lKT2VXo6BFMb+p+a85Q+EAdpv772U1b3iCj9sGJnwgNbZ1SqHck4d6lY5Gzbt3mLsusr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036304; c=relaxed/simple;
	bh=Y1zuvl3Sd5wGNio18lRljzVW8KTA4U/FcdvA8EtLKmc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lgJbSQ4TnnM1TQhLTAkbKimQDbiqxVu1srLkYUnh4XS9R5Z2p/Rfr9xx3Gk6xAejXlxXCMo0XDtzZZ+wJg24RHtv86H1OIsZ61QC8GRB4ik9ew8SdiM3vBVqHcgyJRlSOIF9UkhTOwLbeqtTFKZ5NQ1qH7JPGWp0zbOnkLD0Ro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JnjKPgXR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1uwz9Xx/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 14:31:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744036300;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEGCXO4a29WgfZchPLAIkyTIEXO+V1geOIPBNRhY9lQ=;
	b=JnjKPgXRlWlOSFuGUE6a5eRTyDEKBPNItkuwRp97nPioq83a5or1+l37TWjU0GK20Bx6+n
	ghCBO3CdCFvJKBX30YWdfxsSWqTSMuhM4YZ3dk/b0Vfb6/5nmvnRDnIVX6eG3PA/AIuvZC
	VbhNfCuG/XO3GAQwxinqaV+mUy1WV4Q/5x80+WCnQ+e3L6Nl7NKvtMbnxye4us6awRPztI
	lrpTMCXxyVJPyYt+UkFIc5oqnOiCglLKGC0qAvTG+tFtfvPEcCfXNKJGPqFnpg8roRffie
	FfnKAFFCNRy5xSqQLKYXL3S2IusIu/wLWsIiB9xI30La1c7VwjrpkVvr85euLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744036300;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEGCXO4a29WgfZchPLAIkyTIEXO+V1geOIPBNRhY9lQ=;
	b=1uwz9Xx/1Mv7l7911h9qQrsHb+0aettazMjEsjdDegRFMC+FggxZ+eRn+7IKsTv/ZRJi9H
	UkrZFmPAJTofeuBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] scsi: ufs: qcom: Remove the MSI descriptor abuse
Cc: Thomas Gleixner <tglx@linutronix.de>,
 James Bottomley <James.Bottomley@HansenPartnership.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319105506.805529593@linutronix.de>
References: <20250319105506.805529593@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174403630018.31282.7389409518079736661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     af93317926c284eddb10feeda7e1854f9925c8c3
Gitweb:        https://git.kernel.org/tip/af93317926c284eddb10feeda7e1854f9925c8c3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:57:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 16:24:56 +02:00

scsi: ufs: qcom: Remove the MSI descriptor abuse

The driver abuses the MSI descriptors for internal purposes. Aside of core
code and MSI providers nothing has to care about their existence. They have
been encapsulated with a lot of effort because this kind of abuse caused
all sorts of issues including a maintainability nightmare.

Rewrite the code so it uses dedicated storage to hand the required
information to the interrupt handler and use a custom cleanup function to
simplify the error path.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Link: https://lore.kernel.org/all/20250319105506.805529593@linutronix.de

---
 drivers/ufs/host/ufs-qcom.c | 85 ++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 1b37449..fb30173 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1806,25 +1806,38 @@ static void ufs_qcom_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	ufshcd_mcq_config_esi(hba, msg);
 }
 
+struct ufs_qcom_irq {
+	unsigned int		irq;
+	unsigned int		idx;
+	struct ufs_hba		*hba;
+};
+
 static irqreturn_t ufs_qcom_mcq_esi_handler(int irq, void *data)
 {
-	struct msi_desc *desc = data;
-	struct device *dev = msi_desc_to_dev(desc);
-	struct ufs_hba *hba = dev_get_drvdata(dev);
-	u32 id = desc->msi_index;
-	struct ufs_hw_queue *hwq = &hba->uhq[id];
+	struct ufs_qcom_irq *qi = data;
+	struct ufs_hba *hba = qi->hba;
+	struct ufs_hw_queue *hwq = &hba->uhq[qi->idx];
 
-	ufshcd_mcq_write_cqis(hba, 0x1, id);
+	ufshcd_mcq_write_cqis(hba, 0x1, qi->idx);
 	ufshcd_mcq_poll_cqe_lock(hba, hwq);
 
 	return IRQ_HANDLED;
 }
 
+static void ufs_qcom_irq_free(struct ufs_qcom_irq *uqi)
+{
+	for (struct ufs_qcom_irq *q = uqi; q->irq; q++)
+		devm_free_irq(q->hba->dev, q->irq, q->hba);
+
+	platform_device_msi_free_irqs_all(uqi->hba->dev);
+	devm_kfree(uqi->hba->dev, uqi);
+}
+
+DEFINE_FREE(ufs_qcom_irq, struct ufs_qcom_irq *, if (_T) ufs_qcom_irq_free(_T))
+
 static int ufs_qcom_config_esi(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	struct msi_desc *desc;
-	struct msi_desc *failed_desc = NULL;
 	int nr_irqs, ret;
 
 	if (host->esi_enabled)
@@ -1835,6 +1848,14 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 	 * 2. Poll queues do not need ESI.
 	 */
 	nr_irqs = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
+
+	struct ufs_qcom_irq *qi __free(ufs_qcom_irq) =
+		devm_kcalloc(hba->dev, nr_irqs, sizeof(*qi), GFP_KERNEL);
+	if (!qi)
+		return -ENOMEM;
+	/* Preset so __free() has a pointer to hba in all error paths */
+	qi[0].hba = hba;
+
 	ret = platform_device_msi_init_and_alloc_irqs(hba->dev, nr_irqs,
 						      ufs_qcom_write_msi_msg);
 	if (ret) {
@@ -1842,41 +1863,31 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 		return ret;
 	}
 
-	msi_lock_descs(hba->dev);
-	msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
-		ret = devm_request_irq(hba->dev, desc->irq,
-				       ufs_qcom_mcq_esi_handler,
-				       IRQF_SHARED, "qcom-mcq-esi", desc);
+	for (int idx = 0; idx < nr_irqs; idx++) {
+		qi[idx].irq = msi_get_virq(hba->dev, idx);
+		qi[idx].idx = idx;
+		qi[idx].hba = hba;
+
+		ret = devm_request_irq(hba->dev, qi[idx].irq, ufs_qcom_mcq_esi_handler,
+				       IRQF_SHARED, "qcom-mcq-esi", qi + idx);
 		if (ret) {
 			dev_err(hba->dev, "%s: Fail to request IRQ for %d, err = %d\n",
-				__func__, desc->irq, ret);
-			failed_desc = desc;
-			break;
+				__func__, qi[idx].irq, ret);
+			qi[idx].irq = 0;
+			return ret;
 		}
 	}
-	msi_unlock_descs(hba->dev);
 
-	if (ret) {
-		/* Rewind */
-		msi_lock_descs(hba->dev);
-		msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
-			if (desc == failed_desc)
-				break;
-			devm_free_irq(hba->dev, desc->irq, hba);
-		}
-		msi_unlock_descs(hba->dev);
-		platform_device_msi_free_irqs_all(hba->dev);
-	} else {
-		if (host->hw_ver.major == 6 && host->hw_ver.minor == 0 &&
-		    host->hw_ver.step == 0)
-			ufshcd_rmwl(hba, ESI_VEC_MASK,
-				    FIELD_PREP(ESI_VEC_MASK, MAX_ESI_VEC - 1),
-				    REG_UFS_CFG3);
-		ufshcd_mcq_enable_esi(hba);
-		host->esi_enabled = true;
-	}
+	retain_ptr(qi);
 
-	return ret;
+	if (host->hw_ver.major == 6 && host->hw_ver.minor == 0 &&
+	    host->hw_ver.step == 0) {
+		ufshcd_rmwl(hba, ESI_VEC_MASK, FIELD_PREP(ESI_VEC_MASK, MAX_ESI_VEC - 1),
+			    REG_UFS_CFG3);
+	}
+	ufshcd_mcq_enable_esi(hba);
+	host->esi_enabled = true;
+	return 0;
 }
 
 static u32 ufs_qcom_freq_to_gear_speed(struct ufs_hba *hba, unsigned long freq)

