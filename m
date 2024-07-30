Return-Path: <linux-tip-commits+bounces-1823-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E834A9410BF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255B11C23243
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F3619E7DC;
	Tue, 30 Jul 2024 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dv1VHK35";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mJXMXoqG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8D1993B0;
	Tue, 30 Jul 2024 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339601; cv=none; b=V5IKUZw93haFLlIRyCoubwOp1JGqeobuM7rCH0yEUGLibchEpS0QRj9hJrhzCrkzyXofGb8pPvbf6rTuhI8g+YsCscE0A3zdiyIv7+1nrpuBy69jdYghz167azMXEIiPGNZmZXf0daPCHrs8YtBnUTalCJj9TkJvszT32Fq8/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339601; c=relaxed/simple;
	bh=yMYjkXY1upHFVdKKiGzDGqXAqvbtHdvSkwWnTh9x5ME=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JeKEpAE75EN/3BjhmgE2PTV7LiC+v+qlLOgLVcRp8x4/fPjsVHcKy0xaCKGwMGxTia//3RuXCUyR6UlxVrlKK6XwM5vcF5fUZ6j9yTmmDU+SS4h++nvi6CHJl7CnSDBFyl/gDPtOgyLf7GK3v/JeraN4PUNhKw2laB0MY3FiGXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dv1VHK35; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mJXMXoqG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:39:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+A6XY9TpvR9hgkxe11+yvufRsLP/70qyNG7fVyTOuc=;
	b=Dv1VHK35X6v/paX64dEhLfgWMMDPFvcIKOqatQ80Nq+zPKl6yn3A6jPQsIzDf0dQifrIb6
	UGSJOjQSt53NTxA88GUI3onwz8bzCx0QxoJ0xPSp8Lj+Rtec9nwh1PFGX+KuOnV7u5tLLd
	fbR8fVeeKBZWsIgtQM64ltM0OYbT0bZmumx8E/2wWiUCpnS5axy97IMinLc33x4ncEcAx1
	8+uXjg9CEu9NaPnY3Ion6qPF6wOMIk76po4temjk+IPMcFYGEGiQQRRfQzDQf5fBIsvJWL
	hjqpoJNj49C3BQZ9xSJJu8DVk4j6OGNukJ5+W5vedyqfDEArv3hLErvm/85fTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+A6XY9TpvR9hgkxe11+yvufRsLP/70qyNG7fVyTOuc=;
	b=mJXMXoqGjwjiHGTtZIfVrPSPsmbfRbZ8u2fI2QBbizS9EE7h3AZbiap522PmbLpeIJRNWB
	hsrXkV0t6zNe4xAQ==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/armada-370-xp: Rename variable for consistency
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711160907.31012-8-kabel@kernel.org>
References: <20240711160907.31012-8-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233959829.2215.9483841948118069553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ac0ae59db6f521223b477677d2ff51e26815b114
Gitweb:        https://git.kernel.org/tip/ac0ae59db6f521223b477677d2ff51e2681=
5b114
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 18:09:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:48 +02:00

irqchip/armada-370-xp: Rename variable for consistency

Rename the variable holding the cause register to "cause" in
mpic_handle_cascade_irq().

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240711160907.31012-8-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 4abe0ea..5cde229 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -633,15 +633,15 @@ static inline void mpic_handle_ipi_irq(void) {}
 static void mpic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	unsigned long irqmap, irqsrc, cpuid;
+	unsigned long cause, irqsrc, cpuid;
 	irq_hw_number_t i;
=20
 	chained_irq_enter(chip, desc);
=20
-	irqmap =3D readl_relaxed(per_cpu_int_base + MPIC_PPI_CAUSE);
+	cause =3D readl_relaxed(per_cpu_int_base + MPIC_PPI_CAUSE);
 	cpuid =3D cpu_logical_map(smp_processor_id());
=20
-	for_each_set_bit(i, &irqmap, BITS_PER_LONG) {
+	for_each_set_bit(i, &cause, BITS_PER_LONG) {
 		irqsrc =3D readl_relaxed(main_int_base + MPIC_INT_SOURCE_CTL(i));
=20
 		/* Check if the interrupt is not masked on current CPU.

