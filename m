Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB57027BE7D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 09:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgI2H4u (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 03:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgI2H4t (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 03:56:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0200C061755;
        Tue, 29 Sep 2020 00:56:49 -0700 (PDT)
Date:   Tue, 29 Sep 2020 07:56:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601366208;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MwHuM/OfA85mdm7AHDV3LY9Fuvfz3QI9Xq9JUS2lWo=;
        b=Z02CJ88yYpmF1ZnJVfQfvoJtVzTkuf3TYahGuNj1V5P+MlR4dWcYoPAXgZ9vMXSvs47Ejy
        H5ZBrEfN8Pkc4A9ltrCjV6v9096hjR+sOj7nLLMtfpva8WIsMTOxIY1iXEhV/Tts+/Bpt0
        XcMoeIXnKo5WGwk0+B42FUVU0sRNnYhm4eq2Agmdn3hYopAFHbAR5wB03bgmKtU4FhPBTo
        j0tGuXNhCgKd3ErOgnKg+Ev9Ztp5XMl/JjY+aCZLFq9OkI/k0SF+5OqBwYFL62VE30k6ue
        3XmRfXjnf2c+57FNkF6LCJ4Mf1+TXHFO3RgUfwgNFhEZUajFcxOoclBj6KglTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601366208;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MwHuM/OfA85mdm7AHDV3LY9Fuvfz3QI9Xq9JUS2lWo=;
        b=Hefj1kSiO4aSigoP5C3ndz2LuvANXFBQ3uYEPqa6o6iutUkiS5MRqYwVbyEkkzRnJ5liq+
        /UdPG7vl3120bhDQ==
From:   "tip-bot2 for Peter Oskolkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq/selftests,x86_64: Add rseq_offset_deref_addv()
Cc:     Peter Oskolkov <posk@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200923233618.2572849-2-posk@google.com>
References: <20200923233618.2572849-2-posk@google.com>
MIME-Version: 1.0
Message-ID: <160136620722.7002.13060020083012690160.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ea366dd79c05fcd4cf5e225d2de8a3a7c293160c
Gitweb:        https://git.kernel.org/tip/ea366dd79c05fcd4cf5e225d2de8a3a7c293160c
Author:        Peter Oskolkov <posk@google.com>
AuthorDate:    Wed, 23 Sep 2020 16:36:17 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Sep 2020 14:23:27 +02:00

rseq/selftests,x86_64: Add rseq_offset_deref_addv()

This patch adds rseq_offset_deref_addv() function to
tools/testing/selftests/rseq/rseq-x86.h, to be used in a selftest in
the next patch in the patchset.

Once an architecture adds support for this function they should define
"RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV".

Signed-off-by: Peter Oskolkov <posk@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lkml.kernel.org/r/20200923233618.2572849-2-posk@google.com
---
 tools/testing/selftests/rseq/rseq-x86.h | 57 ++++++++++++++++++++++++-
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index b2da600..6404115 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -279,6 +279,63 @@ error1:
 #endif
 }
 
+#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+
+/*
+ *   pval = *(ptr+off)
+ *  *pval += inc;
+ */
+static inline __attribute__((always_inline))
+int rseq_offset_deref_addv(intptr_t *ptr, off_t off, intptr_t inc, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
+#endif
+		/* get p+v */
+		"movq %[ptr], %%rbx\n\t"
+		"addq %[off], %%rbx\n\t"
+		/* get pv */
+		"movq (%%rbx), %%rcx\n\t"
+		/* *pv += inc */
+		"addq %[inc], (%%rcx)\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_abi]		"r" (&__rseq_abi),
+		  /* final store input */
+		  [ptr]			"m" (*ptr),
+		  [off]			"er" (off),
+		  [inc]			"er" (inc)
+		: "memory", "cc", "rax", "rbx", "rcx"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
 static inline __attribute__((always_inline))
 int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 				 intptr_t *v2, intptr_t newv2,
