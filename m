Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C883131BF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Feb 2021 13:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhBHMEh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Feb 2021 07:04:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36318 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbhBHMBX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Feb 2021 07:01:23 -0500
Date:   Mon, 08 Feb 2021 12:00:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612785640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jelAkqf1bV3AA3Cz8t+pMxrgOl7UDaZXIJ5uL1lnizc=;
        b=EKm2JnrGNPWkWpqJyFZcQroOG4cRslgt9pyPPTfgLn20O5yuzhYWN8wRwEroYvTfDtohE9
        mSOpfo0dM/qEzjm0Qv2cSfiG1Pt2xehCnOb3Vh/oRPX6FtSwFyAuoRwWqXyfBimZpJDO/6
        Ij74vccl9LlFySNLY/o2rEzLhCGwCMJK3M/pPkddTCZMlkJfhHG5BhG1qMFHZL8LB18F2Q
        UZX1+LBWq9azKMjoiOIrYm9cHyWPJgsRJX83su4BuXLhsdAtJan7wCAiTv0007txGjNGOl
        5Z//306h1QBxTn8dpX3ZBT3XR03ZYHQiySiQiwwqR0CdPON9xchSkN3C/h8aPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612785640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jelAkqf1bV3AA3Cz8t+pMxrgOl7UDaZXIJ5uL1lnizc=;
        b=N3IEpqEINbE4Yd87X4S+mwGu/YBwYcPvV6Esq3A3qfzEZ0O8WhgSsT9jex3NphvCZe70ww
        OpOxWAYIoNTTB1DA==
From:   "tip-bot2 for Michal Hocko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] preempt: Introduce CONFIG_PREEMPT_DYNAMIC
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Michal Hocko <mhocko@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210118141223.123667-5-frederic@kernel.org>
References: <20210118141223.123667-5-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <161278563996.23325.11147110316009301248.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5759bcdb871f7f73b033643cd27d6cec33280540
Gitweb:        https://git.kernel.org/tip/5759bcdb871f7f73b033643cd27d6cec33280540
Author:        Michal Hocko <mhocko@kernel.org>
AuthorDate:    Mon, 18 Jan 2021 15:12:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 05 Feb 2021 17:19:56 +01:00

preempt: Introduce CONFIG_PREEMPT_DYNAMIC

Preemption mode selection is currently hardcoded on Kconfig choices.
Introduce a dedicated option to tune preemption flavour at boot time,

This will be only available on architectures efficiently supporting
static calls in order not to tempt with the feature against additional
overhead that might be prohibitive or undesirable.

CONFIG_PREEMPT_DYNAMIC is automatically selected by CONFIG_PREEMPT if
the architecture provides the necessary support (CONFIG_STATIC_CALL_INLINE,
CONFIG_GENERIC_ENTRY, and provide with __preempt_schedule_function() /
__preempt_schedule_notrace_function()).

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
[peterz: relax requirement to HAVE_STATIC_CALL]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210118141223.123667-5-frederic@kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |  7 ++++++-
 arch/Kconfig                                    |  9 ++++++++-
 arch/x86/Kconfig                                |  1 +-
 kernel/Kconfig.preempt                          | 19 ++++++++++++++++-
 4 files changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c722ec1..e854863 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3916,6 +3916,13 @@
 			Format: {"off"}
 			Disable Hardware Transactional Memory
 
+	preempt=	[KNL]
+			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
+			none - Limited to cond_resched() calls
+			voluntary - Limited to cond_resched() and might_sleep() calls
+			full - Any section that isn't explicitly preempt disabled
+			       can be preempted anytime.
+
 	print-fatal-signals=
 			[KNL] debug: print fatal signals
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 78c6f05..94d3dde 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1090,6 +1090,15 @@ config HAVE_STATIC_CALL_INLINE
 	bool
 	depends on HAVE_STATIC_CALL
 
+config HAVE_PREEMPT_DYNAMIC
+	bool
+	depends on HAVE_STATIC_CALL
+	depends on GENERIC_ENTRY
+	help
+	   Select this if the architecture support boot time preempt setting
+	   on top of static calls. It is strongly advised to support inline
+	   static call to avoid any overhead.
+
 config ARCH_WANT_LD_ORPHAN_WARN
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7b6dd10..d021da9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -223,6 +223,7 @@ config X86
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_STATIC_CALL
 	select HAVE_STATIC_CALL_INLINE		if HAVE_STACK_VALIDATION
+	select HAVE_PREEMPT_DYNAMIC
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bf82259..4160173 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -40,6 +40,7 @@ config PREEMPT
 	depends on !ARCH_NO_PREEMPT
 	select PREEMPTION
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
+	select PREEMPT_DYNAMIC if HAVE_PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -80,3 +81,21 @@ config PREEMPT_COUNT
 config PREEMPTION
        bool
        select PREEMPT_COUNT
+
+config PREEMPT_DYNAMIC
+	bool
+	help
+	  This option allows to define the preemption model on the kernel
+	  command line parameter and thus override the default preemption
+	  model defined during compile time.
+
+	  The feature is primarily interesting for Linux distributions which
+	  provide a pre-built kernel binary to reduce the number of kernel
+	  flavors they offer while still offering different usecases.
+
+	  The runtime overhead is negligible with HAVE_STATIC_CALL_INLINE enabled
+	  but if runtime patching is not available for the specific architecture
+	  then the potential overhead should be considered.
+
+	  Interesting if you want the same pre-built kernel should be used for
+	  both Server and Desktop workloads.
