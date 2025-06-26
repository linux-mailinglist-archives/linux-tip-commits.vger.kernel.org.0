Return-Path: <linux-tip-commits+bounces-5931-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 607F5AEA035
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 16:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66461893BB6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 14:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020BD2EBDEB;
	Thu, 26 Jun 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FDh1Ys9s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IP3Yq12k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417CE2EBB94;
	Thu, 26 Jun 2025 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947194; cv=none; b=bRytnRsRYLYsaRxGfeeGJWxzxU9GJUpBi06HYcg0+E8vP6W0TJsZbrOWPgDqvdRt4Idiw/CcvIsJe0tHwWfqbZYYlrvvRhR2eYiUzyNEitxozBPVNGP7NVzv9peKTup04S4fcCK1lsWH0cubu0C5nHvjXfSYj5KK2kTUtL+FDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947194; c=relaxed/simple;
	bh=VQzca9S9aEaink1sO6IKDjeMzYUWO+0jEsNX20q8das=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XMWIMkpgt315FSO9T1xv16XkDUb6Lv4E+4sr/ZWhDxQBwuqX87bzkViP02kR6xQSmaU1kdv+cZ9f7mvW6e8Gm+c5Y5I38AWy9SqObwUR12OmJjMNEDpx5Ory4kPBLtPKKM1yHMa4BwaE/NFtjX6L8RfrVkd69FPFsu8nPIeUNko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FDh1Ys9s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IP3Yq12k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 14:13:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750947191;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WU56A927JIwgpqFuQ3WRIItQ93HiFuTG6fx/4TVWJt4=;
	b=FDh1Ys9sCPipu/iny21/+IhM/I3xwKwTafQiXnmsqSgCQifmHvp/TFwvtrMBxOt/cAedpV
	ImR9575/8rxHXjpWaRjO1adqKuYCc9BaZFqQlr6RHUIq8Ud+t52FFeJ5SHSvrrGTYzEXWr
	ELp+5rCG7cGM4tmk++7+gT9KByvBZJ86deeZBW3EqpcXhaB5OB8lVWQZWqu4kangmyJ5/7
	2hxAarBle4ErE+2yoIDQZ4vmNgoOZ7LeIkmaAvjdq+HkIoSFcqWgtt/lpzmKkq48pdux4q
	eCXd4J26VC2RjrBUZ8+yg+XwaJ+zgR91WLgplP/OzBBDWMAS9Ailu1dfOgmoWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750947191;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WU56A927JIwgpqFuQ3WRIItQ93HiFuTG6fx/4TVWJt4=;
	b=IP3Yq12kieFe89qTjNb0gYAALDHoFQwFA3LfbVuOIt1A5edzPuYyTgIAMyG0wFszBqT+W2
	TJoqRjjXPs1atxDw==
From: "tip-bot2 for Vladimir Kondratiev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] riscv: Helper to parse hart index
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250612143911.3224046-2-vladimir.kondratiev@mobileye.com>
References: <20250612143911.3224046-2-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175094719060.406.2781604233902870510.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     5fe331cdcfba5b2c2dd8211127dadefcaaa97dec
Gitweb:        https://git.kernel.org/tip/5fe331cdcfba5b2c2dd8211127dadefcaaa=
97dec
Author:        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
AuthorDate:    Thu, 12 Jun 2025 17:39:05 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 26 Jun 2025 16:06:40 +02:00

riscv: Helper to parse hart index

RISC-V APLIC specification defines "hart index" in [1]. Similar definitions
can be found for ACLINT in [2]

Quote from the APLIC specification:

Within a given interrupt domain, each of the domain=E2=80=99s harts has a uni=
que
index number in the range 0 to 2^14 =E2=88=92 1 (=3D 16,383). The index numbe=
r a
domain associates with a hart may or may not have any relationship to the
unique hart identifier (=E2=80=9Chart ID=E2=80=9D) that the RISC-V Privileged
Architecture assigns to the hart. Two different interrupt domains may
employ entirely different index numbers for the same set of harts.

Further, it says in "4.5 Memory-mapped control region for an interrupt
domain":

The array of IDC structures may include some for potential hart index
numbers that are not actual hart index numbers in the domain.  For example,
the first IDC structure is always for hart index 0, but 0 is not
necessarily a valid index number for any hart in the domain.

Support arbitrary hart indices specified in an optional property
"riscv,hart-indexes" which is specified as an array of u32 elements, one
per interrupt target, listing hart indexes in the same order as in
"interrupts-extended".

If this property is not specified, fall back to use logical hart indices
within the domain.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250612143911.3224046-2-vladimir.kondratie=
v@mobileye.com
Link: https://github.com/riscv/riscv-aia [1]
Link: https://github.com/riscvarchive/riscv-aclint [2]

---
 arch/riscv/include/asm/irq.h |  2 ++
 arch/riscv/kernel/irq.c      | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 7b038f3..59c975f 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -22,6 +22,8 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, =
int exclude_cpu);
 void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
=20
 struct fwnode_handle *riscv_get_intc_hwnode(void);
+int riscv_get_hart_index(struct fwnode_handle *fwnode, u32 logical_index,
+			 u32 *hart_index);
=20
 #ifdef CONFIG_ACPI
=20
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 9ceda02..b6af20b 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -32,6 +32,40 @@ struct fwnode_handle *riscv_get_intc_hwnode(void)
 }
 EXPORT_SYMBOL_GPL(riscv_get_intc_hwnode);
=20
+/**
+ * riscv_get_hart_index() - get hart index for interrupt delivery
+ * @fwnode: interrupt controller node
+ * @logical_index: index within the "interrupts-extended" property
+ * @hart_index: filled with the hart index to use
+ *
+ * RISC-V uses term "hart index" for its interrupt controllers, for the
+ * purpose of the interrupt routing to destination harts.
+ * It may be arbitrary numbers assigned to each destination hart in context
+ * of the particular interrupt domain.
+ *
+ * These numbers encoded in the optional property "riscv,hart-indexes"
+ * that should contain hart index for each interrupt destination in the same
+ * order as in the "interrupts-extended" property. If this property
+ * not exist, it assumed equal to the logical index, i.e. index within the
+ * "interrupts-extended" property.
+ *
+ * Return: error code
+ */
+int riscv_get_hart_index(struct fwnode_handle *fwnode, u32 logical_index,
+			 u32 *hart_index)
+{
+	static const char *prop_hart_index =3D "riscv,hart-indexes";
+	struct device_node *np =3D to_of_node(fwnode);
+
+	if (!np || !of_property_present(np, prop_hart_index)) {
+		*hart_index =3D logical_index;
+		return 0;
+	}
+
+	return of_property_read_u32_index(np, prop_hart_index,
+					  logical_index, hart_index);
+}
+
 #ifdef CONFIG_IRQ_STACKS
 #include <asm/irq_stack.h>
=20

