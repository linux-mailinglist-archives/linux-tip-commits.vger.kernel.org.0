Return-Path: <linux-tip-commits+bounces-4318-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A3FA67C87
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 20:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F8B8826E8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 19:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0A2207E0B;
	Tue, 18 Mar 2025 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="duqeoGLi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4/erqwrN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789461CF5E2;
	Tue, 18 Mar 2025 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324537; cv=none; b=f88kMSz9kCANJJ1wuXZ6IceTDwpem0DmzTtHezGkXeHRGhleywtFM3PY99fOyA+SbPk+y41/MCjYFaiufdI6LFy9QkGSw20KEALWvA/JVDlMtM5HASJzsp9KFipHQ7hBEYISQh59QnzUhkDAbb/MBz4m3qHL8TuhiR/q/+PxrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324537; c=relaxed/simple;
	bh=pRzobQUoZjtq89rSmh9hSQzFkYI/4r03FOZeuV3Mjcc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EKlXniRa85nX2zFeJdvwK745XnsPN/0Kv6hFg7YVBleIv9lUVg1PerAyWtxD9w7IYDnwYxw9OzVie0A/F653s8OGksJVOjkOmNQW4zTrEhP8O8RDpwdibdb/uZ/5L9VLIpit3ZGNvylkwwErkKPYVH+BzM9/Gg6RXf337zwRbB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=duqeoGLi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4/erqwrN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 18:54:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742324068;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCF4zruRNd8sVR1kaezGa4he30BokYpIFt0J79C8/i4=;
	b=duqeoGLisgLhX4VdjPD0NGBe4GIAQFKWT4ddIXxVQHSwMBYLWe2/rs9CU/U8ahe2300aOT
	4eMw65S3fKX7kH06krwFnEu7kvmyNkRVNy0W9Jh7ki0HXpb3V/6pgJ12fNwxEFph1mZTTg
	g+565TpxrcG6POnqZ1alDzTaF9d1LCcpUMRwJnf7LtIpV26gapNRs2c4LcxHG0ofvPk1Wr
	0lDsGTPGfLR6ONv3q4rDNGwVBVNOUikOTD1vZizOgYxsJYDsKlHVNsvey0lnJ0mJNkCOt1
	4l8xSGkxY4d965705xSHCbFbnQ85qTETpy+P5maZT3W3z/zPTLZDwiVlLy/19g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742324068;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCF4zruRNd8sVR1kaezGa4he30BokYpIFt0J79C8/i4=;
	b=4/erqwrNrxGBQUrOWPM6J0fEp506nammm58oWHro+bxJlrjg8w6nH75NgQ1sUhKMvgB8ng
	Cz2K6jqfE3KYhfDA==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/intel: Fix fast string initialization for
 extended Families
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-12-sohil.mehta@intel.com>
References: <20250219184133.816753-12-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174232406753.14745.6078997125572295195.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     8a1259836966af36c5d3fe68cf33ad9416e5e70a
Gitweb:        https://git.kernel.org/tip/8a1259836966af36c5d3fe68cf33ad9416e5e70a
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:29 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 19:33:46 +01:00

x86/cpu/intel: Fix fast string initialization for extended Families

X86_FEATURE_REP_GOOD is a linux defined feature flag to track whether
fast string operations should be used for copy_page(). It is also used
as a second alternative for clear_page() if enhanced fast string
operations (ERMS) are not available.

X86_FEATURE_ERMS is an Intel-specific hardware-defined feature flag that
tracks hardware support for Enhanced Fast strings.  It is used to track
whether Fast strings should be used for similar memory copy and memory
clearing operations.

On top of these, there is a FAST_STRING enable bit in the
IA32_MISC_ENABLE MSR. It is typically controlled by the BIOS to provide
a hint to the hardware and the OS on whether fast string operations are
preferred.

Commit:

  161ec53c702c ("x86, mem, intel: Initialize Enhanced REP MOVSB/STOSB")

introduced a mechanism to honor the BIOS preference for fast string
operations and clear the above feature flags if needed.

Unfortunately, the current initialization code for Intel to set and
clear these bits is confusing at best and likely incorrect.

X86_FEATURE_REP_GOOD is cleared in early_init_intel() if
MISC_ENABLE.FAST_STRING is 0. But it gets set later on unconditionally
for all Family 6 processors in init_intel(). This not only overrides the
BIOS preference but also contradicts the earlier check.

Fix this by combining the related checks and always relying on the BIOS
provided preference for fast string operations. This simplification
makes sure the upcoming Intel Family 18 and 19 models are covered as
well.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250219184133.816753-12-sohil.mehta@intel.com
---
 arch/x86/kernel/cpu/intel.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index ae20f45..2181304 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -289,12 +289,19 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 		clear_cpu_cap(c, X86_FEATURE_PAT);
 
 	/*
-	 * If fast string is not enabled in IA32_MISC_ENABLE for any reason,
-	 * clear the fast string and enhanced fast string CPU capabilities.
+	 * Modern CPUs are generally expected to have a sane fast string
+	 * implementation. However, BIOSes typically have a knob to tweak
+	 * the architectural MISC_ENABLE.FAST_STRING enable bit.
+	 *
+	 * Adhere to the preference and program the Linux-defined fast
+	 * string flag and enhanced fast string capabilities accordingly.
 	 */
-	if (c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xd)) {
+	if (c->x86_vfm >= INTEL_PENTIUM_M_DOTHAN) {
 		rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
-		if (!(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
+		if (misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING) {
+			/* X86_FEATURE_ERMS is set based on CPUID */
+			set_cpu_cap(c, X86_FEATURE_REP_GOOD);
+		} else {
 			pr_info("Disabled fast string operations\n");
 			setup_clear_cpu_cap(X86_FEATURE_REP_GOOD);
 			setup_clear_cpu_cap(X86_FEATURE_ERMS);
@@ -545,8 +552,6 @@ static void init_intel(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_64
 	if (c->x86 == 15)
 		c->x86_cache_alignment = c->x86_clflush_size * 2;
-	if (c->x86 == 6)
-		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 #else
 	/*
 	 * Names for the Pentium II/Celeron processors

