Return-Path: <linux-tip-commits+bounces-3243-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39884A11DDF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE45161B05
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8041D23F26D;
	Wed, 15 Jan 2025 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EQb0V94R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EOCisYWq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FC4244FBF;
	Wed, 15 Jan 2025 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933213; cv=none; b=dguCA5muc/w1soay8rKjKozbnbIn07mvbCkfTVshEGC9cdqmyqBAEWAo0Wx+QBPgqNROyHi2y111jthp1f32PcD9XUWK4lNcAfr8NldDVrArdAp06BAvUR+UP2lELMtUnQihy0UnUKDdmn1bl1nDNLo1Dz7VhYhnGPzEve3nAgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933213; c=relaxed/simple;
	bh=ausJuFC+MVeHNzWtbSea9a91nuppWE03EfpH5uLS6Q8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pNaWvbXKBn/Y8cwI1ECYk8fDO1S5eH3yLxKoo1w+qQm/9e4Dfta1inENalZzQMmuHEBGdseymSwGbMjmerk4UJKeyx7/PerMkLoQeEh3Jvys3H877xz/72PbY0at+8wYuj0M01/EHQ3dToMVm5af6JTNyxCOV6TOESi70W15mWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EQb0V94R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EOCisYWq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:26:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736933210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDBcFdPCRII4As/lw/4kGuSvQuM/QweelL7CfgR39W0=;
	b=EQb0V94R5A7Dgr5gDpwsWV22cw0b4FNIUrr5LbUTeeO9g/d/OcDr8BfdW6skzzCODk9Dql
	rwd0xQfpvv4BJAdEHqDDK2efjqq0D9668Jurs06zT+kEQ7vPVP85Sn3PtvlJ6qG0P8mPbf
	ljobM6V/8XVmpfevZWMUashZO+kejnZMNQPahY/CIW7+FG0PH+UmtlsP+X/d2NyJOWMxWs
	wtxF+TNId4sYDTLL25b5yYileU32bw973Firer41fg5hXZSGnuurwhsd+ZrkDNx0kJ49sl
	xTDP5EtHEnWmyGgGVQt+6P4jDi24lh9+WXGWU+AhctOs+KV5EHuSrlNtrd5oXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736933210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDBcFdPCRII4As/lw/4kGuSvQuM/QweelL7CfgR39W0=;
	b=EOCisYWqgNqzFU8mCyt6sivrrCsB9QmLFnFeOp62iYex3kNXxfdckzQX5LkYGRLho69wsq
	ZnoaoIAN9VEHqBAQ==
From: "tip-bot2 for Tianyang Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/loongarch-avec: Add multi-nodes topology support
Cc: Tianyang Zhang <zhangtianyang@loongson.cn>,
 Thomas Gleixner <tglx@linutronix.de>, Huacai Chen <chenhuacai@loongson.cn>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250111023704.17285-1-zhangtianyang@loongson.cn>
References: <20250111023704.17285-1-zhangtianyang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693320918.31546.8338251434613521373.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2af257388473298898d71313cfa6092b572f2602
Gitweb:        https://git.kernel.org/tip/2af257388473298898d71313cfa6092b572f2602
Author:        Tianyang Zhang <zhangtianyang@loongson.cn>
AuthorDate:    Sat, 11 Jan 2025 10:37:04 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 10:19:20 +01:00

irqchip/loongarch-avec: Add multi-nodes topology support

avecintc_init() enables the Advanced Interrupt Controller (AVEC) of
the boot CPU node, but nothing enables the AVEC on secondary nodes.

Move the enablement to the CPU hotplug callback so that secondary nodes get
the AVEC enabled too. In theory enabling it once per node would be
sufficient, but redundant enabling does no hurt, so keep the code simple
and do it unconditionally.

Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Link: https://lore.kernel.org/all/20250111023704.17285-1-zhangtianyang@loongson.cn

---
 drivers/irqchip/irq-loongarch-avec.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-loongarch-avec.c b/drivers/irqchip/irq-loongarch-avec.c
index 0f6e465..80e5595 100644
--- a/drivers/irqchip/irq-loongarch-avec.c
+++ b/drivers/irqchip/irq-loongarch-avec.c
@@ -56,6 +56,15 @@ struct avecintc_data {
 	unsigned int		moving;
 };
 
+static inline void avecintc_enable(void)
+{
+	u64 value;
+
+	value = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
+	value |= IOCSR_MISC_FUNC_AVEC_EN;
+	iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
+}
+
 static inline void avecintc_ack_irq(struct irq_data *d)
 {
 }
@@ -127,6 +136,8 @@ static int avecintc_cpu_online(unsigned int cpu)
 
 	guard(raw_spinlock)(&loongarch_avec.lock);
 
+	avecintc_enable();
+
 	irq_matrix_online(loongarch_avec.vector_matrix);
 
 	pending_list_init(cpu);
@@ -339,7 +350,6 @@ static int __init irq_matrix_init(void)
 static int __init avecintc_init(struct irq_domain *parent)
 {
 	int ret, parent_irq;
-	unsigned long value;
 
 	raw_spin_lock_init(&loongarch_avec.lock);
 
@@ -378,9 +388,7 @@ static int __init avecintc_init(struct irq_domain *parent)
 				  "irqchip/loongarch/avecintc:starting",
 				  avecintc_cpu_online, avecintc_cpu_offline);
 #endif
-	value = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
-	value |= IOCSR_MISC_FUNC_AVEC_EN;
-	iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
+	avecintc_enable();
 
 	return ret;
 

