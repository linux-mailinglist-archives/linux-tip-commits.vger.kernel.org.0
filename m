Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0096A33C508
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 19:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhCOSAU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 14:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhCOSAQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 14:00:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DCEC06174A;
        Mon, 15 Mar 2021 11:00:16 -0700 (PDT)
Date:   Mon, 15 Mar 2021 18:00:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615831213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RDCQt+gtJU0SI5X2kIGrUovTAsueGVDmQPyLh0dffmo=;
        b=28FU9tyf1NXLTTeq5+bEjwq0SRwhJwsN7f4lfCbBw8ZVPenZyi+EKlC0OYO3hFf+zFgfVo
        RUaahMZlc2ouI+rMB2kO+q55dEC94Qu0bB/5WuOZTCTyx3G+nhcmsPg1V1XMJktwfIrY25
        3b6gpbj38J9KflUPKdDf4cm2Qfm0/NDrbvSx2lbmEP72KM+H/L/ksTm4T2nO3CZEyy1XcM
        weQ0m6LFchF/dQCOFook+E40eZoodIrIcXwWyZ/LxR9jwo/l+27CA+9kBs7tjQ+1p4PMrQ
        lTdw2J5OyRJgcv8oGIYm7dgtcWo2EPUsQnMwsB7sik//gcgpYHq4/m26EEyqMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615831213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RDCQt+gtJU0SI5X2kIGrUovTAsueGVDmQPyLh0dffmo=;
        b=Lc7vMkrdW4a9WnQ3bNaFcdLQD9S153F6+a5wGIomtWF7gfYhs/QP8pBXdt1t9bDie+FFbi
        DLKnq8UFYamZXfBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] objtool/x86: Use asm/nops.h
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210312115749.136357911@infradead.org>
References: <20210312115749.136357911@infradead.org>
MIME-Version: 1.0
Message-ID: <161583121208.398.8769751653293178203.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     301cddc21a157a3072d789a3097857202e550a24
Gitweb:        https://git.kernel.org/tip/301cddc21a157a3072d789a3097857202e550a24
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 12 Mar 2021 12:32:55 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 16:37:37 +01:00

objtool/x86: Use asm/nops.h

Since the kernel will rely on a single canonical set of NOPs, make sure
objtool uses the exact same ones.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210312115749.136357911@infradead.org
---
 tools/arch/x86/include/asm/nops.h | 81 ++++++++++++++++++++++++++++++-
 tools/objtool/arch/x86/decode.c   | 13 +++--
 tools/objtool/sync-check.sh       |  1 +-
 3 files changed, 90 insertions(+), 5 deletions(-)
 create mode 100644 tools/arch/x86/include/asm/nops.h

