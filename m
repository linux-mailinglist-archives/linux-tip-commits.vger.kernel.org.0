Return-Path: <linux-tip-commits+bounces-4320-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520A8A67C8C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 20:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7133342426E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 19:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37681DDC34;
	Tue, 18 Mar 2025 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ywI64C/m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L3CPCY6z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789A21D63CD;
	Tue, 18 Mar 2025 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324540; cv=none; b=Ju1S0FNpJ4CUS0wcPqTgb4s3Z3+PKlQ5wR1/UL7Qv82yhZDV+kKHrTQVcP6L4FuGbkBl10D36jj/grA4msxD6HQFBkb2+H3fXmeOuyOYzAzfGug5nbc3Pmeb/vL1zGWo5YDdukzws/lWIvwvul3c4RsThQZBIzVD0Zpx+DvidW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324540; c=relaxed/simple;
	bh=KeKv9yBzckGL1DbKLcNxhQlKyhJZhjwQhjZdD2InWuE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kcidowGWDzPXc4K6X8ZuAhn/BmeJFHS/ELqzisAEthYMe1SWUXxLgff8TKbL9nlEB8UliNPDccCWUQBBqzpsAVxWDqy23WpABCpn1i/eaNHJrypCZXnjI5ByLXFjsw38brmt/lt7PHU6ggCaLY7OHAf5RGtrG44tfBpKAlFnP+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ywI64C/m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L3CPCY6z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 18:54:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742324067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/F9CV9HjZs/fV+lN4zy7fMkf2qGn9QGyAA84KyYvwE=;
	b=ywI64C/mGyqKFJQpBwD17Nk6bSM0ut+xq9GCUUOpv7RiaQ1tIThR0s+svy7Cj/5Te+t4fE
	Oju3rD3a0AlrpxnMf1/KULRFal6KxYeFYNpAQsV8abqf8plOb0TC7cyLegqLRPbcmfh7zC
	O/RRh7+a/qxs+kT+2uOlitpvMc+H7GG51PJNzL6rD1Zi7dIriMzvcKcDOfKF/Uj1xps19v
	hqCmAmAuiYRPK2FBcIq09Ugg1TEQhbDKZMta1+6n5PmdVTXVV3pglGF+znIeZqFdzOlEY9
	CKrX2WcZVcsbY9cjFY6KZoCoASCWh2+DkY8mUWkYXYudMjeV5mvwTVST/f/kIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742324067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/F9CV9HjZs/fV+lN4zy7fMkf2qGn9QGyAA84KyYvwE=;
	b=L3CPCY6zWPjVM/Wf31KWZXXJF6RoMv16uyAWURjyoi6ssjBSxNvTzxqR/cyUGudORiv4QY
	Z+5TEMjZfTL+ogCw==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/intel: Limit the non-architectural
 constant_tsc model checks
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-14-sohil.mehta@intel.com>
References: <20250219184133.816753-14-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174232406170.14745.11104170478814576697.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     08d9bb5b0d89826fedc5204c8bd2463220465996
Gitweb:        https://git.kernel.org/tip/08d9bb5b0d89826fedc5204c8bd2463220465996
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:31 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 19:33:47 +01:00

x86/cpu/intel: Limit the non-architectural constant_tsc model checks

X86_FEATURE_CONSTANT_TSC is a Linux-defined, synthesized feature flag.
It is used across several vendors. Intel CPUs will set the feature when
the architectural CPUID.80000007.EDX[1] bit is set. There are also some
Intel CPUs that have the X86_FEATURE_CONSTANT_TSC behavior but don't
enumerate it with the architectural bit.  Those currently have a model
range check.

Today, virtually all of the CPUs that have the CPUID bit *also* match
the "model >= 0x0e" check. This is confusing. Instead of an open-ended
check, pick some models (INTEL_IVYBRIDGE and P4_WILLAMETTE) as the end
of goofy CPUs that should enumerate the bit but don't.  These models are
relatively arbitrary but conservative pick for this.

This makes it obvious that later CPUs (like Family 18+) no longer need
to synthesize X86_FEATURE_CONSTANT_TSC.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20250219184133.816753-14-sohil.mehta@intel.com
---
 arch/x86/kernel/cpu/intel.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 2181304..4cbb2e6 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -201,10 +201,6 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
 
-	if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
-		(c->x86 == 0x6 && c->x86_model >= 0x0e))
-		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
-
 	if (c->x86 >= 6 && !cpu_has(c, X86_FEATURE_IA64))
 		c->microcode = intel_get_microcode_revision();
 
@@ -257,10 +253,16 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 *
 	 * It is also reliable across cores and sockets. (but not across
 	 * cabinets - we turn it off in that case explicitly.)
+	 *
+	 * Use a model-specific check for some older CPUs that have invariant
+	 * TSC but may not report it architecturally via 8000_0007.
 	 */
 	if (c->x86_power & (1 << 8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
+	} else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
+		   (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
+		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 	}
 
 	/* Penwell and Cloverview have the TSC which doesn't sleep on S3 */

