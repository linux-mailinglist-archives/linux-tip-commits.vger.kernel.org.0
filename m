Return-Path: <linux-tip-commits+bounces-3733-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA39BA49709
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 11:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F063AA5B9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98874261569;
	Fri, 28 Feb 2025 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OjsV7RAw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4DscmT8l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3F25E444;
	Fri, 28 Feb 2025 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737938; cv=none; b=N2hE+bFAZH4pUiz+OkytIn/4YiWLO09wBuzRv3bq7dDbrrOlXog8fvZBvGcTF+CggnXS2aF8csdkHd2MyN7LZONGM1iiwaFhyBuEjsr8yksoTuwGDDmuhLAGDjDJaKtWXKc2CzaUdwqoZLZjASi/eZIBwtLbHSWZ82BOFg+itPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737938; c=relaxed/simple;
	bh=bUqwURlMDqP4+mpjSwPYYRUMNT3uIuLyjH6OOZCuoGY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=El2E/qWFkEuqovae9vY1e2yX40mZvb7RSbglA2oqw6jOqcpxnHpw4PJdTLyXS2XHEepZtAtpP9mT9dU8GWPQURvrOETtbVIqdb38EhKRlNm3O1I6UNwlhRBwN0rUp4Tu+ucbBI2vAI3vg4zHhh1m8TL9TITsaO9ksTE89ync9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OjsV7RAw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4DscmT8l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Feb 2025 10:18:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740737935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iuV5QnrElaaxhr8AuMgXa+PQYP2OIkfrssPPL58J22w=;
	b=OjsV7RAwAFIX0/Cx2P3+7HEIMwhBtUJayB5MGnUa+BQSaytLB7KXxEVQy4XddgEYw4W4O6
	UdzRN0C1HBfPJqX2l68RcDmx5sadB4Z26yNRyfnSzVgkx6wjq6P1LCKT61XUd5MAla2Ut9
	rB8CRylOLVGrH+YYRQJBxXr4ZfwMDc5WFXpnHgZ8Xy8AhfXlFG84bSJMlDCiKsVIdyh7uf
	GJvBUM2bTwaTWOijLonrChHu6Au3YMShmYCyeFVTTBcZ2LyFgiOK3r9nJ6KgvWQVlzW91T
	5Yjc/Yi4F5tyamnnHKVLCfJF+2iNIjOvBJR6VWSiXzstv/86wqD2SSi2vNZVPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740737935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iuV5QnrElaaxhr8AuMgXa+PQYP2OIkfrssPPL58J22w=;
	b=4DscmT8ls9w+1dlzXek+IphEK6ow4cx8/iE8tKXRvhZhukGDXdbI9gwAY3ks3DgWDZyzEe
	Bxj9ilKgXUMtOfBg==
From: "tip-bot2 for Brendan Jackman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Create helper function to parse the
 'clearcpuid=' boot parameter
Cc: Brendan Jackman <jackmanb@google.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241220-force-cpu-bug-v2-1-7dc71bce742a@google.com>
References: <20241220-force-cpu-bug-v2-1-7dc71bce742a@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174073793391.10177.13481068038175777623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f034937f5af32188cd1c07865c885b2f171e17bf
Gitweb:        https://git.kernel.org/tip/f034937f5af32188cd1c07865c885b2f171e17bf
Author:        Brendan Jackman <jackmanb@google.com>
AuthorDate:    Fri, 20 Dec 2024 15:18:31 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 28 Feb 2025 10:57:49 +01:00

x86/cpu: Create helper function to parse the 'clearcpuid=' boot parameter

This is in preparation for a later commit that will reuse this code, to
make review convenient.

Factor out a helper function which does the full handling for this arg
including printing info to the console.

No functional change intended.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241220-force-cpu-bug-v2-1-7dc71bce742a@google.com
---
 arch/x86/kernel/cpu/common.c | 96 ++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 76598a9..137d3e0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1479,56 +1479,18 @@ static void detect_nopl(void)
 #endif
 }
 
