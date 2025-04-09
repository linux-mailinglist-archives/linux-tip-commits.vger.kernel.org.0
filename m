Return-Path: <linux-tip-commits+bounces-4798-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C989A82FC1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 20:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8C5881BDC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6E827C145;
	Wed,  9 Apr 2025 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vm22X855";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C7eAmnaE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF72278171;
	Wed,  9 Apr 2025 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224871; cv=none; b=f58bd4Sfz6+fdLjmlY8NN6HVKTBAR7wLbIRQjY+15ljWJIWpiEjUrGSw8GW5UEw0Q1DvN2tFTc3qgc9buuEwEBKUDaeKTHh5iKbhqhANEVyU0dhsGNVWAbDAw184X7M+lk2FRzH00dt2eMFJdOzDrfOXrQFXe7lRR+HfK41dybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224871; c=relaxed/simple;
	bh=4owLVAEbfJS7emLmWpgzuKm5yE1hRX6LQ+qY3k1RKFg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BjcFQnblAvKUzRGWhveQHVjT4tpOvOFaGpbDeFIZlc9jVMFhjQejPyZQ3BrhUaWBUUEwN73oCPd9Zgc4rBq4AtsYeWqjfxoyXXEYDNryDPXob/Ux8i6JymgK3XcEwdXaIVjXon86DfwxON3ATnfM/Mao72Nxj1oHmF6HzVLDzgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vm22X855; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C7eAmnaE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 18:54:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744224868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGVzoWPSBbP9+gb3S1gtijYHI6RX4m1z6SLguQXG6h4=;
	b=Vm22X855QaRiup76az7q5YfWnvnt4GFQWs9PMCAEtu47IjkAQIv4SsZmFU0pAdRJ1HlmNJ
	BCsX4qWktwpUCBODte59B/JAA1o1xdfopF+ySGG91b4HvJ2O0YEKn+0QNebMuJcpDcRWm7
	SF7vCOpW6q2H78ckgckiUO3+HJl1xGzXkV2EirkYJ6h0hJAkGvYDBbnVLzklXBzA2uz8Ew
	AqaQiHoFCpDFmNVP0/EQdqQaSWApYdGxJRRdQE7Gal4O/K357kYicMKJu75O0ztAIj32wR
	bFkh/gNCpUDMioY6OlzF8CI2PmDWRL3aglW+u2wVJ7u79h3CqEcgqQWf14WjjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744224868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGVzoWPSBbP9+gb3S1gtijYHI6RX4m1z6SLguQXG6h4=;
	b=C7eAmnaEt/XeO0UuWiyXW0N9NCHNCLaVdW6G2KCbmr5PvX8RhzclZq4cksjDPMzTK6UPae
	acErUKZSqaOfwwDw==
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
Message-ID: <174422486739.31282.15192867004661617142.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     e46a28cea29a0ca7d51c811acccf5d119b40c745
Gitweb:        https://git.kernel.org/tip/e46a28cea29a0ca7d51c811acccf5d119b40c745
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:57:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Apr 2025 20:47:30 +02:00

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
index 1b37449..4c05b2d 100644
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
+	retain_and_null_ptr(qi);
 
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

