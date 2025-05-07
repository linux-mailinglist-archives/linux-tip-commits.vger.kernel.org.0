Return-Path: <linux-tip-commits+bounces-5391-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1059CAADAE0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364E91BC6A6F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D2823D285;
	Wed,  7 May 2025 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rh0SfnZ5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8VRKm0RI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CC323AE9A;
	Wed,  7 May 2025 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608857; cv=none; b=lhC7PopCzdBCtbeznL6Naac8HtDcpUUA67pmpYoU5Z+hl5f4b+pVCx0wW/T8yOFnk1KaKAZop3RIN3UUIcK+YONPcNxtzHSqdPUL1eSncmOLuHv/8ooDVCPwglKj6J7ry5vopxiQMMAU37fP94rfv/+8cGgvn5BW1LuGjL+HCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608857; c=relaxed/simple;
	bh=7LB1jZ5SZIyGiH/ZE2i6dr//AiZpQ+WqiiGDS4XNnZs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tK8+sqY1+88IyC75YbUOlxMA+oAFx9p9CG9SO0KjSlgeFSoh84a8wLWpa7iKWU7lTLGknEUv8Qn8JaeEgicGwa3dlTggx3gzPu/2418xOs+oo/SygNx7jyj+GvZcfpTR4FC3MInJkonDUTBCmly1B7bDFZh42jOEpyCrFZ98fyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rh0SfnZ5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8VRKm0RI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608854;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HQlmlm4e/irEZM4O9bIJ18NSSxhbiUKer/6NEw3L84=;
	b=rh0SfnZ5/X/foz89CyFL/+NGeB1uXVaTEh3Rz3LrqAbZ5kYdR/oWLR3MIYYV65kX7v4uJm
	dFp50eE7iY/FpOX8eJm3ZulIPex5rnxITPG80AMws3zRwhIgMsO0MpGZ4zrkRAPzyR3ylB
	puTUlvq3BWWTineCQitijEtvTgdwnkKR4BYENkW+3W5kNrvkXzkLnuAPX6FsI9pF2pYyOL
	snYXFfykARzOMs/7rtkSY4jkNz6ne+wDCCo53l8i/KCceSanqGb+wBFb77/7vqlfTIP3z+
	X1Ch7Bh/BAw5S+qHfBx8v7/1iRnPyVmfOfuG+UksbZW2oLoV+0erF0ajE/Z8Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608854;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HQlmlm4e/irEZM4O9bIJ18NSSxhbiUKer/6NEw3L84=;
	b=8VRKm0RIJ1G/EqodG+BaTtekgYwz9RaBU3VmLbaQHgqh3tYYRwEUBXgIQBmHeGrUDUbuUv
	Ak+/v9AbxPQLoFBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Rework irq_set_handler_data()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065421.415072350@linutronix.de>
References: <20250429065421.415072350@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660885345.406.17061411459611878456.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     321a0fdf1337c5449a589b3d8186b23ecd36b240
Gitweb:        https://git.kernel.org/tip/321a0fdf1337c5449a589b3d8186b23ecd36b240
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:14 +02:00

genirq/chip: Rework irq_set_handler_data()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065421.415072350@linutronix.de


---
 kernel/irq/chip.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 0904886..7694e3e 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -67,22 +67,19 @@ int irq_set_irq_type(unsigned int irq, unsigned int type)
 EXPORT_SYMBOL(irq_set_irq_type);
 
 /**
- *	irq_set_handler_data - set irq handler data for an irq
- *	@irq:	Interrupt number
- *	@data:	Pointer to interrupt specific data
+ * irq_set_handler_data - set irq handler data for an irq
+ * @irq:	Interrupt number
+ * @data:	Pointer to interrupt specific data
  *
- *	Set the hardware irq controller data for an irq
+ * Set the hardware irq controller data for an irq
  */
 int irq_set_handler_data(unsigned int irq, void *data)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
-
-	if (!desc)
-		return -EINVAL;
-	desc->irq_common_data.handler_data = data;
-	irq_put_desc_unlock(desc, flags);
-	return 0;
+	scoped_irqdesc_get_and_lock(irq, 0) {
+		scoped_irqdesc->irq_common_data.handler_data = data;
+		return 0;
+	}
+	return -EINVAL;
 }
 EXPORT_SYMBOL(irq_set_handler_data);
 

