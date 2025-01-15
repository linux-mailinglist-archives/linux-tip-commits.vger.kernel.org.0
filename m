Return-Path: <linux-tip-commits+bounces-3250-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E269CA11EDC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 11:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680DE167773
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CF624168E;
	Wed, 15 Jan 2025 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sPDSh8ld";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PkyHf3kd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF69A20AF6C;
	Wed, 15 Jan 2025 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935460; cv=none; b=Z6/Kjz+hdreYRqfZBQ9lYq2zrdoLU222KZus6BcHYji8j4lo/k+8nJzMsnbmIaMpqhGpqdbT/62z9QvWcyw0HF2dSub5CWNv1d0ztJMkKYhoLVu6ZAuT6aKI+4dG26hBNp+yF/n0BI8gS4tpXr1DqegbAOnHhxZLofrdFAq3L6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935460; c=relaxed/simple;
	bh=WZxa4RqBhCzhL3OKyNWm+u8RHKxCkUssQewbrzd4bxU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iAWounuAp8+BwnDz/oaqFpMQ3nYqvlNYUYYWuikTLzx5kWtzeY5LOh99K2RW4YhV2BB6x8H2cFAuQKazeBZVtKFigVb6eavCWew3rWt3z/yqhVxc5lkcNg3nFZgVvez5T4Wnaht2J3AhBQsVf3HOefP090Z/av9/lYt+AEKVA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sPDSh8ld; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PkyHf3kd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 10:04:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736935455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Z3JV6K9tRJYhhHAwnCF5zX4kQLzLcpehk4c81ixL5Y=;
	b=sPDSh8ldEV23NEuoGn3Ho1DYRwQ8uz24V0kFVIOp4PEU1ZOLV/mQ/qeXjgboCI/oSd18Op
	QcWTAZGHxsxVfmDhOWuQmoQMQRi0DyzczUnSIF9+XXLY4zF+Z1t7uyBIihTLgEi0EKXum7
	qb+890Aj64kQh5dfeijwKNuGrkuCveiGQh17ULahqj9FGi1Dzmgqe/NvhRHnbqg1Fdc0Ym
	iMTlEGehCQJDTUBtbUEm5eXwySL/eBWxivb8F+Z1IngQ6CK71C44GelAgL2AhwmVKBKcSJ
	d9RndfEQvhJsNGYLD4nkKBIrPklij+PQNGvkOqlFTl0aePxz1Pn8pS0hSgLtnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736935455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Z3JV6K9tRJYhhHAwnCF5zX4kQLzLcpehk4c81ixL5Y=;
	b=PkyHf3kduh4S8knsUND4Gq4D3Sfw5bB1f6x8H5w6cQsbNvLRplW3L7+BDRCubzqRHn5z+w
	T/pNRBwG5r50s5CA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] ARC: Remove GENERIC_PENDING_IRQ
Cc: Thomas Gleixner <tglx@linutronix.de>, Vineet Gupta <vgupta@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241210103335.373392568@linutronix.de>
References: <20241210103335.373392568@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693545490.31546.7538489724128594213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5d30d6ab8c65b6caf034892aa8ae29285d0a515f
Gitweb:        https://git.kernel.org/tip/5d30d6ab8c65b6caf034892aa8ae29285d0=
a515f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Dec 2024 11:34:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 10:56:22 +01:00

ARC: Remove GENERIC_PENDING_IRQ

Nothing uses the actual functionality and the MCIP controller sets the
flags which disables the deferred affinity change. The other interrupt
controller does not support affinity setting at all.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Vineet Gupta <vgupta@kernel.org>=C2=A0=C2=A0 # arch/arc/
Link: https://lore.kernel.org/all/20241210103335.373392568@linutronix.de

---
 arch/arc/Kconfig       | 1 -
 arch/arc/kernel/mcip.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 5b24881..d1a97fe 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -24,7 +24,6 @@ config ARC
 	# for now, we don't need GENERIC_IRQ_PROBE, CONFIG_GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
-	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_IOREMAP
diff --git a/arch/arc/kernel/mcip.c b/arch/arc/kernel/mcip.c
index 55373ca..cdd370e 100644
--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -357,8 +357,6 @@ static void idu_cascade_isr(struct irq_desc *desc)
 static int idu_irq_map(struct irq_domain *d, unsigned int virq, irq_hw_numbe=
r_t hwirq)
 {
 	irq_set_chip_and_handler(virq, &idu_irq_chip, handle_level_irq);
-	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
-
 	return 0;
 }
=20

