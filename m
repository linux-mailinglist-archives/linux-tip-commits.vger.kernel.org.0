Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F7F423B2D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Oct 2021 12:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbhJFKEO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Oct 2021 06:04:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57210 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhJFKEN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 Oct 2021 06:04:13 -0400
Date:   Wed, 06 Oct 2021 10:02:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633514541;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UI/Mzq+FwvZPWInV3jzYfY50nLqU5dLTfnuRsinHP9Q=;
        b=oPhrfpkCgnylLF7xVcRX89tHojqQX5eMU4d0jNjr5IaM4NeHdO/krXGY/m53VIG2vdu3ai
        AGqd8XwUigPnmIyh6nUXOFRzVSsSR78P3j2Jug36/578KXd3P3y99kJ2dysIzF5FxYyFTg
        97nrdAZRmV6qab1uZ9ZRFYy71znP5Ath+PuAmH2UErtNtQC0ANDyQFmcQIPRF5VB1EMjgf
        EKKF0/oV8RKl7RegXHSrd3X2rd7qQcrg2vSNzuDek3y5Q7Zl/mofGI8yskZkv/wcn8fbsl
        B86Lq3Nn2yfZAurqOmMWarsMd1BKLu4LmT7HlBJ21Wj4Ljhqb3COyFhGjY/ovQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633514541;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UI/Mzq+FwvZPWInV3jzYfY50nLqU5dLTfnuRsinHP9Q=;
        b=TfQ37z1SVlYETyTvPmvagmgVBVVhzTuZd9Zw1ddRhUGPc4r0y1QVphpOnK+Z93N5ybSf/c
        lYSr9wWf/X96/dCA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/insn: Use get_unaligned() instead of memcpy()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YVSsIkj9Z29TyUjE@zn.tnic>
References: <YVSsIkj9Z29TyUjE@zn.tnic>
MIME-Version: 1.0
Message-ID: <163351453975.25758.13801400058796282579.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     f96b4675839b66168f5a07bf964dde6c2f1c4885
Gitweb:        https://git.kernel.org/tip/f96b4675839b66168f5a07bf964dde6c2f1c4885
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 29 Sep 2021 16:37:53 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Oct 2021 11:56:37 +02:00

x86/insn: Use get_unaligned() instead of memcpy()

Use get_unaligned() instead of memcpy() to access potentially unaligned
memory, which, when accessed through a pointer, leads to undefined
behavior. get_unaligned() describes much better what is happening there
anyway even if memcpy() does the job.

In addition, since perf tool builds with -Werror, it would fire with:

  util/intel-pt-decoder/../../../arch/x86/lib/insn.c: In function '__insn_get_emulate_prefix':
  tools/include/../include/asm-generic/unaligned.h:10:15: error: packed attribute is unnecessary [-Werror=packed]
     10 |  const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr); \

because -Werror=packed would complain if the packed attribute would have
no effect on the layout of the structure.

In this case, that is intentional so disable the warning only for that
compilation unit.

That part is Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

No functional changes.

Fixes: 5ba1071f7554 ("x86/insn, tools/x86: Fix undefined behavior due to potential unaligned accesses")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lkml.kernel.org/r/YVSsIkj9Z29TyUjE@zn.tnic
---
 arch/x86/lib/insn.c                    |  5 +++--
 tools/arch/x86/lib/insn.c              |  5 +++--
 tools/include/asm-generic/unaligned.h  | 23 +++++++++++++++++++++++
 tools/perf/util/intel-pt-decoder/Build |  2 ++
 4 files changed, 31 insertions(+), 4 deletions(-)
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
diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
index bc62935..b41c2e9 100644
--- a/tools/perf/util/intel-pt-decoder/Build
+++ b/tools/perf/util/intel-pt-decoder/Build
@@ -18,3 +18,5 @@ CFLAGS_intel-pt-insn-decoder.o += -I$(OUTPUT)util/intel-pt-decoder
 ifeq ($(CC_NO_CLANG), 1)
   CFLAGS_intel-pt-insn-decoder.o += -Wno-override-init
 endif
+
+CFLAGS_intel-pt-insn-decoder.o += -Wno-packed
