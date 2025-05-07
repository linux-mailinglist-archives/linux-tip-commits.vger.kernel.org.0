Return-Path: <linux-tip-commits+bounces-5373-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFE3AADABF
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A640B9A15B5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1417233159;
	Wed,  7 May 2025 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MhfmJSN+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AkRsoyhw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205BD231841;
	Wed,  7 May 2025 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608845; cv=none; b=kNtiTPW3DVF5o3SEFrLgxEGkbSFuRgGTQSfpKJahwoSam6hFRt/1oBhbU4HtVvL/HHh8jJ5cNZx5RJcWaOcxajAtg9yiQEE1TcMAhIUG1fOUBYu1og2SBjq3dGN75jAE1dR0NmIF0L/ATs1UICwXoz6dUCLmMBruhBadOCgFuu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608845; c=relaxed/simple;
	bh=RMFrUgKlMpRz+Btk5S8+wA3fxhApC18EEc/WaVgzYsU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k6qNoW1S1O391mtR8RFoZT4d/qEI8GLvz/povYsH9AqlRR1xcpeiPA7jX4Gu5CEQQnVAii7W6QlLECAr3I4aeLJtvRTvV7XAxBdalXb1ZVwrs2kuz5mcsia9KizYTxOFSOlgb/3KY/vBwv1CeiCz6x6uFoxAANL47LVGdlYX1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MhfmJSN+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AkRsoyhw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608842;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ELGCYu82yINbTL/Ek6zFgjU9vSQ0KeWogCUtnpknBUQ=;
	b=MhfmJSN+bcvj/f1PoHS1CbwLF+0pWhIiwNtBtfaWfrpndyBTAuOaYlmKuGUT/xYLIPOq4L
	ybWF+uhc97IXMd8OLwAPuGeM4axLMYU3RyjfuB3tHAcJz1lEthn3CQQ/HPyzqA3GJzFZ38
	riAqdhZbBZyVwj8pFwot0dVIrO5ShyIjT93Z4Jf2xRAcmiuQOXk9OLnG/2/kwkgqBkQTvG
	pU1suyR0GVGH+K0Rs7LqecXmlpMSB5eJkLCc/SW1jHuH53bivRfnz8V6To/AchTfy6NZwq
	iXXcPJpFT08mYCLZN1BM05ELoP1ufX4+pN8i3x3wGfpEEsiMbHwcAGqMFbaZ0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608842;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ELGCYu82yINbTL/Ek6zFgjU9vSQ0KeWogCUtnpknBUQ=;
	b=AkRsoyhwDPEcUsfgW8yw5H5j/0ZXc2mmOZEJMac0tRFw1hmUj43H43AYyXR6UCEd75BrEV
	Glquej+i22CrgqDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Rework prepare_percpu_nmi()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065422.494561120@linutronix.de>
References: <20250429065422.494561120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660884121.406.14369226360250001451.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     65dd1f7ca94fde615684827af285a0475d177b9a
Gitweb:        https://git.kernel.org/tip/65dd1f7ca94fde615684827af285a0475d177b9a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:16 +02:00

genirq/manage: Rework prepare_percpu_nmi()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065422.494561120@linutronix.de


---
 kernel/irq/manage.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index a57e952..c6472b1 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2606,32 +2606,19 @@ err_out:
  */
 int prepare_percpu_nmi(unsigned int irq)
 {
-	unsigned long flags;
-	struct irq_desc *desc;
-	int ret = 0;
+	int ret = -EINVAL;
 
 	WARN_ON(preemptible());
 
-	desc = irq_get_desc_lock(irq, &flags,
-				 IRQ_GET_DESC_CHECK_PERCPU);
-	if (!desc)
-		return -EINVAL;
-
-	if (WARN(!irq_is_nmi(desc),
-		 KERN_ERR "prepare_percpu_nmi called for a non-NMI interrupt: irq %u\n",
-		 irq)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_PERCPU) {
+		if (WARN(!irq_is_nmi(scoped_irqdesc),
+			 "prepare_percpu_nmi called for a non-NMI interrupt: irq %u\n", irq))
+			return -EINVAL;
 
-	ret = irq_nmi_setup(desc);
-	if (ret) {
-		pr_err("Failed to setup NMI delivery: irq %u\n", irq);
-		goto out;
+		ret = irq_nmi_setup(scoped_irqdesc);
+		if (ret)
+			pr_err("Failed to setup NMI delivery: irq %u\n", irq);
 	}
-
-out:
-	irq_put_desc_unlock(desc, flags);
 	return ret;
 }
 

