Return-Path: <linux-tip-commits+bounces-5738-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A3AAC0843
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 May 2025 11:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515D23AA68C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 May 2025 09:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58973286434;
	Thu, 22 May 2025 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GwUFHr+m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2jKfI/30"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB3A14830F;
	Thu, 22 May 2025 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905118; cv=none; b=OTUv8OcDX3/ZzTX3Qu0FY5Kl//a2VMNE2hUNiRNd92fLzqMdKR8lJQVRpvZQmWLHE8XQZE4Wxda7O0JtWz3JhgedAxC4HyI60PaoITvSfeXzVRZD2PMwvbajE25UagvalKDMFZ6CEAhnBXG1ePa/df1gXz+/AA75pMgI4KIJLZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905118; c=relaxed/simple;
	bh=YzWOSWZEv71+8kKrq+Ly/djzAjVIgODMpQSmvAbYZ3U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=npbDMARh1iK8gbGbFod6WUBta/EMJKi3VrqRRhB5Cr96OXC+FS1lRAVJb7Su08ZgBS2mfo/uHUftjZ3fI0e+5/qq7VWo4r110c37LG+9nWTKFXnoEW84yJPqgng0CnVBO2F6OO27dWJgcCfbWBM6Fti23eNMk8bBmVWatzkeyZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GwUFHr+m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2jKfI/30; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 May 2025 09:11:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747905105;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b58oEBMNouSkoXeXvVR3oqJzwiTleyKrGoHOrDsnFxU=;
	b=GwUFHr+m4OS0s2KwfhLIBUn4qeUJgRM7T4RmtJ77yazsmhE9/A5nLHjAeytyK5yMyY9iNJ
	pRFbhxstk7gRqwqqblkV6ljbJ/wio2CsR2Wg0Khr2IaJSkKMWFtdRS+4zQl77FqpBfmTx+
	xKKySw5ZEwogPEVA2PGUw5CoBtu2WsABw+bAEaAmpWhXtGC87mQgzUdod+Dkx3MW1ru8j4
	S6+/lqUJoaQsT4DHfurAXGonQ2zAAwpmTTa3yaHdIjxjX2BbRiW0poUgHRPRRT7aasLwp1
	LXyj+ujeA/Bf6Nd5gU7qgcdXXsdLOCpPRqlJSSWQsNQYZHJNArK16NxJq3izvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747905105;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b58oEBMNouSkoXeXvVR3oqJzwiTleyKrGoHOrDsnFxU=;
	b=2jKfI/30Xxdc8ICuAy1YMaXmtWRyCH3dkUMGv8TJou4QPVFAGhduGjP4kePwgiiZnUx8sp
	BI9ibVKg2K/Q7gAw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/uapi: Clean up <uapi/linux/perf_event.h> a bit
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250521221529.2547099-1-irogers@google.com>
References: <20250521221529.2547099-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174790510412.406.12106522780238650635.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     44889ff67cee7b9ee2d305690ce7a5488b137a66
Gitweb:        https://git.kernel.org/tip/44889ff67cee7b9ee2d305690ce7a5488b137a66
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 22 May 2025 09:51:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 22 May 2025 11:03:41 +02:00

perf/uapi: Clean up <uapi/linux/perf_event.h> a bit

When applying a recent commit to the <uapi/linux/perf_event.h>
header I noticed that we have accumulated quite a bit of
historic noise in this header, so do a bit of spring cleaning:

 - Define bitfields in a vertically aligned fashion, like
   perf_event_mmap_page::capabilities already does. This
   makes it easier to see the distribution and sizing of
   bits within a word, at a glance. The following is much
   more readable:

			__u64	cap_bit0		: 1,
				cap_bit0_is_deprecated	: 1,
				cap_user_rdpmc		: 1,
				cap_user_time		: 1,
				cap_user_time_zero	: 1,
				cap_user_time_short	: 1,
				cap_____res		: 58;

   Than:

			__u64	cap_bit0:1,
				cap_bit0_is_deprecated:1,
				cap_user_rdpmc:1,
				cap_user_time:1,
				cap_user_time_zero:1,
				cap_user_time_short:1,
				cap_____res:58;

   So convert all bitfield definitions from the latter style to the
   former style.

 - Fix typos and grammar

 - Fix capitalization

 - Remove whitespace noise

 - Harmonize the definitions of various generations and groups of
   PERF_MEM_ ABI values.

 - Vertically align all definitions and assignments to the same
   column (48), as the first definition (enum perf_type_id),
   throughout the entire header.

 - And in general make the code and comments to be more in sync
   with each other and to be more readable overall.

No change in functionality.

