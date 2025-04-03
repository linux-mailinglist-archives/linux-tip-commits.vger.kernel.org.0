Return-Path: <linux-tip-commits+bounces-4641-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED9A7A3C6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 15:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081571894B47
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6C124F5A6;
	Thu,  3 Apr 2025 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pT/2DlOa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c1JOupCV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA7E24E4D9;
	Thu,  3 Apr 2025 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687223; cv=none; b=cjRyvMSjbtWP3qkScTDaSACtiRgNBnrvo3qwrQYcIfvQXWYyKIDkL0egAO2TEZkLqQPy4K9nlSXHUxCVM2Qzs1nDJZI78CKQo/baue1gE47NEK3sNWRBwTqOH+lrfJp/eRd256wGPy3o3RxzOlVkEb1z6cDVJks7rXDeKwHQ0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687223; c=relaxed/simple;
	bh=tDAyg+0Jklw7u5bM0vDz3kfmvgUreHX0rCsaq1UxeSY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OGCM8f1NndKuXncnzx93KDL3zpb61Yd4LE0khZ2nHkArAIN+D+rgv3meVj7UDSBYessGEqopMAl9x13KDBxFfFz+Za+3GLTsFt8ZyaLj24klskTSU0TdHxCrHPQjJTlr8PV7W0+jnM6n8W6JkcJuug+9UO3W6fRKEWPKjD+y7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pT/2DlOa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c1JOupCV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 13:33:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743687219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vS4LkoKjTVENVaUnIeeFrJ5QMRyYGAeA6Wto5PusfAM=;
	b=pT/2DlOaneSwrMRGPlFcBtTj2hQBg91czo0GWe0WM/Q/V00fRF64bfrK7dzyovEsH1Tcm2
	y6QWLLJRhHqkZm6uT+vYctxj1f69lshfDgRNQi12LwTky4AZJr7Gi67hgoiiPgOwp2BnUa
	fV+eVQC5LtiDjQVYsy0F2fzQSvuBylf+64N2nK9QDiHZ5dArfcs8A++z8qYiDeNXjeB49M
	dpnJoOUHlXJDyJQf3JLspJwPLL+glBtTjQl1v+Iias+KdZ9xWar39JBXMZqfFHjit0ptq5
	9YhGRi/hHYtTQC/NXgB+kRzkTdz5T+NIArWlO0zHOOgPP+c/zL4somZAPmg8ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743687219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vS4LkoKjTVENVaUnIeeFrJ5QMRyYGAeA6Wto5PusfAM=;
	b=c1JOupCVkiANNw0H8YSJ6HaTo5oYCTV38h6QpMsI6QqTitWA52n+UyVhvowA3WNs9CJaEr
	66etj83t3gizXQAQ==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/nmi] x86/nmi: Clean up NMI selftest
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327234629.3953536-9-sohil.mehta@intel.com>
References: <20250327234629.3953536-9-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174368721869.30396.12634458298837081238.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/nmi branch of tip:

Commit-ID:     05279a2863ddba6ed993aad655b9f3e57d9a94ce
Gitweb:        https://git.kernel.org/tip/05279a2863ddba6ed993aad655b9f3e57d9a94ce
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Thu, 27 Mar 2025 23:46:28 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:26:32 +02:00

x86/nmi: Clean up NMI selftest

The expected_testcase_failures variable in the NMI selftest has never
been set since its introduction. Remove this unused variable along with
the related checks to simplify the code.

While at it, replace printk() with the corresponding pr_{cont,info}()
calls. Also, get rid of the superfluous testname wrapper and the
redundant file path comment.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20250327234629.3953536-9-sohil.mehta@intel.com
---
 arch/x86/kernel/nmi_selftest.c | 52 ++++++++++-----------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kernel/nmi_selftest.c b/arch/x86/kernel/nmi_selftest.c
index e93a854..a010e9d 100644
--- a/arch/x86/kernel/nmi_selftest.c
+++ b/arch/x86/kernel/nmi_selftest.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * arch/x86/kernel/nmi-selftest.c
- *
  * Testsuite for NMI: IPIs
  *
  * Started by Don Zickus:
@@ -30,7 +28,6 @@ static DECLARE_BITMAP(nmi_ipi_mask, NR_CPUS) __initdata;
 
 static int __initdata testcase_total;
 static int __initdata testcase_successes;
-static int __initdata expected_testcase_failures;
 static int __initdata unexpected_testcase_failures;
 static int __initdata unexpected_testcase_unknowns;
 
@@ -120,26 +117,22 @@ static void __init dotest(void (*testcase_fn)(void), int expected)
 		unexpected_testcase_failures++;
 
 		if (nmi_fail == FAILURE)
-			printk(KERN_CONT "FAILED |");
+			pr_cont("FAILED |");
 		else if (nmi_fail == TIMEOUT)
-			printk(KERN_CONT "TIMEOUT|");
+			pr_cont("TIMEOUT|");
 		else
-			printk(KERN_CONT "ERROR  |");
+			pr_cont("ERROR  |");
 		dump_stack();
 	} else {
 		testcase_successes++;
-		printk(KERN_CONT "  ok  |");
+		pr_cont("  ok  |");
 	}
-	testcase_total++;
+	pr_cont("\n");
 
+	testcase_total++;
 	reset_nmi();
 }
 
-static inline void __init print_testname(const char *testname)
-{
-	printk("%12s:", testname);
-}
-
 void __init nmi_selftest(void)
 {
 	init_nmi_testsuite();
@@ -147,38 +140,25 @@ void __init nmi_selftest(void)
         /*
 	 * Run the testsuite:
 	 */
-	printk("----------------\n");
-	printk("| NMI testsuite:\n");
-	printk("--------------------\n");
+	pr_info("----------------\n");
+	pr_info("| NMI testsuite:\n");
+	pr_info("--------------------\n");
 
-	print_testname("remote IPI");
+	pr_info("%12s:", "remote IPI");
 	dotest(remote_ipi, SUCCESS);
-	printk(KERN_CONT "\n");
-	print_testname("local IPI");
+
+	pr_info("%12s:", "local IPI");
 	dotest(local_ipi, SUCCESS);
-	printk(KERN_CONT "\n");
 
 	cleanup_nmi_testsuite();
 
+	pr_info("--------------------\n");
 	if (unexpected_testcase_failures) {
-		printk("--------------------\n");
-		printk("BUG: %3d unexpected failures (out of %3d) - debugging disabled! |\n",
+		pr_info("BUG: %3d unexpected failures (out of %3d) - debugging disabled! |\n",
 			unexpected_testcase_failures, testcase_total);
-		printk("-----------------------------------------------------------------\n");
-	} else if (expected_testcase_failures && testcase_successes) {
-		printk("--------------------\n");
-		printk("%3d out of %3d testcases failed, as expected. |\n",
-			expected_testcase_failures, testcase_total);
-		printk("----------------------------------------------------\n");
-	} else if (expected_testcase_failures && !testcase_successes) {
-		printk("--------------------\n");
-		printk("All %3d testcases failed, as expected. |\n",
-			expected_testcase_failures);
-		printk("----------------------------------------\n");
 	} else {
-		printk("--------------------\n");
-		printk("Good, all %3d testcases passed! |\n",
+		pr_info("Good, all %3d testcases passed! |\n",
 			testcase_successes);
-		printk("---------------------------------\n");
 	}
+	pr_info("-----------------------------------------------------------------\n");
 }

