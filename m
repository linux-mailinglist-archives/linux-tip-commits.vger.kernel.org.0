Return-Path: <linux-tip-commits+bounces-3855-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19852A4D65B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CAF1745A6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 08:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BD41FE47E;
	Tue,  4 Mar 2025 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qa5q5YpR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mh4uHjsf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B1D1FDA62;
	Tue,  4 Mar 2025 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076877; cv=none; b=C9MO3eEPI1/vnRlJam0NNVMsrLdFvrlFZq2aiiQYl+8FMQ2yzinBITx3mowyKSEmL4SiWwaN2a/QB/U/zg0ueajPRqYA8CdWWvIjFAonquvkO0ALZnQ2WDXq/aWJT3weiL0Sh5yHANyIIpq2z3wDPH58pRIuqXxjRNqh7S///Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076877; c=relaxed/simple;
	bh=s32lUDvRylsejrEGcSnM90fxJmK9sD/vuuS8OdwJWaU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PaTewxqfgD5PAgatun1j/c20HexQCEBvG5IwNy9CcCPDIvYFjiwRCaC8Dd4O7Xx0lF/KL8XRT0oRSKd3aW/POQHvPYHNwgc+hUptEyQS9Sm+u3jIxpehYijmE664pWCnNrZlFd+57tbr2Ja8l2uZF9B8A8gwonDEL6HzTsU8NaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qa5q5YpR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mh4uHjsf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:27:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741076873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXa33ziB1f2bkwpLKUCByXk9J9vda/j3nHgSkEvOTbU=;
	b=Qa5q5YpRVAhrvWZfkDZT0uE8HpUyLkAbNNjbs4Toa5L+BL1TqKLjd0qidkuSLZaZGPgKOB
	EpOXBxFLVTcsUIpQUXzq7b1ntFg6iHzevvWNRmSuRvxnGb6h5EEJ/7nSYUdL0LcMb9FidX
	mlwaknXiMoIRJvxWwO4C0DiStwG+EV9BCsWR2ObbMPABdURPyUq41R3asb01t40X/H0bfR
	OYFvf8O/649ZH6efn69gcV0dZsuefsrnY9m5x7fpOZD1bS+9D4aD1OUgpFGAHiyU7zOyAI
	bfejoLTCF2J3zOvuXUXQ7Y37jiqiopHJomUdcWQb25lwFm1sytkHf0X+sUudaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741076873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXa33ziB1f2bkwpLKUCByXk9J9vda/j3nHgSkEvOTbU=;
	b=Mh4uHjsfFZcRN33FT+npNBaxcpO9Zuh4zRqLrorfgrt8pEgpH+E+27hTjJPWzEd6lDfh/D
	j6MCLntgYslvIIAA==
From: "tip-bot2 for Brendan Jackman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove unnecessary macro indirection related
 to CPU feature names
Cc: Brendan Jackman <jackmanb@google.com>, Ingo Molnar <mingo@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303-setcpuid-taint-louder-v1-1-8d255032cb4c@google.com>
References: <20250303-setcpuid-taint-louder-v1-1-8d255032cb4c@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107687318.14745.1316308236327638700.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     2f0f6cdf9bc1d104c8c224df8dd65748de02118d
Gitweb:        https://git.kernel.org/tip/2f0f6cdf9bc1d104c8c224df8dd65748de02118d
Author:        Brendan Jackman <jackmanb@google.com>
AuthorDate:    Mon, 03 Mar 2025 15:45:37 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 21:23:39 +01:00

x86/cpu: Remove unnecessary macro indirection related to CPU feature names

These macros used to abstract over CONFIG_X86_FEATURE_NAMES, but that
was removed in:

  7583e8fbdc49 ("x86/cpu: Remove X86_FEATURE_NAMES")

Now they are just an unnecessary indirection, remove them.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250303-setcpuid-taint-louder-v1-1-8d255032cb4c@google.com
---
 arch/x86/include/asm/cpufeature.h |  5 -----
 arch/x86/kernel/cpu/common.c      | 12 ++++++------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index de88f9b..7937823 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -38,13 +38,8 @@ enum cpuid_leafs
 	NR_CPUID_WORDS,
 };
 
-#define X86_CAP_FMT_NUM "%d:%d"
-#define x86_cap_flag_num(flag) ((flag) >> 5), ((flag) & 31)
-
 extern const char * const x86_cap_flags[NCAPINTS*32];
 extern const char * const x86_power_flags[32];
-#define X86_CAP_FMT "%s"
-#define x86_cap_flag(flag) x86_cap_flags[flag]
 
 /*
  * In order to save room, we index into this array by doing
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0f32b6f..b5fdaa6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -667,8 +667,8 @@ static void filter_cpuid_features(struct cpuinfo_x86 *c, bool warn)
 		if (!warn)
 			continue;
 
-		pr_warn("CPU: CPU feature " X86_CAP_FMT " disabled, no CPUID level 0x%x\n",
-			x86_cap_flag(df->feature), df->level);
+		pr_warn("CPU: CPU feature %s disabled, no CPUID level 0x%x\n",
+			x86_cap_flags[df->feature], df->level);
 	}
 }
 
@@ -1502,9 +1502,9 @@ static inline void parse_set_clear_cpuid(char *arg, bool set)
 
 				/* empty-string, i.e., ""-defined feature flags */
 				if (!x86_cap_flags[bit])
-					pr_cont(" " X86_CAP_FMT_NUM, x86_cap_flag_num(bit));
+					pr_cont(" %d:%d", bit >> 5, bit & 31);
 				else
-					pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+					pr_cont(" %s", x86_cap_flags[bit]);
 
 				if (set)
 					setup_force_cpu_cap(bit);
@@ -1523,9 +1523,9 @@ static inline void parse_set_clear_cpuid(char *arg, bool set)
 			const char *flag;
 
 			if (bit < 32 * NCAPINTS)
-				flag = x86_cap_flag(bit);
+				flag = x86_cap_flags[bit];
 			else
-				flag = x86_bug_flag(bit - (32 * NCAPINTS));
+				flag = x86_bug_flags[bit - (32 * NCAPINTS)];
 
 			if (!flag)
 				continue;

