Return-Path: <linux-tip-commits+bounces-3732-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E96BDA49706
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 11:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916E91732E3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 10:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA2C25E80D;
	Fri, 28 Feb 2025 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4eC10o7r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DtucnyLQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6444F25E473;
	Fri, 28 Feb 2025 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737937; cv=none; b=G6WjkZEp2HdfUBHDALdCzE70UX77LZqjbSEmIC+TRpvtlvk5f7VX+ywJvV6SV5+mf5PInKQek0DqdJ7JZ+nmXpFn8k+4B7L1GZl/0+VkYMizsoa5bHZQEj1UBrPvg2/l7LXmY2owznZTfFvWS5s/79MDYA2zuw7fFW3cXmrC+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737937; c=relaxed/simple;
	bh=hh8S5n6sipnvbZoA4pnGfPonAx9EOLoN4eggioFAOiY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j8DqdQxJ8Eib9JbR5uNg3TweOCFdtbVrzWz2Nj1+86ZGQNzTKB+CB3mGH1Fn0dvkFSCgIcBetDvAyXkMfmMXTmJmqRo7w2mFDcvq7CfairDIeku7dqcdvveq2X3kHdMlIkqJsNzUn/dAST3H5tgufTtXdDrdvdnEwHj8ASznzfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4eC10o7r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DtucnyLQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Feb 2025 10:18:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740737933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNpVPYwVhV0AgybG2sYfprrzFYjIYieHNApKMMJQ20Q=;
	b=4eC10o7rZUysIuvwBN31W6M/1rW6NY6z3sBAy5GOcLk5s8phaI8uKavVbBSYeGYuxN/Yas
	rQbQyyL5oepfsYc5UoC0hMDWRD9yGF1EQXgnh0QbMC8oPNIAKQOsoQj2gFZHSmPYGerZpU
	mjlDsQod/KTbBV480IaAuPeGZjHiHwB0qi04l28+Lj164wgdY9szK9sAZ3mOIhXEaV85Sn
	TzDXgRECgEqqGNurj/XX70fACWhj2f2F9tBbWFQzi9TAPzlPxeZXxuOGxSQ6cyUuXEH1x6
	V9uThlqh2JodY8D3GctoIFYQRFAgypeWhBgDba7ih8YU435mm3kVcHuBbOCSoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740737933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNpVPYwVhV0AgybG2sYfprrzFYjIYieHNApKMMJQ20Q=;
	b=DtucnyLQgaSL+kgkP5EREv2dLSCiwKLfUlB0l2zBbpiza2715FIfoAmex+QPb6bfBtmQf9
	N4A0uZLFYeDEkAAg==
From: "tip-bot2 for Brendan Jackman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Add the 'setcpuid=' boot parameter
Cc: Brendan Jackman <jackmanb@google.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241220-force-cpu-bug-v2-2-7dc71bce742a@google.com>
References: <20241220-force-cpu-bug-v2-2-7dc71bce742a@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174073793309.10177.166450591972980620.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     814165e9fd1f62332b5444d730b8d6e432328463
Gitweb:        https://git.kernel.org/tip/814165e9fd1f62332b5444d730b8d6e432328463
Author:        Brendan Jackman <jackmanb@google.com>
AuthorDate:    Fri, 20 Dec 2024 15:18:32 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 28 Feb 2025 10:57:49 +01:00

x86/cpu: Add the 'setcpuid=' boot parameter

In preparation for adding support to inject fake CPU bugs at boot-time,
add a general facility to force enablement of CPU flags.

The flag taints the kernel and the documentation attempts to be clear
that this is highly unsuitable for uses outside of kernel development
and platform experimentation.

The new arg is parsed just like clearcpuid, but instead of leading to
setup_clear_cpu_cap() it leads to setup_force_cpu_cap().

I've tested this by booting a nested QEMU guest on an Intel host, which
with setcpuid=svm will claim that it supports AMD virtualization.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241220-force-cpu-bug-v2-2-7dc71bce742a@google.com
---
 arch/x86/kernel/cpu/common.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 137d3e0..ff483c9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1479,12 +1479,12 @@ static void detect_nopl(void)
 #endif
 }
 
-static inline void parse_clearcpuid(char *arg)
+static inline void parse_set_clear_cpuid(char *arg, bool set)
 {
 	char *opt;
 	int taint = 0;
 
-	pr_info("Clearing CPUID bits:");
+	pr_info("%s CPUID bits:", set ? "Force-enabling" : "Clearing");
 
 	while (arg) {
 		bool found __maybe_unused = false;
@@ -1505,7 +1505,10 @@ static inline void parse_clearcpuid(char *arg)
 				else
 					pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
 
-				setup_clear_cpu_cap(bit);
+				if (set)
+					setup_force_cpu_cap(bit);
+				else
+					setup_clear_cpu_cap(bit);
 				taint++;
 			}
 			/*
@@ -1523,7 +1526,10 @@ static inline void parse_clearcpuid(char *arg)
 				continue;
 
 			pr_cont(" %s", opt);
-			setup_clear_cpu_cap(bit);
+			if (set)
+				setup_force_cpu_cap(bit);
+			else
+				setup_clear_cpu_cap(bit);
 			taint++;
 			found = true;
 			break;
@@ -1579,9 +1585,12 @@ static void __init cpu_parse_early_param(void)
 		setup_clear_cpu_cap(X86_FEATURE_FRED);
 
 	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
-	if (arglen <= 0)
-		return;
-	parse_clearcpuid(arg);
+	if (arglen > 0)
+		parse_set_clear_cpuid(arg, false);
+
+	arglen = cmdline_find_option(boot_command_line, "setcpuid", arg, sizeof(arg));
+	if (arglen > 0)
+		parse_set_clear_cpuid(arg, true);
 }
 
 /*
@@ -2013,15 +2022,23 @@ void print_cpu_info(struct cpuinfo_x86 *c)
 }
 
 /*
- * clearcpuid= was already parsed in cpu_parse_early_param().  This dummy
- * function prevents it from becoming an environment variable for init.
+ * clearcpuid= and setcpuid= were already parsed in cpu_parse_early_param().
+ * These dummy functions prevent them from becoming an environment variable for
+ * init.
  */
+
 static __init int setup_clearcpuid(char *arg)
 {
 	return 1;
 }
 __setup("clearcpuid=", setup_clearcpuid);
 
+static __init int setup_setcpuid(char *arg)
+{
+	return 1;
+}
+__setup("setcpuid=", setup_setcpuid);
+
 DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
 	.current_task	= &init_task,
 	.preempt_count	= INIT_PREEMPT_COUNT,

