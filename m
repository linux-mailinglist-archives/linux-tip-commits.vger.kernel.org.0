Return-Path: <linux-tip-commits+bounces-6330-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8F3B32EF1
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Aug 2025 12:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17911B28454
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Aug 2025 10:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C802264C6;
	Sun, 24 Aug 2025 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M4a94LX5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cftCJ5uP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65361993B9;
	Sun, 24 Aug 2025 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756030950; cv=none; b=A6iq/CqgmWzBoCZSFlbtYWoFTrZ8oW+lR3xX2PmY/H+eMEKEsmkQMp1fY3dHjHajdGUTS1LoYTV73ka42VMXSKnUvxzi7WGMKZhgZpJEz/CWqhSlFVQdAsjxZaA3CRDNHUw+eOmEgqeUwCT7AzOgTZi2AMc2r33eLLUNBDbFNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756030950; c=relaxed/simple;
	bh=8cuxYXWFU1xxwpNyQfcUxkz6M/gMSmr76PFy905T4xg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WY5yeCMn7VS6XDs9u5UOQB9d8Y8HEdXJHhRe2Jp0/s0o7/b6jc8/tfZmkQAelCXI463MydPQmwnOy97THC4DJjLOKDoolmPuIaGFaDB+2MXeK55Ku31nYTHqUyWaKAvWCqYrZzOB6rnSBii86JdoLzdIBvMGCZmPSOBiq5/dhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M4a94LX5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cftCJ5uP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 24 Aug 2025 10:22:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756030946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ohiUyNJuAbPTZb7pTiT9V9/zAva5G0BS5xNPTx9Pp8w=;
	b=M4a94LX5eViMSTuFHn00CZO1YURdIf1VvqOW1XAvxHDTXXAnnBtXgSSsRfIOI1aVy6+ghZ
	FZYOEcBeatEMTisxBU13aJJt22OBpeyZVEjGy4O+54H5eMMDPQcWGxBm+74x+Dr0MlItCB
	QpXV9JTyPGXGeQeu1qrMbZH5B/SgYJIbSp2wX4iJ+xVWphSJ+FC1fpMbMJvgI6uBYmDR8a
	TSS+KCEb4LfIdPxTvkEkHQtBWYWEwLO3f/13iFffPDqCdBKvsukFR8/QLY5zT4RpAn1M6h
	4vXvpOoA2LGMurkmdyn7AHghRpnfGXaYuWYjr52toPvUiy7PCEXBpK5tJUkVIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756030946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ohiUyNJuAbPTZb7pTiT9V9/zAva5G0BS5xNPTx9Pp8w=;
	b=cftCJ5uPLgSSp2UmfV7Pjc80/238NzEkXNEFFQGgQOG/PMJJll1TlG/wYie+6YpHCr98bo
	Jw3s6AncvpOsMcBQ==
From: "tip-bot2 for Fushuai Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/sifive-plic: Use for_each_present_cpu()
 instead of for_each_cpu()
Cc: Fushuai Wang <wangfushuai@baidu.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250811064701.2906-1-wangfushuai@baidu.com>
References: <20250811064701.2906-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175603094480.1420.3435582541559010943.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     b92ff23b12046f70f7f41f1e57e77c498dec35d7
Gitweb:        https://git.kernel.org/tip/b92ff23b12046f70f7f41f1e57e77c498de=
c35d7
Author:        Fushuai Wang <wangfushuai@baidu.com>
AuthorDate:    Mon, 11 Aug 2025 14:47:01 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 24 Aug 2025 12:10:46 +02:00

irqchip/sifive-plic: Use for_each_present_cpu() instead of for_each_cpu()

Replace the open coded for_each_cpu(cpu, cpu_present_mask) loop with the
more readable and equivalent for_each_present_cpu(cpu) macro.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250811064701.2906-1-wangfushuai@baidu.com

---
 drivers/irqchip/irq-sifive-plic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index bf69a48..3de5460 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -257,7 +257,7 @@ static int plic_irq_suspend(void)
 			     readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
 	}
=20
-	for_each_cpu(cpu, cpu_present_mask) {
+	for_each_present_cpu(cpu) {
 		struct plic_handler *handler =3D per_cpu_ptr(&plic_handlers, cpu);
=20
 		if (!handler->present)
@@ -289,7 +289,7 @@ static void plic_irq_resume(void)
 		       priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
 	}
=20
-	for_each_cpu(cpu, cpu_present_mask) {
+	for_each_present_cpu(cpu) {
 		struct plic_handler *handler =3D per_cpu_ptr(&plic_handlers, cpu);
=20
 		if (!handler->present)

