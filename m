Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CDD4A8682
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Feb 2022 15:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351407AbiBCOeR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Feb 2022 09:34:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351358AbiBCOdy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:54 -0500
Date:   Thu, 03 Feb 2022 14:33:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mvPSJsmjezbBY/GB4FLxwhER5gD00cgd98CwiqFPXQ4=;
        b=i7SQoXR6f56aPhy2x8ORj3dcMBYJOl/G3R6dSDgo+sH3td4hpqaKTNpD77PVn6nqDOnEey
        xaGVotUAz6GJMJdVYr/LsFpKWVO35dVivhQRVXBzIIf+v0yahefjS6vOhnfXGkrp/ymFlz
        +fs5zym8/kBbhSkCz3Vjdb24W/xqzh86blgap/iMx+zzotADJqVbFMa7kZRJXOgs0Xl30a
        wWdbyyhWhYvXeybBaabtgAA/SPe2AeNe0/mGlDpAOvE40jjJ0RloOFfctv9v+/e+N2hY3K
        YSf3txrtoY+Az/M8eW74GUyQa2e3Fnud41jJD0J0wvNSXcqWV4lMlvRcaylfwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mvPSJsmjezbBY/GB4FLxwhER5gD00cgd98CwiqFPXQ4=;
        b=FnEA02wx/j1vsOoUD2BR2+x1hdvgxVIg30JhE+z/PTXL0JgwOQA0S/KM5QeG1mQTrrAlsb
        VzmzetBcHj4YfuCg==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: introduce own copy of rseq uapi header
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220124171253.22072-2-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <164389883255.16921.17243853997352277789.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5c105d55a9dc9e01535116ccfc26e703168a574f
Gitweb:        https://git.kernel.org/tip/5c105d55a9dc9e01535116ccfc26e703168a574f
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Mon, 24 Jan 2022 12:12:39 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:33 +01:00

selftests/rseq: introduce own copy of rseq uapi header

The Linux kernel rseq uapi header has a broken layout for the
rseq_cs.ptr field on 32-bit little endian architectures. The entire
rseq_cs.ptr field is planned for removal, leaving only the 64-bit
rseq_cs.ptr64 field available.

Both glibc and librseq use their own copy of the Linux kernel uapi
header, where they introduce proper union fields to access to the 32-bit
low order bits of the rseq_cs pointer on 32-bit architectures.

Introduce a copy of the Linux kernel uapi headers in the Linux kernel
selftests.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220124171253.22072-2-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/rseq-abi.h | 151 +++++++++++++++++++++++-
 tools/testing/selftests/rseq/rseq.c     |  14 +-
 tools/testing/selftests/rseq/rseq.h     |  10 +--
 3 files changed, 161 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-abi.h

diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
new file mode 100644
index 0000000..a8c44d9
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _RSEQ_ABI_H
+#define _RSEQ_ABI_H
+
+/*
+ * rseq-abi.h
+ *
+ * Restartable sequences system call API
+ *
+ * Copyright (c) 2015-2022 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+enum rseq_abi_cpu_id_state {
+	RSEQ_ABI_CPU_ID_UNINITIALIZED			= -1,
+	RSEQ_ABI_CPU_ID_REGISTRATION_FAILED		= -2,
+};
+
+enum rseq_abi_flags {
+	RSEQ_ABI_FLAG_UNREGISTER = (1 << 0),
+};
+
+enum rseq_abi_cs_flags_bit {
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
+};
+
+enum rseq_abi_cs_flags {
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_PREEMPT	=
+		(1U << RSEQ_ABI_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT),
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_SIGNAL	=
+		(1U << RSEQ_ABI_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE	=
+		(1U << RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
+};
+
+/*
+ * struct rseq_abi_cs is aligned on 4 * 8 bytes to ensure it is always
+ * contained within a single cache-line. It is usually declared as
+ * link-time constant data.
+ */
+struct rseq_abi_cs {
+	/* Version of this structure. */
+	__u32 version;
+	/* enum rseq_abi_cs_flags */
+	__u32 flags;
+	__u64 start_ip;
+	/* Offset from start_ip. */
+	__u64 post_commit_offset;
+	__u64 abort_ip;
+} __attribute__((aligned(4 * sizeof(__u64))));
+
+/*
+ * struct rseq_abi is aligned on 4 * 8 bytes to ensure it is always
+ * contained within a single cache-line.
+ *
+ * A single struct rseq_abi per thread is allowed.
+ */
+struct rseq_abi {
+	/*
+	 * Restartable sequences cpu_id_start field. Updated by the
+	 * kernel. Read by user-space with single-copy atomicity
+	 * semantics. This field should only be read by the thread which
+	 * registered this data structure. Aligned on 32-bit. Always
+	 * contains a value in the range of possible CPUs, although the
+	 * value may not be the actual current CPU (e.g. if rseq is not
+	 * initialized). This CPU number value should always be compared
+	 * against the value of the cpu_id field before performing a rseq
+	 * commit or returning a value read from a data structure indexed
+	 * using the cpu_id_start value.
+	 */
+	__u32 cpu_id_start;
+	/*
+	 * Restartable sequences cpu_id field. Updated by the kernel.
+	 * Read by user-space with single-copy atomicity semantics. This
+	 * field should only be read by the thread which registered this
+	 * data structure. Aligned on 32-bit. Values
+	 * RSEQ_CPU_ID_UNINITIALIZED and RSEQ_CPU_ID_REGISTRATION_FAILED
+	 * have a special semantic: the former means "rseq uninitialized",
+	 * and latter means "rseq initialization failed". This value is
+	 * meant to be read within rseq critical sections and compared
+	 * with the cpu_id_start value previously read, before performing
+	 * the commit instruction, or read and compared with the
+	 * cpu_id_start value before returning a value loaded from a data
+	 * structure indexed using the cpu_id_start value.
+	 */
+	__u32 cpu_id;
+	/*
+	 * Restartable sequences rseq_cs field.
+	 *
+	 * Contains NULL when no critical section is active for the current
+	 * thread, or holds a pointer to the currently active struct rseq_cs.
+	 *
+	 * Updated by user-space, which sets the address of the currently
+	 * active rseq_cs at the beginning of assembly instruction sequence
+	 * block, and set to NULL by the kernel when it restarts an assembly
+	 * instruction sequence block, as well as when the kernel detects that
+	 * it is preempting or delivering a signal outside of the range
+	 * targeted by the rseq_cs. Also needs to be set to NULL by user-space
+	 * before reclaiming memory that contains the targeted struct rseq_cs.
+	 *
+	 * Read and set by the kernel. Set by user-space with single-copy
+	 * atomicity semantics. This field should only be updated by the
+	 * thread which registered this data structure. Aligned on 64-bit.
+	 */
+	union {
+		__u64 ptr64;
+
+		/*
+		 * The "arch" field provides architecture accessor for
+		 * the ptr field based on architecture pointer size and
+		 * endianness.
+		 */
+		struct {
+#ifdef __LP64__
+			__u64 ptr;
+#elif defined(__BYTE_ORDER) ? (__BYTE_ORDER == __BIG_ENDIAN) : defined(__BIG_ENDIAN)
+			__u32 padding;		/* Initialized to zero. */
+			__u32 ptr;
+#else
+			__u32 ptr;
+			__u32 padding;		/* Initialized to zero. */
+#endif
+		} arch;
+	} rseq_cs;
+
+	/*
+	 * Restartable sequences flags field.
+	 *
+	 * This field should only be updated by the thread which
+	 * registered this data structure. Read by the kernel.
+	 * Mainly used for single-stepping through rseq critical sections
+	 * with debuggers.
+	 *
+	 * - RSEQ_ABI_CS_FLAG_NO_RESTART_ON_PREEMPT
+	 *     Inhibit instruction sequence block restart on preemption
+	 *     for this thread.
+	 * - RSEQ_ABI_CS_FLAG_NO_RESTART_ON_SIGNAL
+	 *     Inhibit instruction sequence block restart on signal
+	 *     delivery for this thread.
+	 * - RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE
+	 *     Inhibit instruction sequence block restart on migration for
+	 *     this thread.
+	 */
+	__u32 flags;
+} __attribute__((aligned(4 * sizeof(__u64))));
+
+#endif /* _RSEQ_ABI_H */
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index fb440df..bfe1b26 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -30,8 +30,8 @@
 #include "../kselftest.h"
 #include "rseq.h"
 
-__thread volatile struct rseq __rseq_abi = {
-	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
+__thread volatile struct rseq_abi __rseq_abi = {
+	.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
 };
 
 /*
@@ -66,7 +66,7 @@ static void signal_restore(sigset_t oldset)
 		abort();
 }
 
-static int sys_rseq(volatile struct rseq *rseq_abi, uint32_t rseq_len,
+static int sys_rseq(volatile struct rseq_abi *rseq_abi, uint32_t rseq_len,
 		    int flags, uint32_t sig)
 {
 	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
@@ -86,13 +86,13 @@ int rseq_register_current_thread(void)
 	}
 	if (__rseq_refcount++)
 		goto end;
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq), 0, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi), 0, RSEQ_SIG);
 	if (!rc) {
 		assert(rseq_current_cpu_raw() >= 0);
 		goto end;
 	}
 	if (errno != EBUSY)
-		__rseq_abi.cpu_id = RSEQ_CPU_ID_REGISTRATION_FAILED;
+		__rseq_abi.cpu_id = RSEQ_ABI_CPU_ID_REGISTRATION_FAILED;
 	ret = -1;
 	__rseq_refcount--;
 end:
@@ -114,8 +114,8 @@ int rseq_unregister_current_thread(void)
 	}
 	if (--__rseq_refcount)
 		goto end;
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq),
-		      RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi),
+		      RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
 	if (!rc)
 		goto end;
 	__rseq_refcount = 1;
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 3f63eb3..cb6bbc5 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -16,7 +16,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <linux/rseq.h>
+#include "rseq-abi.h"
 
 /*
  * Empty code injection macros, override when testing.
@@ -43,7 +43,7 @@
 #define RSEQ_INJECT_FAILED
 #endif
 
-extern __thread volatile struct rseq __rseq_abi;
+extern __thread volatile struct rseq_abi __rseq_abi;
 extern int __rseq_handled;
 
 #define rseq_likely(x)		__builtin_expect(!!(x), 1)
@@ -139,11 +139,7 @@ static inline uint32_t rseq_current_cpu(void)
 
 static inline void rseq_clear_rseq_cs(void)
 {
-#ifdef __LP64__
-	__rseq_abi.rseq_cs.ptr = 0;
-#else
-	__rseq_abi.rseq_cs.ptr.ptr32 = 0;
-#endif
+	__rseq_abi.rseq_cs.arch.ptr = 0;
 }
 
 /*
