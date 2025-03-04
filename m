Return-Path: <linux-tip-commits+bounces-3856-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78670A4D661
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CC21898874
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 08:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51B91FECB4;
	Tue,  4 Mar 2025 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HEqMS7Ms";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7VcAwdDz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215341FDE2B;
	Tue,  4 Mar 2025 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076877; cv=none; b=BWjTV4baT7ZStPKIZsns8jm+buNI1cutODob5YVRJXghf0I/L1tGcX2F5xYdj/J2r7IlKmapiihVOOsool4SkTuZE8cuD6v1G1MOH8y/7qgGWGumCeo2ft1jDN9LK4mKlOpvZTeeqKeHzuMrzNMa5lxyCzkIaMnmzIAACgm55fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076877; c=relaxed/simple;
	bh=UXK34iZcqNzOHgTgkxnA9XSM43n+N2SNFGr56lakNzM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UZk7/3qGD+VhTKtP0S1iF4zuD3Py6rVKfQp3ptqbar4T8Hbuo9Sa9M7B0F7BoQiW6CDXRqedIWOlMLvRSQfTDUD1Y1oFIVIpI4yfDzLr/EJWkWvzZ6A5zz8i9iW3+tb634mRdSYOBKvJS49QC0GKM0rmDvW46XxbcoCQUk8ANiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HEqMS7Ms; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7VcAwdDz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:27:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741076873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dMGDQZu5FA95BFqikIlJ7YWTqVrXpl8bK0mGP7UazmU=;
	b=HEqMS7MsLNxIizOvRKD8ZoPQUPM9Yf0OoZRPjFNgIpB9gxTuqBg8UPbhRyVPEq4rVTcBc4
	cCM8YnatJYNorBDvqFrbSY9N7Jej0RZX2W7IKUBDjts5KqJdbj+M//Qq4FBOI2SvqCM0YI
	D1SmE7NnloVAyBD5lntfoCy1j0vyso8SKiayqShNbEglY8OPmZrP3bHj+zODGWox6E/eYC
	iBWjC+gnqB62tWNvlf2GDRseVApEW6Cy84OuwENP3eelnlUQjyX2th2Bm494qtqjrFxpFL
	CDtdVDDiMrSDeIaDLE0nMU4PJo6kcGLzoRBo6m8+AG3dSwHV8Y+HqmsPZ4CJyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741076873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dMGDQZu5FA95BFqikIlJ7YWTqVrXpl8bK0mGP7UazmU=;
	b=7VcAwdDz9JhxU83HNUIOdnM5Gcoj0cSeITaCX1Doel5lGuUPxuQePdYfYukriUfa0Zv+DF
	D/VSKKOVQoufJMCA==
From: "tip-bot2 for Brendan Jackman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Warn louder about the {set,clear}cpuid boot
 parameters
Cc: Ingo Molnar <mingo@redhat.com>, Brendan Jackman <jackmanb@google.com>,
 Ingo Molnar <mingo@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250303-setcpuid-taint-louder-v1-2-8d255032cb4c@google.com>
References: <20250303-setcpuid-taint-louder-v1-2-8d255032cb4c@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107687265.14745.5980705395851261771.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     cf4d8a642cb8556c3cb786278a6f7fa43bc3f5e9
Gitweb:        https://git.kernel.org/tip/cf4d8a642cb8556c3cb786278a6f7fa43bc3f5e9
Author:        Brendan Jackman <jackmanb@google.com>
AuthorDate:    Mon, 03 Mar 2025 15:45:38 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 21:23:39 +01:00

x86/cpu: Warn louder about the {set,clear}cpuid boot parameters

Commit 814165e9fd1f6 ("x86/cpu: Add the 'setcpuid=' boot parameter")
recently expanded the user's ability to break their system horribly by
overriding effective CPU flags. This was reflected with updates to the
documentation to try and make people aware that this is dangerous.

To further reduce the risk of users mistaking this for a "real feature",
and try to help them figure out why their kernel is tainted if they do
use it:

- Upgrade the existing printk to pr_warn, to help ensure kernel logs
  reflect what changes are in effect.

- Print an extra warning that tries to be as dramatic as possible, while
  also highlighting the fact that it tainted the kernel.

Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250303-setcpuid-taint-louder-v1-2-8d255032cb4c@google.com
---
 arch/x86/kernel/cpu/common.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b5fdaa6..c1ced31 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1479,12 +1479,12 @@ static void detect_nopl(void)
 #endif
 }
 
-static inline void parse_set_clear_cpuid(char *arg, bool set)
+static inline bool parse_set_clear_cpuid(char *arg, bool set)
 {
 	char *opt;
 	int taint = 0;
 
-	pr_info("%s CPUID bits:", set ? "Force-enabling" : "Clearing");
+	pr_warn("%s CPUID bits:", set ? "Force-enabling" : "Clearing");
 
 	while (arg) {
 		bool found __maybe_unused = false;
@@ -1547,10 +1547,9 @@ static inline void parse_set_clear_cpuid(char *arg, bool set)
 			pr_cont(" (unknown: %s)", opt);
 	}
 
-	if (taint)
-		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
-
 	pr_cont("\n");
+
+	return taint;
 }
 
 
@@ -1560,6 +1559,7 @@ static inline void parse_set_clear_cpuid(char *arg, bool set)
  */
 static void __init cpu_parse_early_param(void)
 {
+	bool cpuid_taint = false;
 	char arg[128];
 	int arglen;
 
@@ -1594,11 +1594,16 @@ static void __init cpu_parse_early_param(void)
 
 	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
 	if (arglen > 0)
-		parse_set_clear_cpuid(arg, false);
+		cpuid_taint |= parse_set_clear_cpuid(arg, false);
 
 	arglen = cmdline_find_option(boot_command_line, "setcpuid", arg, sizeof(arg));
 	if (arglen > 0)
-		parse_set_clear_cpuid(arg, true);
+		cpuid_taint |= parse_set_clear_cpuid(arg, true);
+
+	if (cpuid_taint) {
+		pr_warn("!!! setcpuid=/clearcpuid= in use, this is for TESTING ONLY, may break things horribly. Tainting kernel.\n");
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	}
 }
 
 /*

