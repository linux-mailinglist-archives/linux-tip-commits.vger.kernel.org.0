Return-Path: <linux-tip-commits+bounces-1987-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5440094AE17
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22B61F23CFC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F3F143C54;
	Wed,  7 Aug 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iq7KPUbR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6tHZpjod"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F5713CF86;
	Wed,  7 Aug 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047936; cv=none; b=LSDZvWH1yFWvxg8LXob0IPDOCzBhFtt/RMulw5uc0SSseNIBji0g4yetiZCMXhWZsRXmPi4Ruwn3RZ4yHNEoWnPH1SEc3gTv+S/eIEfld4xe62V3BZhHeMmcN3ObNpRpZ7fly24K6bGXfTm0a18XtJW4eHPL1snf8+Lutn8jvOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047936; c=relaxed/simple;
	bh=gOHTFFWjzlJNIMNJo8F5YoOaJDpHMGsCRhjwFjoKGnI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sJW9V5REqQCIirZBTZZlBEYO8VakiFcIfy8Oo3BiXIDYffbtscApSg+2/gnYNrXdljSWVl8hJpLGXOwRVNVip4/V0e9jhcBwV/PRWFJDrkcwqfDb8x7T7U0qWyVFpckLUwAhIFIAy7fbrr1L+f0P7QEFIdM6WEz7lnxIVLst0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iq7KPUbR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6tHZpjod; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 16:25:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723047930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YyfoPXQuLV3do/fWiHN2ca83YfdWXLbxhtlgbLpAE0w=;
	b=iq7KPUbRqx+8t34DPMYLv0wDNbPxkSxflxgJHR37KLa9AZxPBunnBhB3uNM6mylSo2uFGJ
	WcwxslQAq5QLrcFOKy9qsLha8KWTwvkaji3lpLrV6nsXBI1PMGUC8B6hrFMQRGojH39cpd
	ABCIqp7e28LCxMvcdO5BsH9TaTTc4i0v6knK6q+jMKXmH6c72yMpcwDkkqrbyb7EoMmUWZ
	kQHc3LoYjyYQzquvjkYSXzcHnRZvAlpQ1FvwW5ThIPIVHhWj0Tw4jP6mZRyPSunxK6eBAT
	u2CuaQopR/hSlIpY8WK+KiJ/LOyqe1Pjalnxb/R9vNiaaRMrBl+3ZBBRuZC+ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723047930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YyfoPXQuLV3do/fWiHN2ca83YfdWXLbxhtlgbLpAE0w=;
	b=6tHZpjodOjIs1d3EgVuEh+kr1eeDI/gym/sXxbul+O5cyRdWYzPl7VOXNCuCpV4UD51Vfm
	Kfg5dhc9KDzV3xDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Cleanup structs
Cc: Thomas Gleixner <tglx@linutronix.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Breno Leitao <leitao@debian.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802155440.402005874@linutronix.de>
References: <20240802155440.402005874@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304792980.2215.1996098678622462229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     d8c76d0167a0f20d071c540b1ffba5794eeb83ca
Gitweb:        https://git.kernel.org/tip/d8c76d0167a0f20d071c540b1ffba5794eeb83ca
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Aug 2024 18:15:37 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 18:13:27 +02:00

x86/ioapic: Cleanup structs

Make them conforming to the TIP coding style guide.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/20240802155440.402005874@linutronix.de

---
 arch/x86/kernel/apic/io_apic.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 30a3af2..e24d48d 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -86,8 +86,8 @@ static unsigned int ioapic_dynirq_base;
 static int ioapic_initialized;
 
 struct irq_pin_list {
-	struct list_head list;
-	int apic, pin;
+	struct list_head	list;
+	int			apic, pin;
 };
 
 struct mp_chip_data {
@@ -96,7 +96,7 @@ struct mp_chip_data {
 	bool				is_level;
 	bool				active_low;
 	bool				isa_irq;
-	u32 count;
+	u32				count;
 };
 
 struct mp_ioapic_gsi {
@@ -105,21 +105,17 @@ struct mp_ioapic_gsi {
 };
 
 static struct ioapic {
-	/*
-	 * # of IRQ routing registers
-	 */
-	int nr_registers;
-	/*
-	 * Saved state during suspend/resume, or while enabling intr-remap.
-	 */
-	struct IO_APIC_route_entry *saved_registers;
+	/* # of IRQ routing registers */
+	int				nr_registers;
+	/* Saved state during suspend/resume, or while enabling intr-remap. */
+	struct IO_APIC_route_entry	*saved_registers;
 	/* I/O APIC config */
-	struct mpc_ioapic mp_config;
+	struct mpc_ioapic		mp_config;
 	/* IO APIC gsi routing info */
-	struct mp_ioapic_gsi  gsi_config;
-	struct ioapic_domain_cfg irqdomain_cfg;
-	struct irq_domain *irqdomain;
-	struct resource *iomem_res;
+	struct mp_ioapic_gsi		gsi_config;
+	struct ioapic_domain_cfg	irqdomain_cfg;
+	struct irq_domain		*irqdomain;
+	struct resource			*iomem_res;
 } ioapics[MAX_IO_APICS];
 
 #define mpc_ioapic_ver(ioapic_idx)	ioapics[ioapic_idx].mp_config.apicver
@@ -2431,8 +2427,8 @@ static void ioapic_resume(void)
 }
 
 static struct syscore_ops ioapic_syscore_ops = {
-	.suspend = save_ioapic_entries,
-	.resume = ioapic_resume,
+	.suspend	= save_ioapic_entries,
+	.resume		= ioapic_resume,
 };
 
 static int __init ioapic_init_ops(void)