-/*
- * We parse cpu parameters early because fpu__init_system() is executed
- * before parse_early_param().
- */
-static void __init cpu_parse_early_param(void)
+static inline void parse_clearcpuid(char *arg)
 {
-	char arg[128];
-	char *argptr = arg, *opt;
-	int arglen, taint = 0;
-
-#ifdef CONFIG_X86_32
-	if (cmdline_find_option_bool(boot_command_line, "no387"))
-#ifdef CONFIG_MATH_EMULATION
-		setup_clear_cpu_cap(X86_FEATURE_FPU);
-#else
-		pr_err("Option 'no387' required CONFIG_MATH_EMULATION enabled.\n");
-#endif
-
-	if (cmdline_find_option_bool(boot_command_line, "nofxsr"))
-		setup_clear_cpu_cap(X86_FEATURE_FXSR);
-#endif
-
-	if (cmdline_find_option_bool(boot_command_line, "noxsave"))
-		setup_clear_cpu_cap(X86_FEATURE_XSAVE);
-
-	if (cmdline_find_option_bool(boot_command_line, "noxsaveopt"))
-		setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
-
-	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
-		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
-
-	if (cmdline_find_option_bool(boot_command_line, "nousershstk"))
-		setup_clear_cpu_cap(X86_FEATURE_USER_SHSTK);
-
-	/* Minimize the gap between FRED is available and available but disabled. */
-	arglen = cmdline_find_option(boot_command_line, "fred", arg, sizeof(arg));
-	if (arglen != 2 || strncmp(arg, "on", 2))
-		setup_clear_cpu_cap(X86_FEATURE_FRED);
-
-	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
-	if (arglen <= 0)
-		return;
+	char *opt;
+	int taint = 0;
 
 	pr_info("Clearing CPUID bits:");
 
-	while (argptr) {
+	while (arg) {
 		bool found __maybe_unused = false;
 		unsigned int bit;
 
-		opt = strsep(&argptr, ",");
+		opt = strsep(&arg, ",");
 
 		/*
 		 * Handle naked numbers first for feature flags which don't
@@ -1570,10 +1532,56 @@ static void __init cpu_parse_early_param(void)
 		if (!found)
 			pr_cont(" (unknown: %s)", opt);
 	}
-	pr_cont("\n");
 
 	if (taint)
 		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+
+	pr_cont("\n");
+}
+
+
+/*
+ * We parse cpu parameters early because fpu__init_system() is executed
+ * before parse_early_param().
+ */
+static void __init cpu_parse_early_param(void)
+{
+	char arg[128];
+	int arglen;
+
+#ifdef CONFIG_X86_32
+	if (cmdline_find_option_bool(boot_command_line, "no387"))
+#ifdef CONFIG_MATH_EMULATION
+		setup_clear_cpu_cap(X86_FEATURE_FPU);
+#else
+		pr_err("Option 'no387' required CONFIG_MATH_EMULATION enabled.\n");
+#endif
+
+	if (cmdline_find_option_bool(boot_command_line, "nofxsr"))
+		setup_clear_cpu_cap(X86_FEATURE_FXSR);
+#endif
+
+	if (cmdline_find_option_bool(boot_command_line, "noxsave"))
+		setup_clear_cpu_cap(X86_FEATURE_XSAVE);
+
+	if (cmdline_find_option_bool(boot_command_line, "noxsaveopt"))
+		setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
+
+	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
+		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
+
+	if (cmdline_find_option_bool(boot_command_line, "nousershstk"))
+		setup_clear_cpu_cap(X86_FEATURE_USER_SHSTK);
+
+	/* Minimize the gap between FRED is available and available but disabled. */
+	arglen = cmdline_find_option(boot_command_line, "fred", arg, sizeof(arg));
+	if (arglen != 2 || strncmp(arg, "on", 2))
+		setup_clear_cpu_cap(X86_FEATURE_FRED);
+
+	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
+	if (arglen <= 0)
+		return;
+	parse_clearcpuid(arg);
 }
 
 /*