diff --git a/tools/arch/x86/include/asm/nops.h b/tools/arch/x86/include/asm/nops.h
new file mode 100644
index 0000000..c1e5e81
--- /dev/null
+++ b/tools/arch/x86/include/asm/nops.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_NOPS_H
+#define _ASM_X86_NOPS_H
+
+/*
+ * Define nops for use with alternative() and for tracing.
+ */
+
+#ifndef CONFIG_64BIT
+
+/*
+ * Generic 32bit nops from GAS:
+ *
+ * 1: nop
+ * 2: movl %esi,%esi
+ * 3: leal 0x0(%esi),%esi
+ * 4: leal 0x0(%esi,%eiz,1),%esi
+ * 5: leal %ds:0x0(%esi,%eiz,1),%esi
+ * 6: leal 0x0(%esi),%esi
+ * 7: leal 0x0(%esi,%eiz,1),%esi
+ * 8: leal %ds:0x0(%esi,%eiz,1),%esi
+ *
+ * Except 5 and 8, which are DS prefixed 4 and 7 resp, where GAS would emit 2
+ * nop instructions.
+ */
+#define BYTES_NOP1	0x90
+#define BYTES_NOP2	0x89,0xf6
+#define BYTES_NOP3	0x8d,0x76,0x00
+#define BYTES_NOP4	0x8d,0x74,0x26,0x00
+#define BYTES_NOP5	0x3e,BYTES_NOP4
+#define BYTES_NOP6	0x8d,0xb6,0x00,0x00,0x00,0x00
+#define BYTES_NOP7	0x8d,0xb4,0x26,0x00,0x00,0x00,0x00
+#define BYTES_NOP8	0x3e,BYTES_NOP7
+
+#else
+
+/*
+ * Generic 64bit nops from GAS:
+ *
+ * 1: nop
+ * 2: osp nop
+ * 3: nopl (%eax)
+ * 4: nopl 0x00(%eax)
+ * 5: nopl 0x00(%eax,%eax,1)
+ * 6: osp nopl 0x00(%eax,%eax,1)
+ * 7: nopl 0x00000000(%eax)
+ * 8: nopl 0x00000000(%eax,%eax,1)
+ */
+#define BYTES_NOP1	0x90
+#define BYTES_NOP2	0x66,BYTES_NOP1
+#define BYTES_NOP3	0x0f,0x1f,0x00
+#define BYTES_NOP4	0x0f,0x1f,0x40,0x00
+#define BYTES_NOP5	0x0f,0x1f,0x44,0x00,0x00
+#define BYTES_NOP6	0x66,BYTES_NOP5
+#define BYTES_NOP7	0x0f,0x1f,0x80,0x00,0x00,0x00,0x00
+#define BYTES_NOP8	0x0f,0x1f,0x84,0x00,0x00,0x00,0x00,0x00
+
+#endif /* CONFIG_64BIT */
+
+#ifdef __ASSEMBLY__
+#define _ASM_MK_NOP(x) .byte x
+#else
+#define _ASM_MK_NOP(x) ".byte " __stringify(x) "\n"
+#endif
+
+#define ASM_NOP1 _ASM_MK_NOP(BYTES_NOP1)
+#define ASM_NOP2 _ASM_MK_NOP(BYTES_NOP2)
+#define ASM_NOP3 _ASM_MK_NOP(BYTES_NOP3)
+#define ASM_NOP4 _ASM_MK_NOP(BYTES_NOP4)
+#define ASM_NOP5 _ASM_MK_NOP(BYTES_NOP5)
+#define ASM_NOP6 _ASM_MK_NOP(BYTES_NOP6)
+#define ASM_NOP7 _ASM_MK_NOP(BYTES_NOP7)
+#define ASM_NOP8 _ASM_MK_NOP(BYTES_NOP8)
+
+#define ASM_NOP_MAX 8
+
+#ifndef __ASSEMBLY__
+extern const unsigned char * const x86_nops[];
+#endif
+
+#endif /* _ASM_X86_NOPS_H */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 549813c..c117bfc 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -11,6 +11,9 @@
 #include "../../../arch/x86/lib/inat.c"
 #include "../../../arch/x86/lib/insn.c"
 
+#define CONFIG_64BIT 1
+#include <asm/nops.h>
+
 #include <asm/orc_types.h>
 #include <objtool/check.h>
 #include <objtool/elf.h>
@@ -596,11 +599,11 @@ void arch_initial_func_cfi_state(struct cfi_init_state *state)
 const char *arch_nop_insn(int len)
 {
 	static const char nops[5][5] = {
-		/* 1 */ { 0x90 },
-		/* 2 */ { 0x66, 0x90 },
-		/* 3 */ { 0x0f, 0x1f, 0x00 },
-		/* 4 */ { 0x0f, 0x1f, 0x40, 0x00 },
-		/* 5 */ { 0x0f, 0x1f, 0x44, 0x00, 0x00 },
+		{ BYTES_NOP1 },
+		{ BYTES_NOP2 },
+		{ BYTES_NOP3 },
+		{ BYTES_NOP4 },
+		{ BYTES_NOP5 },
 	};
 
 	if (len < 1 || len > 5) {
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 606a4b5..d232686 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -10,6 +10,7 @@ FILES="include/linux/objtool.h"
 
 if [ "$SRCARCH" = "x86" ]; then
 FILES="$FILES
+arch/x86/include/asm/nops.h
 arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/orc_types.h
 arch/x86/include/asm/emulate_prefix.h
