Return-Path: <linux-tip-commits+bounces-5392-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7B8AADAE8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E5A504254
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B580823D2B9;
	Wed,  7 May 2025 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gz0y8urN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OF1TMOvU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB12123C4E1;
	Wed,  7 May 2025 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608858; cv=none; b=F1oINNMLt5r3ma2sAAunwfCrllNoh7GDjV4Wmu7O/xQCu8CtG/TclWy/k4uSEN12R0ywlTrayYdzj4x20DSQ1JLzdkGjNFqJyiWWzyYqXXFmXdvoqqYriTmISeb5nb4/pzyVnUwEzJLuoj59DvonPRLrUJWjerOZuHlx/i/SJp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608858; c=relaxed/simple;
	bh=wfmMmQwu29xG7BjPxFnxeephH3GjtviGyGPBNk1HkeE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I2eeln0cfBXWypDW6m5xqHsBqR9uuGr8iU/w7vFlfrHOdqGvw1lACF6twq2SuvNOhsyHAoHOwpSZ1TASquLW7H73YxUF3C4ZBMKy/MOyRyOw16AxZZIIZNPHv/kov3ss2SQgUCjzP8rz1N2EnUiX/BNd98wFBAvkMgEgPY0Is8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gz0y8urN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OF1TMOvU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608854;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1+1UZ+qZefEpBVuLThVlW1wH14huP+7G2rUVkUp+MM=;
	b=gz0y8urNxgznPjeN4NWA2WY/5PVJ3lPzzDRC+q9EJ2fAg/DsWONbpZKwtJl4no4XUMcexS
	YPx5q4BoQTY1g8JdRpkoBorNjl1o0JR1+S3N7W4mkvwSbrIoQh+TOoxXqMQH1D9cSiJKV9
	v0RlRrqmT80ySEdQrGICMIDxD+Wp+yTHGiwSaW2M117j1APJrMekdd1+7gQ/u4q2JQbI00
	p6JmwzOmsEw5zOxXNJ6MU7vM5uLMJEG5kMJ8nfOEgBE+9IhLtc2FQkTGe0+YUmCKkkQwwL
	+m0VrhTrU2tc7MNB7p/a+YuOfFgt6va9iqMaGnsDcRYKiJUF5Wvs1fZz+uCNsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608854;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1+1UZ+qZefEpBVuLThVlW1wH14huP+7G2rUVkUp+MM=;
	b=OF1TMOvUK17ldC0rSGiymtDISGNl5mRyWgCuuaKtFvoNXxT3zYHMTAynK0FfLf72DXcXYw
	BcD9H6XDcU3EhaBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Rework irq_set_irq_type()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065421.355673840@linutronix.de>
References: <20250429065421.355673840@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660885411.406.16646641237641068739.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fa870e0f3551cfff90c7d0261e8f208a83097946
Gitweb:        https://git.kernel.org/tip/fa870e0f3551cfff90c7d0261e8f208a83097946
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:13 +02:00

genirq/chip: Rework irq_set_irq_type()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065421.355673840@linutronix.de


---
 kernel/irq/chip.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 92bf81a..0904886 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -54,22 +54,15 @@ int irq_set_chip(unsigned int irq, const struct irq_chip *chip)
 EXPORT_SYMBOL(irq_set_chip);
 
 /**
- *	irq_set_irq_type - set the irq trigger type for an irq
- *	@irq:	irq number
- *	@type:	IRQ_TYPE_{LEVEL,EDGE}_* value - see include/linux/irq.h
+ * irq_set_irq_type - set the irq trigger type for an irq
+ * @irq:	irq number
+ * @type:	IRQ_TYPE_{LEVEL,EDGE}_* value - see include/linux/irq.h
  */
 int irq_set_irq_type(unsigned int irq, unsigned int type)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
-	int ret = 0;
-
-	if (!desc)
-		return -EINVAL;
-
-	ret = __irq_set_trigger(desc, type);
-	irq_put_desc_busunlock(desc, flags);
-	return ret;
+	scoped_irqdesc_get_and_buslock(irq, IRQ_GET_DESC_CHECK_GLOBAL)
+		return __irq_set_trigger(scoped_irqdesc, type);
+	return -EINVAL;
 }
 EXPORT_SYMBOL(irq_set_irq_type);
 

