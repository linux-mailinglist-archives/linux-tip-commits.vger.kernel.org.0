Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655F01B5055
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Apr 2020 00:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgDVW01 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Apr 2020 18:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726544AbgDVWYy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Apr 2020 18:24:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E922C03C1A9;
        Wed, 22 Apr 2020 15:24:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRNnC-0001L0-Iq; Thu, 23 Apr 2020 00:24:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DF9FD1C047B;
        Thu, 23 Apr 2020 00:24:29 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:24:29 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Rearrange validate_section()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115119.405863817@infradead.org>
References: <20200416115119.405863817@infradead.org>
MIME-Version: 1.0
Message-ID: <158759426944.28353.2192916542303185665.tip-bot2@tip-bot2>
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

Commit-ID:     0e7f7f7c11588dd778f702da1405f0cc33cfea8c
Gitweb:        https://git.kernel.org/tip/0e7f7f7c11588dd778f702da1405f0cc33cfea8c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 23 Mar 2020 21:17:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Apr 2020 23:10:08 +02:00

objtool: Rearrange validate_section()

In preparation of further changes, once again break out the loop body.
No functional changes intended.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115119.405863817@infradead.org
---
 tools/objtool/check.c | 51 +++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ef082a3..1d455d6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2502,12 +2502,37 @@ static bool ignore_unreachable_insn(struct instruction *insn)
 	return false;
 }
 
-static int validate_section(struct objtool_file *file, struct section *sec)
+static int validate_symbol(struct objtool_file *file, struct section *sec,
+			   struct symbol *sym, struct insn_state *state)
 {
-	struct symbol *func;
 	struct instruction *insn;
+	int ret;
+
+	if (!sym->len) {
+		WARN("%s() is missing an ELF size annotation", sym->name);
+		return 1;
+	}
+
+	if (sym->pfunc != sym || sym->alias != sym)
+		return 0;
+
+	insn = find_insn(file, sec, sym->offset);
+	if (!insn || insn->ignore || insn->visited)
+		return 0;
+
+	state->uaccess = sym->uaccess_safe;
+
+	ret = validate_branch(file, insn->func, insn, *state);
+	if (ret && backtrace)
+		BT_FUNC("<=== (sym)", insn);
+	return ret;
+}
+
+static int validate_section(struct objtool_file *file, struct section *sec)
+{
 	struct insn_state state;
-	int ret, warnings = 0;
+	struct symbol *func;
+	int warnings = 0;
 
 	/*
 	 * We need the full vmlinux for noinstr validation, otherwise we can
@@ -2521,31 +2546,13 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 		if (func->type != STT_FUNC)
 			continue;
 
-		if (!func->len) {
-			WARN("%s() is missing an ELF size annotation",
-			     func->name);
-			warnings++;
-		}
-
-		if (func->pfunc != func || func->alias != func)
-			continue;
-
-		insn = find_insn(file, sec, func->offset);
-		if (!insn || insn->ignore || insn->visited)
-			continue;
-
 		clear_insn_state(&state);
 		state.cfi.cfa = initial_func_cfi.cfa;
 		memcpy(&state.cfi.regs, &initial_func_cfi.regs,
 		       CFI_NUM_REGS * sizeof(struct cfi_reg));
 		state.cfi.stack_size = initial_func_cfi.cfa.offset;
 
-		state.uaccess = func->uaccess_safe;
-
-		ret = validate_branch(file, func, insn, state);
-		if (ret && backtrace)
-			BT_FUNC("<=== (func)", insn);
-		warnings += ret;
+		warnings += validate_symbol(file, sec, func, &state);
 	}
 
 	return warnings;
