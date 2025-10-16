Return-Path: <linux-tip-commits+bounces-6935-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 523F3BE3857
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 14:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58011A62FAF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72660334390;
	Thu, 16 Oct 2025 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rf5aOMvx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4+Id+NaC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C3A3314AA;
	Thu, 16 Oct 2025 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619345; cv=none; b=kz5CZ2rqfiWIH4qa3zZ50tOqobipYzu50qhqq9KOUVtgvHi9h3ypn1ePVZzo9zwGFs8ggZKiDuDoDaCc0oQsr373dKKs0KXtCrwKWwuUurzkGtUJYCGkmuvDGri1mW/soUYG28auRjRWEDlcA7hylFBVi4b7htZi2lW8QezefrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619345; c=relaxed/simple;
	bh=q/UmdYuUHj1bJIPMMn3mA+6d8MNJKwCeG3Ec4bT3PM8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ku7XM7EOC9k0S5kwvwajczN7hvoHXaDcDiIRyIDxuEiSrgstG/PxuSHyJEOPh1nQLBYIBx3xV/8WE/7XhtHTrgiZzBSu0I5c6Q8iFEo2RKw/X5ho2BF+I5Ujbg2ehAHSD6Q/G1DpeePpo7JStoKfZpLbx9ZEaIv3AlnuwHtqVKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rf5aOMvx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4+Id+NaC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 12:55:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760619341;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOjisSGD9Lan3kvyX3u82ydQKRlaOCpL7PyEIG5Jmk0=;
	b=rf5aOMvxKh57GT+/581PuQzKG9FJbG4JBhfvOAMXvKInAZYoN5uRIvfvJeUNyAf9Yn81ry
	d1DQpUbKi3NhOIfh3yvOhsF262pYRENstbDoShhslT3B6qoK7vCETwU/XShZhOZjoZiYJF
	C6onvz6TdKqHgfSxWuAfZJmt8TBTaJOTgUIcUJVfvZ7cSl7+Ai3y/CWG1Qz4YR89G2IbxZ
	8LyZv9+UTr3xKpmD5jYSt4Ci+biogLBg9gk6uFyugDgjc7u3M5W1dWzSY8BuUwpCItjaaj
	vJr75QygN3Z6kMLja6SZe1Jgb36cBH6EuPfJzE72ihNVMbdOMIPdW8VBpNUNPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760619341;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOjisSGD9Lan3kvyX3u82ydQKRlaOCpL7PyEIG5Jmk0=;
	b=4+Id+NaCgg05RqfMfGOom2fEY9jr7v/+gyPRQlsVZKPIynhHqmcZyyytbLHWojPEiVddOV
	58Zn7iMrM9VdDOBw==
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
Message-ID: <176061933933.709179.15384458361786704876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     424eafac024552b352d765afc392b090e55bfbf6
Gitweb:        https://git.kernel.org/tip/424eafac024552b352d765afc392b090e55=
bfbf6
Author:        Samuel Holland <samuel.holland@sifive.com>
AuthorDate:    Wed, 15 Oct 2025 12:55:13 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 13:12:50 +02:00

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