Copy the changes over to tools/include/uapi/linux/perf_event.h.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20250521221529.2547099-1-irogers@google.com
---
 include/uapi/linux/perf_event.h       | 652 ++++++++++++-------------
 tools/include/uapi/linux/perf_event.h | 652 ++++++++++++-------------
 2 files changed, 662 insertions(+), 642 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b2722da..78a362b 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -39,18 +39,21 @@ enum perf_type_id {
 
 /*
  * attr.config layout for type PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
+ *
  * PERF_TYPE_HARDWARE:			0xEEEEEEEE000000AA
  *					AA: hardware event ID
  *					EEEEEEEE: PMU type ID
+ *
  * PERF_TYPE_HW_CACHE:			0xEEEEEEEE00DDCCBB
  *					BB: hardware cache ID
  *					CC: hardware cache op ID
  *					DD: hardware cache op result ID
  *					EEEEEEEE: PMU type ID
- * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
+ *
+ * If the PMU type ID is 0, PERF_TYPE_RAW will be applied.
  */
-#define PERF_PMU_TYPE_SHIFT		32
-#define PERF_HW_EVENT_MASK		0xffffffff
+#define PERF_PMU_TYPE_SHIFT			32
+#define PERF_HW_EVENT_MASK			0xffffffff
 
 /*
  * Generalized performance event event_id types, used by the
@@ -112,7 +115,7 @@ enum perf_hw_cache_op_result_id {
 /*
  * Special "software" events provided by the kernel, even if the hardware
  * does not support performance events. These events measure various
- * physical and sw events of the kernel (and allow the profiling of them as
+ * physical and SW events of the kernel (and allow the profiling of them as
  * well):
  */
 enum perf_sw_ids {
@@ -167,8 +170,9 @@ enum perf_event_sample_format {
 };
 
 #define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
+
 /*
- * values to program into branch_sample_type when PERF_SAMPLE_BRANCH is set
+ * Values to program into branch_sample_type when PERF_SAMPLE_BRANCH is set.
  *
  * If the user does not pass priv level information via branch_sample_type,
  * the kernel uses the event's priv level. Branch and event priv levels do
@@ -178,20 +182,20 @@ enum perf_event_sample_format {
  * of branches and therefore it supersedes all the other types.
  */
 enum perf_branch_sample_type_shift {
-	PERF_SAMPLE_BRANCH_USER_SHIFT		= 0, /* user branches */
-	PERF_SAMPLE_BRANCH_KERNEL_SHIFT		= 1, /* kernel branches */
-	PERF_SAMPLE_BRANCH_HV_SHIFT		= 2, /* hypervisor branches */
-
-	PERF_SAMPLE_BRANCH_ANY_SHIFT		= 3, /* any branch types */
-	PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT	= 4, /* any call branch */
-	PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT	= 5, /* any return branch */
-	PERF_SAMPLE_BRANCH_IND_CALL_SHIFT	= 6, /* indirect calls */
-	PERF_SAMPLE_BRANCH_ABORT_TX_SHIFT	= 7, /* transaction aborts */
-	PERF_SAMPLE_BRANCH_IN_TX_SHIFT		= 8, /* in transaction */
-	PERF_SAMPLE_BRANCH_NO_TX_SHIFT		= 9, /* not in transaction */
+	PERF_SAMPLE_BRANCH_USER_SHIFT		=  0, /* user branches */
+	PERF_SAMPLE_BRANCH_KERNEL_SHIFT		=  1, /* kernel branches */
+	PERF_SAMPLE_BRANCH_HV_SHIFT		=  2, /* hypervisor branches */
+
+	PERF_SAMPLE_BRANCH_ANY_SHIFT		=  3, /* any branch types */
+	PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT	=  4, /* any call branch */
+	PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT	=  5, /* any return branch */
+	PERF_SAMPLE_BRANCH_IND_CALL_SHIFT	=  6, /* indirect calls */
+	PERF_SAMPLE_BRANCH_ABORT_TX_SHIFT	=  7, /* transaction aborts */
+	PERF_SAMPLE_BRANCH_IN_TX_SHIFT		=  8, /* in transaction */
+	PERF_SAMPLE_BRANCH_NO_TX_SHIFT		=  9, /* not in transaction */
 	PERF_SAMPLE_BRANCH_COND_SHIFT		= 10, /* conditional branches */
 
-	PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT	= 11, /* call/ret stack */
+	PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT	= 11, /* CALL/RET stack */
 	PERF_SAMPLE_BRANCH_IND_JUMP_SHIFT	= 12, /* indirect jumps */
 	PERF_SAMPLE_BRANCH_CALL_SHIFT		= 13, /* direct call */
 
@@ -210,96 +214,95 @@ enum perf_branch_sample_type_shift {
 };
 
 enum perf_branch_sample_type {
-	PERF_SAMPLE_BRANCH_USER		= 1U << PERF_SAMPLE_BRANCH_USER_SHIFT,
-	PERF_SAMPLE_BRANCH_KERNEL	= 1U << PERF_SAMPLE_BRANCH_KERNEL_SHIFT,
-	PERF_SAMPLE_BRANCH_HV		= 1U << PERF_SAMPLE_BRANCH_HV_SHIFT,
+	PERF_SAMPLE_BRANCH_USER			= 1U << PERF_SAMPLE_BRANCH_USER_SHIFT,
+	PERF_SAMPLE_BRANCH_KERNEL		= 1U << PERF_SAMPLE_BRANCH_KERNEL_SHIFT,
+	PERF_SAMPLE_BRANCH_HV			= 1U << PERF_SAMPLE_BRANCH_HV_SHIFT,
 
-	PERF_SAMPLE_BRANCH_ANY		= 1U << PERF_SAMPLE_BRANCH_ANY_SHIFT,
-	PERF_SAMPLE_BRANCH_ANY_CALL	= 1U << PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT,
-	PERF_SAMPLE_BRANCH_ANY_RETURN	= 1U << PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT,
-	PERF_SAMPLE_BRANCH_IND_CALL	= 1U << PERF_SAMPLE_BRANCH_IND_CALL_SHIFT,
-	PERF_SAMPLE_BRANCH_ABORT_TX	= 1U << PERF_SAMPLE_BRANCH_ABORT_TX_SHIFT,
-	PERF_SAMPLE_BRANCH_IN_TX	= 1U << PERF_SAMPLE_BRANCH_IN_TX_SHIFT,
-	PERF_SAMPLE_BRANCH_NO_TX	= 1U << PERF_SAMPLE_BRANCH_NO_TX_SHIFT,
-	PERF_SAMPLE_BRANCH_COND		= 1U << PERF_SAMPLE_BRANCH_COND_SHIFT,
+	PERF_SAMPLE_BRANCH_ANY			= 1U << PERF_SAMPLE_BRANCH_ANY_SHIFT,
+	PERF_SAMPLE_BRANCH_ANY_CALL		= 1U << PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT,
+	PERF_SAMPLE_BRANCH_ANY_RETURN		= 1U << PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT,
+	PERF_SAMPLE_BRANCH_IND_CALL		= 1U << PERF_SAMPLE_BRANCH_IND_CALL_SHIFT,
+	PERF_SAMPLE_BRANCH_ABORT_TX		= 1U << PERF_SAMPLE_BRANCH_ABORT_TX_SHIFT,
+	PERF_SAMPLE_BRANCH_IN_TX		= 1U << PERF_SAMPLE_BRANCH_IN_TX_SHIFT,
+	PERF_SAMPLE_BRANCH_NO_TX		= 1U << PERF_SAMPLE_BRANCH_NO_TX_SHIFT,
+	PERF_SAMPLE_BRANCH_COND			= 1U << PERF_SAMPLE_BRANCH_COND_SHIFT,
 
-	PERF_SAMPLE_BRANCH_CALL_STACK	= 1U << PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT,
-	PERF_SAMPLE_BRANCH_IND_JUMP	= 1U << PERF_SAMPLE_BRANCH_IND_JUMP_SHIFT,
-	PERF_SAMPLE_BRANCH_CALL		= 1U << PERF_SAMPLE_BRANCH_CALL_SHIFT,
+	PERF_SAMPLE_BRANCH_CALL_STACK		= 1U << PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT,
+	PERF_SAMPLE_BRANCH_IND_JUMP		= 1U << PERF_SAMPLE_BRANCH_IND_JUMP_SHIFT,
+	PERF_SAMPLE_BRANCH_CALL			= 1U << PERF_SAMPLE_BRANCH_CALL_SHIFT,
 
-	PERF_SAMPLE_BRANCH_NO_FLAGS	= 1U << PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT,
-	PERF_SAMPLE_BRANCH_NO_CYCLES	= 1U << PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT,
+	PERF_SAMPLE_BRANCH_NO_FLAGS		= 1U << PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT,
+	PERF_SAMPLE_BRANCH_NO_CYCLES		= 1U << PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT,
 
-	PERF_SAMPLE_BRANCH_TYPE_SAVE	=
-		1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
+	PERF_SAMPLE_BRANCH_TYPE_SAVE		= 1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
 
-	PERF_SAMPLE_BRANCH_HW_INDEX	= 1U << PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT,
+	PERF_SAMPLE_BRANCH_HW_INDEX		= 1U << PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT,
 
-	PERF_SAMPLE_BRANCH_PRIV_SAVE	= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
+	PERF_SAMPLE_BRANCH_PRIV_SAVE		= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
 
-	PERF_SAMPLE_BRANCH_COUNTERS	= 1U << PERF_SAMPLE_BRANCH_COUNTERS_SHIFT,
+	PERF_SAMPLE_BRANCH_COUNTERS		= 1U << PERF_SAMPLE_BRANCH_COUNTERS_SHIFT,
 
-	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
+	PERF_SAMPLE_BRANCH_MAX			= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
 /*
- * Common flow change classification
+ * Common control flow change classifications:
  */
 enum {
-	PERF_BR_UNKNOWN		= 0,	/* unknown */
-	PERF_BR_COND		= 1,	/* conditional */
-	PERF_BR_UNCOND		= 2,	/* unconditional  */
-	PERF_BR_IND		= 3,	/* indirect */
-	PERF_BR_CALL		= 4,	/* function call */
-	PERF_BR_IND_CALL	= 5,	/* indirect function call */
-	PERF_BR_RET		= 6,	/* function return */
-	PERF_BR_SYSCALL		= 7,	/* syscall */
-	PERF_BR_SYSRET		= 8,	/* syscall return */
-	PERF_BR_COND_CALL	= 9,	/* conditional function call */
-	PERF_BR_COND_RET	= 10,	/* conditional function return */
-	PERF_BR_ERET		= 11,	/* exception return */
-	PERF_BR_IRQ		= 12,	/* irq */
-	PERF_BR_SERROR		= 13,	/* system error */
-	PERF_BR_NO_TX		= 14,	/* not in transaction */
-	PERF_BR_EXTEND_ABI	= 15,	/* extend ABI */
+	PERF_BR_UNKNOWN				=  0,	/* Unknown */
+	PERF_BR_COND				=  1,	/* Conditional */
+	PERF_BR_UNCOND				=  2,	/* Unconditional  */
+	PERF_BR_IND				=  3,	/* Indirect */
+	PERF_BR_CALL				=  4,	/* Function call */
+	PERF_BR_IND_CALL			=  5,	/* Indirect function call */
+	PERF_BR_RET				=  6,	/* Function return */
+	PERF_BR_SYSCALL				=  7,	/* Syscall */
+	PERF_BR_SYSRET				=  8,	/* Syscall return */
+	PERF_BR_COND_CALL			=  9,	/* Conditional function call */
+	PERF_BR_COND_RET			= 10,	/* Conditional function return */
+	PERF_BR_ERET				= 11,	/* Exception return */
+	PERF_BR_IRQ				= 12,	/* IRQ */
+	PERF_BR_SERROR				= 13,	/* System error */
+	PERF_BR_NO_TX				= 14,	/* Not in transaction */
+	PERF_BR_EXTEND_ABI			= 15,	/* Extend ABI */
 	PERF_BR_MAX,
 };
 
 /*
- * Common branch speculation outcome classification
+ * Common branch speculation outcome classifications:
  */
 enum {
-	PERF_BR_SPEC_NA			= 0,	/* Not available */
-	PERF_BR_SPEC_WRONG_PATH		= 1,	/* Speculative but on wrong path */
-	PERF_BR_NON_SPEC_CORRECT_PATH	= 2,	/* Non-speculative but on correct path */
-	PERF_BR_SPEC_CORRECT_PATH	= 3,	/* Speculative and on correct path */
+	PERF_BR_SPEC_NA				= 0,	/* Not available */
+	PERF_BR_SPEC_WRONG_PATH			= 1,	/* Speculative but on wrong path */
+	PERF_BR_NON_SPEC_CORRECT_PATH		= 2,	/* Non-speculative but on correct path */
+	PERF_BR_SPEC_CORRECT_PATH		= 3,	/* Speculative and on correct path */
 	PERF_BR_SPEC_MAX,
 };
 
 enum {
-	PERF_BR_NEW_FAULT_ALGN		= 0,    /* Alignment fault */
-	PERF_BR_NEW_FAULT_DATA		= 1,    /* Data fault */
-	PERF_BR_NEW_FAULT_INST		= 2,    /* Inst fault */
-	PERF_BR_NEW_ARCH_1		= 3,    /* Architecture specific */
-	PERF_BR_NEW_ARCH_2		= 4,    /* Architecture specific */
-	PERF_BR_NEW_ARCH_3		= 5,    /* Architecture specific */
-	PERF_BR_NEW_ARCH_4		= 6,    /* Architecture specific */
-	PERF_BR_NEW_ARCH_5		= 7,    /* Architecture specific */
+	PERF_BR_NEW_FAULT_ALGN			= 0,    /* Alignment fault */
+	PERF_BR_NEW_FAULT_DATA			= 1,    /* Data fault */
+	PERF_BR_NEW_FAULT_INST			= 2,    /* Inst fault */
+	PERF_BR_NEW_ARCH_1			= 3,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_2			= 4,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_3			= 5,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_4			= 6,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_5			= 7,    /* Architecture specific */
 	PERF_BR_NEW_MAX,
 };
 
 enum {
-	PERF_BR_PRIV_UNKNOWN	= 0,
-	PERF_BR_PRIV_USER	= 1,
-	PERF_BR_PRIV_KERNEL	= 2,
-	PERF_BR_PRIV_HV		= 3,
+	PERF_BR_PRIV_UNKNOWN			= 0,
+	PERF_BR_PRIV_USER			= 1,
+	PERF_BR_PRIV_KERNEL			= 2,
+	PERF_BR_PRIV_HV				= 3,
 };
 
-#define PERF_BR_ARM64_FIQ		PERF_BR_NEW_ARCH_1
-#define PERF_BR_ARM64_DEBUG_HALT	PERF_BR_NEW_ARCH_2
-#define PERF_BR_ARM64_DEBUG_EXIT	PERF_BR_NEW_ARCH_3
-#define PERF_BR_ARM64_DEBUG_INST	PERF_BR_NEW_ARCH_4
-#define PERF_BR_ARM64_DEBUG_DATA	PERF_BR_NEW_ARCH_5
+#define PERF_BR_ARM64_FIQ			PERF_BR_NEW_ARCH_1
+#define PERF_BR_ARM64_DEBUG_HALT		PERF_BR_NEW_ARCH_2
+#define PERF_BR_ARM64_DEBUG_EXIT		PERF_BR_NEW_ARCH_3
+#define PERF_BR_ARM64_DEBUG_INST		PERF_BR_NEW_ARCH_4
+#define PERF_BR_ARM64_DEBUG_DATA		PERF_BR_NEW_ARCH_5
 
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
@@ -310,9 +313,9 @@ enum {
  * Values to determine ABI of the registers dump.
  */
 enum perf_sample_regs_abi {
-	PERF_SAMPLE_REGS_ABI_NONE	= 0,
-	PERF_SAMPLE_REGS_ABI_32		= 1,
-	PERF_SAMPLE_REGS_ABI_64		= 2,
+	PERF_SAMPLE_REGS_ABI_NONE		= 0,
+	PERF_SAMPLE_REGS_ABI_32			= 1,
+	PERF_SAMPLE_REGS_ABI_64			= 2,
 };
 
 /*
@@ -320,21 +323,21 @@ enum perf_sample_regs_abi {
  * abort events. Multiple bits can be set.
  */
 enum {
-	PERF_TXN_ELISION        = (1 << 0), /* From elision */
-	PERF_TXN_TRANSACTION    = (1 << 1), /* From transaction */
-	PERF_TXN_SYNC           = (1 << 2), /* Instruction is related */
-	PERF_TXN_ASYNC          = (1 << 3), /* Instruction not related */
-	PERF_TXN_RETRY          = (1 << 4), /* Retry possible */
-	PERF_TXN_CONFLICT       = (1 << 5), /* Conflict abort */
-	PERF_TXN_CAPACITY_WRITE = (1 << 6), /* Capacity write abort */
-	PERF_TXN_CAPACITY_READ  = (1 << 7), /* Capacity read abort */
+	PERF_TXN_ELISION			= (1 << 0), /* From elision */
+	PERF_TXN_TRANSACTION			= (1 << 1), /* From transaction */
+	PERF_TXN_SYNC				= (1 << 2), /* Instruction is related */
+	PERF_TXN_ASYNC				= (1 << 3), /* Instruction is not related */
+	PERF_TXN_RETRY				= (1 << 4), /* Retry possible */
+	PERF_TXN_CONFLICT			= (1 << 5), /* Conflict abort */
+	PERF_TXN_CAPACITY_WRITE			= (1 << 6), /* Capacity write abort */
+	PERF_TXN_CAPACITY_READ			= (1 << 7), /* Capacity read abort */
 
-	PERF_TXN_MAX	        = (1 << 8), /* non-ABI */
+	PERF_TXN_MAX				= (1 << 8), /* non-ABI */
 
-	/* bits 32..63 are reserved for the abort code */
+	/* Bits 32..63 are reserved for the abort code */
 
-	PERF_TXN_ABORT_MASK  = (0xffffffffULL << 32),
-	PERF_TXN_ABORT_SHIFT = 32,
+	PERF_TXN_ABORT_MASK			= (0xffffffffULL << 32),
+	PERF_TXN_ABORT_SHIFT			= 32,
 };
 
 /*
@@ -369,24 +372,22 @@ enum perf_event_read_format {
 	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
-#define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
-#define PERF_ATTR_SIZE_VER1	72	/* add: config2 */
-#define PERF_ATTR_SIZE_VER2	80	/* add: branch_sample_type */
-#define PERF_ATTR_SIZE_VER3	96	/* add: sample_regs_user */
-					/* add: sample_stack_user */
-#define PERF_ATTR_SIZE_VER4	104	/* add: sample_regs_intr */
-#define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
-#define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
-#define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
-#define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
+#define PERF_ATTR_SIZE_VER0			 64	/* Size of first published 'struct perf_event_attr' */
+#define PERF_ATTR_SIZE_VER1			 72	/* Add: config2 */
+#define PERF_ATTR_SIZE_VER2			 80	/* Add: branch_sample_type */
+#define PERF_ATTR_SIZE_VER3			 96	/* Add: sample_regs_user */
+							/* Add: sample_stack_user */
+#define PERF_ATTR_SIZE_VER4			104	/* Add: sample_regs_intr */
+#define PERF_ATTR_SIZE_VER5			112	/* Add: aux_watermark */
+#define PERF_ATTR_SIZE_VER6			120	/* Add: aux_sample_size */
+#define PERF_ATTR_SIZE_VER7			128	/* Add: sig_data */
+#define PERF_ATTR_SIZE_VER8			136	/* Add: config3 */
 
 /*
- * Hardware event_id to monitor via a performance monitoring event:
- *
- * @sample_max_stack: Max number of frame pointers in a callchain,
- *		      should be < /proc/sys/kernel/perf_event_max_stack
- *		      Max number of entries of branch stack
- *		      should be < hardware limit
+ * 'struct perf_event_attr' contains various attributes that define
+ * a performance event - most of them hardware related configuration
+ * details, but also a lot of behavioral switches and values implemented
+ * by the kernel.
  */
 struct perf_event_attr {
 
@@ -396,7 +397,7 @@ struct perf_event_attr {
 	__u32			type;
 
 	/*
-	 * Size of the attr structure, for fwd/bwd compat.
+	 * Size of the attr structure, for forward/backwards compatibility.
 	 */
 	__u32			size;
 
@@ -451,21 +452,21 @@ struct perf_event_attr {
 				comm_exec      :  1, /* flag comm events that are due to an exec */
 				use_clockid    :  1, /* use @clockid for time fields */
 				context_switch :  1, /* context switch data */
-				write_backward :  1, /* Write ring buffer from end to beginning */
+				write_backward :  1, /* write ring buffer from end to beginning */
 				namespaces     :  1, /* include namespaces data */
 				ksymbol        :  1, /* include ksymbol events */
-				bpf_event      :  1, /* include bpf events */
+				bpf_event      :  1, /* include BPF events */
 				aux_output     :  1, /* generate AUX records instead of events */
 				cgroup         :  1, /* include cgroup events */
 				text_poke      :  1, /* include text poke events */
-				build_id       :  1, /* use build id in mmap2 events */
+				build_id       :  1, /* use build ID in mmap2 events */
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
 				__reserved_1   : 26;
 
 	union {
-		__u32		wakeup_events;	  /* wakeup every n events */
+		__u32		wakeup_events;	  /* wake up every n events */
 		__u32		wakeup_watermark; /* bytes before wakeup   */
 	};
 
@@ -474,13 +475,13 @@ struct perf_event_attr {
 		__u64		bp_addr;
 		__u64		kprobe_func; /* for perf_kprobe */
 		__u64		uprobe_path; /* for perf_uprobe */
-		__u64		config1; /* extension of config */
+		__u64		config1;     /* extension of config */
 	};
 	union {
 		__u64		bp_len;
-		__u64		kprobe_addr; /* when kprobe_func == NULL */
+		__u64		kprobe_addr;  /* when kprobe_func == NULL */
 		__u64		probe_offset; /* for perf_[k,u]probe */
-		__u64		config2; /* extension of config1 */
+		__u64		config2;      /* extension of config1 */
 	};
 	__u64	branch_sample_type; /* enum perf_branch_sample_type */
 
@@ -510,7 +511,16 @@ struct perf_event_attr {
 	 * Wakeup watermark for AUX area
 	 */
 	__u32	aux_watermark;
+
+	/*
+	 * Max number of frame pointers in a callchain, should be
+	 * lower than /proc/sys/kernel/perf_event_max_stack.
+	 *
+	 * Max number of entries of branch stack should be lower
+	 * than the hardware limit.
+	 */
 	__u16	sample_max_stack;
+
 	__u16	__reserved_2;
 	__u32	aux_sample_size;
 
@@ -537,7 +547,7 @@ struct perf_event_attr {
 
 /*
  * Structure used by below PERF_EVENT_IOC_QUERY_BPF command
- * to query bpf programs attached to the same perf tracepoint
+ * to query BPF programs attached to the same perf tracepoint
  * as the given perf event.
  */
 struct perf_event_query_bpf {
@@ -559,21 +569,21 @@ struct perf_event_query_bpf {
 /*
  * Ioctls that can be done on a perf event fd:
  */
-#define PERF_EVENT_IOC_ENABLE			_IO ('$', 0)
-#define PERF_EVENT_IOC_DISABLE			_IO ('$', 1)
-#define PERF_EVENT_IOC_REFRESH			_IO ('$', 2)
-#define PERF_EVENT_IOC_RESET			_IO ('$', 3)
-#define PERF_EVENT_IOC_PERIOD			_IOW('$', 4, __u64)
-#define PERF_EVENT_IOC_SET_OUTPUT		_IO ('$', 5)
-#define PERF_EVENT_IOC_SET_FILTER		_IOW('$', 6, char *)
-#define PERF_EVENT_IOC_ID			_IOR('$', 7, __u64 *)
-#define PERF_EVENT_IOC_SET_BPF			_IOW('$', 8, __u32)
-#define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
+#define PERF_EVENT_IOC_ENABLE			_IO  ('$', 0)
+#define PERF_EVENT_IOC_DISABLE			_IO  ('$', 1)
+#define PERF_EVENT_IOC_REFRESH			_IO  ('$', 2)
+#define PERF_EVENT_IOC_RESET			_IO  ('$', 3)
+#define PERF_EVENT_IOC_PERIOD			_IOW ('$', 4, __u64)
+#define PERF_EVENT_IOC_SET_OUTPUT		_IO  ('$', 5)
+#define PERF_EVENT_IOC_SET_FILTER		_IOW ('$', 6, char *)
+#define PERF_EVENT_IOC_ID			_IOR ('$', 7, __u64 *)
+#define PERF_EVENT_IOC_SET_BPF			_IOW ('$', 8, __u32)
+#define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW ('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
-#define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW ('$', 11, struct perf_event_attr *)
 
 enum perf_event_ioc_flags {
-	PERF_IOC_FLAG_GROUP		= 1U << 0,
+	PERF_IOC_FLAG_GROUP			= 1U << 0,
 };
 
 /*
@@ -584,7 +594,7 @@ struct perf_event_mmap_page {
 	__u32	compat_version;		/* lowest version this is compat with */
 
 	/*
-	 * Bits needed to read the hw events in user-space.
+	 * Bits needed to read the HW events in user-space.
 	 *
 	 *   u32 seq, time_mult, time_shift, index, width;
 	 *   u64 count, enabled, running;
@@ -622,7 +632,7 @@ struct perf_event_mmap_page {
 	__u32	index;			/* hardware event identifier */
 	__s64	offset;			/* add to hardware event value */
 	__u64	time_enabled;		/* time event active */
-	__u64	time_running;		/* time event on cpu */
+	__u64	time_running;		/* time event on CPU */
 	union {
 		__u64	capabilities;
 		struct {
@@ -650,7 +660,7 @@ struct perf_event_mmap_page {
 
 	/*
 	 * If cap_usr_time the below fields can be used to compute the time
-	 * delta since time_enabled (in ns) using rdtsc or similar.
+	 * delta since time_enabled (in ns) using RDTSC or similar.
 	 *
 	 *   u64 quot, rem;
 	 *   u64 delta;
@@ -723,7 +733,7 @@ struct perf_event_mmap_page {
 	 * after reading this value.
 	 *
 	 * When the mapping is PROT_WRITE the @data_tail value should be
-	 * written by userspace to reflect the last read data, after issueing
+	 * written by user-space to reflect the last read data, after issuing
 	 * an smp_mb() to separate the data read from the ->data_tail store.
 	 * In this case the kernel will not over-write unread data.
 	 *
@@ -739,7 +749,7 @@ struct perf_event_mmap_page {
 
 	/*
 	 * AUX area is defined by aux_{offset,size} fields that should be set
-	 * by the userspace, so that
+	 * by the user-space, so that
 	 *
 	 *   aux_offset >= data_offset + data_size
 	 *
@@ -813,7 +823,7 @@ struct perf_event_mmap_page {
  *   Indicates that thread was preempted in TASK_RUNNING state.
  *
  * PERF_RECORD_MISC_MMAP_BUILD_ID:
- *   Indicates that mmap2 event carries build id data.
+ *   Indicates that mmap2 event carries build ID data.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
 #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
@@ -824,26 +834,26 @@ struct perf_event_mmap_page {
 #define PERF_RECORD_MISC_EXT_RESERVED		(1 << 15)
 
 struct perf_event_header {
-	__u32	type;
-	__u16	misc;
-	__u16	size;
+	__u32 type;
+	__u16 misc;
+	__u16 size;
 };
 
 struct perf_ns_link_info {
-	__u64	dev;
-	__u64	ino;
+	__u64 dev;
+	__u64 ino;
 };
 
 enum {
-	NET_NS_INDEX		= 0,
-	UTS_NS_INDEX		= 1,
-	IPC_NS_INDEX		= 2,
-	PID_NS_INDEX		= 3,
-	USER_NS_INDEX		= 4,
-	MNT_NS_INDEX		= 5,
-	CGROUP_NS_INDEX		= 6,
-
-	NR_NAMESPACES,		/* number of available namespaces */
+	NET_NS_INDEX				= 0,
+	UTS_NS_INDEX				= 1,
+	IPC_NS_INDEX				= 2,
+	PID_NS_INDEX				= 3,
+	USER_NS_INDEX				= 4,
+	MNT_NS_INDEX				= 5,
+	CGROUP_NS_INDEX				= 6,
+
+	NR_NAMESPACES, /* number of available namespaces */
 };
 
 enum perf_event_type {
@@ -859,11 +869,11 @@ enum perf_event_type {
 	 * optional fields being ignored.
 	 *
 	 * struct sample_id {
-	 * 	{ u32			pid, tid; } && PERF_SAMPLE_TID
-	 * 	{ u64			time;     } && PERF_SAMPLE_TIME
-	 * 	{ u64			id;       } && PERF_SAMPLE_ID
-	 * 	{ u64			stream_id;} && PERF_SAMPLE_STREAM_ID
-	 * 	{ u32			cpu, res; } && PERF_SAMPLE_CPU
+	 *	{ u32			pid, tid; } && PERF_SAMPLE_TID
+	 *	{ u64			time;     } && PERF_SAMPLE_TIME
+	 *	{ u64			id;       } && PERF_SAMPLE_ID
+	 *	{ u64			stream_id;} && PERF_SAMPLE_STREAM_ID
+	 *	{ u32			cpu, res; } && PERF_SAMPLE_CPU
 	 *	{ u64			id;	  } && PERF_SAMPLE_IDENTIFIER
 	 * } && perf_event_attr::sample_id_all
 	 *
@@ -874,7 +884,7 @@ enum perf_event_type {
 
 	/*
 	 * The MMAP events record the PROT_EXEC mappings so that we can
-	 * correlate userspace IPs to code. They have the following structure:
+	 * correlate user-space IPs to code. They have the following structure:
 	 *
 	 * struct {
 	 *	struct perf_event_header	header;
@@ -884,7 +894,7 @@ enum perf_event_type {
 	 *	u64				len;
 	 *	u64				pgoff;
 	 *	char				filename[];
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_MMAP			= 1,
@@ -894,7 +904,7 @@ enum perf_event_type {
 	 *	struct perf_event_header	header;
 	 *	u64				id;
 	 *	u64				lost;
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_LOST			= 2,
@@ -905,7 +915,7 @@ enum perf_event_type {
 	 *
 	 *	u32				pid, tid;
 	 *	char				comm[];
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_COMM			= 3,
@@ -916,7 +926,7 @@ enum perf_event_type {
 	 *	u32				pid, ppid;
 	 *	u32				tid, ptid;
 	 *	u64				time;
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_EXIT			= 4,
@@ -927,7 +937,7 @@ enum perf_event_type {
 	 *	u64				time;
 	 *	u64				id;
 	 *	u64				stream_id;
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_THROTTLE			= 5,
@@ -939,7 +949,7 @@ enum perf_event_type {
 	 *	u32				pid, ppid;
 	 *	u32				tid, ptid;
 	 *	u64				time;
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_FORK			= 7,
@@ -950,7 +960,7 @@ enum perf_event_type {
 	 *	u32				pid, tid;
 	 *
 	 *	struct read_format		values;
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_READ			= 8,
@@ -1005,12 +1015,12 @@ enum perf_event_type {
 	 *        { u64 counters; } cntr[nr] && PERF_SAMPLE_BRANCH_COUNTERS
 	 *      } && PERF_SAMPLE_BRANCH_STACK
 	 *
-	 * 	{ u64			abi; # enum perf_sample_regs_abi
-	 * 	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
+	 *	{ u64			abi; # enum perf_sample_regs_abi
+	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
 	 *
-	 * 	{ u64			size;
-	 * 	  char			data[size];
-	 * 	  u64			dyn_size; } && PERF_SAMPLE_STACK_USER
+	 *	{ u64			size;
+	 *	  char			data[size];
+	 *	  u64			dyn_size; } && PERF_SAMPLE_STACK_USER
 	 *
 	 *	{ union perf_sample_weight
 	 *	 {
@@ -1071,7 +1081,7 @@ enum perf_event_type {
 	 *	};
 	 *	u32				prot, flags;
 	 *	char				filename[];
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_MMAP2			= 10,
@@ -1080,12 +1090,12 @@ enum perf_event_type {
 	 * Records that new data landed in the AUX buffer part.
 	 *
 	 * struct {
-	 * 	struct perf_event_header	header;
+	 *	struct perf_event_header	header;
 	 *
-	 * 	u64				aux_offset;
-	 * 	u64				aux_size;
+	 *	u64				aux_offset;
+	 *	u64				aux_size;
 	 *	u64				flags;
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_AUX				= 11,
@@ -1168,7 +1178,7 @@ enum perf_event_type {
 	PERF_RECORD_KSYMBOL			= 17,
 
 	/*
-	 * Record bpf events:
+	 * Record BPF events:
 	 *  enum perf_bpf_event_type {
 	 *	PERF_BPF_EVENT_UNKNOWN		= 0,
 	 *	PERF_BPF_EVENT_PROG_LOAD	= 1,
@@ -1246,181 +1256,181 @@ enum perf_record_ksymbol_type {
 #define PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER	(1 << 0)
 
 enum perf_bpf_event_type {
-	PERF_BPF_EVENT_UNKNOWN		= 0,
-	PERF_BPF_EVENT_PROG_LOAD	= 1,
-	PERF_BPF_EVENT_PROG_UNLOAD	= 2,
-	PERF_BPF_EVENT_MAX,		/* non-ABI */
+	PERF_BPF_EVENT_UNKNOWN			= 0,
+	PERF_BPF_EVENT_PROG_LOAD		= 1,
+	PERF_BPF_EVENT_PROG_UNLOAD		= 2,
+	PERF_BPF_EVENT_MAX,			/* non-ABI */
 };
 
-#define PERF_MAX_STACK_DEPTH		127
-#define PERF_MAX_CONTEXTS_PER_STACK	  8
+#define PERF_MAX_STACK_DEPTH			127
+#define PERF_MAX_CONTEXTS_PER_STACK		  8
 
 enum perf_callchain_context {
-	PERF_CONTEXT_HV			= (__u64)-32,
-	PERF_CONTEXT_KERNEL		= (__u64)-128,
-	PERF_CONTEXT_USER		= (__u64)-512,
+	PERF_CONTEXT_HV				= (__u64)-32,
+	PERF_CONTEXT_KERNEL			= (__u64)-128,
+	PERF_CONTEXT_USER			= (__u64)-512,
 
-	PERF_CONTEXT_GUEST		= (__u64)-2048,
-	PERF_CONTEXT_GUEST_KERNEL	= (__u64)-2176,
-	PERF_CONTEXT_GUEST_USER		= (__u64)-2560,
+	PERF_CONTEXT_GUEST			= (__u64)-2048,
+	PERF_CONTEXT_GUEST_KERNEL		= (__u64)-2176,
+	PERF_CONTEXT_GUEST_USER			= (__u64)-2560,
 
-	PERF_CONTEXT_MAX		= (__u64)-4095,
+	PERF_CONTEXT_MAX			= (__u64)-4095,
 };
 
 /**
  * PERF_RECORD_AUX::flags bits
  */
-#define PERF_AUX_FLAG_TRUNCATED			0x01	/* record was truncated to fit */
-#define PERF_AUX_FLAG_OVERWRITE			0x02	/* snapshot from overwrite mode */
-#define PERF_AUX_FLAG_PARTIAL			0x04	/* record contains gaps */
-#define PERF_AUX_FLAG_COLLISION			0x08	/* sample collided with another */
+#define PERF_AUX_FLAG_TRUNCATED			0x0001	/* Record was truncated to fit */
+#define PERF_AUX_FLAG_OVERWRITE			0x0002	/* Snapshot from overwrite mode */
+#define PERF_AUX_FLAG_PARTIAL			0x0004	/* Record contains gaps */
+#define PERF_AUX_FLAG_COLLISION			0x0008	/* Sample collided with another */
 #define PERF_AUX_FLAG_PMU_FORMAT_TYPE_MASK	0xff00	/* PMU specific trace format type */
 
 /* CoreSight PMU AUX buffer formats */
-#define PERF_AUX_FLAG_CORESIGHT_FORMAT_CORESIGHT	0x0000 /* Default for backward compatibility */
-#define PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW		0x0100 /* Raw format of the source */
+#define PERF_AUX_FLAG_CORESIGHT_FORMAT_CORESIGHT 0x0000 /* Default for backward compatibility */
+#define PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW	 0x0100 /* Raw format of the source */
 
-#define PERF_FLAG_FD_NO_GROUP		(1UL << 0)
-#define PERF_FLAG_FD_OUTPUT		(1UL << 1)
-#define PERF_FLAG_PID_CGROUP		(1UL << 2) /* pid=cgroup id, per-cpu mode only */
-#define PERF_FLAG_FD_CLOEXEC		(1UL << 3) /* O_CLOEXEC */
+#define PERF_FLAG_FD_NO_GROUP			(1UL << 0)
+#define PERF_FLAG_FD_OUTPUT			(1UL << 1)
+#define PERF_FLAG_PID_CGROUP			(1UL << 2) /* pid=cgroup ID, per-CPU mode only */
+#define PERF_FLAG_FD_CLOEXEC			(1UL << 3) /* O_CLOEXEC */
 
 #if defined(__LITTLE_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64   mem_op:5,	/* type of opcode */
-			mem_lvl:14,	/* memory hierarchy level */
-			mem_snoop:5,	/* snoop mode */
-			mem_lock:2,	/* lock instr */
-			mem_dtlb:7,	/* tlb access */
-			mem_lvl_num:4,	/* memory hierarchy level number */
-			mem_remote:1,   /* remote */
-			mem_snoopx:2,	/* snoop mode, ext */
-			mem_blk:3,	/* access blocked */
-			mem_hops:3,	/* hop level */
-			mem_rsvd:18;
+		__u64   mem_op      :  5, /* Type of opcode */
+			mem_lvl     : 14, /* Memory hierarchy level */
+			mem_snoop   :  5, /* Snoop mode */
+			mem_lock    :  2, /* Lock instr */
+			mem_dtlb    :  7, /* TLB access */
+			mem_lvl_num :  4, /* Memory hierarchy level number */
+			mem_remote  :  1, /* Remote */
+			mem_snoopx  :  2, /* Snoop mode, ext */
+			mem_blk     :  3, /* Access blocked */
+			mem_hops    :  3, /* Hop level */
+			mem_rsvd    : 18;
 	};
 };
 #elif defined(__BIG_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64	mem_rsvd:18,
-			mem_hops:3,	/* hop level */
-			mem_blk:3,	/* access blocked */
-			mem_snoopx:2,	/* snoop mode, ext */
-			mem_remote:1,   /* remote */
-			mem_lvl_num:4,	/* memory hierarchy level number */
-			mem_dtlb:7,	/* tlb access */
-			mem_lock:2,	/* lock instr */
-			mem_snoop:5,	/* snoop mode */
-			mem_lvl:14,	/* memory hierarchy level */
-			mem_op:5;	/* type of opcode */
+		__u64	mem_rsvd    : 18,
+			mem_hops    :  3, /* Hop level */
+			mem_blk     :  3, /* Access blocked */
+			mem_snoopx  :  2, /* Snoop mode, ext */
+			mem_remote  :  1, /* Remote */
+			mem_lvl_num :  4, /* Memory hierarchy level number */
+			mem_dtlb    :  7, /* TLB access */
+			mem_lock    :  2, /* Lock instr */
+			mem_snoop   :  5, /* Snoop mode */
+			mem_lvl     : 14, /* Memory hierarchy level */
+			mem_op      :  5; /* Type of opcode */
 	};
 };
 #else
-#error "Unknown endianness"
+# error "Unknown endianness"
 #endif
 
-/* type of opcode (load/store/prefetch,code) */
-#define PERF_MEM_OP_NA		0x01 /* not available */
-#define PERF_MEM_OP_LOAD	0x02 /* load instruction */
-#define PERF_MEM_OP_STORE	0x04 /* store instruction */
-#define PERF_MEM_OP_PFETCH	0x08 /* prefetch */
-#define PERF_MEM_OP_EXEC	0x10 /* code (execution) */
-#define PERF_MEM_OP_SHIFT	0
+/* Type of memory opcode: */
+#define PERF_MEM_OP_NA				0x0001 /* Not available */
+#define PERF_MEM_OP_LOAD			0x0002 /* Load instruction */
+#define PERF_MEM_OP_STORE			0x0004 /* Store instruction */
+#define PERF_MEM_OP_PFETCH			0x0008 /* Prefetch */
+#define PERF_MEM_OP_EXEC			0x0010 /* Code (execution) */
+#define PERF_MEM_OP_SHIFT			0
 
 /*
- * PERF_MEM_LVL_* namespace being depricated to some extent in the
+ * The PERF_MEM_LVL_* namespace is being deprecated to some extent in
  * favour of newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_} fields.
- * Supporting this namespace inorder to not break defined ABIs.
+ * We support this namespace in order to not break defined ABIs.
  *
- * memory hierarchy (memory level, hit or miss)
+ * Memory hierarchy (memory level, hit or miss)
  */
-#define PERF_MEM_LVL_NA		0x01  /* not available */
-#define PERF_MEM_LVL_HIT	0x02  /* hit level */
-#define PERF_MEM_LVL_MISS	0x04  /* miss level  */
-#define PERF_MEM_LVL_L1		0x08  /* L1 */
-#define PERF_MEM_LVL_LFB	0x10  /* Line Fill Buffer */
-#define PERF_MEM_LVL_L2		0x20  /* L2 */
-#define PERF_MEM_LVL_L3		0x40  /* L3 */
-#define PERF_MEM_LVL_LOC_RAM	0x80  /* Local DRAM */
-#define PERF_MEM_LVL_REM_RAM1	0x100 /* Remote DRAM (1 hop) */
-#define PERF_MEM_LVL_REM_RAM2	0x200 /* Remote DRAM (2 hops) */
-#define PERF_MEM_LVL_REM_CCE1	0x400 /* Remote Cache (1 hop) */
-#define PERF_MEM_LVL_REM_CCE2	0x800 /* Remote Cache (2 hops) */
-#define PERF_MEM_LVL_IO		0x1000 /* I/O memory */
-#define PERF_MEM_LVL_UNC	0x2000 /* Uncached memory */
-#define PERF_MEM_LVL_SHIFT	5
-
-#define PERF_MEM_REMOTE_REMOTE	0x01  /* Remote */
-#define PERF_MEM_REMOTE_SHIFT	37
-
-#define PERF_MEM_LVLNUM_L1	0x01 /* L1 */
-#define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
-#define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
-#define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-#define PERF_MEM_LVLNUM_L2_MHB	0x05 /* L2 Miss Handling Buffer */
-#define PERF_MEM_LVLNUM_MSC	0x06 /* Memory-side Cache */
-/* 0x7 available */
-#define PERF_MEM_LVLNUM_UNC	0x08 /* Uncached */
-#define PERF_MEM_LVLNUM_CXL	0x09 /* CXL */
-#define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
-#define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
-#define PERF_MEM_LVLNUM_LFB	0x0c /* LFB / L1 Miss Handling Buffer */
-#define PERF_MEM_LVLNUM_RAM	0x0d /* RAM */
-#define PERF_MEM_LVLNUM_PMEM	0x0e /* PMEM */
-#define PERF_MEM_LVLNUM_NA	0x0f /* N/A */
-
-#define PERF_MEM_LVLNUM_SHIFT	33
-
-/* snoop mode */
-#define PERF_MEM_SNOOP_NA	0x01 /* not available */
-#define PERF_MEM_SNOOP_NONE	0x02 /* no snoop */
-#define PERF_MEM_SNOOP_HIT	0x04 /* snoop hit */
-#define PERF_MEM_SNOOP_MISS	0x08 /* snoop miss */
-#define PERF_MEM_SNOOP_HITM	0x10 /* snoop hit modified */
-#define PERF_MEM_SNOOP_SHIFT	19
-
-#define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
-#define PERF_MEM_SNOOPX_PEER	0x02 /* xfer from peer */
-#define PERF_MEM_SNOOPX_SHIFT  38
-
-/* locked instruction */
-#define PERF_MEM_LOCK_NA	0x01 /* not available */
-#define PERF_MEM_LOCK_LOCKED	0x02 /* locked transaction */
-#define PERF_MEM_LOCK_SHIFT	24
+#define PERF_MEM_LVL_NA				0x0001 /* Not available */
+#define PERF_MEM_LVL_HIT			0x0002 /* Hit level */
+#define PERF_MEM_LVL_MISS			0x0004 /* Miss level  */
+#define PERF_MEM_LVL_L1				0x0008 /* L1 */
+#define PERF_MEM_LVL_LFB			0x0010 /* Line Fill Buffer */
+#define PERF_MEM_LVL_L2				0x0020 /* L2 */
+#define PERF_MEM_LVL_L3				0x0040 /* L3 */
+#define PERF_MEM_LVL_LOC_RAM			0x0080 /* Local DRAM */
+#define PERF_MEM_LVL_REM_RAM1			0x0100 /* Remote DRAM (1 hop) */
+#define PERF_MEM_LVL_REM_RAM2			0x0200 /* Remote DRAM (2 hops) */
+#define PERF_MEM_LVL_REM_CCE1			0x0400 /* Remote Cache (1 hop) */
+#define PERF_MEM_LVL_REM_CCE2			0x0800 /* Remote Cache (2 hops) */
+#define PERF_MEM_LVL_IO				0x1000 /* I/O memory */
+#define PERF_MEM_LVL_UNC			0x2000 /* Uncached memory */
+#define PERF_MEM_LVL_SHIFT			5
+
+#define PERF_MEM_REMOTE_REMOTE			0x0001 /* Remote */
+#define PERF_MEM_REMOTE_SHIFT			37
+
+#define PERF_MEM_LVLNUM_L1			0x0001 /* L1 */
+#define PERF_MEM_LVLNUM_L2			0x0002 /* L2 */
+#define PERF_MEM_LVLNUM_L3			0x0003 /* L3 */
+#define PERF_MEM_LVLNUM_L4			0x0004 /* L4 */
+#define PERF_MEM_LVLNUM_L2_MHB			0x0005 /* L2 Miss Handling Buffer */
+#define PERF_MEM_LVLNUM_MSC			0x0006 /* Memory-side Cache */
+/* 0x007 available */
+#define PERF_MEM_LVLNUM_UNC			0x0008 /* Uncached */
+#define PERF_MEM_LVLNUM_CXL			0x0009 /* CXL */
+#define PERF_MEM_LVLNUM_IO			0x000a /* I/O */
+#define PERF_MEM_LVLNUM_ANY_CACHE		0x000b /* Any cache */
+#define PERF_MEM_LVLNUM_LFB			0x000c /* LFB / L1 Miss Handling Buffer */
+#define PERF_MEM_LVLNUM_RAM			0x000d /* RAM */
+#define PERF_MEM_LVLNUM_PMEM			0x000e /* PMEM */
+#define PERF_MEM_LVLNUM_NA			0x000f /* N/A */
+
+#define PERF_MEM_LVLNUM_SHIFT			33
+
+/* Snoop mode */
+#define PERF_MEM_SNOOP_NA			0x0001 /* Not available */
+#define PERF_MEM_SNOOP_NONE			0x0002 /* No snoop */
+#define PERF_MEM_SNOOP_HIT			0x0004 /* Snoop hit */
+#define PERF_MEM_SNOOP_MISS			0x0008 /* Snoop miss */
+#define PERF_MEM_SNOOP_HITM			0x0010 /* Snoop hit modified */
+#define PERF_MEM_SNOOP_SHIFT			19
+
+#define PERF_MEM_SNOOPX_FWD			0x0001 /* Forward */
+#define PERF_MEM_SNOOPX_PEER			0x0002 /* Transfer from peer */
+#define PERF_MEM_SNOOPX_SHIFT			38
+
+/* Locked instruction */
+#define PERF_MEM_LOCK_NA			0x0001 /* Not available */
+#define PERF_MEM_LOCK_LOCKED			0x0002 /* Locked transaction */
+#define PERF_MEM_LOCK_SHIFT			24
 
 /* TLB access */
-#define PERF_MEM_TLB_NA		0x01 /* not available */
-#define PERF_MEM_TLB_HIT	0x02 /* hit level */
-#define PERF_MEM_TLB_MISS	0x04 /* miss level */
-#define PERF_MEM_TLB_L1		0x08 /* L1 */
-#define PERF_MEM_TLB_L2		0x10 /* L2 */
-#define PERF_MEM_TLB_WK		0x20 /* Hardware Walker*/
-#define PERF_MEM_TLB_OS		0x40 /* OS fault handler */
-#define PERF_MEM_TLB_SHIFT	26
+#define PERF_MEM_TLB_NA				0x0001 /* Not available */
+#define PERF_MEM_TLB_HIT			0x0002 /* Hit level */
+#define PERF_MEM_TLB_MISS			0x0004 /* Miss level */
+#define PERF_MEM_TLB_L1				0x0008 /* L1 */
+#define PERF_MEM_TLB_L2				0x0010 /* L2 */
+#define PERF_MEM_TLB_WK				0x0020 /* Hardware Walker*/
+#define PERF_MEM_TLB_OS				0x0040 /* OS fault handler */
+#define PERF_MEM_TLB_SHIFT			26
 
 /* Access blocked */
-#define PERF_MEM_BLK_NA		0x01 /* not available */
-#define PERF_MEM_BLK_DATA	0x02 /* data could not be forwarded */
-#define PERF_MEM_BLK_ADDR	0x04 /* address conflict */
-#define PERF_MEM_BLK_SHIFT	40
-
-/* hop level */
-#define PERF_MEM_HOPS_0		0x01 /* remote core, same node */
-#define PERF_MEM_HOPS_1		0x02 /* remote node, same socket */
-#define PERF_MEM_HOPS_2		0x03 /* remote socket, same board */
-#define PERF_MEM_HOPS_3		0x04 /* remote board */
+#define PERF_MEM_BLK_NA				0x0001 /* Not available */
+#define PERF_MEM_BLK_DATA			0x0002 /* Data could not be forwarded */
+#define PERF_MEM_BLK_ADDR			0x0004 /* Address conflict */
+#define PERF_MEM_BLK_SHIFT			40
+
+/* Hop level */
+#define PERF_MEM_HOPS_0				0x0001 /* Remote core, same node */
+#define PERF_MEM_HOPS_1				0x0002 /* Remote node, same socket */
+#define PERF_MEM_HOPS_2				0x0003 /* Remote socket, same board */
+#define PERF_MEM_HOPS_3				0x0004 /* Remote board */
 /* 5-7 available */
-#define PERF_MEM_HOPS_SHIFT	43
+#define PERF_MEM_HOPS_SHIFT			43
 
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
 
 /*
- * single taken branch record layout:
+ * Layout of single taken branch records:
  *
  *      from: source instruction (may not always be a branch insn)
  *        to: branch target
@@ -1439,37 +1449,37 @@ union perf_mem_data_src {
 struct perf_branch_entry {
 	__u64	from;
 	__u64	to;
-	__u64	mispred:1,  /* target mispredicted */
-		predicted:1,/* target predicted */
-		in_tx:1,    /* in transaction */
-		abort:1,    /* transaction abort */
-		cycles:16,  /* cycle count to last branch */
-		type:4,     /* branch type */
-		spec:2,     /* branch speculation info */
-		new_type:4, /* additional branch type */
-		priv:3,     /* privilege level */
-		reserved:31;
+	__u64	mispred   :  1, /* target mispredicted */
+		predicted :  1, /* target predicted */
+		in_tx     :  1, /* in transaction */
+		abort     :  1, /* transaction abort */
+		cycles    : 16, /* cycle count to last branch */
+		type      :  4, /* branch type */
+		spec      :  2, /* branch speculation info */
+		new_type  :  4, /* additional branch type */
+		priv      :  3, /* privilege level */
+		reserved  : 31;
 };
 
 /* Size of used info bits in struct perf_branch_entry */
 #define PERF_BRANCH_ENTRY_INFO_BITS_MAX		33
 
 union perf_sample_weight {
-	__u64		full;
+	__u64	      full;
 #if defined(__LITTLE_ENDIAN_BITFIELD)
 	struct {
-		__u32	var1_dw;
-		__u16	var2_w;
-		__u16	var3_w;
+		__u32 var1_dw;
+		__u16 var2_w;
+		__u16 var3_w;
 	};
 #elif defined(__BIG_ENDIAN_BITFIELD)
 	struct {
-		__u16	var3_w;
-		__u16	var2_w;
-		__u32	var1_dw;
+		__u16 var3_w;
+		__u16 var2_w;
+		__u32 var1_dw;
 	};
 #else
-#error "Unknown endianness"
+# error "Unknown endianness"
 #endif
 };
 
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b2722da..78a362b 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -39,18 +39,21 @@ enum perf_type_id {
 
 /*
  * attr.config layout for type PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
+ *
  * PERF_TYPE_HARDWARE:			0xEEEEEEEE000000AA
  *					AA: hardware event ID
  *					EEEEEEEE: PMU type ID
+ *
  * PERF_TYPE_HW_CACHE:			0xEEEEEEEE00DDCCBB
  *					BB: hardware cache ID
  *					CC: hardware cache op ID
  *					DD: hardware cache op result ID
  *					EEEEEEEE: PMU type ID
- * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
+ *
+ * If the PMU type ID is 0, PERF_TYPE_RAW will be applied.
  */
-#define PERF_PMU_TYPE_SHIFT		32
-#define PERF_HW_EVENT_MASK		0xffffffff
+#define PERF_PMU_TYPE_SHIFT			32
+#define PERF_HW_EVENT_MASK			0xffffffff
 
 /*
  * Generalized performance event event_id types, used by the
@@ -112,7 +115,7 @@ enum perf_hw_cache_op_result_id {
 /*
  * Special "software" events provided by the kernel, even if the hardware
  * does not support performance events. These events measure various
- * physical and sw events of the kernel (and allow the profiling of them as
+ * physical and SW events of the kernel (and allow the profiling of them as
  * well):
  */
 enum perf_sw_ids {
@@ -167,8 +170,9 @@ enum perf_event_sample_format {
 };
 
 #define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
+
 /*
- * values to program into branch_sample_type when PERF_SAMPLE_BRANCH is set
+ * Values to program into branch_sample_type when PERF_SAMPLE_BRANCH is set.
  *
  * If the user does not pass priv level information via branch_sample_type,
  * the kernel uses the event's priv level. Branch and event priv levels do
@@ -178,20 +182,20 @@ enum perf_event_sample_format {
  * of branches and therefore it supersedes all the other types.
  */
 enum perf_branch_sample_type_shift {
-	PERF_SAMPLE_BRANCH_USER_SHIFT		= 0, /* user branches */
-	PERF_SAMPLE_BRANCH_KERNEL_SHIFT		= 1, /* kernel branches */
-	PERF_SAMPLE_BRANCH_HV_SHIFT		= 2, /* hypervisor branches */
-
-	PERF_SAMPLE_BRANCH_ANY_SHIFT		= 3, /* any branch types */
-	PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT	= 4, /* any call branch */
-	PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT	= 5, /* any return branch */
-	PERF_SAMPLE_BRANCH_IND_CALL_SHIFT	= 6, /* indirect calls */
-	PERF_SAMPLE_BRANCH_ABORT_TX_SHIFT	= 7, /* transaction aborts */
-	PERF_SAMPLE_BRANCH_IN_TX_SHIFT		= 8, /* in transaction */
-	PERF_SAMPLE_BRANCH_NO_TX_SHIFT		= 9, /* not in transaction */
+	PERF_SAMPLE_BRANCH_USER_SHIFT		=  0, /* user branches */
+	PERF_SAMPLE_BRANCH_KERNEL_SHIFT		=  1, /* kernel branches */
+	PERF_SAMPLE_BRANCH_HV_SHIFT		=  2, /* hypervisor branches */
+
+	PERF_SAMPLE_BRANCH_ANY_SHIFT		=  3, /* any branch types */
+	PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT	=  4, /* any call branch */
+	PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT	=  5, /* any return branch */
+	PERF_SAMPLE_BRANCH_IND_CALL_SHIFT	=  6, /* indirect calls */
+	PERF_SAMPLE_BRANCH_ABORT_TX_SHIFT	=  7, /* transaction aborts */
+	PERF_SAMPLE_BRANCH_IN_TX_SHIFT		=  8, /* in transaction */
+	PERF_SAMPLE_BRANCH_NO_TX_SHIFT		=  9, /* not in transaction */
 	PERF_SAMPLE_BRANCH_COND_SHIFT		= 10, /* conditional branches */
 
-	PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT	= 11, /* call/ret stack */
+	PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT	= 11, /* CALL/RET stack */
 	PERF_SAMPLE_BRANCH_IND_JUMP_SHIFT	= 12, /* indirect jumps */
 	PERF_SAMPLE_BRANCH_CALL_SHIFT		= 13, /* direct call */
 
@@ -210,96 +214,95 @@ enum perf_branch_sample_type_shift {
 };
 
 enum perf_branch_sample_type {
-	PERF_SAMPLE_BRANCH_USER		= 1U << PERF_SAMPLE_BRANCH_USER_SHIFT,
-	PERF_SAMPLE_BRANCH_KERNEL	= 1U << PERF_SAMPLE_BRANCH_KERNEL_SHIFT,
-	PERF_SAMPLE_BRANCH_HV		= 1U << PERF_SAMPLE_BRANCH_HV_SHIFT,
+	PERF_SAMPLE_BRANCH_USER			= 1U << PERF_SAMPLE_BRANCH_USER_SHIFT,
+	PERF_SAMPLE_BRANCH_KERNEL		= 1U << PERF_SAMPLE_BRANCH_KERNEL_SHIFT,
+	PERF_SAMPLE_BRANCH_HV			= 1U << PERF_SAMPLE_BRANCH_HV_SHIFT,
 
-	PERF_SAMPLE_BRANCH_ANY		= 1U << PERF_SAMPLE_BRANCH_ANY_SHIFT,
-	PERF_SAMPLE_BRANCH_ANY_CALL	= 1U << PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT,
-	PERF_SAMPLE_BRANCH_ANY_RETURN	= 1U << PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT,
-	PERF_SAMPLE_BRANCH_IND_CALL	= 1U << PERF_SAMPLE_BRANCH_IND_CALL_SHIFT,
-	PERF_SAMPLE_BRANCH_ABORT_TX	= 1U << PERF_SAMPLE_BRANCH_ABORT_TX_SHIFT,
-	PERF_SAMPLE_BRANCH_IN_TX	= 1U << PERF_SAMPLE_BRANCH_IN_TX_SHIFT,
-	PERF_SAMPLE_BRANCH_NO_TX	= 1U << PERF_SAMPLE_BRANCH_NO_TX_SHIFT,
-	PERF_SAMPLE_BRANCH_COND		= 1U << PERF_SAMPLE_BRANCH_COND_SHIFT,
+	PERF_SAMPLE_BRANCH_ANY			= 1U << PERF_SAMPLE_BRANCH_ANY_SHIFT,
+	PERF_SAMPLE_BRANCH_ANY_CALL		= 1U << PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT,
+	PERF_SAMPLE_BRANCH_ANY_RETURN		= 1U << PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT,
+	PERF_SAMPLE_BRANCH_IND_CALL		= 1U << PERF_SAMPLE_BRANCH_IND_CALL_SHIFT,
+	PERF_SAMPLE_BRANCH_ABORT_TX		= 1U << PERF_SAMPLE_BRANCH_ABORT_TX_SHIFT,
+	PERF_SAMPLE_BRANCH_IN_TX		= 1U << PERF_SAMPLE_BRANCH_IN_TX_SHIFT,
+	PERF_SAMPLE_BRANCH_NO_TX		= 1U << PERF_SAMPLE_BRANCH_NO_TX_SHIFT,
+	PERF_SAMPLE_BRANCH_COND			= 1U << PERF_SAMPLE_BRANCH_COND_SHIFT,
 
-	PERF_SAMPLE_BRANCH_CALL_STACK	= 1U << PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT,
-	PERF_SAMPLE_BRANCH_IND_JUMP	= 1U << PERF_SAMPLE_BRANCH_IND_JUMP_SHIFT,
-	PERF_SAMPLE_BRANCH_CALL		= 1U << PERF_SAMPLE_BRANCH_CALL_SHIFT,
+	PERF_SAMPLE_BRANCH_CALL_STACK		= 1U << PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT,
+	PERF_SAMPLE_BRANCH_IND_JUMP		= 1U << PERF_SAMPLE_BRANCH_IND_JUMP_SHIFT,
+	PERF_SAMPLE_BRANCH_CALL			= 1U << PERF_SAMPLE_BRANCH_CALL_SHIFT,
 
-	PERF_SAMPLE_BRANCH_NO_FLAGS	= 1U << PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT,
-	PERF_SAMPLE_BRANCH_NO_CYCLES	= 1U << PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT,
+	PERF_SAMPLE_BRANCH_NO_FLAGS		= 1U << PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT,
+	PERF_SAMPLE_BRANCH_NO_CYCLES		= 1U << PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT,
 
-	PERF_SAMPLE_BRANCH_TYPE_SAVE	=
-		1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
+	PERF_SAMPLE_BRANCH_TYPE_SAVE		= 1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
 
-	PERF_SAMPLE_BRANCH_HW_INDEX	= 1U << PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT,
+	PERF_SAMPLE_BRANCH_HW_INDEX		= 1U << PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT,
 
-	PERF_SAMPLE_BRANCH_PRIV_SAVE	= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
+	PERF_SAMPLE_BRANCH_PRIV_SAVE		= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
 
-	PERF_SAMPLE_BRANCH_COUNTERS	= 1U << PERF_SAMPLE_BRANCH_COUNTERS_SHIFT,
+	PERF_SAMPLE_BRANCH_COUNTERS		= 1U << PERF_SAMPLE_BRANCH_COUNTERS_SHIFT,
 
-	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
+	PERF_SAMPLE_BRANCH_MAX			= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
 /*
- * Common flow change classification
+ * Common control flow change classifications:
  */
 enum {
-	PERF_BR_UNKNOWN		= 0,	/* unknown */
-	PERF_BR_COND		= 1,	/* conditional */
-	PERF_BR_UNCOND		= 2,	/* unconditional  */
-	PERF_BR_IND		= 3,	/* indirect */
-	PERF_BR_CALL		= 4,	/* function call */
-	PERF_BR_IND_CALL	= 5,	/* indirect function call */
-	PERF_BR_RET		= 6,	/* function return */
-	PERF_BR_SYSCALL		= 7,	/* syscall */
-	PERF_BR_SYSRET		= 8,	/* syscall return */
-	PERF_BR_COND_CALL	= 9,	/* conditional function call */
-	PERF_BR_COND_RET	= 10,	/* conditional function return */
-	PERF_BR_ERET		= 11,	/* exception return */
-	PERF_BR_IRQ		= 12,	/* irq */
-	PERF_BR_SERROR		= 13,	/* system error */
-	PERF_BR_NO_TX		= 14,	/* not in transaction */
-	PERF_BR_EXTEND_ABI	= 15,	/* extend ABI */
+	PERF_BR_UNKNOWN				=  0,	/* Unknown */
+	PERF_BR_COND				=  1,	/* Conditional */
+	PERF_BR_UNCOND				=  2,	/* Unconditional  */
+	PERF_BR_IND				=  3,	/* Indirect */
+	PERF_BR_CALL				=  4,	/* Function call */
+	PERF_BR_IND_CALL			=  5,	/* Indirect function call */
+	PERF_BR_RET				=  6,	/* Function return */
+	PERF_BR_SYSCALL				=  7,	/* Syscall */
+	PERF_BR_SYSRET				=  8,	/* Syscall return */
+	PERF_BR_COND_CALL			=  9,	/* Conditional function call */
+	PERF_BR_COND_RET			= 10,	/* Conditional function return */
+	PERF_BR_ERET				= 11,	/* Exception return */
+	PERF_BR_IRQ				= 12,	/* IRQ */
+	PERF_BR_SERROR				= 13,	/* System error */
+	PERF_BR_NO_TX				= 14,	/* Not in transaction */
+	PERF_BR_EXTEND_ABI			= 15,	/* Extend ABI */
 	PERF_BR_MAX,
 };
 
 /*
- * Common branch speculation outcome classification
+ * Common branch speculation outcome classifications:
  */
 enum {
-	PERF_BR_SPEC_NA			= 0,	/* Not available */
-	PERF_BR_SPEC_WRONG_PATH		= 1,	/* Speculative but on wrong path */
-	PERF_BR_NON_SPEC_CORRECT_PATH	= 2,	/* Non-speculative but on correct path */
-	PERF_BR_SPEC_CORRECT_PATH	= 3,	/* Speculative and on correct path */
+	PERF_BR_SPEC_NA				= 0,	/* Not available */
+	PERF_BR_SPEC_WRONG_PATH			= 1,	/* Speculative but on wrong path */
+	PERF_BR_NON_SPEC_CORRECT_PATH		= 2,	/* Non-speculative but on correct path */
+	PERF_BR_SPEC_CORRECT_PATH		= 3,	/* Speculative and on correct path */
 	PERF_BR_SPEC_MAX,
 };
 
 enum {
-	PERF_BR_NEW_FAULT_ALGN		= 0,    /* Alignment fault */
-	PERF_BR_NEW_FAULT_DATA		= 1,    /* Data fault */
-	PERF_BR_NEW_FAULT_INST		= 2,    /* Inst fault */
-	PERF_BR_NEW_ARCH_1		= 3,    /* Architecture specific */
-	PERF_BR_NEW_ARCH_2		= 4,    /* Architecture specific */
-	PERF_BR_NEW_ARCH_3		= 5,    /* Architecture specific */
-	PERF_BR_NEW_ARCH_4		= 6,    /* Architecture specific */
-	PERF_BR_NEW_ARCH_5		= 7,    /* Architecture specific */
+	PERF_BR_NEW_FAULT_ALGN			= 0,    /* Alignment fault */
+	PERF_BR_NEW_FAULT_DATA			= 1,    /* Data fault */
+	PERF_BR_NEW_FAULT_INST			= 2,    /* Inst fault */
+	PERF_BR_NEW_ARCH_1			= 3,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_2			= 4,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_3			= 5,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_4			= 6,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_5			= 7,    /* Architecture specific */
 	PERF_BR_NEW_MAX,
 };
 
 enum {
-	PERF_BR_PRIV_UNKNOWN	= 0,
-	PERF_BR_PRIV_USER	= 1,
-	PERF_BR_PRIV_KERNEL	= 2,
-	PERF_BR_PRIV_HV		= 3,
+	PERF_BR_PRIV_UNKNOWN			= 0,
+	PERF_BR_PRIV_USER			= 1,
+	PERF_BR_PRIV_KERNEL			= 2,
+	PERF_BR_PRIV_HV				= 3,
 };
 
-#define PERF_BR_ARM64_FIQ		PERF_BR_NEW_ARCH_1
-#define PERF_BR_ARM64_DEBUG_HALT	PERF_BR_NEW_ARCH_2
-#define PERF_BR_ARM64_DEBUG_EXIT	PERF_BR_NEW_ARCH_3
-#define PERF_BR_ARM64_DEBUG_INST	PERF_BR_NEW_ARCH_4
-#define PERF_BR_ARM64_DEBUG_DATA	PERF_BR_NEW_ARCH_5
+#define PERF_BR_ARM64_FIQ			PERF_BR_NEW_ARCH_1
+#define PERF_BR_ARM64_DEBUG_HALT		PERF_BR_NEW_ARCH_2
+#define PERF_BR_ARM64_DEBUG_EXIT		PERF_BR_NEW_ARCH_3
+#define PERF_BR_ARM64_DEBUG_INST		PERF_BR_NEW_ARCH_4
+#define PERF_BR_ARM64_DEBUG_DATA		PERF_BR_NEW_ARCH_5
 
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
@@ -310,9 +313,9 @@ enum {
  * Values to determine ABI of the registers dump.
  */
 enum perf_sample_regs_abi {
-	PERF_SAMPLE_REGS_ABI_NONE	= 0,
-	PERF_SAMPLE_REGS_ABI_32		= 1,
-	PERF_SAMPLE_REGS_ABI_64		= 2,
+	PERF_SAMPLE_REGS_ABI_NONE		= 0,
+	PERF_SAMPLE_REGS_ABI_32			= 1,
+	PERF_SAMPLE_REGS_ABI_64			= 2,
 };
 
 /*
@@ -320,21 +323,21 @@ enum perf_sample_regs_abi {
  * abort events. Multiple bits can be set.
  */
 enum {
-	PERF_TXN_ELISION        = (1 << 0), /* From elision */
-	PERF_TXN_TRANSACTION    = (1 << 1), /* From transaction */
-	PERF_TXN_SYNC           = (1 << 2), /* Instruction is related */
-	PERF_TXN_ASYNC          = (1 << 3), /* Instruction not related */
-	PERF_TXN_RETRY          = (1 << 4), /* Retry possible */
-	PERF_TXN_CONFLICT       = (1 << 5), /* Conflict abort */
-	PERF_TXN_CAPACITY_WRITE = (1 << 6), /* Capacity write abort */
-	PERF_TXN_CAPACITY_READ  = (1 << 7), /* Capacity read abort */
+	PERF_TXN_ELISION			= (1 << 0), /* From elision */
+	PERF_TXN_TRANSACTION			= (1 << 1), /* From transaction */
+	PERF_TXN_SYNC				= (1 << 2), /* Instruction is related */
+	PERF_TXN_ASYNC				= (1 << 3), /* Instruction is not related */
+	PERF_TXN_RETRY				= (1 << 4), /* Retry possible */
+	PERF_TXN_CONFLICT			= (1 << 5), /* Conflict abort */
+	PERF_TXN_CAPACITY_WRITE			= (1 << 6), /* Capacity write abort */
+	PERF_TXN_CAPACITY_READ			= (1 << 7), /* Capacity read abort */
 
-	PERF_TXN_MAX	        = (1 << 8), /* non-ABI */
+	PERF_TXN_MAX				= (1 << 8), /* non-ABI */
 
-	/* bits 32..63 are reserved for the abort code */
+	/* Bits 32..63 are reserved for the abort code */
 
-	PERF_TXN_ABORT_MASK  = (0xffffffffULL << 32),
-	PERF_TXN_ABORT_SHIFT = 32,
+	PERF_TXN_ABORT_MASK			= (0xffffffffULL << 32),
+	PERF_TXN_ABORT_SHIFT			= 32,
 };
 
 /*
@@ -369,24 +372,22 @@ enum perf_event_read_format {
 	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
-#define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
-#define PERF_ATTR_SIZE_VER1	72	/* add: config2 */
-#define PERF_ATTR_SIZE_VER2	80	/* add: branch_sample_type */
-#define PERF_ATTR_SIZE_VER3	96	/* add: sample_regs_user */
-					/* add: sample_stack_user */
-#define PERF_ATTR_SIZE_VER4	104	/* add: sample_regs_intr */
-#define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
-#define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
-#define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
-#define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
+#define PERF_ATTR_SIZE_VER0			 64	/* Size of first published 'struct perf_event_attr' */
+#define PERF_ATTR_SIZE_VER1			 72	/* Add: config2 */
+#define PERF_ATTR_SIZE_VER2			 80	/* Add: branch_sample_type */
+#define PERF_ATTR_SIZE_VER3			 96	/* Add: sample_regs_user */
+							/* Add: sample_stack_user */
+#define PERF_ATTR_SIZE_VER4			104	/* Add: sample_regs_intr */
+#define PERF_ATTR_SIZE_VER5			112	/* Add: aux_watermark */
+#define PERF_ATTR_SIZE_VER6			120	/* Add: aux_sample_size */
+#define PERF_ATTR_SIZE_VER7			128	/* Add: sig_data */
+#define PERF_ATTR_SIZE_VER8			136	/* Add: config3 */
 
 /*
- * Hardware event_id to monitor via a performance monitoring event:
- *
- * @sample_max_stack: Max number of frame pointers in a callchain,
- *		      should be < /proc/sys/kernel/perf_event_max_stack
- *		      Max number of entries of branch stack
- *		      should be < hardware limit
+ * 'struct perf_event_attr' contains various attributes that define
+ * a performance event - most of them hardware related configuration
+ * details, but also a lot of behavioral switches and values implemented
+ * by the kernel.
  */
 struct perf_event_attr {
 
@@ -396,7 +397,7 @@ struct perf_event_attr {
 	__u32			type;
 
 	/*
-	 * Size of the attr structure, for fwd/bwd compat.
+	 * Size of the attr structure, for forward/backwards compatibility.
 	 */
 	__u32			size;
 
@@ -451,21 +452,21 @@ struct perf_event_attr {
 				comm_exec      :  1, /* flag comm events that are due to an exec */
 				use_clockid    :  1, /* use @clockid for time fields */
 				context_switch :  1, /* context switch data */
-				write_backward :  1, /* Write ring buffer from end to beginning */
+				write_backward :  1, /* write ring buffer from end to beginning */
 				namespaces     :  1, /* include namespaces data */
 				ksymbol        :  1, /* include ksymbol events */
-				bpf_event      :  1, /* include bpf events */
+				bpf_event      :  1, /* include BPF events */
 				aux_output     :  1, /* generate AUX records instead of events */
 				cgroup         :  1, /* include cgroup events */
 				text_poke      :  1, /* include text poke events */
-				build_id       :  1, /* use build id in mmap2 events */
+				build_id       :  1, /* use build ID in mmap2 events */
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
 				__reserved_1   : 26;
 
 	union {
-		__u32		wakeup_events;	  /* wakeup every n events */
+		__u32		wakeup_events;	  /* wake up every n events */
 		__u32		wakeup_watermark; /* bytes before wakeup   */
 	};
 
@@ -474,13 +475,13 @@ struct perf_event_attr {
 		__u64		bp_addr;
 		__u64		kprobe_func; /* for perf_kprobe */
 		__u64		uprobe_path; /* for perf_uprobe */
-		__u64		config1; /* extension of config */
+		__u64		config1;     /* extension of config */
 	};
 	union {
 		__u64		bp_len;
-		__u64		kprobe_addr; /* when kprobe_func == NULL */
+		__u64		kprobe_addr;  /* when kprobe_func == NULL */
 		__u64		probe_offset; /* for perf_[k,u]probe */
-		__u64		config2; /* extension of config1 */
+		__u64		config2;      /* extension of config1 */
 	};
 	__u64	branch_sample_type; /* enum perf_branch_sample_type */
 
@@ -510,7 +511,16 @@ struct perf_event_attr {
 	 * Wakeup watermark for AUX area
 	 */
 	__u32	aux_watermark;
+
+	/*
+	 * Max number of frame pointers in a callchain, should be
+	 * lower than /proc/sys/kernel/perf_event_max_stack.
+	 *
+	 * Max number of entries of branch stack should be lower
+	 * than the hardware limit.
+	 */
 	__u16	sample_max_stack;
+
 	__u16	__reserved_2;
 	__u32	aux_sample_size;
 
@@ -537,7 +547,7 @@ struct perf_event_attr {
 
 /*
  * Structure used by below PERF_EVENT_IOC_QUERY_BPF command
- * to query bpf programs attached to the same perf tracepoint
+ * to query BPF programs attached to the same perf tracepoint
  * as the given perf event.
  */
 struct perf_event_query_bpf {
@@ -559,21 +569,21 @@ struct perf_event_query_bpf {
 /*
  * Ioctls that can be done on a perf event fd:
  */
-#define PERF_EVENT_IOC_ENABLE			_IO ('$', 0)
-#define PERF_EVENT_IOC_DISABLE			_IO ('$', 1)
-#define PERF_EVENT_IOC_REFRESH			_IO ('$', 2)
-#define PERF_EVENT_IOC_RESET			_IO ('$', 3)
-#define PERF_EVENT_IOC_PERIOD			_IOW('$', 4, __u64)
-#define PERF_EVENT_IOC_SET_OUTPUT		_IO ('$', 5)
-#define PERF_EVENT_IOC_SET_FILTER		_IOW('$', 6, char *)
-#define PERF_EVENT_IOC_ID			_IOR('$', 7, __u64 *)
-#define PERF_EVENT_IOC_SET_BPF			_IOW('$', 8, __u32)
-#define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
+#define PERF_EVENT_IOC_ENABLE			_IO  ('$', 0)
+#define PERF_EVENT_IOC_DISABLE			_IO  ('$', 1)
+#define PERF_EVENT_IOC_REFRESH			_IO  ('$', 2)
+#define PERF_EVENT_IOC_RESET			_IO  ('$', 3)
+#define PERF_EVENT_IOC_PERIOD			_IOW ('$', 4, __u64)
+#define PERF_EVENT_IOC_SET_OUTPUT		_IO  ('$', 5)
+#define PERF_EVENT_IOC_SET_FILTER		_IOW ('$', 6, char *)
+#define PERF_EVENT_IOC_ID			_IOR ('$', 7, __u64 *)
+#define PERF_EVENT_IOC_SET_BPF			_IOW ('$', 8, __u32)
+#define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW ('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
-#define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW ('$', 11, struct perf_event_attr *)
 
 enum perf_event_ioc_flags {
-	PERF_IOC_FLAG_GROUP		= 1U << 0,
+	PERF_IOC_FLAG_GROUP			= 1U << 0,
 };
 
 /*
@@ -584,7 +594,7 @@ struct perf_event_mmap_page {
 	__u32	compat_version;		/* lowest version this is compat with */
 
 	/*
-	 * Bits needed to read the hw events in user-space.
+	 * Bits needed to read the HW events in user-space.
 	 *
 	 *   u32 seq, time_mult, time_shift, index, width;
 	 *   u64 count, enabled, running;
@@ -622,7 +632,7 @@ struct perf_event_mmap_page {
 	__u32	index;			/* hardware event identifier */
 	__s64	offset;			/* add to hardware event value */
 	__u64	time_enabled;		/* time event active */
-	__u64	time_running;		/* time event on cpu */
+	__u64	time_running;		/* time event on CPU */
 	union {
 		__u64	capabilities;
 		struct {
@@ -650,7 +660,7 @@ struct perf_event_mmap_page {
 
 	/*
 	 * If cap_usr_time the below fields can be used to compute the time
-	 * delta since time_enabled (in ns) using rdtsc or similar.
+	 * delta since time_enabled (in ns) using RDTSC or similar.
 	 *
 	 *   u64 quot, rem;
 	 *   u64 delta;
@@ -723,7 +733,7 @@ struct perf_event_mmap_page {
 	 * after reading this value.
 	 *
 	 * When the mapping is PROT_WRITE the @data_tail value should be
-	 * written by userspace to reflect the last read data, after issueing
+	 * written by user-space to reflect the last read data, after issuing
 	 * an smp_mb() to separate the data read from the ->data_tail store.
 	 * In this case the kernel will not over-write unread data.
 	 *
@@ -739,7 +749,7 @@ struct perf_event_mmap_page {
 
 	/*
 	 * AUX area is defined by aux_{offset,size} fields that should be set
-	 * by the userspace, so that
+	 * by the user-space, so that
 	 *
 	 *   aux_offset >= data_offset + data_size
 	 *
@@ -813,7 +823,7 @@ struct perf_event_mmap_page {
  *   Indicates that thread was preempted in TASK_RUNNING state.
  *
  * PERF_RECORD_MISC_MMAP_BUILD_ID:
- *   Indicates that mmap2 event carries build id data.
+ *   Indicates that mmap2 event carries build ID data.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
 #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
@@ -824,26 +834,26 @@ struct perf_event_mmap_page {
 #define PERF_RECORD_MISC_EXT_RESERVED		(1 << 15)
 
 struct perf_event_header {
-	__u32	type;
-	__u16	misc;
-	__u16	size;
+	__u32 type;
+	__u16 misc;
+	__u16 size;
 };
 
 struct perf_ns_link_info {
-	__u64	dev;
-	__u64	ino;
+	__u64 dev;
+	__u64 ino;
 };
 
 enum {
-	NET_NS_INDEX		= 0,
-	UTS_NS_INDEX		= 1,
-	IPC_NS_INDEX		= 2,
-	PID_NS_INDEX		= 3,
-	USER_NS_INDEX		= 4,
-	MNT_NS_INDEX		= 5,
-	CGROUP_NS_INDEX		= 6,
-
-	NR_NAMESPACES,		/* number of available namespaces */
+	NET_NS_INDEX				= 0,
+	UTS_NS_INDEX				= 1,
+	IPC_NS_INDEX				= 2,
+	PID_NS_INDEX				= 3,
+	USER_NS_INDEX				= 4,
+	MNT_NS_INDEX				= 5,
+	CGROUP_NS_INDEX				= 6,
+
+	NR_NAMESPACES, /* number of available namespaces */
 };
 
 enum perf_event_type {
@@ -859,11 +869,11 @@ enum perf_event_type {
 	 * optional fields being ignored.
 	 *
 	 * struct sample_id {
-	 * 	{ u32			pid, tid; } && PERF_SAMPLE_TID
-	 * 	{ u64			time;     } && PERF_SAMPLE_TIME
-	 * 	{ u64			id;       } && PERF_SAMPLE_ID
-	 * 	{ u64			stream_id;} && PERF_SAMPLE_STREAM_ID
-	 * 	{ u32			cpu, res; } && PERF_SAMPLE_CPU
+	 *	{ u32			pid, tid; } && PERF_SAMPLE_TID
+	 *	{ u64			time;     } && PERF_SAMPLE_TIME
+	 *	{ u64			id;       } && PERF_SAMPLE_ID
+	 *	{ u64			stream_id;} && PERF_SAMPLE_STREAM_ID
+	 *	{ u32			cpu, res; } && PERF_SAMPLE_CPU
 	 *	{ u64			id;	  } && PERF_SAMPLE_IDENTIFIER
 	 * } && perf_event_attr::sample_id_all
 	 *
@@ -874,7 +884,7 @@ enum perf_event_type {
 
 	/*
 	 * The MMAP events record the PROT_EXEC mappings so that we can
-	 * correlate userspace IPs to code. They have the following structure:
+	 * correlate user-space IPs to code. They have the following structure:
 	 *
 	 * struct {
 	 *	struct perf_event_header	header;
@@ -884,7 +894,7 @@ enum perf_event_type {
 	 *	u64				len;
 	 *	u64				pgoff;
 	 *	char				filename[];
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_MMAP			= 1,
@@ -894,7 +904,7 @@ enum perf_event_type {
 	 *	struct perf_event_header	header;
 	 *	u64				id;
 	 *	u64				lost;
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_LOST			= 2,
@@ -905,7 +915,7 @@ enum perf_event_type {
 	 *
 	 *	u32				pid, tid;
 	 *	char				comm[];
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_COMM			= 3,
@@ -916,7 +926,7 @@ enum perf_event_type {
 	 *	u32				pid, ppid;
 	 *	u32				tid, ptid;
 	 *	u64				time;
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_EXIT			= 4,
@@ -927,7 +937,7 @@ enum perf_event_type {
 	 *	u64				time;
 	 *	u64				id;
 	 *	u64				stream_id;
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_THROTTLE			= 5,
@@ -939,7 +949,7 @@ enum perf_event_type {
 	 *	u32				pid, ppid;
 	 *	u32				tid, ptid;
 	 *	u64				time;
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_FORK			= 7,
@@ -950,7 +960,7 @@ enum perf_event_type {
 	 *	u32				pid, tid;
 	 *
 	 *	struct read_format		values;
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_READ			= 8,
@@ -1005,12 +1015,12 @@ enum perf_event_type {
 	 *        { u64 counters; } cntr[nr] && PERF_SAMPLE_BRANCH_COUNTERS
 	 *      } && PERF_SAMPLE_BRANCH_STACK
 	 *
-	 * 	{ u64			abi; # enum perf_sample_regs_abi
-	 * 	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
+	 *	{ u64			abi; # enum perf_sample_regs_abi
+	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
 	 *
-	 * 	{ u64			size;
-	 * 	  char			data[size];
-	 * 	  u64			dyn_size; } && PERF_SAMPLE_STACK_USER
+	 *	{ u64			size;
+	 *	  char			data[size];
+	 *	  u64			dyn_size; } && PERF_SAMPLE_STACK_USER
 	 *
 	 *	{ union perf_sample_weight
 	 *	 {
@@ -1071,7 +1081,7 @@ enum perf_event_type {
 	 *	};
 	 *	u32				prot, flags;
 	 *	char				filename[];
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_MMAP2			= 10,
@@ -1080,12 +1090,12 @@ enum perf_event_type {
 	 * Records that new data landed in the AUX buffer part.
 	 *
 	 * struct {
-	 * 	struct perf_event_header	header;
+	 *	struct perf_event_header	header;
 	 *
-	 * 	u64				aux_offset;
-	 * 	u64				aux_size;
+	 *	u64				aux_offset;
+	 *	u64				aux_size;
 	 *	u64				flags;
-	 * 	struct sample_id		sample_id;
+	 *	struct sample_id		sample_id;
 	 * };
 	 */
 	PERF_RECORD_AUX				= 11,
@@ -1168,7 +1178,7 @@ enum perf_event_type {
 	PERF_RECORD_KSYMBOL			= 17,
 
 	/*
-	 * Record bpf events:
+	 * Record BPF events:
 	 *  enum perf_bpf_event_type {
 	 *	PERF_BPF_EVENT_UNKNOWN		= 0,
 	 *	PERF_BPF_EVENT_PROG_LOAD	= 1,
@@ -1246,181 +1256,181 @@ enum perf_record_ksymbol_type {
 #define PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER	(1 << 0)
 
 enum perf_bpf_event_type {
-	PERF_BPF_EVENT_UNKNOWN		= 0,
-	PERF_BPF_EVENT_PROG_LOAD	= 1,
-	PERF_BPF_EVENT_PROG_UNLOAD	= 2,
-	PERF_BPF_EVENT_MAX,		/* non-ABI */
+	PERF_BPF_EVENT_UNKNOWN			= 0,
+	PERF_BPF_EVENT_PROG_LOAD		= 1,
+	PERF_BPF_EVENT_PROG_UNLOAD		= 2,
+	PERF_BPF_EVENT_MAX,			/* non-ABI */
 };
 
-#define PERF_MAX_STACK_DEPTH		127
-#define PERF_MAX_CONTEXTS_PER_STACK	  8
+#define PERF_MAX_STACK_DEPTH			127
+#define PERF_MAX_CONTEXTS_PER_STACK		  8
 
 enum perf_callchain_context {
-	PERF_CONTEXT_HV			= (__u64)-32,
-	PERF_CONTEXT_KERNEL		= (__u64)-128,
-	PERF_CONTEXT_USER		= (__u64)-512,
+	PERF_CONTEXT_HV				= (__u64)-32,
+	PERF_CONTEXT_KERNEL			= (__u64)-128,
+	PERF_CONTEXT_USER			= (__u64)-512,
 
-	PERF_CONTEXT_GUEST		= (__u64)-2048,
-	PERF_CONTEXT_GUEST_KERNEL	= (__u64)-2176,
-	PERF_CONTEXT_GUEST_USER		= (__u64)-2560,
+	PERF_CONTEXT_GUEST			= (__u64)-2048,
+	PERF_CONTEXT_GUEST_KERNEL		= (__u64)-2176,
+	PERF_CONTEXT_GUEST_USER			= (__u64)-2560,
 
-	PERF_CONTEXT_MAX		= (__u64)-4095,
+	PERF_CONTEXT_MAX			= (__u64)-4095,
 };
 
 /**
  * PERF_RECORD_AUX::flags bits
  */
-#define PERF_AUX_FLAG_TRUNCATED			0x01	/* record was truncated to fit */
-#define PERF_AUX_FLAG_OVERWRITE			0x02	/* snapshot from overwrite mode */
-#define PERF_AUX_FLAG_PARTIAL			0x04	/* record contains gaps */
-#define PERF_AUX_FLAG_COLLISION			0x08	/* sample collided with another */
+#define PERF_AUX_FLAG_TRUNCATED			0x0001	/* Record was truncated to fit */
+#define PERF_AUX_FLAG_OVERWRITE			0x0002	/* Snapshot from overwrite mode */
+#define PERF_AUX_FLAG_PARTIAL			0x0004	/* Record contains gaps */
+#define PERF_AUX_FLAG_COLLISION			0x0008	/* Sample collided with another */
 #define PERF_AUX_FLAG_PMU_FORMAT_TYPE_MASK	0xff00	/* PMU specific trace format type */
 
 /* CoreSight PMU AUX buffer formats */
-#define PERF_AUX_FLAG_CORESIGHT_FORMAT_CORESIGHT	0x0000 /* Default for backward compatibility */
-#define PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW		0x0100 /* Raw format of the source */
+#define PERF_AUX_FLAG_CORESIGHT_FORMAT_CORESIGHT 0x0000 /* Default for backward compatibility */
+#define PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW	 0x0100 /* Raw format of the source */
 
-#define PERF_FLAG_FD_NO_GROUP		(1UL << 0)
-#define PERF_FLAG_FD_OUTPUT		(1UL << 1)
-#define PERF_FLAG_PID_CGROUP		(1UL << 2) /* pid=cgroup id, per-cpu mode only */
-#define PERF_FLAG_FD_CLOEXEC		(1UL << 3) /* O_CLOEXEC */
+#define PERF_FLAG_FD_NO_GROUP			(1UL << 0)
+#define PERF_FLAG_FD_OUTPUT			(1UL << 1)
+#define PERF_FLAG_PID_CGROUP			(1UL << 2) /* pid=cgroup ID, per-CPU mode only */
+#define PERF_FLAG_FD_CLOEXEC			(1UL << 3) /* O_CLOEXEC */
 
 #if defined(__LITTLE_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64   mem_op:5,	/* type of opcode */
-			mem_lvl:14,	/* memory hierarchy level */
-			mem_snoop:5,	/* snoop mode */
-			mem_lock:2,	/* lock instr */
-			mem_dtlb:7,	/* tlb access */
-			mem_lvl_num:4,	/* memory hierarchy level number */
-			mem_remote:1,   /* remote */
-			mem_snoopx:2,	/* snoop mode, ext */
-			mem_blk:3,	/* access blocked */
-			mem_hops:3,	/* hop level */
-			mem_rsvd:18;
+		__u64   mem_op      :  5, /* Type of opcode */
+			mem_lvl     : 14, /* Memory hierarchy level */
+			mem_snoop   :  5, /* Snoop mode */
+			mem_lock    :  2, /* Lock instr */
+			mem_dtlb    :  7, /* TLB access */
+			mem_lvl_num :  4, /* Memory hierarchy level number */
+			mem_remote  :  1, /* Remote */
+			mem_snoopx  :  2, /* Snoop mode, ext */
+			mem_blk     :  3, /* Access blocked */
+			mem_hops    :  3, /* Hop level */
+			mem_rsvd    : 18;
 	};
 };
 #elif defined(__BIG_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64	mem_rsvd:18,
-			mem_hops:3,	/* hop level */
-			mem_blk:3,	/* access blocked */
-			mem_snoopx:2,	/* snoop mode, ext */
-			mem_remote:1,   /* remote */
-			mem_lvl_num:4,	/* memory hierarchy level number */
-			mem_dtlb:7,	/* tlb access */
-			mem_lock:2,	/* lock instr */
-			mem_snoop:5,	/* snoop mode */
-			mem_lvl:14,	/* memory hierarchy level */
-			mem_op:5;	/* type of opcode */
+		__u64	mem_rsvd    : 18,
+			mem_hops    :  3, /* Hop level */
+			mem_blk     :  3, /* Access blocked */
+			mem_snoopx  :  2, /* Snoop mode, ext */
+			mem_remote  :  1, /* Remote */
+			mem_lvl_num :  4, /* Memory hierarchy level number */
+			mem_dtlb    :  7, /* TLB access */
+			mem_lock    :  2, /* Lock instr */
+			mem_snoop   :  5, /* Snoop mode */
+			mem_lvl     : 14, /* Memory hierarchy level */
+			mem_op      :  5; /* Type of opcode */
 	};
 };
 #else
-#error "Unknown endianness"
+# error "Unknown endianness"
 #endif
 
-/* type of opcode (load/store/prefetch,code) */
-#define PERF_MEM_OP_NA		0x01 /* not available */
-#define PERF_MEM_OP_LOAD	0x02 /* load instruction */
-#define PERF_MEM_OP_STORE	0x04 /* store instruction */
-#define PERF_MEM_OP_PFETCH	0x08 /* prefetch */
-#define PERF_MEM_OP_EXEC	0x10 /* code (execution) */
-#define PERF_MEM_OP_SHIFT	0
+/* Type of memory opcode: */
+#define PERF_MEM_OP_NA				0x0001 /* Not available */
+#define PERF_MEM_OP_LOAD			0x0002 /* Load instruction */
+#define PERF_MEM_OP_STORE			0x0004 /* Store instruction */
+#define PERF_MEM_OP_PFETCH			0x0008 /* Prefetch */
+#define PERF_MEM_OP_EXEC			0x0010 /* Code (execution) */
+#define PERF_MEM_OP_SHIFT			0
 
 /*
- * PERF_MEM_LVL_* namespace being depricated to some extent in the
+ * The PERF_MEM_LVL_* namespace is being deprecated to some extent in
  * favour of newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_} fields.
- * Supporting this namespace inorder to not break defined ABIs.
+ * We support this namespace in order to not break defined ABIs.
  *
- * memory hierarchy (memory level, hit or miss)
+ * Memory hierarchy (memory level, hit or miss)
  */
-#define PERF_MEM_LVL_NA		0x01  /* not available */
-#define PERF_MEM_LVL_HIT	0x02  /* hit level */
-#define PERF_MEM_LVL_MISS	0x04  /* miss level  */
-#define PERF_MEM_LVL_L1		0x08  /* L1 */
-#define PERF_MEM_LVL_LFB	0x10  /* Line Fill Buffer */
-#define PERF_MEM_LVL_L2		0x20  /* L2 */
-#define PERF_MEM_LVL_L3		0x40  /* L3 */
-#define PERF_MEM_LVL_LOC_RAM	0x80  /* Local DRAM */
-#define PERF_MEM_LVL_REM_RAM1	0x100 /* Remote DRAM (1 hop) */
-#define PERF_MEM_LVL_REM_RAM2	0x200 /* Remote DRAM (2 hops) */
-#define PERF_MEM_LVL_REM_CCE1	0x400 /* Remote Cache (1 hop) */
-#define PERF_MEM_LVL_REM_CCE2	0x800 /* Remote Cache (2 hops) */
-#define PERF_MEM_LVL_IO		0x1000 /* I/O memory */
-#define PERF_MEM_LVL_UNC	0x2000 /* Uncached memory */
-#define PERF_MEM_LVL_SHIFT	5
-
-#define PERF_MEM_REMOTE_REMOTE	0x01  /* Remote */
-#define PERF_MEM_REMOTE_SHIFT	37
-
-#define PERF_MEM_LVLNUM_L1	0x01 /* L1 */
-#define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
-#define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
-#define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-#define PERF_MEM_LVLNUM_L2_MHB	0x05 /* L2 Miss Handling Buffer */
-#define PERF_MEM_LVLNUM_MSC	0x06 /* Memory-side Cache */
-/* 0x7 available */
-#define PERF_MEM_LVLNUM_UNC	0x08 /* Uncached */
-#define PERF_MEM_LVLNUM_CXL	0x09 /* CXL */
-#define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
-#define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
-#define PERF_MEM_LVLNUM_LFB	0x0c /* LFB / L1 Miss Handling Buffer */
-#define PERF_MEM_LVLNUM_RAM	0x0d /* RAM */
-#define PERF_MEM_LVLNUM_PMEM	0x0e /* PMEM */
-#define PERF_MEM_LVLNUM_NA	0x0f /* N/A */
-
-#define PERF_MEM_LVLNUM_SHIFT	33
-
-/* snoop mode */
-#define PERF_MEM_SNOOP_NA	0x01 /* not available */
-#define PERF_MEM_SNOOP_NONE	0x02 /* no snoop */
-#define PERF_MEM_SNOOP_HIT	0x04 /* snoop hit */
-#define PERF_MEM_SNOOP_MISS	0x08 /* snoop miss */
-#define PERF_MEM_SNOOP_HITM	0x10 /* snoop hit modified */
-#define PERF_MEM_SNOOP_SHIFT	19
-
-#define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
-#define PERF_MEM_SNOOPX_PEER	0x02 /* xfer from peer */
-#define PERF_MEM_SNOOPX_SHIFT  38
-
-/* locked instruction */
-#define PERF_MEM_LOCK_NA	0x01 /* not available */
-#define PERF_MEM_LOCK_LOCKED	0x02 /* locked transaction */
-#define PERF_MEM_LOCK_SHIFT	24
+#define PERF_MEM_LVL_NA				0x0001 /* Not available */
+#define PERF_MEM_LVL_HIT			0x0002 /* Hit level */
+#define PERF_MEM_LVL_MISS			0x0004 /* Miss level  */
+#define PERF_MEM_LVL_L1				0x0008 /* L1 */
+#define PERF_MEM_LVL_LFB			0x0010 /* Line Fill Buffer */
+#define PERF_MEM_LVL_L2				0x0020 /* L2 */
+#define PERF_MEM_LVL_L3				0x0040 /* L3 */
+#define PERF_MEM_LVL_LOC_RAM			0x0080 /* Local DRAM */
+#define PERF_MEM_LVL_REM_RAM1			0x0100 /* Remote DRAM (1 hop) */
+#define PERF_MEM_LVL_REM_RAM2			0x0200 /* Remote DRAM (2 hops) */
+#define PERF_MEM_LVL_REM_CCE1			0x0400 /* Remote Cache (1 hop) */
+#define PERF_MEM_LVL_REM_CCE2			0x0800 /* Remote Cache (2 hops) */
+#define PERF_MEM_LVL_IO				0x1000 /* I/O memory */
+#define PERF_MEM_LVL_UNC			0x2000 /* Uncached memory */
+#define PERF_MEM_LVL_SHIFT			5
+
+#define PERF_MEM_REMOTE_REMOTE			0x0001 /* Remote */
+#define PERF_MEM_REMOTE_SHIFT			37
+
+#define PERF_MEM_LVLNUM_L1			0x0001 /* L1 */
+#define PERF_MEM_LVLNUM_L2			0x0002 /* L2 */
+#define PERF_MEM_LVLNUM_L3			0x0003 /* L3 */
+#define PERF_MEM_LVLNUM_L4			0x0004 /* L4 */
+#define PERF_MEM_LVLNUM_L2_MHB			0x0005 /* L2 Miss Handling Buffer */
+#define PERF_MEM_LVLNUM_MSC			0x0006 /* Memory-side Cache */
+/* 0x007 available */
+#define PERF_MEM_LVLNUM_UNC			0x0008 /* Uncached */
+#define PERF_MEM_LVLNUM_CXL			0x0009 /* CXL */
+#define PERF_MEM_LVLNUM_IO			0x000a /* I/O */
+#define PERF_MEM_LVLNUM_ANY_CACHE		0x000b /* Any cache */
+#define PERF_MEM_LVLNUM_LFB			0x000c /* LFB / L1 Miss Handling Buffer */
+#define PERF_MEM_LVLNUM_RAM			0x000d /* RAM */
+#define PERF_MEM_LVLNUM_PMEM			0x000e /* PMEM */
+#define PERF_MEM_LVLNUM_NA			0x000f /* N/A */
+
+#define PERF_MEM_LVLNUM_SHIFT			33
+
+/* Snoop mode */
+#define PERF_MEM_SNOOP_NA			0x0001 /* Not available */
+#define PERF_MEM_SNOOP_NONE			0x0002 /* No snoop */
+#define PERF_MEM_SNOOP_HIT			0x0004 /* Snoop hit */
+#define PERF_MEM_SNOOP_MISS			0x0008 /* Snoop miss */
+#define PERF_MEM_SNOOP_HITM			0x0010 /* Snoop hit modified */
+#define PERF_MEM_SNOOP_SHIFT			19
+
+#define PERF_MEM_SNOOPX_FWD			0x0001 /* Forward */
+#define PERF_MEM_SNOOPX_PEER			0x0002 /* Transfer from peer */
+#define PERF_MEM_SNOOPX_SHIFT			38
+
+/* Locked instruction */
+#define PERF_MEM_LOCK_NA			0x0001 /* Not available */
+#define PERF_MEM_LOCK_LOCKED			0x0002 /* Locked transaction */
+#define PERF_MEM_LOCK_SHIFT			24
 
 /* TLB access */
-#define PERF_MEM_TLB_NA		0x01 /* not available */
-#define PERF_MEM_TLB_HIT	0x02 /* hit level */
-#define PERF_MEM_TLB_MISS	0x04 /* miss level */
-#define PERF_MEM_TLB_L1		0x08 /* L1 */
-#define PERF_MEM_TLB_L2		0x10 /* L2 */
-#define PERF_MEM_TLB_WK		0x20 /* Hardware Walker*/
-#define PERF_MEM_TLB_OS		0x40 /* OS fault handler */
-#define PERF_MEM_TLB_SHIFT	26
+#define PERF_MEM_TLB_NA				0x0001 /* Not available */
+#define PERF_MEM_TLB_HIT			0x0002 /* Hit level */
+#define PERF_MEM_TLB_MISS			0x0004 /* Miss level */
+#define PERF_MEM_TLB_L1				0x0008 /* L1 */
+#define PERF_MEM_TLB_L2				0x0010 /* L2 */
+#define PERF_MEM_TLB_WK				0x0020 /* Hardware Walker*/
+#define PERF_MEM_TLB_OS				0x0040 /* OS fault handler */
+#define PERF_MEM_TLB_SHIFT			26
 
 /* Access blocked */
-#define PERF_MEM_BLK_NA		0x01 /* not available */
-#define PERF_MEM_BLK_DATA	0x02 /* data could not be forwarded */
-#define PERF_MEM_BLK_ADDR	0x04 /* address conflict */
-#define PERF_MEM_BLK_SHIFT	40
-
-/* hop level */
-#define PERF_MEM_HOPS_0		0x01 /* remote core, same node */
-#define PERF_MEM_HOPS_1		0x02 /* remote node, same socket */
-#define PERF_MEM_HOPS_2		0x03 /* remote socket, same board */
-#define PERF_MEM_HOPS_3		0x04 /* remote board */
+#define PERF_MEM_BLK_NA				0x0001 /* Not available */
+#define PERF_MEM_BLK_DATA			0x0002 /* Data could not be forwarded */
+#define PERF_MEM_BLK_ADDR			0x0004 /* Address conflict */
+#define PERF_MEM_BLK_SHIFT			40
+
+/* Hop level */
+#define PERF_MEM_HOPS_0				0x0001 /* Remote core, same node */
+#define PERF_MEM_HOPS_1				0x0002 /* Remote node, same socket */
+#define PERF_MEM_HOPS_2				0x0003 /* Remote socket, same board */
+#define PERF_MEM_HOPS_3				0x0004 /* Remote board */
 /* 5-7 available */
-#define PERF_MEM_HOPS_SHIFT	43
+#define PERF_MEM_HOPS_SHIFT			43
 
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
 
 /*
- * single taken branch record layout:
+ * Layout of single taken branch records:
  *
  *      from: source instruction (may not always be a branch insn)
  *        to: branch target
@@ -1439,37 +1449,37 @@ union perf_mem_data_src {
 struct perf_branch_entry {
 	__u64	from;
 	__u64	to;
-	__u64	mispred:1,  /* target mispredicted */
-		predicted:1,/* target predicted */
-		in_tx:1,    /* in transaction */
-		abort:1,    /* transaction abort */
-		cycles:16,  /* cycle count to last branch */
-		type:4,     /* branch type */
-		spec:2,     /* branch speculation info */
-		new_type:4, /* additional branch type */
-		priv:3,     /* privilege level */
-		reserved:31;
+	__u64	mispred   :  1, /* target mispredicted */
+		predicted :  1, /* target predicted */
+		in_tx     :  1, /* in transaction */
+		abort     :  1, /* transaction abort */
+		cycles    : 16, /* cycle count to last branch */
+		type      :  4, /* branch type */
+		spec      :  2, /* branch speculation info */
+		new_type  :  4, /* additional branch type */
+		priv      :  3, /* privilege level */
+		reserved  : 31;
 };
 
 /* Size of used info bits in struct perf_branch_entry */
 #define PERF_BRANCH_ENTRY_INFO_BITS_MAX		33
 
 union perf_sample_weight {
-	__u64		full;
+	__u64	      full;
 #if defined(__LITTLE_ENDIAN_BITFIELD)
 	struct {
-		__u32	var1_dw;
-		__u16	var2_w;
-		__u16	var3_w;
+		__u32 var1_dw;
+		__u16 var2_w;
+		__u16 var3_w;
 	};
 #elif defined(__BIG_ENDIAN_BITFIELD)
 	struct {
-		__u16	var3_w;
-		__u16	var2_w;
-		__u32	var1_dw;
+		__u16 var3_w;
+		__u16 var2_w;
+		__u32 var1_dw;
 	};
 #else
-#error "Unknown endianness"
+# error "Unknown endianness"
 #endif
 };
 

