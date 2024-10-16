Return-Path: <linux-tip-commits+bounces-2471-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 264AC9A132A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1521F228C5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4699E2141B9;
	Wed, 16 Oct 2024 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="19igvSdi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qRreb05J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2A91C07C7;
	Wed, 16 Oct 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109050; cv=none; b=PAiOIAIBSGnAowzaqYZ86sjIbaFR/RI25hqEx+uZF0ytYZBRHTejBhn8qBFfy7eEBtQcvSnUnYZ+WlEwz6FzkuKakaBIrz2FXYUs+mRuHA3mqMq+3+jp/YAs5UVuxggyk+AaPB42u1XBvXy3L7IQBZwMI9npW8GXNhQneG9zBO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109050; c=relaxed/simple;
	bh=NegUyxvPIo0AewzxC2v1Gngpcr9k6R3zwLsRFYw4zrc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lpjkBYyK8m6d48azvR1qjJ9EgLTDTMIiS/FqcCkN83DrgBQ40zu4j5LoAe/JKmWlVnuqsNgM5PMu2qEtM6td3VdN0hz4rHn6ug/6krfbPYrRrFSF4nbsyI6OtzMzI9ufCPuVnROp46rRsj0M9dBHP+A7wQfENe8hyu3vpq448wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=19igvSdi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qRreb05J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109046;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJpJLWfqNlNMV6iR9mISRD3clYKlUQEro1oIxSOSwdA=;
	b=19igvSdivUvAz7BylmYUaXc4hHRPUCN6cBMK63Ycd8Etnqkv5Y7MO8G29dSsGHW8HqBL+T
	I96h2V/nLhb8hH0eJOxB3OS8mbmGah2cL+xKmjz1uP6zofbook62JzHiOrRHyBQI72KDwT
	ZrE1xyGfKNlEHeORsDPMM64GAGLhCLSds0fNrTS50ogbQ4UyfdaQIKS6BHCA95xX2jSRFY
	cbzjrLhU+E1O91O+XelnDrAK4CFh9M6E5y0iTA8L4IcmTZOKEbGJSTFD3YJ9etq6U/CgR1
	5xwBcUjix4H/Eu8dnHB7VSTG+/Qw+6kKmuiuNG3vCym+yHsrEku1UKIOVv7ayQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109046;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJpJLWfqNlNMV6iR9mISRD3clYKlUQEro1oIxSOSwdA=;
	b=qRreb05JqOMfNpAhHW+lkkJAADqjoRo20SQ2H0Py/h8U5upJwcPx/0oeBJ4ebEJ7u7ywyi
	6q/FKEJFgySYK2CQ==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-22-bvanassche@acm.org>
References: <20241015190953.1266194-22-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910904397.1442.10984493492959840181.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     1ad2048bf7146efb83bc033147ca1611a7fe8494
Gitweb:        https://git.kernel.org/tip/1ad2048bf7146efb83bc033147ca1611a7fe8494
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:52 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:59 +02:00

genirq: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Cache the result of this function in a local variable in
order not to rely on CSE (common subexpression elimination). Prepare
for changing 'nr_irqs' from an exported global variable into a variable
with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-22-bvanassche@acm.org

---
 include/linux/irqnr.h  | 33 +++++++++++++++++++--------------
 kernel/irq/irqdomain.c |  2 +-
 kernel/irq/proc.c      |  3 ++-
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/include/linux/irqnr.h b/include/linux/irqnr.h
index 7419b80..a33088d 100644
--- a/include/linux/irqnr.h
+++ b/include/linux/irqnr.h
@@ -11,26 +11,31 @@ unsigned int irq_set_nr_irqs(unsigned int nr);
 extern struct irq_desc *irq_to_desc(unsigned int irq);
 unsigned int irq_get_next_irq(unsigned int offset);
 
-# define for_each_irq_desc(irq, desc)					\
-	for (irq = 0, desc = irq_to_desc(irq); irq < nr_irqs;		\
-	     irq++, desc = irq_to_desc(irq))				\
-		if (!desc)						\
-			;						\
-		else
-
+#define for_each_irq_desc(irq, desc)                                      \
+	for (unsigned int __nr_irqs__ = irq_get_nr_irqs(); __nr_irqs__;   \
+	     __nr_irqs__ = 0)                                             \
+		for (irq = 0, desc = irq_to_desc(irq); irq < __nr_irqs__; \
+		     irq++, desc = irq_to_desc(irq))                      \
+			if (!desc)                                        \
+				;                                         \
+			else
 
 # define for_each_irq_desc_reverse(irq, desc)				\
-	for (irq = nr_irqs - 1, desc = irq_to_desc(irq); irq >= 0;	\
-	     irq--, desc = irq_to_desc(irq))				\
+	for (irq = irq_get_nr_irqs() - 1, desc = irq_to_desc(irq);	\
+	     irq >= 0; irq--, desc = irq_to_desc(irq))			\
 		if (!desc)						\
 			;						\
 		else
 
-# define for_each_active_irq(irq)			\
-	for (irq = irq_get_next_irq(0); irq < nr_irqs;	\
-	     irq = irq_get_next_irq(irq + 1))
+#define for_each_active_irq(irq)                                        \
+	for (unsigned int __nr_irqs__ = irq_get_nr_irqs(); __nr_irqs__; \
+	     __nr_irqs__ = 0)                                           \
+		for (irq = irq_get_next_irq(0); irq < __nr_irqs__;      \
+		     irq = irq_get_next_irq(irq + 1))
 
-#define for_each_irq_nr(irq)                   \
-       for (irq = 0; irq < nr_irqs; irq++)
+#define for_each_irq_nr(irq)                                            \
+	for (unsigned int __nr_irqs__ = irq_get_nr_irqs(); __nr_irqs__; \
+	     __nr_irqs__ = 0)                                           \
+		for (irq = 0; irq < __nr_irqs__; irq++)
 
 #endif
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e0bff21..ec6d8e7 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1225,7 +1225,7 @@ int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
 		virq = __irq_alloc_descs(virq, virq, cnt, node, THIS_MODULE,
 					 affinity);
 	} else {
-		hint = hwirq % nr_irqs;
+		hint = hwirq % irq_get_nr_irqs();
 		if (hint == 0)
 			hint++;
 		virq = __irq_alloc_descs(-1, hint, cnt, node, THIS_MODULE,
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 9081ada..d226282 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -457,11 +457,12 @@ int __weak arch_show_interrupts(struct seq_file *p, int prec)
 }
 
 #ifndef ACTUAL_NR_IRQS
-# define ACTUAL_NR_IRQS nr_irqs
+# define ACTUAL_NR_IRQS irq_get_nr_irqs()
 #endif
 
 int show_interrupts(struct seq_file *p, void *v)
 {
+	const unsigned int nr_irqs = irq_get_nr_irqs();
 	static int prec;
 
 	int i = *(loff_t *) v, j;

