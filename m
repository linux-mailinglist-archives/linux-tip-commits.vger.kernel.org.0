Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D2E76DAA4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Aug 2023 00:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjHBWVC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Aug 2023 18:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjHBWUb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Aug 2023 18:20:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CF92D7B;
        Wed,  2 Aug 2023 15:19:39 -0700 (PDT)
Date:   Wed, 02 Aug 2023 22:19:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691014777;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pwNDUxRB22ducScdriZJp4Pt+IAZ8QVpg2bxaMumOV4=;
        b=nUpLrNNRViINLIUJNOqxgbkT5JNFaDaz3BuGXTlaUxRVboMmTaEm5sW0frVWtTaGI30aXo
        rThfcr9OcL4/CZJrgJfLDQ1EVr7w/VHyD+GaUuN0LQk39iLbQ+Wg1VEIl0HING5kVra/cg
        QT0SAf8dDwKu1WGWfLc7FydTEmOSgV7NBFZ23kN0A141cj2oMY/zlRvsqf2moeGQc0O8Si
        l1ZgxkOJ1KBTl2o4N0Osq0Gln84CFFcbEeqczLKQW9QUil2AaSDiTcpRHONcv475yYsBsf
        deSGYeP6WiE7e00ZMGCNj1vS2fX8gZi6Ai2XxmEcLa1mfwVekqJ/QbW4VS9sNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691014777;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pwNDUxRB22ducScdriZJp4Pt+IAZ8QVpg2bxaMumOV4=;
        b=fMVeqtD8e5ZyHk5Yf+LgUN5iBgpo5SPjEYPLVen/YwPAaHnoGBO3y2lhVIAAu9Mux+DWdT
        lAn5Im30pQJKl4DQ==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86: Introduce userspace API for shadow stack
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169101477654.28540.3534090663659038498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     98cfa4630912a80a575277d1bf193376ba66116a
Gitweb:        https://git.kernel.org/tip/98cfa4630912a80a575277d1bf193376ba66116a
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:52 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 02 Aug 2023 15:01:50 -07:00

x86: Introduce userspace API for shadow stack

Add three new arch_prctl() handles:

 - ARCH_SHSTK_ENABLE/DISABLE enables or disables the specified
   feature. Returns 0 on success or a negative value on error.

 - ARCH_SHSTK_LOCK prevents future disabling or enabling of the
   specified feature. Returns 0 on success or a negative value
   on error.

The features are handled per-thread and inherited over fork(2)/clone(2),
but reset on exec().

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-27-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/processor.h  |  6 ++++-
 arch/x86/include/asm/shstk.h      | 21 ++++++++++++++-
 arch/x86/include/uapi/asm/prctl.h |  6 ++++-
 arch/x86/kernel/Makefile          |  2 +-
 arch/x86/kernel/process_64.c      |  6 ++++-
 arch/x86/kernel/shstk.c           | 44 ++++++++++++++++++++++++++++++-
 6 files changed, 85 insertions(+)
 create mode 100644 arch/x86/include/asm/shstk.h
 create mode 100644 arch/x86/kernel/shstk.c

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d46300e..4e35f40 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -28,6 +28,7 @@ struct vm86;
 #include <asm/unwind_hints.h>
 #include <asm/vmxfeatures.h>
 #include <asm/vdso/processor.h>
+#include <asm/shstk.h>
 
 #include <linux/personality.h>
 #include <linux/cache.h>
@@ -475,6 +476,11 @@ struct thread_struct {
 	 */
 	u32			pkru;
 
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+	unsigned long		features;
+	unsigned long		features_locked;
+#endif
+
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
 	/*
diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
new file mode 100644
index 0000000..ec75380
--- /dev/null
+++ b/arch/x86/include/asm/shstk.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SHSTK_H
+#define _ASM_X86_SHSTK_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+struct task_struct;
+
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+long shstk_prctl(struct task_struct *task, int option, unsigned long features);
+void reset_thread_features(void);
+#else
+static inline long shstk_prctl(struct task_struct *task, int option,
+			       unsigned long arg2) { return -EINVAL; }
+static inline void reset_thread_features(void) {}
+#endif /* CONFIG_X86_USER_SHADOW_STACK */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_X86_SHSTK_H */
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index e8d7ebb..1cd44ec 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -23,9 +23,15 @@
 #define ARCH_MAP_VDSO_32		0x2002
 #define ARCH_MAP_VDSO_64		0x2003
 
+/* Don't use 0x3001-0x3004 because of old glibcs */
+
 #define ARCH_GET_UNTAG_MASK		0x4001
 #define ARCH_ENABLE_TAGGED_ADDR		0x4002
 #define ARCH_GET_MAX_TAG_BITS		0x4003
 #define ARCH_FORCE_TAGGED_SVA		0x4004
 
+#define ARCH_SHSTK_ENABLE		0x5001
+#define ARCH_SHSTK_DISABLE		0x5002
+#define ARCH_SHSTK_LOCK			0x5003
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index abee056..6b6bf47 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -147,6 +147,8 @@ obj-$(CONFIG_CALL_THUNKS)		+= callthunks.o
 
 obj-$(CONFIG_X86_CET)			+= cet.o
 
+obj-$(CONFIG_X86_USER_SHADOW_STACK)	+= shstk.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 3d181c1..0f89aa0 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -515,6 +515,8 @@ start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 		load_gs_index(__USER_DS);
 	}
 
+	reset_thread_features();
+
 	loadsegment(fs, 0);
 	loadsegment(es, _ds);
 	loadsegment(ds, _ds);
@@ -894,6 +896,10 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 		else
 			return put_user(LAM_U57_BITS, (unsigned long __user *)arg2);
 #endif
+	case ARCH_SHSTK_ENABLE:
+	case ARCH_SHSTK_DISABLE:
+	case ARCH_SHSTK_LOCK:
+		return shstk_prctl(task, option, arg2);
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
new file mode 100644
index 0000000..41ed655
--- /dev/null
+++ b/arch/x86/kernel/shstk.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * shstk.c - Intel shadow stack support
+ *
+ * Copyright (c) 2021, Intel Corporation.
+ * Yu-cheng Yu <yu-cheng.yu@intel.com>
+ */
+
+#include <linux/sched.h>
+#include <linux/bitops.h>
+#include <asm/prctl.h>
+
+void reset_thread_features(void)
+{
+	current->thread.features = 0;
+	current->thread.features_locked = 0;
+}
+
+long shstk_prctl(struct task_struct *task, int option, unsigned long features)
+{
+	if (option == ARCH_SHSTK_LOCK) {
+		task->thread.features_locked |= features;
+		return 0;
+	}
+
+	/* Don't allow via ptrace */
+	if (task != current)
+		return -EINVAL;
+
+	/* Do not allow to change locked features */
+	if (features & task->thread.features_locked)
+		return -EPERM;
+
+	/* Only support enabling/disabling one feature at a time. */
+	if (hweight_long(features) > 1)
+		return -EINVAL;
+
+	if (option == ARCH_SHSTK_DISABLE) {
+		return -EINVAL;
+	}
+
+	/* Handle ARCH_SHSTK_ENABLE */
+	return -EINVAL;
+}
