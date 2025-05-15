Return-Path: <linux-tip-commits+bounces-5555-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E995AB8D75
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 19:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 851B47B1E55
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 17:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C66B25743B;
	Thu, 15 May 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i/vDy4e4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1x78PTMc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207B62550D3;
	Thu, 15 May 2025 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329439; cv=none; b=YX+OMk4I2npK0VEosyHVXC23PgIbHhysRGrdodz43e4Dnc3bD/8UPTfjY8vDZlra2WOnrfwxe0NvrR9XkUfFXASck8ZkNngthlRAlyeDzdxjL9dgcRh9S5nMgxfLNfy+G54qJy87IOSarOUtm5jXtXG3mX997OB6J/EyJoF2A9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329439; c=relaxed/simple;
	bh=MNqz2tzv89uMSYwBmim6oUIR8Q1b4KxpaZnq+KjILEs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JvoFqAeuruRcnAgvt2x11NCAGE5R/zOIEh25XHNDC8gmOjhszRoE2nUfyxikJfcaWJc8Ye3Ejftf+nX3YZdoRl0ezxd6ZKGSUeZHYGiRIlI1LkPDwx+4hIuj2ZDvcvNZITgfpcKpUZ6iQ5WpD2Ld/F8UnpGjLo0B3yn5eRDHK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i/vDy4e4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1x78PTMc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 May 2025 17:17:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747329435;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SO5bdLm8iikFzL92Vi0eZYrrmsKDoOgUV0OZhOLbhx8=;
	b=i/vDy4e4WxKewwv4l1TZAYGvxM5lgfcnGxjQAF3bo5WjM8wRP+yC9S5roOc11Vv2FcPCQe
	je6+8P2lfxMarxMWrxPKlBI4QzwBkMAa3l6o71KExHypJpdTahRMxuymhsI5zG6zq51IH3
	JiId2rSUO4ug9KZ8PzfJLWktIuMClW5aYeVIESl7enoftkR+xsfYCybzPh3Dl3RFT+w7P9
	jnnRSs7xfBerRgCRhNXqcw6zbcF+0HiGqUuIodGNI0JLWom1jiV8phjxm3PHYOebeiRTvW
	DqQ9G8FuUpqTZOSviwuXzwsNVNgVjGitiok4yQI74jz9tke8osgtG/GtctjqtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747329435;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SO5bdLm8iikFzL92Vi0eZYrrmsKDoOgUV0OZhOLbhx8=;
	b=1x78PTMcxs9i3KRLpCS6/OyY3ZMbFykBbuh1LTHqv7OnpHrjsXqTZJ1Q1/P6w2Yrk6MUFR
	UQXfcl4fwPYHtFBw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu/intel: Rename CPUID(0x2) descriptors iterator
 parameter
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250508150240.172915-8-darwi@linutronix.de>
References: <20250508150240.172915-8-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174732943411.406.16408552779328178408.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     234792ea4421499f123e73b2e6411469a561a123
Gitweb:        https://git.kernel.org/tip/234792ea4421499f123e73b2e6411469a561a123
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 08 May 2025 17:02:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 15 May 2025 18:48:10 +02:00

x86/cpu/intel: Rename CPUID(0x2) descriptors iterator parameter

The CPUID(0x2) descriptors iterator has been renamed from:

    for_each_leaf_0x2_entry()

to:

    for_each_cpuid_0x2_desc()

since it iterates over CPUID(0x2) cache and TLB "descriptors", not
"entries".

In the macro's x86/cpu call-site, rename the parameter denoting the
parsed descriptor at each iteration from 'entry' to 'desc'.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250508150240.172915-8-darwi@linutronix.de
---
 arch/x86/kernel/cpu/intel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index f8141b5..076eaa4 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -648,11 +648,11 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 }
 #endif
 
-static void intel_tlb_lookup(const struct leaf_0x2_table *entry)
+static void intel_tlb_lookup(const struct leaf_0x2_table *desc)
 {
-	short entries = entry->entries;
+	short entries = desc->entries;
 
-	switch (entry->t_type) {
+	switch (desc->t_type) {
 	case STLB_4K:
 		tlb_lli_4k = max(tlb_lli_4k, entries);
 		tlb_lld_4k = max(tlb_lld_4k, entries);
@@ -709,7 +709,7 @@ static void intel_tlb_lookup(const struct leaf_0x2_table *entry)
 
 static void intel_detect_tlb(struct cpuinfo_x86 *c)
 {
-	const struct leaf_0x2_table *entry;
+	const struct leaf_0x2_table *desc;
 	union leaf_0x2_regs regs;
 	u8 *ptr;
 
@@ -717,8 +717,8 @@ static void intel_detect_tlb(struct cpuinfo_x86 *c)
 		return;
 
 	cpuid_leaf_0x2(&regs);
-	for_each_cpuid_0x2_desc(regs, ptr, entry)
-		intel_tlb_lookup(entry);
+	for_each_cpuid_0x2_desc(regs, ptr, desc)
+		intel_tlb_lookup(desc);
 }
 
 static const struct cpu_dev intel_cpu_dev = {

