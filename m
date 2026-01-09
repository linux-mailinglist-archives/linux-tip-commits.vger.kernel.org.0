Return-Path: <linux-tip-commits+bounces-7835-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EA3D0AD2B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 09 Jan 2026 16:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 820DE301F25E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Jan 2026 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC6A318ED2;
	Fri,  9 Jan 2026 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kiVvZijE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KE0WZpW8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDB731078B;
	Fri,  9 Jan 2026 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767971498; cv=none; b=Tgc4uOtIXhyybH5P8l5lFgAOyvDdi50agIJbleTbcaTX17p3gjjLK7tdqNOlhPwi56bmCpk0YoxomyqmRwTq3Njmx46y5kXwjFWkEq52jjCR1HFoteqhll/pBttBFwTGtU6GLcZJh9G8bl+Roxg7pY5/WB3Sz+fkP+wLqXxskvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767971498; c=relaxed/simple;
	bh=6+40AsmntmEQwJiyTbENgPZAEEohp4vEw0GxeaXXsNE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jk/eQUkh/czTpe4g6LuxkgVYDySBRBGbtxXGXPlGY8jVw0HnVepzD8e1bLNYk6b/zRjhcXCV/ywA/2y+iTyRCqAUnabILI+pGiLD8lLihiWnBiz4MfzNMOIlHJ1EuAEi5g0VcCtowRAKCfqyMMfrmBv9mqJDZ3hNMmwTuycnfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kiVvZijE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KE0WZpW8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 09 Jan 2026 15:11:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767971494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXR+LnsXussxESSx8KZQX8GvZgjE5+TYfUBfRA6Nqp8=;
	b=kiVvZijEoywM9x2NLQGW4YkBdHUFlFcaloBjG/4aYCVgN2jvhfQf7T5CnaEYlY9WjG6ymj
	hKxf6ZjWLKr331b0ytwfqsoYfIoZKMf7A8d2ln0x0ROoPAyAyzm0JUBnuVqoNzbKKkrHx7
	3Pz9EVJKAY1y8eAhAhoGOvC85EskX6Ipx4N6bpuXaGn2F6yrE4HGxLx6wj36Idf3NzAfsN
	o6n24yIHN9QAfzB4uQgZkyuWlT2rTKFb+1nGXBsqjhLDc8BbOjTyH161mNjUGW3+XcpMWj
	HcNNmLjMGDOJhE7b1NvFfltaX7GUAhObSN4ac3ExdUet2NpWURn3Cxk49kQ7gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767971494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXR+LnsXussxESSx8KZQX8GvZgjE5+TYfUBfRA6Nqp8=;
	b=KE0WZpW8tNOnlpZNWmK/wwBhkqINWvOBiUcIBqbiEGBc3BotF9ef9OUL5VxEYSqDUaia5g
	0+vnzefWootjFfDA==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Revert "irqchip/riscv-imsic: Embed the vector array
 in lpriv"
Cc: Anup Patel <anup.patel@oss.qualcomm.com>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251223143544.1504217-1-anup.patel@oss.qualcomm.com>
References: <20251223143544.1504217-1-anup.patel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176797149304.510.10298269992790894269.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     a33d16dc874a9512c02b1f1a3e08c26a82b4be5e
Gitweb:        https://git.kernel.org/tip/a33d16dc874a9512c02b1f1a3e08c26a82b=
4be5e
Author:        Anup Patel <anup.patel@oss.qualcomm.com>
AuthorDate:    Tue, 23 Dec 2025 20:05:44 +05:30
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 09 Jan 2026 16:10:05 +01:00

Revert "irqchip/riscv-imsic: Embed the vector array in lpriv"

The __alloc_percpu() fails when the number of IDs are greater than 959
because size parameter of __alloc_percpu() must be less than 32768 (aka
PCPU_MIN_UNIT_SIZE). This failure is observed with KVMTOOL when AIA is
trap-n-emulated by in-kernel KVM because in this case KVM guest has 2047
interrupt IDs.

To address this issue, don't embed vector array in struct imsic_local_priv
until __alloc_percpu() support size parameter greater than 32768.

This reverts commit 79eaabc61dfb ("irqchip/riscv-imsic: Embed the vector
array in lpriv").

Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20251223143544.1504217-1-anup.patel@oss.qualco=
mm.com
---
 drivers/irqchip/irq-riscv-imsic-state.c | 10 ++++++++--
 drivers/irqchip/irq-riscv-imsic-state.h |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-ri=
scv-imsic-state.c
index 3853680..b6cebfe 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -477,6 +477,7 @@ static void __init imsic_local_cleanup(void)
 		lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
=20
 		bitmap_free(lpriv->dirty_bitmap);
+		kfree(lpriv->vectors);
 	}
=20
 	free_percpu(imsic->lpriv);
@@ -490,8 +491,7 @@ static int __init imsic_local_init(void)
 	int cpu, i;
=20
 	/* Allocate per-CPU private state */
-	imsic->lpriv =3D __alloc_percpu(struct_size(imsic->lpriv, vectors, global->=
nr_ids + 1),
-				      __alignof__(*imsic->lpriv));
+	imsic->lpriv =3D alloc_percpu(typeof(*imsic->lpriv));
 	if (!imsic->lpriv)
 		return -ENOMEM;
=20
@@ -511,6 +511,12 @@ static int __init imsic_local_init(void)
 		timer_setup(&lpriv->timer, imsic_local_timer_callback, TIMER_PINNED);
 #endif
=20
+		/* Allocate vector array */
+		lpriv->vectors =3D kcalloc(global->nr_ids + 1, sizeof(*lpriv->vectors),
+					 GFP_KERNEL);
+		if (!lpriv->vectors)
+			goto fail_local_cleanup;
+
 		/* Setup vector array */
 		for (i =3D 0; i <=3D global->nr_ids; i++) {
 			vec =3D &lpriv->vectors[i];
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-ri=
scv-imsic-state.h
index 6332501..c42ee18 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -40,7 +40,7 @@ struct imsic_local_priv {
 #endif
=20
 	/* Local vector table */
-	struct imsic_vector			vectors[];
+	struct imsic_vector			*vectors;
 };
=20
 struct imsic_priv {

