Return-Path: <linux-tip-commits+bounces-1840-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F16DE9410DE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2CC286032
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560DA1A08BF;
	Tue, 30 Jul 2024 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VXxrgcEo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3LfHvDOt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B919FA64;
	Tue, 30 Jul 2024 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339609; cv=none; b=MVoe4sDqhdY0dQnk2z1oLEajH8Gg69+VUUNtb6NcD0K+5aONqpAEeld3axplQZUF/8eNLkrHkwtwJYqsATJyjpMSXhlf6MX0itR9U0Rj5I/TQhnexm0qtxO2iJmbUU/ULqCWhb/mNrLtoYq71/9DahRoUUxNyaeg8ZASets3m7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339609; c=relaxed/simple;
	bh=7LKVneuTfqjVeLfgxT/NA5HwtNP/xW8Ryepn/8e5TP8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q4GZC67BsWDxdq6MxA+7nVubvPwntkE7sShIFquqJ3yeKNyraBEcQtXWt6tBppvrGSARC07BKGABfIpPhxV+LQA0QGurCwd7GyFZ7asKXqa5pY5+L5j9WmxYnceABv3MWPUTzhtmcEP8NsLBOM3mpHdqnzn/1/Pc01TWMz80V2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VXxrgcEo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3LfHvDOt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdICrnKjgKvGV2+9GGahsabgh+zqD1ISrwfIpvNN94M=;
	b=VXxrgcEoV+GGL81Tns7b9AnlX5DHq4gFf6uGFa/OPb2M+tLTdYEeEZ+3RmtZlmK2ZSTRu1
	m1EQnjXYUzD1r5IJgKGSz6NsPoYaKsISMOfpeOkrLEx5IbvO9AFFsX6Wk389kaHdDdFYwh
	1iCyJ2cOkvRLvOhfVhU2yqNPG1eCWuIOIUD5P6xCJwosPDzygQPThwKQifyqfYcZcF0xQ2
	abKqY6psHrfXX8pstPqjLO/o6adEy4T54DcVcdEM7w54uJ2YKBqqpfk3213n9+oxLc9Vaf
	7ozUqXW8GakosgT0vU+zy+gdt1y7a7CvFpEyC5JDl4qsW0pxAM4o1QbtMts4uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdICrnKjgKvGV2+9GGahsabgh+zqD1ISrwfIpvNN94M=;
	b=3LfHvDOthFUL58vcgnHOSxqt+09HJ5olWZPEwT8cXni/oEU3bibYtWfmKjmLvPBGufgd1t
	1kb293gZvD1LraDA==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Use BIT() and GENMASK() macros
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240708151801.11592-5-kabel@kernel.org>
References: <20240708151801.11592-5-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233960397.2215.14199846757867543374.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2613b94d2dc5fc6b80ea8175ac3dbf579e6e1bac
Gitweb:        https://git.kernel.org/tip/2613b94d2dc5fc6b80ea8175ac3dbf579e6=
e1bac
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:17:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:45 +02:00

irqchip/armada-370-xp: Use BIT() and GENMASK() macros

Use the BIT() and GENMASK() macros where appropriate.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/all/20240708151801.11592-5-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 427ba5f..18aca9b 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -121,7 +121,7 @@
 #define ARMADA_370_XP_INT_SET_ENABLE		(0x30)
 #define ARMADA_370_XP_INT_CLEAR_ENABLE		(0x34)
 #define ARMADA_370_XP_INT_SOURCE_CTL(irq)	(0x100 + irq*4)
-#define ARMADA_370_XP_INT_SOURCE_CPU_MASK	0xF
+#define ARMADA_370_XP_INT_SOURCE_CPU_MASK	GENMASK(3, 0)
 #define ARMADA_370_XP_INT_IRQ_FIQ_MASK(cpuid)	((BIT(0) | BIT(8)) << cpuid)
=20
 /* Registers relative to per_cpu_int_base */
@@ -132,18 +132,18 @@
 #define ARMADA_370_XP_INT_SET_MASK		(0x48)
 #define ARMADA_370_XP_INT_CLEAR_MASK		(0x4C)
 #define ARMADA_370_XP_INT_FABRIC_MASK		(0x54)
-#define ARMADA_370_XP_INT_CAUSE_PERF(cpu)	(1 << cpu)
+#define ARMADA_370_XP_INT_CAUSE_PERF(cpu)	BIT(cpu)
=20
 #define ARMADA_370_XP_MAX_PER_CPU_IRQS		(28)
=20
 /* IPI and MSI interrupt definitions for IPI platforms */
 #define IPI_DOORBELL_START			(0)
 #define IPI_DOORBELL_END			(8)
-#define IPI_DOORBELL_MASK			0xFF
+#define IPI_DOORBELL_MASK			GENMASK(7, 0)
 #define PCI_MSI_DOORBELL_START			(16)
 #define PCI_MSI_DOORBELL_NR			(16)
 #define PCI_MSI_DOORBELL_END			(32)
-#define PCI_MSI_DOORBELL_MASK			0xFFFF0000
+#define PCI_MSI_DOORBELL_MASK			GENMASK(31, 16)
=20
 /* MSI interrupt definitions for non-IPI platforms */
 #define PCI_MSI_FULL_DOORBELL_START		0
@@ -415,7 +415,7 @@ static void armada_370_xp_ipi_send_mask(struct irq_data *=
d,
=20
 	/* Convert our logical CPU mask into a physical one. */
 	for_each_cpu(cpu, mask)
-		map |=3D 1 << cpu_logical_map(cpu);
+		map |=3D BIT(cpu_logical_map(cpu));
=20
 	/*
 	 * Ensure that stores to Normal memory are visible to the

