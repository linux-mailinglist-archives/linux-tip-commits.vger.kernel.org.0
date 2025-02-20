Return-Path: <linux-tip-commits+bounces-3533-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F96A3DCE7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Feb 2025 15:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF573B5850
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Feb 2025 14:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5021FE471;
	Thu, 20 Feb 2025 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YKPi8Qfy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R0P87Y6S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A953D1FCCE9;
	Thu, 20 Feb 2025 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061604; cv=none; b=r9BBcbzguA1bMiogpMT8Xo9zQEGjJcfF1UaZhWxB/q/2OK223bZdurikwpogUcK0UAyP1ZWWWvjDTr9L6ar0eSmWqdrn7iBe+4H0hIQeJrURs/nEqZ5qmVwmc/+dRgzpOjNERA+jpcdPFZ9Mm0c6/xO6zlPdd/ADu1axI+IDLtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061604; c=relaxed/simple;
	bh=Iisxb+OwQGfSFXkHpfbSwKdDO3OT8ipY9twcwklG5dE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MncVGxpvXytSMIAmJVZfERjIEFKtiZK+jzDxw3KDlsIvcmEUSE6Du2WSzVhjXzjeQN5tvQzJRg7hS4YshKvjBeChssUgaHhN0ilUZc/5c69ZClerSlg5SP8p8tpbnRBCyYDNSNJB50v6cKgKw3y5iYjbWRQY4Ndojf22abD6QfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YKPi8Qfy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R0P87Y6S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Feb 2025 14:26:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740061600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBf38VYt0f7CFg7ZuVElbynQyaWCpqMyxiAG+opZXkM=;
	b=YKPi8Qfy3tfmZLkCM7OFsqENmBLm2lkRRmL1hqUr1um0dqdwjDgyWjACcXZIttfIYR/ni+
	yFuSX3V8EvPuS33DOdpIFTNm6f8Bx+QRDiAJYNY734IVvuksI6p0+aSgRqPtFblVzEp/9B
	NrG+J+zu3Sf5p+UEMqefXQZd4R6IiXEcYH4GH+GgiFH2QSoZuF41UaEiqWmHFhBDvxkkkz
	AIYNKw4zCDBWTDGCJHH0SxJiW8m1U1pZ2HsuMwpaUQjKBOkng4tRaa1PXjZC8ov3uRHZa0
	sEpAjaAjWLmgwEudHPwWW/yzI4rxTmp8wPtu5iYF/UQkzbPbmz5yZsY1slXjdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740061600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBf38VYt0f7CFg7ZuVElbynQyaWCpqMyxiAG+opZXkM=;
	b=R0P87Y6S2ZLBF9paLcj7w1tDBU7I/BI0bSU1BOrmxcSUKXQzSRMl3lOek7c6GjLxMmtQXT
	ktGCLjprUwQYYlCA==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] genirq: Introduce irq_can_move_in_process_context()
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250217085657.789309-6-apatel@ventanamicro.com>
References: <20250217085657.789309-6-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174006159951.10177.14927239047948181862.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     e54b1b5e89ae765e6d71d41883a8f551fde8d0ab
Gitweb:        https://git.kernel.org/tip/e54b1b5e89ae765e6d71d41883a8f551fde8d0ab
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Mon, 17 Feb 2025 14:26:51 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Feb 2025 15:19:26 +01:00

genirq: Introduce irq_can_move_in_process_context()

Interrupt controller drivers which enable CONFIG_GENERIC_PENDING_IRQ
require to know whether an interrupt can be moved in process context or not
to decide whether they need to invoke the work around for non-atomic MSI
updates or not.

This information can be retrieved via irq_can_move_pcntxt(). That helper
requires access to the top-most interrupt domain data, but the driver which
requires this is usually further down in the hierarchy.

Introduce irq_can_move_in_process_context() which retrieves that
information from the top-most interrupt domain data.

[ tglx: Massaged change log ]

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250217085657.789309-6-apatel@ventanamicro.com

---
 include/linux/irq.h    |  2 ++
 kernel/irq/migration.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 56f6583..dd5df1e 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -615,6 +615,7 @@ extern int irq_affinity_online_cpu(unsigned int cpu);
 #endif
 
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_PENDING_IRQ)
+bool irq_can_move_in_process_context(struct irq_data *data);
 void __irq_move_irq(struct irq_data *data);
 static inline void irq_move_irq(struct irq_data *data)
 {
@@ -623,6 +624,7 @@ static inline void irq_move_irq(struct irq_data *data)
 }
 void irq_move_masked_irq(struct irq_data *data);
 #else
+static inline bool irq_can_move_in_process_context(struct irq_data *data) { return true; }
 static inline void irq_move_irq(struct irq_data *data) { }
 static inline void irq_move_masked_irq(struct irq_data *data) { }
 #endif
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index e110300..147cabb 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -127,3 +127,13 @@ void __irq_move_irq(struct irq_data *idata)
 	if (!masked)
 		idata->chip->irq_unmask(idata);
 }
+
+bool irq_can_move_in_process_context(struct irq_data *data)
+{
+	/*
+	 * Get the top level irq_data in the hierarchy, which is optimized
+	 * away when CONFIG_IRQ_DOMAIN_HIERARCHY is disabled.
+	 */
+	data = irq_desc_get_irq_data(irq_data_to_desc(data));
+	return irq_can_move_pcntxt(data);
+}

