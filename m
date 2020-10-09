Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602ED288246
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbgJIGf6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55748 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732105AbgJIGfu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:50 -0400
Date:   Fri, 09 Oct 2020 06:35:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DimqHnIvb5MmJ0JVNjOGvT+nPykSXf2+BDOZarmElyE=;
        b=rrboBbczeiazReluupF0Rk9QrFTQm3lG20xdmi1GTN/LCKRGZ0cYbuifWppINmZxGABjdW
        ODR4F7G2+elzqgm4KdWKeBpg0WGTEL99UPujQbjpqxPRfVM4yxa46cBImjc/28TvKpdfpP
        wW7KtVdhIC7nTCqM4i1nPV/HXS7tlCpYn6TwTOzsY4r1shkIebFHy/2FFffUurRRL4xOla
        ZRw11l7mzSdb8oLDU32fyWuJnIYFr1C5TFA7TY4f966bS1m2aGv/8Czs31isUZ/mfTaW7m
        ijEsqwU+ZCSrkjTQQrnKoOvcVuW7AUpxLxQM8+9xbuJPX9Xou7FgcYw2W3IOWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DimqHnIvb5MmJ0JVNjOGvT+nPykSXf2+BDOZarmElyE=;
        b=QOYmADnCsoSsUmGHyJtcV9HxqoNG4JarETVD+hz8QPEgPpwjnkg83PH+xBZlEdxEdJqCkv
        dCdXPq6CaoIgYpDg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] lib: Add backtrace_idle parameter to force backtrace
 of idle CPUs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-doc@vger.kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222534715.7002.9036613961207183639.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     160c7ba34605d9b59ee406a1b4a61b0f942b1ae9
Gitweb:        https://git.kernel.org/tip/160c7ba34605d9b59ee406a1b4a61b0f942b1ae9
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 08 Jul 2020 16:25:43 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 14:24:25 -07:00

lib: Add backtrace_idle parameter to force backtrace of idle CPUs

Currently, the nmi_cpu_backtrace() declines to produce backtraces for
idle CPUs.  This is a good choice in the common case in which problems are
caused only by non-idle CPUs.  However, there are occasionally situations
in which idle CPUs are helping to cause problems.  This commit therefore
adds an nmi_backtrace.backtrace_idle kernel boot parameter that causes
nmi_cpu_backtrace() to dump stacks even of idle CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <linux-doc@vger.kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 lib/nmi_backtrace.c                             | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdc1f33..5e6d191 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3073,6 +3073,10 @@
 			and gids from such clients.  This is intended to ease
 			migration from NFSv2/v3.
 
+	nmi_backtrace.backtrace_idle [KNL]
+			Dump stacks even of idle CPUs in response to an
+			NMI stack-backtrace request.
+
 	nmi_debug=	[KNL,SH] Specify one or more actions to take
 			when a NMI is triggered.
 			Format: [state][,regs][,debounce][,die]
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 15ca78e..8abe187 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -85,12 +85,16 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 	put_cpu();
 }
 
+// Dump stacks even for idle CPUs.
+static bool backtrace_idle;
+module_param(backtrace_idle, bool, 0644);
+
 bool nmi_cpu_backtrace(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
 
 	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
-		if (regs && cpu_in_idle(instruction_pointer(regs))) {
+		if (!READ_ONCE(backtrace_idle) && regs && cpu_in_idle(instruction_pointer(regs))) {
 			pr_warn("NMI backtrace for cpu %d skipped: idling at %pS\n",
 				cpu, (void *)instruction_pointer(regs));
 		} else {
