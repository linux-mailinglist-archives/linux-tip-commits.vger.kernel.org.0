Return-Path: <linux-tip-commits+bounces-6938-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30935BE4534
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 17:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A1F75071B6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E1434F49B;
	Thu, 16 Oct 2025 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HYBuHmnd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iskbyw2j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347D1FC110;
	Thu, 16 Oct 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629598; cv=none; b=XWk+3HwNwJ43URAUHGxCc+VE+gggswA7J0xYmlj5FcjD1xkIdi3kpomucJHxcc2/jNTM3xzV4N1bIa6IYMFXZEM2aRaNkoqXZ2Kr0QaV6PN41s0toxG4jF2rbR/PEl8ujQP9Np90rUVOACYK6mTN7nui4A+8A/VCzVMkxj62FFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629598; c=relaxed/simple;
	bh=BUCwj+DfQ8gyrNRs2tBIjoHmtyReRUBuOukQFavhSPs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e42Zd3B8hTTM0neC3xoAHjxkgmnngXSohtMQWAOXeqLvWd6oxlqY7AWjqYxJ0dUwfv3E7W6dlIkqyNRGOlHEwWjdPoQoQGUtmT1wQOjt9pqeqXa6bkUNXAz0eLP44dQ5Ms+vf34rgW6wWe1nzLFB0XvpguHs6FtcWboiGzLJqww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HYBuHmnd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iskbyw2j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 15:46:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760629595;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KQkmnrflySmhdEZ3nemiwLVPeiWdpz4LtKjSldzIsI8=;
	b=HYBuHmndhgzbOlEJnKbnFB2+nJuo8p27a0uytizk7vGE62R2XrLoAXlOuavO8XSbS/DncU
	GoyCy4gaYSmG4u2RZZuNORaCreFnmfP5BliarVvq4uFe1aEaaLWR9Xd7P7q4B8PbzucQmj
	flLEYHt2+E/T+uzTT1UH1mhcr5kLwxCW/FvDAz2QIobuCN+xM/ws7T2yCwUIIlbRFx1o43
	UuYgchK5ujus0ptUc12Q+l7zbjVLVyEr7ixh5UsoCz0/nTUZLbK85ZYdzgLmVQ+OOeTm8u
	obSqXBv4/jp4Lkj3EARNBBtKEmXy7hAyJtL7SoY1G5Q/nol/G84TA/M3RONXtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760629595;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KQkmnrflySmhdEZ3nemiwLVPeiWdpz4LtKjSldzIsI8=;
	b=iskbyw2jNUHmNIIFyWLPVz4G1Ipv/dIqar72NbxLb47RPh0+15R92xqDwz23sy2bj1rTwA
	uFiYQ8mpRPsyJJDw==
From: "tip-bot2 for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/riscv-imsic: Embed the vector array in lpriv
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251015195712.3813004-3-samuel.holland@sifive.com>
References: <20251015195712.3813004-3-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176062959406.709179.4675912253469876151.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     6efefb71195ae1c93913615bcf0e7c5a63083e35
Gitweb:        https://git.kernel.org/tip/6efefb71195ae1c93913615bcf0e7c5a630=
83e35
Author:        Samuel Holland <samuel.holland@sifive.com>
AuthorDate:    Wed, 15 Oct 2025 12:55:13 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 17:26:35 +02:00

irqchip/riscv-imsic: Embed the vector array in lpriv

Reduce pointer chasing and the number of allocations by using a flexible
array member for the vector array instead of a separate allocation.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-riscv-imsic-state.c | 10 ++--------
 drivers/irqchip/irq-riscv-imsic-state.h |  2 +-
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-ri=
scv-imsic-state.c
index dc95ad8..9a499ef 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -487,7 +487,6 @@ static void __init imsic_local_cleanup(void)
 		lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
=20
 		bitmap_free(lpriv->dirty_bitmap);
-		kfree(lpriv->vectors);
 	}
=20
 	free_percpu(imsic->lpriv);
@@ -501,7 +500,8 @@ static int __init imsic_local_init(void)
 	int cpu, i;
=20
 	/* Allocate per-CPU private state */
-	imsic->lpriv =3D alloc_percpu(typeof(*imsic->lpriv));
+	imsic->lpriv =3D __alloc_percpu(struct_size(imsic->lpriv, vectors, global->=
nr_ids + 1),
+				      __alignof__(*imsic->lpriv));
 	if (!imsic->lpriv)
 		return -ENOMEM;
=20
@@ -521,12 +521,6 @@ static int __init imsic_local_init(void)
 		timer_setup(&lpriv->timer, imsic_local_timer_callback, TIMER_PINNED);
 #endif
=20
-		/* Allocate vector array */
-		lpriv->vectors =3D kcalloc(global->nr_ids + 1, sizeof(*lpriv->vectors),
-					 GFP_KERNEL);
-		if (!lpriv->vectors)
-			goto fail_local_cleanup;
-
 		/* Setup vector array */
 		for (i =3D 0; i <=3D global->nr_ids; i++) {
 			vec =3D &lpriv->vectors[i];
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-ri=
scv-imsic-state.h
index 57f9519..196457f 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -40,7 +40,7 @@ struct imsic_local_priv {
 #endif
=20
 	/* Local vector table */
-	struct imsic_vector			*vectors;
+	struct imsic_vector			vectors[];
 };
=20
 struct imsic_priv {

