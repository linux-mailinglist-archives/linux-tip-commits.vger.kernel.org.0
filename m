Return-Path: <linux-tip-commits+bounces-5387-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1643AAADADB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0866E1BC5C4F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0FE23AE84;
	Wed,  7 May 2025 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HupnvuZj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zvm7dBCs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE340239E85;
	Wed,  7 May 2025 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608855; cv=none; b=XWhUMRDAGR6iPyWDwatbfepYiAkl8BdLzn+gnbnMzoZP0MLDoUTmNdKoXjbOAY6YFg2LB3cuFWpkSAAaq28cIE+yaF6mnjn0XTj/wRCijcapNrt5sVfBJLVIDUOMcagv0N4EQ43XJ5lBKw2c9Wb3GCK28wf55qSggQKtu4ql1Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608855; c=relaxed/simple;
	bh=lCCvgwajwZTdn3n2gxjj4GolcFyCPMml7eGv4U64Yd4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uvMrJ0VGMTV2m3pFP7fLriDZwwXdQwVhbDz4OFAZhRNQQguZEhOclOJNiNSI5Rx9TK1VNvJMTdnmikZSGHUZh24mrWqrSqC25iBz1n1b4jJQXtfn3vNjPmneH/tG6W3u+gCOyeVzlQmuo9sCvAWsw4guxRPkGSAIc0LQ4d/Uygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HupnvuZj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zvm7dBCs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608852;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iqfw9Sgn6gVQJNHS5CcF0UCMfiA9g4/YQ7JijDD1ljc=;
	b=HupnvuZjBguQXzZDbVsZ9mMVSkzXD4IPHP2sy7yt4udsfh/oeDQsuYy9eDHOx0DOwBMZgV
	msldNlvdspJ4VuMOXjQ2uVd8hI1Hk8KEeOJ0KvRSQa0XmAbqzJTqsSohBFdzRu3hZaEyTD
	5bbBNVstyzEKrNRKcplnnlQYlyiTlV4eicF8s6TNfsSYlUuHDdhfJQiLBQylEnnLFR/jQO
	SDakQBGF7oKOnSxXea5lfQ+BDRYoXFzqN8RUjftQx0C+H6DKGFZAOgV2ER56NFkB2/R55E
	W5zSyU3cUiS8uUC/P3icBIkTrCfk9DWZ9sKeYLmgisPF57eZom231oJwH+xJig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608852;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iqfw9Sgn6gVQJNHS5CcF0UCMfiA9g4/YQ7JijDD1ljc=;
	b=Zvm7dBCsSIWu/rliw9XC4dvbEPXfryhKRnvzUi12MYDd5EfEaHRIpmbY6ig4HJpUyV2jzz
	TfQ/vWQtBRbyzmCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Rework irq_set_handler() variants
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065421.590753128@linutronix.de>
References: <20250429065421.590753128@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660885141.406.3425428725244045573.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5cd05f3e23152b97e0be09938c78058395c3ee19
Gitweb:        https://git.kernel.org/tip/5cd05f3e23152b97e0be09938c78058395c3ee19
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:14 +02:00

genirq/chip: Rework irq_set_handler() variants

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065421.590753128@linutronix.de


---
 kernel/irq/chip.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 2041225..7f1c640 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -941,35 +941,23 @@ __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
 	}
 }
 
-void
-__irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
-		  const char *name)
+void __irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
+		       const char *name)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, 0);
-
-	if (!desc)
-		return;
-
-	__irq_do_set_handler(desc, handle, is_chained, name);
-	irq_put_desc_busunlock(desc, flags);
+	scoped_irqdesc_get_and_lock(irq, 0)
+		__irq_do_set_handler(scoped_irqdesc, handle, is_chained, name);
 }
 EXPORT_SYMBOL_GPL(__irq_set_handler);
 
-void
-irq_set_chained_handler_and_data(unsigned int irq, irq_flow_handler_t handle,
-				 void *data)
+void irq_set_chained_handler_and_data(unsigned int irq, irq_flow_handler_t handle,
+				      void *data)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, 0);
+	scoped_irqdesc_get_and_buslock(irq, 0) {
+		struct irq_desc *desc = scoped_irqdesc;
 
-	if (!desc)
-		return;
-
-	desc->irq_common_data.handler_data = data;
-	__irq_do_set_handler(desc, handle, 1, NULL);
-
-	irq_put_desc_busunlock(desc, flags);
+		desc->irq_common_data.handler_data = data;
+		__irq_do_set_handler(desc, handle, 1, NULL);
+	}
 }
 EXPORT_SYMBOL_GPL(irq_set_chained_handler_and_data);
 

