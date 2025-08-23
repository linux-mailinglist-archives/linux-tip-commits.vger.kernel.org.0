Return-Path: <linux-tip-commits+bounces-6324-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF60B32BA3
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Aug 2025 21:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BFDB7A4D97
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Aug 2025 19:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E07F2E9EBC;
	Sat, 23 Aug 2025 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CtLZo0DM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T0UWxSNZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520A2206BB;
	Sat, 23 Aug 2025 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755977426; cv=none; b=YNgZzYQvKloZKMvznGQaWGARdrteAHUuQygq60jAUioMGtuFdTlcEhR/50OAPUO4836NsaCY3edpu8tMXpa+cNjIAFxdGQ4iGHUEzSQ2l6SBXHj2Uxy/P2eftF8fNLoFmbLV/YcRMg3d5E50oBT7S3YA94zz0I7+8gj2OGXRoFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755977426; c=relaxed/simple;
	bh=verecrmYD1JQzMLZTzQDfd6Y1tdFsYmi8MRtkE6g8+I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gPmJ4HZ2/3sI/6W/hhr+sTXoCTQKyjjlrFgJHiM5XVCcErwI1xZxnZPpsvfsnCwIXvCTKxjAUJrwRHDyMG2tjzfvWVMUXkGQgmMgk0OVxQwksLmb9dRYLTsBTaYp+5/VdBaDX1yfRITD8kVP1PE4bGnTIAkTdlgSFfpm/r4TRVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CtLZo0DM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T0UWxSNZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Aug 2025 19:28:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755977422;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQmArxF8zgjApv0Jec23ljOQWkkUx+wQzpuIYEOFAJQ=;
	b=CtLZo0DMzKeunDzEaJ4fknzJ4llagjVkoWhyzvJHRxwk2SoPxpUv+5YIFD8cD3ImMriFfa
	gtTU4i2i4NIbD32iEVPh8ViBoO/Sz2uQXQOVnEiMrYsIQ0bnqXJ4q+T0N7drRDRpmtqOZ9
	rHFJWAWsP5BSPHU3735Y+6HVQkz9OTEmZEvT8Pv1XgkPnv37wyH4vluK5JtWsdRC2Yc5Fm
	N8NxtV6vWaLoMcMVr1aFokpoPZmnYSuvxjQEdOI37+OHk66BLCy7ChyPSqAMzOUt1m1/2n
	3kj6M6JG+CvL3uCJFGtOnIeFsi6VXAont1V3ISaFtMfOqkpPdIA6U9waR7AaCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755977422;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQmArxF8zgjApv0Jec23ljOQWkkUx+wQzpuIYEOFAJQ=;
	b=T0UWxSNZo/J3ZBFDMZqmIHZBDMz2BCI+VOqI3MBq/x5tLAOUD2jyhriDVD497OZ4/1NgNt
	rlVwzLhZXBpgsoDQ==
From: "tip-bot2 for Inochi Amaoto" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Add irq_chip_(startup/shutdown)_parent()
Cc: Thomas Gleixner <tglx@linutronix.de>, Inochi Amaoto <inochiama@gmail.com>,
 Chen Wang <unicorn_wang@outlook.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250813232835.43458-2-inochiama@gmail.com>
References: <20250813232835.43458-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175597732893.1420.15935701466781671435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7a721a2fee2bce01af26699a87739db8ca8ea3c8
Gitweb:        https://git.kernel.org/tip/7a721a2fee2bce01af26699a87739db8ca8=
ea3c8
Author:        Inochi Amaoto <inochiama@gmail.com>
AuthorDate:    Thu, 14 Aug 2025 07:28:31 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 23 Aug 2025 21:20:25 +02:00

genirq: Add irq_chip_(startup/shutdown)_parent()

As the MSI controller on SG2044 uses PLIC as the underlying interrupt
controller, it needs to call irq_enable() and irq_disable() to
startup/shutdown interrupts. Otherwise, the MSI interrupt can not be
startup correctly and will not respond any incoming interrupt.

Introduce irq_chip_startup_parent() and irq_chip_shutdown_parent() to allow
the interrupt controller to call the irq_startup()/irq_shutdown() callbacks
of the parent interrupt chip.

In case the irq_startup()/irq_shutdown() callbacks are not implemented for
the parent interrupt chip, this will fallback to irq_chip_enable_parent()
or irq_chip_disable_parent().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Link: https://lore.kernel.org/all/20250813232835.43458-2-inochiama@gmail.com
Link: https://lore.kernel.org/lkml/20250722224513.22125-1-inochiama@gmail.com/
---
 include/linux/irq.h |  2 ++
 kernel/irq/chip.c   | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c9bcdbf..c67e76f 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -669,6 +669,8 @@ extern int irq_chip_set_parent_state(struct irq_data *dat=
a,
 extern int irq_chip_get_parent_state(struct irq_data *data,
 				     enum irqchip_irq_state which,
 				     bool *state);
+extern void irq_chip_shutdown_parent(struct irq_data *data);
+extern unsigned int irq_chip_startup_parent(struct irq_data *data);
 extern void irq_chip_enable_parent(struct irq_data *data);
 extern void irq_chip_disable_parent(struct irq_data *data);
 extern void irq_chip_ack_parent(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 0d02763..3ffa0d8 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1260,6 +1260,43 @@ int irq_chip_get_parent_state(struct irq_data *data,
 EXPORT_SYMBOL_GPL(irq_chip_get_parent_state);
=20
 /**
+ * irq_chip_shutdown_parent - Shutdown the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ *
+ * Invokes the irq_shutdown() callback of the parent if available or falls
+ * back to irq_chip_disable_parent().
+ */
+void irq_chip_shutdown_parent(struct irq_data *data)
+{
+	struct irq_data *parent =3D data->parent_data;
+
+	if (parent->chip->irq_shutdown)
+		parent->chip->irq_shutdown(parent);
+	else
+		irq_chip_disable_parent(data);
+}
+EXPORT_SYMBOL_GPL(irq_chip_shutdown_parent);
+
+/**
+ * irq_chip_startup_parent - Startup the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ *
+ * Invokes the irq_startup() callback of the parent if available or falls
+ * back to irq_chip_enable_parent().
+ */
+unsigned int irq_chip_startup_parent(struct irq_data *data)
+{
+	struct irq_data *parent =3D data->parent_data;
+
+	if (parent->chip->irq_startup)
+		return parent->chip->irq_startup(parent);
+
+	irq_chip_enable_parent(data);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(irq_chip_startup_parent);
+
+/**
  * irq_chip_enable_parent - Enable the parent interrupt (defaults to unmask =
if
  * NULL)
  * @data:	Pointer to interrupt specific data

