Return-Path: <linux-tip-commits+bounces-5563-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B48FCAB9837
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 11:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425F14A3293
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9BB223DCA;
	Fri, 16 May 2025 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zp1+931/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p6fvYGFT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0900E1624DD;
	Fri, 16 May 2025 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386063; cv=none; b=M68fEPiDorPD+Jp+8zDatMR5xL5c5+JrUSlE4PlRi+WpaMw/oB8XH/cxMw6OhXQIkhT6m4c5Z7ap2WBMUyje+U45vR4tru/OYK90SybBd6UaGN7dT1UFZk5uwJeuDsyQlpTdgCinIW6lpahG8XGx45CnZ4PttocNXC30i/HiYe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386063; c=relaxed/simple;
	bh=GYa/YaANJ6VXGToJj4KAUIkqcyAj8eau/yBxIOt0pJc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VEuujMY3miH67tIESN+afCqRdC1fgdgBTVCtfCsZGlWmGn/8Udkirc+KC1afqf4n91fqpZAk4+S8KQiW6yR/rOkgkcF+0K7bHarNuwhIVU1cr95Oy+Na98VIM57XgFkmSBJq+bYnb585PfXR4HtLQuaGzwEIl5ShU4bFxTCgSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zp1+931/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p6fvYGFT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 09:00:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747386060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFlfKRnb/HyA83iZtvMmzZR6nHpJoD8gHlSTHA8MDvI=;
	b=Zp1+931/C1UdCqzjBt4VVdaPVivUFt7YtcH8w0mGeb7jmVmIGOWdeg6Pk5+/m0gB0laNmd
	WFJ25lG/hnGyOCr4Z9O+vBiQJQxs6aWXjgpXB4peDOTGVaFUkE/jfSuCcx2HjAdg3ZGCqh
	/yDpVWavJ5mw3CpzO6hILyevYuuvMeLz1Dso4z9ZtPCnZAqu0W0nu4KhQDdjumaPtm7opF
	2BrGkLK0QaZsMoE84UHplM7KkZ1PzCs7Com2WJFcZAbxUJ0ETVE1HRbGFOYNqw2p6s1vPH
	X1Mt9oILmn9d7+CKuwXmrpq9b/Z61Wa9IXXxeXOv2Hs0mi9MveWOxO8XD9r5Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747386060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFlfKRnb/HyA83iZtvMmzZR6nHpJoD8gHlSTHA8MDvI=;
	b=p6fvYGFTc6ZaNs4ekmm/nGqO5WUJXhc36II5PE11+OHsT28vLNkeY6Mt+3PKYxf/49gV8R
	T84aNX5JnylHDzAQ==
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
Message-ID: <174738605887.406.8422170755255496716.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     119deb95b0bc2793d4b002549444ce0aec346b4f
Gitweb:        https://git.kernel.org/tip/119deb95b0bc2793d4b002549444ce0aec346b4f
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 08 May 2025 17:02:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 16 May 2025 10:49:55 +02:00

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

