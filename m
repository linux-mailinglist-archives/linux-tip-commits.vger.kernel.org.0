Return-Path: <linux-tip-commits+bounces-2491-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D969A1361
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFA81F235B3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42E821D179;
	Wed, 16 Oct 2024 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RrWEncwd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HPuOkyBs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FBD21C185;
	Wed, 16 Oct 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109073; cv=none; b=cdiJJVDhAWyhdb/xsOsieTt6b3d6slZq+AHwj8aJ2/h0UacNI7gQYrvGr4BQkIm/YV0GgfEHmmpczdr+NwKp2tig5FfeAxWSCj3FQx/t+dosvG3F9bO/KheJGMvY2Fm9J0X4V0tMDiWCVPttYWUrWZqN3ubIks6AtAFOSKt/Mbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109073; c=relaxed/simple;
	bh=DoBukzS00sPW3AzqNFIk+xsSBSHH9r+QIGlk1oag5Qk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WtCQHDMfRwWxOFhsxebxBE+cNOEPu8eOelNhiPTlbw0g9y283x76FFhmgyI/ErqxQIqV6Dt//2S89dKDPOn3nk2l8v/pDe2Q8XLgHeILam/tocCN75h5eVPGjk6aP4nAuNxdDKSOJaNR88qZHYEXiFL6jrBInconDoHBN9cCHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RrWEncwd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HPuOkyBs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109070;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ba69XaHljNlE1Ru2+3DKTH8gJU8H2eATIfXUHKcuENw=;
	b=RrWEncwdZvBpVMtrDdPcZVTa61o0rTfF/AB+29Or9q5/xHCjLL0kFQUxQIOg6Gg5NqUor4
	IJE3aJ0w4yrfUpb8xyWCX+IhJLLeKDo3ujKzINr6a269ss/t99GZQdmdGFsTSsnWjmzwu1
	AOcRW7wokfu0jH8rdiZ9CZ+IglSD3EGIPV9ovPIi+DdT3Ju/bdd5tvRQ2b9QtBSMrmEQPC
	jgn5u58Mxa3V6jbe1FTm1qLR7NNmGogKS2Rcc0Ye0waypgqQyMaj1/GBnxYo91+SQMD+au
	JatVHF+h6P5owNfXl5iQvvmJ6Kcc8/SqWNru9wLGjU5WGSc7mvVDrdJKm2sKGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109070;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ba69XaHljNlE1Ru2+3DKTH8gJU8H2eATIfXUHKcuENw=;
	b=HPuOkyBsE5SrC5AJm6kG7GW0bZrQ18oefyLnUQqsqgin9jQS8Q+F02+m6lVEKyTCgcuF8E
	PBy5zDuYVLp8kZDw==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq: Introduce irq_get_nr_irqs() and irq_set_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-2-bvanassche@acm.org>
References: <20241015190953.1266194-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910906931.1442.11657321398909787666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5280a14a6079040205a1d968cd80f20448d047c7
Gitweb:        https://git.kernel.org/tip/5280a14a6079040205a1d968cd80f20448d047c7
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:32 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:56 +02:00

genirq: Introduce irq_get_nr_irqs() and irq_set_nr_irqs()

Prepare for changing 'nr_irqs' from an exported global variable into a
variable with file scope.

This will prevent accidental changes of assignments to a local variable
'nr_irqs' into assignments to the global 'nr_irqs' variable.

Suppose that a patch would be submitted for review that removes a
declaration of a local variable with the name 'nr_irqs' and that that patch
does not remove all assignments to that local variable. Such a patch
converts an assignment to a local variable into an assignment into a global
variable. If the 'nr_irqs' assignment is more than three lines away from
other changes, the assignment won't be included in the diff context lines
and hence won't be visible without inspecting the modified file.

With these abstraction series applied, such accidental conversions from
assignments to a local variable into an assignment to a global variable are
converted into a compilation error.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-2-bvanassche@acm.org
---
 include/linux/irqnr.h |  2 ++
 kernel/irq/irqdesc.c  | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/irqnr.h b/include/linux/irqnr.h
index 3496baa..7419b80 100644
--- a/include/linux/irqnr.h
+++ b/include/linux/irqnr.h
@@ -6,6 +6,8 @@
 
 
 extern int nr_irqs;
+unsigned int irq_get_nr_irqs(void) __pure;
+unsigned int irq_set_nr_irqs(unsigned int nr);
 extern struct irq_desc *irq_to_desc(unsigned int irq);
 unsigned int irq_get_next_irq(unsigned int offset);
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 1dee88b..b073395 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -141,6 +141,29 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 int nr_irqs = NR_IRQS;
 EXPORT_SYMBOL_GPL(nr_irqs);
 
+/**
+ * irq_get_nr_irqs() - Number of interrupts supported by the system.
+ */
+unsigned int irq_get_nr_irqs(void)
+{
+	return nr_irqs;
+}
+EXPORT_SYMBOL_GPL(irq_get_nr_irqs);
+
+/**
+ * irq_set_nr_irqs() - Set the number of interrupts supported by the system.
+ * @nr: New number of interrupts.
+ *
+ * Return: @nr.
+ */
+unsigned int irq_set_nr_irqs(unsigned int nr)
+{
+	nr_irqs = nr;
+
+	return nr;
+}
+EXPORT_SYMBOL_GPL(irq_set_nr_irqs);
+
 static DEFINE_MUTEX(sparse_irq_lock);
 static struct maple_tree sparse_irqs = MTREE_INIT_EXT(sparse_irqs,
 					MT_FLAGS_ALLOC_RANGE |

