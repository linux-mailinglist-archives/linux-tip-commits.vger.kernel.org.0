Return-Path: <linux-tip-commits+bounces-4797-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D135A82F9A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 20:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E2F4A0D15
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 18:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EDF27BF82;
	Wed,  9 Apr 2025 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UwwXgD9U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qmdwCcMj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820E27932D;
	Wed,  9 Apr 2025 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224870; cv=none; b=MEiOXTntduqi+DxAJZbuBEgqspVeil+Iklyd/5+18BYquQkW11VeXCFIxmAft95waWg8fakqzFK6NQcllWTVOe07C+Gp90kHOq0//vH/nCEMfiPloRBhTJo0snjBTKgU5XPCG5mqPSEjRv0YhuMm5SPE1lkkbtghqHyu61hOEpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224870; c=relaxed/simple;
	bh=mMG6xH4tZQ2fTDUJgPzk70r/8nOTLnpgQpsI7uB3zkw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dN04Pho3S3OGLzPw45NaR/2ycbczZ5WjMiKWbcD7Ok4HRxq1YDVbHGgHXAMvzespj+QMEnMJTlmPh2d08qLlviDtZ9SsxkHM8pJeMMeHlsxptEAX6qvPLWwR66B1uNHzb4PM4L1j1Dgo5oQ01id41xyyrOAC6Mv+PoOgZZVW7rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UwwXgD9U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qmdwCcMj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 18:54:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744224867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WvAiMyF7rx9J7jNxozNCGf3dIM4d28Yv0WOtKBRR93E=;
	b=UwwXgD9Uaam9Ybj4wH/+FRdmgZ8/KhwvEfNNLFF0fZa8qOEyDKRhnFr1dSj+F4DgQeDHuh
	QqY32w32arlsTIlbz4AinPn5j8EZu74THo7PsNTqKWLFDradoNSz6jglWj2lslUGm6WYgf
	GkEnqyO/YkdMXZ6UHYn3Ceb9OZFLC60CkI2FigPWb4m0c4cTdfS56vgab8JToThvU9fFBK
	D0nxw/tzZMCOfM5IeNp0FgCLOBmvsi0TZ57929J4ezXrRyid8s10+4jZcNklfjAfvyc7wF
	9igIBLR4zWndZd6U0Knz3jrLcOrxsFlGDDXsi5C/rC5blmQYXKxJwT6LOen+og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744224867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WvAiMyF7rx9J7jNxozNCGf3dIM4d28Yv0WOtKBRR93E=;
	b=qmdwCcMjZaRzNPkNIIIh52RQvpfA6XflWYv9lHO8GgXHrQ71xZDLAUTIAGa9s5y3vtj7AO
	1eHer5EkCwdhBkCg==
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
Message-ID: <174422486256.31282.18049333911691421551.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     9357e329cdeb6f2d27b431a22d4965700bec478a
Gitweb:        https://git.kernel.org/tip/9357e329cdeb6f2d27b431a22d4965700bec478a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:57:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Apr 2025 20:47:30 +02:00

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
index 5747d20..a8f7701 100644
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

