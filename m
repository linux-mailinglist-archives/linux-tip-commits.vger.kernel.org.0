Return-Path: <linux-tip-commits+bounces-5389-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CD9AADADC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644731BC6613
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381FE23BD01;
	Wed,  7 May 2025 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c8io5SMZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u3YDz3JK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609E2239E96;
	Wed,  7 May 2025 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608856; cv=none; b=eH5yj6NxiNynBGn8sLkBNwMVSWQsUGhb4+kGpmSyaPhEB+YB7WTD2CwTZJ5gQpiv287EyMN32NEXjXI2DKsmdvXQyhzPS2e1gRy5ccw46kMSSSLcXcj2lNUXJJ9UZTHEHf8L5ekzWIvsm+bGxOsPMY1/yUW8SBsjpskGhZT631E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608856; c=relaxed/simple;
	bh=KUk3n4eK9We9sLOq98R41XOEwHVu16A2CJzO7VqR5Bo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JJ4vuCjLGwsazfquLs485kV1dK2qMDvcd8tPsbqpggQP7C6qpMYfK4N9MaHssH8vxh8ZI3AFXNI1SsAuPl6WZmuhYUd/+7fVoJjJz2oD1lo3p9xAtkPR0egpauxGmw+/PcT7TLktY+QzCfSJNb2sHSrO7TWqdSzNhaVGIzxvN0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c8io5SMZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u3YDz3JK; arc=none smtp.client-ip=193.142.43.55
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
	bh=8cf2g/IvjBoUZv7eMkZdXAPTf6agcI9GUCP9vcVXU44=;
	b=c8io5SMZBIT3GP2JcutkdJsbA+LIl/dgq2/jQ9uQmmAL4VmrLYkUw8lUlJ/uJT/s79ChMV
	fc7UxEG/Pnxk9X97AWpGL0Yx92yxoHcse2lUV7iTNfpHVfFpP0cTaEvVRF0p/Y0GKKkbub
	HllMb02Z6m8bVpR5wM0uNAyHgIKIg8FmIty8RAhruKCD+CzfhkeKN4X5FW07nYnK8c8oCG
	hGOHr+AWnRXE24GrM1WfEksoQ9wnpTG/w0yI4RoyM5jqryOdjf94hqgWSdcLuLeelK3CKZ
	3wKK7r4f0mOheQAIroTrZjaANLHMc0/IDK08ydwayPuJShtPsF4gDSFc/7RT0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608853;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cf2g/IvjBoUZv7eMkZdXAPTf6agcI9GUCP9vcVXU44=;
	b=u3YDz3JKWtq2/IDIpkDxptWcKr8a12A4NdtlN5PHi3YYeBV0Tum/r22mmYhsn1a7FLIvRZ
	P805MMS94/NFExBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Rework irq_set_chip_data()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065421.532308759@linutronix.de>
References: <20250429065421.532308759@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660885210.406.7025332084240893910.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b3801ddc6883169a2e020dbf06da3723446808ee
Gitweb:        https://git.kernel.org/tip/b3801ddc6883169a2e020dbf06da3723446808ee
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:14 +02:00

genirq/chip: Rework irq_set_chip_data()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065421.532308759@linutronix.de


---
 kernel/irq/chip.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 13d8c89..2041225 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -115,22 +115,19 @@ int irq_set_msi_desc(unsigned int irq, struct msi_desc *entry)
 }
 
 /**
- *	irq_set_chip_data - set irq chip data for an irq
- *	@irq:	Interrupt number
- *	@data:	Pointer to chip specific data
+ * irq_set_chip_data - set irq chip data for an irq
+ * @irq:	Interrupt number
+ * @data:	Pointer to chip specific data
  *
- *	Set the hardware irq chip data for an irq
+ * Set the hardware irq chip data for an irq
  */
 int irq_set_chip_data(unsigned int irq, void *data)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
-
-	if (!desc)
-		return -EINVAL;
-	desc->irq_data.chip_data = data;
-	irq_put_desc_unlock(desc, flags);
-	return 0;
+	scoped_irqdesc_get_and_lock(irq, 0) {
+		scoped_irqdesc->irq_data.chip_data = data;
+		return 0;
+	}
+	return -EINVAL;
 }
 EXPORT_SYMBOL(irq_set_chip_data);
 

