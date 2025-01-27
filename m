Return-Path: <linux-tip-commits+bounces-3293-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFFCA1D438
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Jan 2025 11:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACDC1884390
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Jan 2025 10:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6BD1FDA99;
	Mon, 27 Jan 2025 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IOfZejWK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G70gx6YN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B301FDA83;
	Mon, 27 Jan 2025 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737972841; cv=none; b=OLYTGGwz+H0AU8MiNDDmGLhARszRHDOfVW/KGBGxhgqY5Df+a8g4cjYcv1a04iJf7s1sSCucbJqxdwvMoT8yfIn1R1zYPjDlAgIx+tpHxO2ZZiSAtOgNKmeHXTY/+i8WGqcdfoEQisI/uzI2axng3wuIqz6kbzszsdSCMYNzmkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737972841; c=relaxed/simple;
	bh=tuggGvAF2l5ZTklyQFZqBlje/8DoxVNE7d/IdMDE9ag=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Hok/+W8qb5Mp+jD0MG9k4Nci7t693aSIbaMaPWNzyB3M0eQFZWuaOFkXC2PhPmYEI5PkZ/wZl1EbLUrHS+ZCiALV0g3O0dcKKrC7bNd65MWFxbu0e4nuPPm20rSIrPfyvdA10wpzSihncTyXkQz5YtgcCK3JESfgYfetNp87zVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IOfZejWK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G70gx6YN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Jan 2025 10:13:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737972838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1dBK16j4NWkA1FclmauP+TfC6dk0F3TUIO23KVDlqWg=;
	b=IOfZejWK7FPQBp7ry+RTCy0G3Zrh0G+2LLah59dcAipq2HgSyq0pr2pZo05LnGsMw4VJvS
	uJ91OTq1Y1JnkijtDtQBlv5CRVnQseHgskEm3aMRgFVkgG/ZFhx7HWRn124cBjGHt2KIbN
	OiKxYGXc50TDXlISRty+oAuwhRIU9bMCHDwfVAxztjTCS0b8V8tzBxL9MJxwtPeSfY76wl
	+F6uCL2/ZkCgzcEQqqXiviTj2ExkJZFta4D8t1Bi7tRn/QA1g9SrrQlFGEJ1MPbpWwv9e0
	C7ZpfQ/izBrn4lmoPhA580wGy9/4UaUhG8HMujHdS/n7C+0s1stSzmSJJnHcyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737972838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1dBK16j4NWkA1FclmauP+TfC6dk0F3TUIO23KVDlqWg=;
	b=G70gx6YNMi9qIWMe9I/D1EgFUzdFcfdpBiFDGOAWM+TIBUuZvCp0B+R0hda1Jo2R7bWQcq
	E1VolGcbCbeoZ8BQ==
From: "tip-bot2 for Xu Lu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/riscv: Ensure ordering of memory writes and
 IPI writes
Cc: Xu Lu <luxu.kernel@bytedance.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250127093846.98625-1-luxu.kernel@bytedance.com>
References: <20250127093846.98625-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173797283771.31546.1447436776133364882.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     825c78e6a60c309a59d18d5ac5968aa79cef0bd6
Gitweb:        https://git.kernel.org/tip/825c78e6a60c309a59d18d5ac5968aa79cef0bd6
Author:        Xu Lu <luxu.kernel@bytedance.com>
AuthorDate:    Mon, 27 Jan 2025 17:38:46 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Jan 2025 11:07:03 +01:00

irqchip/riscv: Ensure ordering of memory writes and IPI writes

RISC-V distinguishes between memory accesses and device I/O and uses FENCE
instruction to order them as viewed by other RISC-V harts and external
devices or coprocessors. The FENCE instruction can order any combination of
device input(I), device output(O), memory reads(R) and memory
writes(W). For example, 'fence w, o' is used to ensure all memory writes
from instructions preceding the FENCE instruction appear earlier in the
global memory order than device output writes from instructions after the
FENCE instruction.

RISC-V issues IPIs by writing to the IMSIC/ACLINT MMIO registers, which is
regarded as device output operation. However, the existing implementation
of the IMSIC/ACLINT drivers issue the IPI via writel_relaxed(), which does
not guarantee the order of device output operation and preceding memory
writes. As a consequence the hart receiving the IPI might not observe the
IPI related data.

Fix this by replacing writel_relaxed() with writel() when issuing IPIs,
which uses 'fence w, o' to ensure all previous writes made by the current
hart are visible to other harts before they receive the IPI.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250127093846.98625-1-luxu.kernel@bytedance.com
---
 drivers/irqchip/irq-riscv-imsic-early.c      | 2 +-
 drivers/irqchip/irq-thead-c900-aclint-sswi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index c5c2e69..275df50 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -27,7 +27,7 @@ static void imsic_ipi_send(unsigned int cpu)
 {
 	struct imsic_local_config *local = per_cpu_ptr(imsic->global.local, cpu);
 
-	writel_relaxed(IMSIC_IPI_ID, local->msi_va);
+	writel(IMSIC_IPI_ID, local->msi_va);
 }
 
 static void imsic_ipi_starting_cpu(void)
diff --git a/drivers/irqchip/irq-thead-c900-aclint-sswi.c b/drivers/irqchip/irq-thead-c900-aclint-sswi.c
index b0e366a..8ff6e7a 100644
--- a/drivers/irqchip/irq-thead-c900-aclint-sswi.c
+++ b/drivers/irqchip/irq-thead-c900-aclint-sswi.c
@@ -31,7 +31,7 @@ static DEFINE_PER_CPU(void __iomem *, sswi_cpu_regs);
 
 static void thead_aclint_sswi_ipi_send(unsigned int cpu)
 {
-	writel_relaxed(0x1, per_cpu(sswi_cpu_regs, cpu));
+	writel(0x1, per_cpu(sswi_cpu_regs, cpu));
 }
 
 static void thead_aclint_sswi_ipi_clear(void)

