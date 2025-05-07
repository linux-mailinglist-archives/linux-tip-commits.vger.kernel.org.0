Return-Path: <linux-tip-commits+bounces-5390-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BDBAADAE6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DA0503432
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB8D23C517;
	Wed,  7 May 2025 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HSvZm+D6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pETW4fR/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1161323A9A0;
	Wed,  7 May 2025 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608857; cv=none; b=Q4RM3I7UmaXKjvcC1GT3xidJYM4Odewi92FCT2Po3VlwN00MoPUuxsMD07nxur2j2ZBN4VXgc/I/asIQ2jChsp3CwmQ906tOrxl9oxXZewdxtYYXzx1q3gZ39p+AIAipJ3yvox25LFXSx3sJ+LjemA6drquubYL/NmGQK3EnmFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608857; c=relaxed/simple;
	bh=2qv5CREuCC0XFTrQxlGfLy5aDi5Fcj0m2spquq3zQV4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DSCK4vp1q08iiUuY8CbNXGMS7DIWu1xWKqLlOE0sijyTnVB1/G1dCMcaxlzZXsB6Z5haUdtDppEg6DJOoLks6qNiGxTC6oqHtvVaWF3x0X6I1hi85X4lPNnc9JXfNG0wTsmO7/7Nfip+39Wv8W7y5FGBKq5fm7kv7AtxJQfeqZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HSvZm+D6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pETW4fR/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608853;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ek1iWkimd+IMzSKuz6jdmSZ753zsS5ggwZV8lYs1CUA=;
	b=HSvZm+D6mLdb2VuNO4hsuYqfNfBbkMFGO+29ko9TeZmOMQcnYmjj5TgoOpVINRXMJNshJ7
	erMwW2cFxcuobXqyf5UlB5ozWeVvZd9N4a2vj3dlOvZX+zzwlZOlDQWFwcKMzVB6kWiygg
	FAnKxtXIIiUmknTYV3vDWX9/L69x0fssycCvlatRYlHNqsXYgsLNX0aioZAgQVhXSXDVtA
	IqtUnujOxjKfTmmkE6A6EYKayip83c9BBjdmVP7AZX7DDkOSkDoZdArv1LnmQ58cOBl6jM
	V4jb5Lm604lsrraBhmPt0Q5g5ehjtZz6uJx5c6sXPpKk+cN9ATliJS33o3XjYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608853;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ek1iWkimd+IMzSKuz6jdmSZ753zsS5ggwZV8lYs1CUA=;
	b=pETW4fR/aVNLHbFl/63M2pPXAkkoZ6jxSx1Btf3D/aOgS1O4Sb9cdyC/VGi7B4JYbLbfr8
	qJ/4iih4Swx3YWCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Rework irq_set_msi_desc_off()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065421.473563978@linutronix.de>
References: <20250429065421.473563978@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660885278.406.13480775529880437200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c836e5a70c59a361559d57ad02ececa40d160cb9
Gitweb:        https://git.kernel.org/tip/c836e5a70c59a361559d57ad02ececa40d160cb9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:14 +02:00

genirq/chip: Rework irq_set_msi_desc_off()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065421.473563978@linutronix.de


---
 kernel/irq/chip.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 7694e3e..13d8c89 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -84,34 +84,30 @@ int irq_set_handler_data(unsigned int irq, void *data)
 EXPORT_SYMBOL(irq_set_handler_data);
 
 /**
- *	irq_set_msi_desc_off - set MSI descriptor data for an irq at offset
- *	@irq_base:	Interrupt number base
- *	@irq_offset:	Interrupt number offset
- *	@entry:		Pointer to MSI descriptor data
+ * irq_set_msi_desc_off - set MSI descriptor data for an irq at offset
+ * @irq_base:	Interrupt number base
+ * @irq_offset:	Interrupt number offset
+ * @entry:		Pointer to MSI descriptor data
  *
- *	Set the MSI descriptor entry for an irq at offset
+ * Set the MSI descriptor entry for an irq at offset
  */
-int irq_set_msi_desc_off(unsigned int irq_base, unsigned int irq_offset,
-			 struct msi_desc *entry)
+int irq_set_msi_desc_off(unsigned int irq_base, unsigned int irq_offset, struct msi_desc *entry)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq_base + irq_offset, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
-
-	if (!desc)
-		return -EINVAL;
-	desc->irq_common_data.msi_desc = entry;
-	if (entry && !irq_offset)
-		entry->irq = irq_base;
-	irq_put_desc_unlock(desc, flags);
-	return 0;
+	scoped_irqdesc_get_and_lock(irq_base + irq_offset, IRQ_GET_DESC_CHECK_GLOBAL) {
+		scoped_irqdesc->irq_common_data.msi_desc = entry;
+		if (entry && !irq_offset)
+			entry->irq = irq_base;
+		return 0;
+	}
+	return -EINVAL;
 }
 
 /**
- *	irq_set_msi_desc - set MSI descriptor data for an irq
- *	@irq:	Interrupt number
- *	@entry:	Pointer to MSI descriptor data
+ * irq_set_msi_desc - set MSI descriptor data for an irq
+ * @irq:	Interrupt number
+ * @entry:	Pointer to MSI descriptor data
  *
- *	Set the MSI descriptor entry for an irq
+ * Set the MSI descriptor entry for an irq
  */
 int irq_set_msi_desc(unsigned int irq, struct msi_desc *entry)
 {

