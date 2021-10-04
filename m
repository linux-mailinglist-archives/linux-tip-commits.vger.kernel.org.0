Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673CB4208AC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Oct 2021 11:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhJDJug (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 4 Oct 2021 05:50:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43100 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbhJDJuf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 4 Oct 2021 05:50:35 -0400
Date:   Mon, 04 Oct 2021 09:48:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633340925;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q2VEavoVmxJT6/qNHY0cCEWJCj7ekzYqm9XY6Xk9h54=;
        b=W4yQM3biE3DUQ3YN25HxHI1HqhoS1nQx5SnmSzihIC+4ISP+nFmboFibkNWzNZpSVqcUFq
        NpdCItGV3MOkreNadJvRqEIr3Uo3GicvboDeb/REv8mfdC3Kn9dxr0b6itZ+AZ+VMrQCtT
        DocaqjdEuOiO8wCU/mtdCV05BZAzLOf3JhSDaFcDOgg51uz4gXrVxjXrsrNDpBWb19XaIX
        qpbnMnE/MZlzxXk4+stZCkizrAMmKXWar/ecY75iVYquATldru/3Waogs3FdAX1NlERaMm
        wC1pberpOWPwKUXbV23vzTewgyd8qPkXfCUfUUEnMWT8qKm0lWs3foI+xmmPmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633340925;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q2VEavoVmxJT6/qNHY0cCEWJCj7ekzYqm9XY6Xk9h54=;
        b=iqa2kNXFWm8yImZm/xQLZOO6ww8UelC/2Yj+qUkhDCMWI+S4+WtV5ES2qTETtunUEsz+kf
        bV3d8MSw0sB62yDQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/insn: Use get_unaligned() instead of memcpy()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YVSsIkj9Z29TyUjE@zn.tnic>
References: <YVSsIkj9Z29TyUjE@zn.tnic>
MIME-Version: 1.0
Message-ID: <163334092477.25758.5874478380909816941.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     a1be25a30cf654b3314bc7b26db5e52716833144
Gitweb:        https://git.kernel.org/tip/a1be25a30cf654b3314bc7b26db5e52716833144
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 29 Sep 2021 16:37:53 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Oct 2021 11:11:58 +02:00

x86/insn: Use get_unaligned() instead of memcpy()

Use get_unaligned() instead of memcpy() to access potentially unaligned
memory, which, when accessed through a pointer, leads to undefined
behavior. get_unaligned() describes much better what is happening there
anyway even if memcpy() does the job.

No functional changes.

Fixes: 5ba1071f7554 ("x86/insn, tools/x86: Fix undefined behavior due to potential unaligned accesses")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/YVSsIkj9Z29TyUjE@zn.tnic
---
 arch/x86/lib/insn.c                   |  5 +++--
 tools/arch/x86/lib/insn.c             |  5 +++--
 tools/include/asm-generic/unaligned.h | 23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+), 4 deletions(-)
 create mode 100644 tools/include/asm-generic/unaligned.h

diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index c565def..55e371c 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -13,6 +13,7 @@
 #endif
 #include <asm/inat.h> /*__ignore_sync_check__ */
 #include <asm/insn.h> /* __ignore_sync_check__ */
+#include <asm/unaligned.h> /* __ignore_sync_check__ */
 
 #include <linux/errno.h>
 #include <linux/kconfig.h>
@@ -37,10 +38,10 @@
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
+	({ t r = get_unaligned((t *)(insn)->next_byte); (insn)->next_byte += sizeof(t); leXX_to_cpu(t, r); })
 
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
+	({ t r = get_unaligned((t *)(insn)->next_byte + n); leXX_to_cpu(t, r); })
 
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 7976994..8fd63a0 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -13,6 +13,7 @@
 #endif
 #include "../include/asm/inat.h" /* __ignore_sync_check__ */
 #include "../include/asm/insn.h" /* __ignore_sync_check__ */
+#include "../include/asm-generic/unaligned.h" /* __ignore_sync_check__ */
 
 #include <linux/errno.h>
 #include <linux/kconfig.h>
@@ -37,10 +38,10 @@
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
+	({ t r = get_unaligned((t *)(insn)->next_byte); (insn)->next_byte += sizeof(t); leXX_to_cpu(t, r); })
 
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r); })
+	({ t r = get_unaligned((t *)(insn)->next_byte + n); leXX_to_cpu(t, r); })
 
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
diff --git a/tools/include/asm-generic/unaligned.h b/tools/include/asm-generic/unaligned.h
new file mode 100644
index 0000000..47387c6
--- /dev/null
+++ b/tools/include/asm-generic/unaligned.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copied from the kernel sources to tools/perf/:
+ */
+
+#ifndef __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H
+#define __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H
+
+#define __get_unaligned_t(type, ptr) ({						\
+	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
+	__pptr->x;								\
+})
+
+#define __put_unaligned_t(type, val, ptr) do {					\
+	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
+	__pptr->x = (val);							\
+} while (0)
+
+#define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
+#define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
+
+#endif /* __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H */
+
