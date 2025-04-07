Return-Path: <linux-tip-commits+bounces-4726-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EA5A7E28D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 16:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF619421C4D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EC41F63FE;
	Mon,  7 Apr 2025 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ULHIa4J2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hECGIQY7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D81F584F;
	Mon,  7 Apr 2025 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036303; cv=none; b=BEqdV8ZcGrtpu+vyt95UHwtVoyhZ6WUJAZsAnocqOlGTzhhzhMNzq77wHRI/QMMfV0I2ukXCkpGYAYzGhPcpmxEAWueBPUYCIIUa/V5mMDLeZv5d58zl3i2w47GXWA7UWnubHBxZCcdp7w6ELugLFrzumkfIufm6KYyPknmG3QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036303; c=relaxed/simple;
	bh=qu1e18I6RTvaxyeLAbVG8ox7hMPhV/hopmth1TihXIE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KoFx5V6H6+nP28Du8y6CZdVOHx8TBVHypqn1ohnCbrFaJLB1jAWH7dCJd4hajAxxPfANAiER4G/PhisW9hJuC+n57aXz5DkJ7O0G7QehAH1FCScJcvQIhVfoLClZJ6uOppLoUzYrhZaR2NDQjBn86W6CaUE3IspH8hf/7M3vkbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ULHIa4J2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hECGIQY7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 14:31:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744036300;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=quO60zMfqZZo8Nd+WpA+nvKfkDwquj/mnL60vKMj0Kg=;
	b=ULHIa4J226zf5NztiZYDp5p1cy7OMauf7L0Wr4j1pMNvx5lxL03nh2YNmSxJeVlkfgqTbT
	P3WJbo2E2mH62DiDrutmWEPkRK8AqBBiMH8JAEAYAGOfL/TutV4wbrVLX4VK4fbjHx7nV+
	HzS1odsLFzmUXlB/956sqa6/xJFtVfc2xMeHSTsu1u1xAUSOyqUcmIN+IwsofQNUd19q4D
	gYWFWYJYfB25bNYno5bN2NeDIA0AeAEETuLd+tKX/hne6k3pRkpuywFifO7dyInK2MhNTN
	Q26kWlQyqTZeN3sXhVwfTh8VLV8nERZn1zyrO5C20DAcFrOvXpbARn+dIpE6yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744036300;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=quO60zMfqZZo8Nd+WpA+nvKfkDwquj/mnL60vKMj0Kg=;
	b=hECGIQY7C4zV+AH2DEFOjNRjhYTmPcfplxYCKflaaiTpLuzl2RC6vQjwV8gfqcg/+AKpW3
	0DSZSH5JEd68wZAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Rename msi_[un]lock_descs()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huwei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319105506.864699741@linutronix.de>
References: <20250319105506.864699741@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174403629525.31282.2054616009551828048.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     0ee2572d7b843cd7015720eda2e876ecedcdb4bc
Gitweb:        https://git.kernel.org/tip/0ee2572d7b843cd7015720eda2e876ecedcdb4bc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:57:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 16:24:56 +02:00

genirq/msi: Rename msi_[un]lock_descs()

Now that all abuse is gone and the legit users are converted to
guard(msi_descs_lock), rename the lock functions and document them as
internal.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
Link: https://lore.kernel.org/all/20250319105506.864699741@linutronix.de



---
 include/linux/msi.h |  8 ++++----
 kernel/irq/msi.c    | 16 ++++++++++------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 4e43991..8c0ec9f 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -229,11 +229,11 @@ struct msi_dev_domain {
 
 int msi_setup_device_data(struct device *dev);
 
-void msi_lock_descs(struct device *dev);
-void msi_unlock_descs(struct device *dev);
+void __msi_lock_descs(struct device *dev);
+void __msi_unlock_descs(struct device *dev);
 
-DEFINE_LOCK_GUARD_1(msi_descs_lock, struct device, msi_lock_descs(_T->lock),
-		    msi_unlock_descs(_T->lock));
+DEFINE_LOCK_GUARD_1(msi_descs_lock, struct device, __msi_lock_descs(_T->lock),
+		    __msi_unlock_descs(_T->lock));
 
 struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domid,
 				       enum msi_desc_filter filter);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 1d30e47..49c08cc 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -343,26 +343,30 @@ int msi_setup_device_data(struct device *dev)
 }
 
 /**
- * msi_lock_descs - Lock the MSI descriptor storage of a device
+ * __msi_lock_descs - Lock the MSI descriptor storage of a device
  * @dev:	Device to operate on
+ *
+ * Internal function for guard(msi_descs_lock). Don't use in code.
  */
-void msi_lock_descs(struct device *dev)
+void __msi_lock_descs(struct device *dev)
 {
 	mutex_lock(&dev->msi.data->mutex);
 }
-EXPORT_SYMBOL_GPL(msi_lock_descs);
+EXPORT_SYMBOL_GPL(__msi_lock_descs);
 
 /**
- * msi_unlock_descs - Unlock the MSI descriptor storage of a device
+ * __msi_unlock_descs - Unlock the MSI descriptor storage of a device
  * @dev:	Device to operate on
+ *
+ * Internal function for guard(msi_descs_lock). Don't use in code.
  */
-void msi_unlock_descs(struct device *dev)
+void __msi_unlock_descs(struct device *dev)
 {
 	/* Invalidate the index which was cached by the iterator */
 	dev->msi.data->__iter_idx = MSI_XA_MAX_INDEX;
 	mutex_unlock(&dev->msi.data->mutex);
 }
-EXPORT_SYMBOL_GPL(msi_unlock_descs);
+EXPORT_SYMBOL_GPL(__msi_unlock_descs);
 
 static struct msi_desc *msi_find_desc(struct msi_device_data *md, unsigned int domid,
 				      enum msi_desc_filter filter)

