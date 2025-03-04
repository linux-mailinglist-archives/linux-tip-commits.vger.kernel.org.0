Return-Path: <linux-tip-commits+bounces-3854-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72891A4D65C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F386188EF3B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 08:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9EA1FBEB9;
	Tue,  4 Mar 2025 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PYaWeYzm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iht9gTNo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C7C1F9A86;
	Tue,  4 Mar 2025 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076876; cv=none; b=VdAMTKi9ZQ02oT4cjuL8AUUyRv01ueXgdhlZ/XPWIKU4xmIh8YtaMWgsMa2dDfhw76BjW1XyNE/eaTpqN+caqabtk/uBaAsiR2EmWD41gQN9XW6oKqi4I044NoHCTROn+O7PCiXLNVpqpCQN8pxqgUuWO+1hX84b+uxZnoD3c3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076876; c=relaxed/simple;
	bh=q0cuqQyo9SIY0VTMYHyWO+Hig1X50Bra29ZVSx6hMeI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QRdi3xiQLHrjy4EPSAZVenNbs95kdiG0+GAlnaBVIiKGGbmcdyYmVrD0MrVFVL7TXH7gWMeZKdqPvKtdcSSSDxwuNwmHJ7krx5HRuiRoXSqbiEeidvoP45gGLd5etEnAeLQjlrr48xftoFiUwG4Bu0kZfnlXExYoMhaU9UGpIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PYaWeYzm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iht9gTNo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:27:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741076872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCCts8Hr/FIb98+k5QZ3ed44sI4LTdycaXJLNXaMjVk=;
	b=PYaWeYzmIzWwAG8OKRp31YlZ3DrAq0LDPdyQK3Ee1ADTsMFsDEE58SgRuwsZ9WT2YrxSyW
	9LGU/0cENikz+xsGybmstkGUl2bSK4sAIwb793E3qEGulahotp2DwpYJOq/iMBPAu/XYQG
	hCXr2TQ9Nn4e4XU4ANAmzTqLjIFHXF+9RZUbC9uy2wD5ESEyCnD4gULDo758qbPQAtzuOA
	DcVh5QsHwVSWa5cb64kTUk1O4O/TsD8xVi8EABoD+oojHYcOnqxIk9m8Bmakpp5vTMj6vY
	hBQ5UXQIKtSNn/F4j6fc9AmmAkPO3uqm5AbZbfwR1AgkANLd85CI/xQJfv+nbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741076872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCCts8Hr/FIb98+k5QZ3ed44sI4LTdycaXJLNXaMjVk=;
	b=iht9gTNoPXxUXw43AWdSQa9c6VbBCB8D4xTkeCWexBsasUP0S+Pn5LPY6J0IZ7yxGWfkgF
	nP0ahfU5f1OoNlCQ==
From: "tip-bot2 for Brendan Jackman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Log CPU flag cmdline hacks more verbosely
Cc: Peter Zijlstra <peterz@infradead.org>,
 Brendan Jackman <jackmanb@google.com>, Ingo Molnar <mingo@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303-setcpuid-taint-louder-v1-3-8d255032cb4c@google.com>
References: <20250303-setcpuid-taint-louder-v1-3-8d255032cb4c@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107687222.14745.13846566171595394892.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     75ab6506acbc494a838dc8bc5fbbde7092f71b33
Gitweb:        https://git.kernel.org/tip/75ab6506acbc494a838dc8bc5fbbde7092f71b33
Author:        Brendan Jackman <jackmanb@google.com>
AuthorDate:    Mon, 03 Mar 2025 15:45:39 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 21:23:39 +01:00

x86/cpu: Log CPU flag cmdline hacks more verbosely

Since using these options is very dangerous, make details as visible as
possible:

- Instead of a single message for each of the cmdline options, print a
  separate pr_warn() for each individual flag.

- Say explicitly whether the flag is a "feature" or a "bug".

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250303-setcpuid-taint-louder-v1-3-8d255032cb4c@google.com
---
 arch/x86/kernel/cpu/common.c | 39 ++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c1ced31..8eba9ca 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1484,8 +1484,6 @@ static inline bool parse_set_clear_cpuid(char *arg, bool set)
 	char *opt;
 	int taint = 0;
 
-	pr_warn("%s CPUID bits:", set ? "Force-enabling" : "Clearing");
-
 	while (arg) {
 		bool found __maybe_unused = false;
 		unsigned int bit;
@@ -1500,16 +1498,19 @@ static inline bool parse_set_clear_cpuid(char *arg, bool set)
 		if (!kstrtouint(opt, 10, &bit)) {
 			if (bit < NCAPINTS * 32) {
 
+				if (set) {
+					pr_warn("setcpuid: force-enabling CPU feature flag:");
+					setup_force_cpu_cap(bit);
+				} else {
+					pr_warn("clearcpuid: force-disabling CPU feature flag:");
+					setup_clear_cpu_cap(bit);
+				}
 				/* empty-string, i.e., ""-defined feature flags */
 				if (!x86_cap_flags[bit])
-					pr_cont(" %d:%d", bit >> 5, bit & 31);
+					pr_cont(" %d:%d\n", bit >> 5, bit & 31);
 				else
-					pr_cont(" %s", x86_cap_flags[bit]);
+					pr_cont(" %s\n", x86_cap_flags[bit]);
 
-				if (set)
-					setup_force_cpu_cap(bit);
-				else
-					setup_clear_cpu_cap(bit);
 				taint++;
 			}
 			/*
@@ -1521,11 +1522,15 @@ static inline bool parse_set_clear_cpuid(char *arg, bool set)
 
 		for (bit = 0; bit < 32 * (NCAPINTS + NBUGINTS); bit++) {
 			const char *flag;
+			const char *kind;
 
-			if (bit < 32 * NCAPINTS)
+			if (bit < 32 * NCAPINTS) {
 				flag = x86_cap_flags[bit];
-			else
+				kind = "feature";
+			} else {
+				kind = "bug";
 				flag = x86_bug_flags[bit - (32 * NCAPINTS)];
+			}
 
 			if (!flag)
 				continue;
@@ -1533,22 +1538,24 @@ static inline bool parse_set_clear_cpuid(char *arg, bool set)
 			if (strcmp(flag, opt))
 				continue;
 
-			pr_cont(" %s", opt);
-			if (set)
+			if (set) {
+				pr_warn("setcpuid: force-enabling CPU %s flag: %s\n",
+					kind, flag);
 				setup_force_cpu_cap(bit);
-			else
+			} else {
+				pr_warn("clearcpuid: force-disabling CPU %s flag: %s\n",
+					kind, flag);
 				setup_clear_cpu_cap(bit);
+			}
 			taint++;
 			found = true;
 			break;
 		}
 
 		if (!found)
-			pr_cont(" (unknown: %s)", opt);
+			pr_warn("%s: unknown CPU flag: %s", set ? "setcpuid" : "clearcpuid", opt);
 	}
 
-	pr_cont("\n");
-
 	return taint;
 }
 

