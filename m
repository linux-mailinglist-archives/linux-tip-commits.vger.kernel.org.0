Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6081B56A9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Apr 2020 09:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgDWHvT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 23 Apr 2020 03:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgDWHto (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:44 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD553C03C1AB;
        Thu, 23 Apr 2020 00:49:43 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWc4-0008M1-Ln; Thu, 23 Apr 2020 09:49:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 505F41C0450;
        Thu, 23 Apr 2020 09:49:36 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:35 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] kbuild/objtool: Add objtool-vmlinux.o pass
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115119.287494491@infradead.org>
References: <20200416115119.287494491@infradead.org>
MIME-Version: 1.0
Message-ID: <158762817594.28353.11951845543029889353.tip-bot2@tip-bot2>
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

Commit-ID:     6804c1afd794c8135351faaa69e1503ee11393ac
Gitweb:        https://git.kernel.org/tip/6804c1afd794c8135351faaa69e1503ee11393ac
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 18 Mar 2020 13:33:54 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 Apr 2020 10:53:51 +02:00

kbuild/objtool: Add objtool-vmlinux.o pass

Now that objtool is capable of processing vmlinux.o and actually has
something useful to do there, (conditionally) add it to the final link
pass.

This will increase build time by a few seconds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115119.287494491@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 lib/Kconfig.debug       |  5 +++++
 scripts/link-vmlinux.sh | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 21d9c5f..977b5a1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -369,6 +369,11 @@ config STACK_VALIDATION
 	  For more information, see
 	  tools/objtool/Documentation/stack-validation.txt.
 
+config VMLINUX_VALIDATION
+	bool
+	depends on STACK_VALIDATION && DEBUG_ENTRY && !PARAVIRT
+	default y
+
 config DEBUG_FORCE_WEAK_PER_CPU
 	bool "Force weak per-cpu definitions"
 	depends on DEBUG_KERNEL
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index d09ab4a..3adef49 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -55,6 +55,29 @@ modpost_link()
 	${LD} ${KBUILD_LDFLAGS} -r -o ${1} ${objects}
 }
 
+objtool_link()
+{
+	local objtoolopt;
+
+	if [ -n "${CONFIG_VMLINUX_VALIDATION}" ]; then
+		objtoolopt="check"
+		if [ -z "${CONFIG_FRAME_POINTER}" ]; then
+			objtoolopt="${objtoolopt} --no-fp"
+		fi
+		if [ -n "${CONFIG_GCOV_KERNEL}" ]; then
+			objtoolopt="${objtoolopt} --no-unreachable"
+		fi
+		if [ -n "${CONFIG_RETPOLINE}" ]; then
+			objtoolopt="${objtoolopt} --retpoline"
+		fi
+		if [ -n "${CONFIG_X86_SMAP}" ]; then
+			objtoolopt="${objtoolopt} --uaccess"
+		fi
+		info OBJTOOL ${1}
+		tools/objtool/objtool ${objtoolopt} ${1}
+	fi
+}
+
 # Link of vmlinux
 # ${1} - output file
 # ${2}, ${3}, ... - optional extra .o files
@@ -251,6 +274,7 @@ ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init need-builtin=1
 #link vmlinux.o
 info LD vmlinux.o
 modpost_link vmlinux.o
+objtool_link vmlinux.o
 
 # modpost vmlinux.o to check for section mismatches
 ${MAKE} -f "${srctree}/scripts/Makefile.modpost" MODPOST_VMLINUX=1
