Return-Path: <linux-tip-commits+bounces-1334-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0544D8D8029
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 12:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B518D28B009
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 10:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F7682D6D;
	Mon,  3 Jun 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E3B7z7lu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uKNK0vlA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F85824AA;
	Mon,  3 Jun 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410989; cv=none; b=lQHjCb36LDD/O6BK8CH/C20mu2zBNRJVDWOc4xcgeGS3aKMLpeqh+dD/xQVYbsz1rlozwKTFs902OmPhIkzTdBwGgqrAwoEB32guvtQaKPO73nHQPW+L77OCD1z28Ygq7vIUoKiz2GtxBqRB0O7bG6xqdLamy0reLsrnGE9oia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410989; c=relaxed/simple;
	bh=UhK8pMa60JF30Y6Ipr0e5xfX/FTHilTracTJJHEjBBE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k+vCSCqzbFDXqqpeW+J7rsDNW3eL6uXC4n7Nz/t+snUKu5sk2aSiJxV4gN1ieGNnhIiTqceFbwHqNjn7xNj+1LLIHo8fZazp4LpehjnhWDKYFdR58HBzOikWq/uKEuO/5wJa7l8JBoXj/5gas2OaGJhduTJtGTsthlR/owFbUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E3B7z7lu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uKNK0vlA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Jun 2024 10:36:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717410985;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOiVkvLmakTsrdzKal91vcIAZuc9+0Alsiu9QzCidlU=;
	b=E3B7z7lutFSJZQL0vSABYp4nSStUtG2okIbZa9u2G+Rc3tM/aI1faa0bbuD0RLf5m0dAa+
	lNagoxOw2oX6kH2CFSDBZivPdk/5tUAwWAkPEUKM1vuHtqe6D5TxBUZXa10xVq6eW3b0oI
	m4aNUaTKVc+OVVX1r10IYYCM8BHGXBQJ7weNUZxkIQYNmXX7QX3ErCtkdVVj6hwHfAkAw+
	GH0RCnYSfS9P11Z/MJ9wzChLbf/a4gyyV4ctDb99RMm7RFQD+uKrjz3BToBEE0e4le9nsq
	x6r4578KQa+1hS1/O9XPgqJo00Fh5S3cPW6Eun97Qg3Eg+zHMVfIe612kTw6Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717410985;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOiVkvLmakTsrdzKal91vcIAZuc9+0Alsiu9QzCidlU=;
	b=uKNK0vlA2z+SpPDxVavFtQKkI7D3HV67svKnHA6Q7DDNscN9CDyjaH8OIgugN8HbHBoFAz
	pfsC7yJ+1bUvQZAg==
From: "tip-bot2 for Jinjie Ruan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/debugfs: Print irqdomain flags as
 human-readable strings
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240529091628.3666379-1-ruanjinjie@huawei.com>
References: <20240529091628.3666379-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171741098475.10875.417937352199719133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     cb06c9826991c746039d076df10d40819f88a6bc
Gitweb:        https://git.kernel.org/tip/cb06c9826991c746039d076df10d40819f88a6bc
Author:        Jinjie Ruan <ruanjinjie@huawei.com>
AuthorDate:    Wed, 29 May 2024 09:16:28 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Jun 2024 12:24:51 +02:00

genirq/debugfs: Print irqdomain flags as human-readable strings

Improve the readability of irqdomain debugging information in debugfs by
printing the flags field of domain files as human-readable strings instead
of a raw bitmask, which aligned with the existing style used for irqchip
flags in the irq debug files.

Before:
	#cat :cpus:cpu@0:interrupt-controller
	name:   :cpus:cpu@0:interrupt-controller
	 size:   0
	 mapped: 2
	 flags:  0x00000003

After:
	#cat :cpus:cpu@0:interrupt-controller
	name:   :cpus:cpu@0:interrupt-controller
	 size:   0
	 mapped: 3
	 flags:  0x00000003
	            IRQ_DOMAIN_FLAG_HIERARCHY
	            IRQ_DOMAIN_NAME_ALLOCATED

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240529091628.3666379-1-ruanjinjie@huawei.com

---
 kernel/irq/debugfs.c   | 10 ++--------
 kernel/irq/internals.h | 10 ++++++++++
 kernel/irq/irqdomain.c | 17 +++++++++++++++--
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index aae0402..c6ffb97 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -9,14 +9,8 @@
 
 static struct dentry *irq_dir;
 
-struct irq_bit_descr {
-	unsigned int	mask;
-	char		*name;
-};
-#define BIT_MASK_DESCR(m)	{ .mask = m, .name = #m }
-
-static void irq_debug_show_bits(struct seq_file *m, int ind, unsigned int state,
-				const struct irq_bit_descr *sd, int size)
+void irq_debug_show_bits(struct seq_file *m, int ind, unsigned int state,
+			 const struct irq_bit_descr *sd, int size)
 {
 	int i;
 
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index ed28059..fe0272c 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -501,6 +501,16 @@ static inline struct irq_data *irqd_get_parent_data(struct irq_data *irqd)
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 #include <linux/debugfs.h>
 
+struct irq_bit_descr {
+	unsigned int	mask;
+	char		*name;
+};
+
+#define BIT_MASK_DESCR(m)	{ .mask = m, .name = #m }
+
+void irq_debug_show_bits(struct seq_file *m, int ind, unsigned int state,
+			 const struct irq_bit_descr *sd, int size);
+
 void irq_add_debugfs_entry(unsigned int irq, struct irq_desc *desc);
 static inline void irq_remove_debugfs_entry(struct irq_desc *desc)
 {
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index aadc889..d937231 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1932,13 +1932,26 @@ static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int virq
 
 static struct dentry *domain_dir;
 
-static void
-irq_domain_debug_show_one(struct seq_file *m, struct irq_domain *d, int ind)
+static const struct irq_bit_descr irqdomain_flags[] = {
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_HIERARCHY),
+	BIT_MASK_DESCR(IRQ_DOMAIN_NAME_ALLOCATED),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_IPI_PER_CPU),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_IPI_SINGLE),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_MSI),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_ISOLATED_MSI),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_NO_MAP),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_MSI_PARENT),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_MSI_DEVICE),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_NONCORE),
+};
+
+static void irq_domain_debug_show_one(struct seq_file *m, struct irq_domain *d, int ind)
 {
 	seq_printf(m, "%*sname:   %s\n", ind, "", d->name);
 	seq_printf(m, "%*ssize:   %u\n", ind + 1, "", d->revmap_size);
 	seq_printf(m, "%*smapped: %u\n", ind + 1, "", d->mapcount);
 	seq_printf(m, "%*sflags:  0x%08x\n", ind +1 , "", d->flags);
+	irq_debug_show_bits(m, ind, d->flags, irqdomain_flags, ARRAY_SIZE(irqdomain_flags));
 	if (d->ops && d->ops->debug_show)
 		d->ops->debug_show(m, d, NULL, ind + 1);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY

