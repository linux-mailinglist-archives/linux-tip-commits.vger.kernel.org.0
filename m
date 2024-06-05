Return-Path: <linux-tip-commits+bounces-1348-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3D38FD1F4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 17:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07CAF1F21DE6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47354778E;
	Wed,  5 Jun 2024 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C+L/a80y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qPw1NWO0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E921E89C;
	Wed,  5 Jun 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602245; cv=none; b=OABex+EIOw5OYGKPvzTL8oEwySDofhEp9AYqSR28JtFR8+QMqMLaE6YtDw0Zeiq7NM2bdnVQD8xe+0goFyRx4BZ5LQg/h4VovoEZC+ezGBCRJo0XBybM/hnxNFkTKEpMM4fSltOLy+mt1pgwplRFuw5molNPT23vQNz+QLjquXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602245; c=relaxed/simple;
	bh=KT6Ja21CeBwDwnbTMjxwB5jW7NaOaDFBEqS3Jil1IB0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qkD31hZtWtucuor22NyMVI2TTJwykwCBH8bMKWumEtByc+axEB9t++zFqDw3iLxUbgugVdf4YmhAgsL63aBHJJxPpIwT9VC8TjPNNI427R3NH7UqMRBFUhNxDyDYrh4GhPZ0tSQ9eHpUf8Wu03SAhrQBNlgIKyFufcjSpDHYCpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C+L/a80y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qPw1NWO0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Jun 2024 15:44:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717602242;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvg4wm+N6AqA16g0BLTOAUIQFZA6StgSmQvAxJCYYhc=;
	b=C+L/a80yiUTx/cR1sYxPOwlaZkb3//acDXR2L8VOji0MzhIZuU2iA+F//ATG4iiT4rBXFj
	ruSKi58IBCwwygxocVpsYjNFxLV3eTYRgd2OhEnRMbJNqkCc3IdkzRxwJT+EdkJdss/mtu
	xzWbYRBHUsCMPoknWOHtYzRRABusqCvDQ2tDr0j79E5Su3uf7yfGZxiaaZ3n0bdebe003t
	QZSsFsGr1iXbS6iNLvejD0+iIyDLFM5jTGQhKDt88eVViNxIddpjsqFA4UwN6hWmBbE+N5
	pmKBWkLQIvX01dhJvYVS/igMpDsXlyGERo/xGJz/RgpA+Mdffzxp9Xo9BDCsGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717602242;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvg4wm+N6AqA16g0BLTOAUIQFZA6StgSmQvAxJCYYhc=;
	b=qPw1NWO0fw7aOwNayDhnmtiDrWyieKBRVbJ4ZJEHT0mXatsKOz6j68fuAZLQm5XFSQDpcT
	q7JxYm/LgKIUy5CA==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Add missing parameter descriptions in
 kernel-doc comments
Cc: Herve Codina <herve.codina@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240527161450.326615-10-herve.codina@bootlin.com>
References: <20240527161450.326615-10-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171760224154.10875.18416115234457548979.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b4dc049ea3ea98df58820f988c7c9578aa076f72
Gitweb:        https://git.kernel.org/tip/b4dc049ea3ea98df58820f988c7c9578aa076f72
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Mon, 27 May 2024 18:14:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 05 Jun 2024 17:41:42 +02:00

irqdomain: Add missing parameter descriptions in kernel-doc comments

During compilation, several warning of the following form were raised:
  Function parameter or struct member 'x' not described in 'yyy'

Add the missing function parameter descriptions.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240527161450.326615-10-herve.codina@bootlin.com
---
 kernel/irq/irqdomain.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index d937231..28709c1 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -111,6 +111,7 @@ EXPORT_SYMBOL_GPL(__irq_domain_alloc_fwnode);
 
 /**
  * irq_domain_free_fwnode - Free a non-OF-backed fwnode_handle
+ * @fwnode: fwnode_handle to free
  *
  * Free a fwnode_handle allocated with irq_domain_alloc_fwnode.
  */
@@ -982,6 +983,12 @@ EXPORT_SYMBOL_GPL(__irq_resolve_mapping);
 
 /**
  * irq_domain_xlate_onecell() - Generic xlate for direct one cell bindings
+ * @d:		Interrupt domain involved in the translation
+ * @ctrlr:	The device tree node for the device whose interrupt is translated
+ * @intspec:	The interrupt specifier data from the device tree
+ * @intsize:	The number of entries in @intspec
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
  *
  * Device Tree IRQ specifier translation function which works with one cell
  * bindings where the cell value maps directly to the hwirq number.
@@ -1000,6 +1007,12 @@ EXPORT_SYMBOL_GPL(irq_domain_xlate_onecell);
 
 /**
  * irq_domain_xlate_twocell() - Generic xlate for direct two cell bindings
+ * @d:		Interrupt domain involved in the translation
+ * @ctrlr:	The device tree node for the device whose interrupt is translated
+ * @intspec:	The interrupt specifier data from the device tree
+ * @intsize:	The number of entries in @intspec
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
  *
  * Device Tree IRQ specifier translation function which works with two cell
  * bindings where the cell values map directly to the hwirq number
@@ -1018,6 +1031,12 @@ EXPORT_SYMBOL_GPL(irq_domain_xlate_twocell);
 
 /**
  * irq_domain_xlate_onetwocell() - Generic xlate for one or two cell bindings
+ * @d:		Interrupt domain involved in the translation
+ * @ctrlr:	The device tree node for the device whose interrupt is translated
+ * @intspec:	The interrupt specifier data from the device tree
+ * @intsize:	The number of entries in @intspec
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
  *
  * Device Tree IRQ specifier translation function which works with either one
  * or two cell bindings where the cell values map directly to the hwirq number
@@ -1051,6 +1070,10 @@ EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
 /**
  * irq_domain_translate_onecell() - Generic translate for direct one cell
  * bindings
+ * @d:		Interrupt domain involved in the translation
+ * @fwspec:	The firmware interrupt specifier to translate
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
  */
 int irq_domain_translate_onecell(struct irq_domain *d,
 				 struct irq_fwspec *fwspec,
@@ -1068,6 +1091,10 @@ EXPORT_SYMBOL_GPL(irq_domain_translate_onecell);
 /**
  * irq_domain_translate_twocell() - Generic translate for direct two cell
  * bindings
+ * @d:		Interrupt domain involved in the translation
+ * @fwspec:	The firmware interrupt specifier to translate
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
  *
  * Device Tree IRQ specifier translation function which works with two cell
  * bindings where the cell values map directly to the hwirq number

