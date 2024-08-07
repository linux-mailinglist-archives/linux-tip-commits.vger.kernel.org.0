Return-Path: <linux-tip-commits+bounces-1979-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A21894AE08
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A91F1C20BDE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 16:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D10B13D265;
	Wed,  7 Aug 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fw+voLOa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fu08kw7X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D213AA41;
	Wed,  7 Aug 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047932; cv=none; b=ON2dUHgJygrIYD3a5/t1LHc0Wzk3qynWmGho//qo9f05iW4bmSiZKowTu+DMO9MTveg/5yidSqNYgs5GTjgD6wSUC+BkcF90zeqHlnkeid7+6MjxlLnKY7hR2Sp3DbqKYFAWfLzT3JDRdLsyFE7NAzUe4k0VjxNm/cyUR4ARFjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047932; c=relaxed/simple;
	bh=NHs+h21TlBfkPwXCKsiHl9M92+MoP0CNCoE2C967rNI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jqIm8JaVAREqL3yhhhu7tYzQRmdX6IyDeSKQ+GujxmG7SiTYvk5h6bXPtfqE8tc4t3MdTmLf7sl+kJPox3DaMNVsxvpPcdAi9/2kM0GjC8bqu7FEtRKkY4gDkoyRkadABxQch+ibwTvFMQugvA7+HlJuYl5DoFYk4ZRlWG7m+0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fw+voLOa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fu08kw7X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 16:25:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723047928;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iPg6uFgKveX2ARbz7pZ0DtjSOBfBiVQzspCqlwPIas=;
	b=fw+voLOaSUy8fm3BUZ3BhbSGx0feWTeajtYibu5BF5fPBGxJyRmgPIe7IppNRGrPtTZ7pR
	o21T1GnA2Kyi7ovUntPHwJUMZHQ4Ok6WMqRZSHdJOVD922SgCquLBbjmIR95FZIr7CpSfK
	WsVYBa6/QwhgPGyOG0ChWs3jVkR3v33dzv7rB17/8Dbrhi/3L8bwEAuoX5BAoZny+sme6q
	0OQi/sF/RZA2CXQQ7HBT/GTL9jgu6p9Cr56Y/bD+sdtuPRiDFcPYTzgJvLPYOc/ip5JKA7
	t/Zu7a6SDkTyuciIYsYgA/ulvpIbB4ZfbwgY7qBkc7wVJQubDjbVZCz0iJ+eDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723047928;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iPg6uFgKveX2ARbz7pZ0DtjSOBfBiVQzspCqlwPIas=;
	b=Fu08kw7XUHBYXxzHkyJctvVWAnieofLbhEyH682etk1kuRVtsHBGGfNwBphgWDPBluHV2/
	LoZlRBZzcI2BPuCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/mpparse: Cleanup apic_printk()s
Cc: Thomas Gleixner <tglx@linutronix.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Breno Leitao <leitao@debian.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802155440.779537108@linutronix.de>
References: <20240802155440.779537108@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304792825.2215.16286899367489592230.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     1ee0aa8285c11921ad22336d07b67fc81a0d36cf
Gitweb:        https://git.kernel.org/tip/1ee0aa8285c11921ad22336d07b67fc81a0d36cf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Aug 2024 18:15:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 18:13:28 +02:00

x86/mpparse: Cleanup apic_printk()s

Use the new apic_pr_verbose() helper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/20240802155440.779537108@linutronix.de

---
 arch/x86/kernel/mpparse.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index e89171b..4a1b1b2 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -68,7 +68,7 @@ static void __init mpc_oem_bus_info(struct mpc_bus *m, char *str)
 {
 	memcpy(str, m->bustype, 6);
 	str[6] = 0;
-	apic_printk(APIC_VERBOSE, "Bus #%d is %s\n", m->busid, str);
+	apic_pr_verbose("Bus #%d is %s\n", m->busid, str);
 }
 
 static void __init MP_bus_info(struct mpc_bus *m)
@@ -417,7 +417,7 @@ static unsigned long __init get_mpc_size(unsigned long physptr)
 	mpc = early_memremap(physptr, PAGE_SIZE);
 	size = mpc->length;
 	early_memunmap(mpc, PAGE_SIZE);
-	apic_printk(APIC_VERBOSE, "  mpc: %lx-%lx\n", physptr, physptr + size);
+	apic_pr_verbose("  mpc: %lx-%lx\n", physptr, physptr + size);
 
 	return size;
 }
@@ -560,8 +560,7 @@ static int __init smp_scan_config(unsigned long base, unsigned long length)
 	struct mpf_intel *mpf;
 	int ret = 0;
 
-	apic_printk(APIC_VERBOSE, "Scan for SMP in [mem %#010lx-%#010lx]\n",
-		    base, base + length - 1);
+	apic_pr_verbose("Scan for SMP in [mem %#010lx-%#010lx]\n", base, base + length - 1);
 	BUILD_BUG_ON(sizeof(*mpf) != 16);
 
 	while (length > 0) {
@@ -683,13 +682,13 @@ static void __init check_irq_src(struct mpc_intsrc *m, int *nr_m_spare)
 {
 	int i;
 
-	apic_printk(APIC_VERBOSE, "OLD ");
+	apic_pr_verbose("OLD ");
 	print_mp_irq_info(m);
 
 	i = get_MP_intsrc_index(m);
 	if (i > 0) {
 		memcpy(m, &mp_irqs[i], sizeof(*m));
-		apic_printk(APIC_VERBOSE, "NEW ");
+		apic_pr_verbose("NEW ");
 		print_mp_irq_info(&mp_irqs[i]);
 		return;
 	}
@@ -772,7 +771,7 @@ static int  __init replace_intsrc_all(struct mpc_table *mpc,
 			continue;
 
 		if (nr_m_spare > 0) {
-			apic_printk(APIC_VERBOSE, "*NEW* found\n");
+			apic_pr_verbose("*NEW* found\n");
 			nr_m_spare--;
 			memcpy(m_spare[nr_m_spare], &mp_irqs[i], sizeof(mp_irqs[i]));
 			m_spare[nr_m_spare] = NULL;

