Return-Path: <linux-tip-commits+bounces-7895-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9F1D178F5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5472F300CA1E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 09:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F006389DF4;
	Tue, 13 Jan 2026 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TOrQmWnU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mfATfCD3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E127C38757E;
	Tue, 13 Jan 2026 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768295876; cv=none; b=GTXNoIt/wj2QPGJvHTyrykvCBgUeNkHXLu/uow8D7eiWdYIIS4/jHMCtLs3o/AgcfeVWZv/gTA0PQND5vSHiylCW8e//oVX1MQnIRGmdOzooJeNxZnQp02WelMljMTPOsNf1JCg5vut32xlauPnuJZqQJovNN3d8hCcCH661fOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768295876; c=relaxed/simple;
	bh=Mm0pZkEsfg10j8yt/RD/BhNJc2yc8qCwm2X6xjd15qk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SfePOpygeYil8jXK7VgH0AFRqF9j/jBl+GGU1gh4krOupXM4M99wsHnNBMcBmFfD90/nY1jr2gsMfWE3Chlodhb++cGPQeCdp0v7iFCwmICLPY/EB2eeDOAl9vb6DwbrfFK6oGsCglrnOI/AzehJEawZckqxcUPQOlI7Z7ugswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TOrQmWnU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mfATfCD3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 09:17:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768295869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfQ31V8tLBfHD9/zrwiaRhNyra9WskxlS7VzB0s9OjY=;
	b=TOrQmWnUVJK+cV8W4xK4A91Vq0HUE/tOdqivS9mOgcN30E1dT9nmjrxMZqSUWo6bSHO26A
	heuA3RLHZBjqPf/DpgurcHJo+5h087S4eIYek0nWDNxOfBNdFwMuu16lIXTwNaL1i19vVv
	HU9vXYpqHoRO1siihms4DUTHGW71VQSp+iKl11yQMza0G7QII46Kq7tI8MFRj6bUINJhZM
	PUpWCDHTo9ktTp4oXE4G2n4e5uqucvoqAXnG5Eqyz30J0p5U97EQBVIWrX2Jaz8sIoRI9U
	KN88dPSjWXCoHn2JJ5+DnKdtjieJH8U74vLFefllRo59e1IIC/FnQU8h1aZ/fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768295869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfQ31V8tLBfHD9/zrwiaRhNyra9WskxlS7VzB0s9OjY=;
	b=mfATfCD3vh42lRGFfrxeQGskF+OeYs2Ny4nU3qfRI1/MueP6hed4IuJ/sooiOpqqNQK/nT
	hJa8V1I62brslsAA==
From: "tip-bot2 for Luigi Rizzo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Move clear of kstat_irqs to free_desc()
Cc: Luigi Rizzo <lrizzo@google.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20260112083234.2665832-1-lrizzo@google.com>
References: <20260112083234.2665832-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176829586810.510.8056737405388398505.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fb11a2493e685d0b733c2346f5b26f2e372584fb
Gitweb:        https://git.kernel.org/tip/fb11a2493e685d0b733c2346f5b26f2e372=
584fb
Author:        Luigi Rizzo <lrizzo@google.com>
AuthorDate:    Mon, 12 Jan 2026 08:32:33=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 10:16:29 +01:00

genirq: Move clear of kstat_irqs to free_desc()

desc_set_defaults() has a loop to clear the per-cpu counters kstats_irq.

This is only needed in free_desc(), which is used with non-sparse IRQs so
that the interrupt descriptor can be recycled. For newly allocated
descriptors, the memory comes from alloc_percpu() and is already zeroed
out.

Move the loop to free_desc() to avoid wasting time unnecessarily.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260112083234.2665832-1-lrizzo@google.com
---
 kernel/irq/irqdesc.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index f8e4e13..c3bc00e 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -115,8 +115,6 @@ static inline void free_masks(struct irq_desc *desc) { }
 static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int n=
ode,
 			      const struct cpumask *affinity, struct module *owner)
 {
-	int cpu;
-
 	desc->irq_common_data.handler_data =3D NULL;
 	desc->irq_common_data.msi_desc =3D NULL;
=20
@@ -134,8 +132,6 @@ static void desc_set_defaults(unsigned int irq, struct ir=
q_desc *desc, int node,
 	desc->tot_count =3D 0;
 	desc->name =3D NULL;
 	desc->owner =3D owner;
-	for_each_possible_cpu(cpu)
-		*per_cpu_ptr(desc->kstat_irqs, cpu) =3D (struct irqstat) { };
 	desc_smp_init(desc, node, affinity);
 }
=20
@@ -621,9 +617,14 @@ EXPORT_SYMBOL(irq_to_desc);
 static void free_desc(unsigned int irq)
 {
 	struct irq_desc *desc =3D irq_to_desc(irq);
+	int cpu;
=20
 	scoped_guard(raw_spinlock_irqsave, &desc->lock)
 		desc_set_defaults(irq, desc, irq_desc_get_node(desc), NULL, NULL);
+
+	for_each_possible_cpu(cpu)
+		*per_cpu_ptr(desc->kstat_irqs, cpu) =3D (struct irqstat) { };
+
 	delete_irq_desc(irq);
 }
=20

