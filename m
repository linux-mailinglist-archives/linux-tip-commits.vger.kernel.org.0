Return-Path: <linux-tip-commits+bounces-1754-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DA793F193
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1C1B22A83
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7DE1411EB;
	Mon, 29 Jul 2024 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JPyCHCTX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="miqciIbs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458AA13DBB1;
	Mon, 29 Jul 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246584; cv=none; b=mBVDo1gvBk1eok6kbMroeoeWI7/8bJTdSkmwIFSctoz7lz5ONR8wrYIO0rHovPrh13RPN76bGOut5947M/KrDGUiGr9wurjRokgkLDoWNAeS2Q5WKI812htYGxfUIfkDXpGEagk0y6vUJAfWZA9B7SflKCZ4uN8QO2vVPZez5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246584; c=relaxed/simple;
	bh=TzfL+k597vMwacH5/A9zWpV8etS+27uYATWFJGRvwlU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j3Xmt1eFAsMHK5Qi2jsczTiH4PZBFdr73TxLK/ttlrRrNWI/XzmWhABU7kd0QZBT4OlJtqxrOz7WqZgmo9wl/ktrhdv1Ns6SFxGMtYaYMhYa7oRfDB/3aPQ/7Wq62XC0S2GIXFWf5iZ/GJcyxBK4dEEfgYun7Ssaw+T4xUaU/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JPyCHCTX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=miqciIbs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHKUfR5iu74YnWTusRb4b87Dq+8BJITEWaXZIYmjkeU=;
	b=JPyCHCTX0jVAlXfncM0gVbQbUysTn+Ag2duano032dwP0Esjfz+8uLPEsHO4I8Wi0z5FuV
	Qpzh9nK6Js5aKRBLuMikNVhFq8/sABD3nQm3kE1gMedQLBCuTaU7ZmJLgEMWua0EKj1Sc9
	1tlpvmnuO1bOqy1PkNi+uqi74RPPk2jjluBT9SZvv5BkfidKdC0jvI4i1nvatFp55Q1Dnw
	ppI1IeRH/6dxHFumq+W3xUAx+mFyjHmWq+dvfHXUzzOb0WljhqivwRLPzMxZOOT5vrak60
	jWO8aKgNiBFIwfErJO83gXvnBupBnj6Z3P+XOnTSDkyikcO3r5FWtPynT0wQPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHKUfR5iu74YnWTusRb4b87Dq+8BJITEWaXZIYmjkeU=;
	b=miqciIbsHwzlnIdjyS1esaEYxjvITcY0Rc+ayecOpX9ebyWb3EtZHfUob0ftUPEFsLOZL1
	1aEKbKY3iJspjABQ==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Use u32 type instead of
 unsigned long where possieble
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711160907.31012-9-kabel@kernel.org>
References: <20240711160907.31012-9-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224658139.2215.14071964803272233893.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     33950cdeab2ebc7644db556a0c3f486ca0296027
Gitweb:        https://git.kernel.org/tip/33950cdeab2ebc7644db556a0c3f486ca02=
96027
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 18:09:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:24 +02:00

irqchip/armada-370-xp: Use u32 type instead of unsigned long where possieble

For consistency across the driver, use the u32 type instead of unsigned
long for holding register values and return value of cpu_logical_map().

One exception is when the variable is referenced for passing into
for_each_set_bit(), in which case it has to be unsigned long.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240711160907.31012-9-kabel@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 29ce6fe..1e0f1b4 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -357,7 +357,7 @@ static inline int mpic_msi_init(struct device_node *node,
=20
 static void mpic_perf_init(void)
 {
-	unsigned long cpuid;
+	u32 cpuid;
=20
 	/*
 	 * This Performance Counter Overflow interrupt is specific for
@@ -396,8 +396,8 @@ static void mpic_ipi_unmask(struct irq_data *d)
=20
 static void mpic_ipi_send_mask(struct irq_data *d, const struct cpumask *mas=
k)
 {
-	unsigned long map =3D 0;
 	unsigned int cpu;
+	u32 map =3D 0;
=20
 	/* Convert our logical CPU mask into a physical one. */
 	for_each_cpu(cpu, mask)
@@ -633,7 +633,8 @@ static inline void mpic_handle_ipi_irq(void) {}
 static void mpic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	unsigned long cause, irqsrc, cpuid;
+	unsigned long cause;
+	u32 irqsrc, cpuid;
 	irq_hw_number_t i;
=20
 	chained_irq_enter(chip, desc);

