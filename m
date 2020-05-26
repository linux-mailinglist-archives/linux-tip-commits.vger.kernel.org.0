Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EFD1B504B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Apr 2020 00:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgDVWZ5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Apr 2020 18:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726724AbgDVWZF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Apr 2020 18:25:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED9FC03C1AA;
        Wed, 22 Apr 2020 15:25:05 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRNnZ-0001TH-D1; Thu, 23 Apr 2020 00:24:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D3FA41C047B;
        Thu, 23 Apr 2020 00:24:47 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:24:47 -0000
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Split out arch-specific CFI definitions
Cc:     Julien Thierry <jthierry@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158759428722.28353.11322555821987321171.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     f04f7d856a6d8de36a7ccf70e652565991db1b25
Gitweb:        https://git.kernel.org/tip/f04f7d856a6d8de36a7ccf70e652565991db1b25
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Fri, 27 Mar 2020 15:28:46 
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 14 Apr 2020 10:39:25 -05:00

objtool: Split out arch-specific CFI definitions

Some CFI definitions used by generic objtool code have no reason to vary
from one architecture to another.  Keep those definitions in generic
code and move the arch-specific ones to a new arch-specific header.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/Makefile                    |  3 ++-
 tools/objtool/arch/x86/include/cfi_regs.h | 25 ++++++++++++++++++++++-
 tools/objtool/cfi.h                       | 21 +-----------------
 3 files changed, 29 insertions(+), 20 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/cfi_regs.h

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index d1ab0cc..6b91388 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -35,7 +35,8 @@ all: $(OBJTOOL)
 
 INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
-	    -I$(srctree)/tools/arch/$(SRCARCH)/include
+	    -I$(srctree)/tools/arch/$(SRCARCH)/include	\
+	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
 CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
diff --git a/tools/objtool/arch/x86/include/cfi_regs.h b/tools/objtool/arch/x86/include/cfi_regs.h
new file mode 100644
index 0000000..79bc517
--- /dev/null
+++ b/tools/objtool/arch/x86/include/cfi_regs.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _OBJTOOL_CFI_REGS_H
+#define _OBJTOOL_CFI_REGS_H
+
+#define CFI_AX			0
+#define CFI_DX			1
+#define CFI_CX			2
+#define CFI_BX			3
+#define CFI_SI			4
+#define CFI_DI			5
+#define CFI_BP			6
+#define CFI_SP			7
+#define CFI_R8			8
+#define CFI_R9			9
+#define CFI_R10			10
+#define CFI_R11			11
+#define CFI_R12			12
+#define CFI_R13			13
+#define CFI_R14			14
+#define CFI_R15			15
+#define CFI_RA			16
+#define CFI_NUM_REGS		17
+
+#endif /* _OBJTOOL_CFI_REGS_H */
diff --git a/tools/objtool/cfi.h b/tools/objtool/cfi.h
index 4427bf8..1a3e7b8 100644
--- a/tools/objtool/cfi.h
+++ b/tools/objtool/cfi.h
@@ -6,30 +6,13 @@
 #ifndef _OBJTOOL_CFI_H
 #define _OBJTOOL_CFI_H
 
+#include "cfi_regs.h"
+
 #define CFI_UNDEFINED		-1
 #define CFI_CFA			-2
 #define CFI_SP_INDIRECT		-3
 #define CFI_BP_INDIRECT		-4
 
-#define CFI_AX			0
-#define CFI_DX			1
-#define CFI_CX			2
-#define CFI_BX			3
-#define CFI_SI			4
-#define CFI_DI			5
-#define CFI_BP			6
-#define CFI_SP			7
-#define CFI_R8			8
-#define CFI_R9			9
-#define CFI_R10			10
-#define CFI_R11			11
-#define CFI_R12			12
-#define CFI_R13			13
-#define CFI_R14			14
-#define CFI_R15			15
-#define CFI_RA			16
-#define CFI_NUM_REGS		17
-
 struct cfi_reg {
 	int base;
 	int offset;
