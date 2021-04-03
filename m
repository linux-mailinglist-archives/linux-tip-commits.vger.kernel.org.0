Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D0E35339B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 Apr 2021 13:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbhDCLLJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 3 Apr 2021 07:11:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbhDCLLD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 3 Apr 2021 07:11:03 -0400
Date:   Sat, 03 Apr 2021 11:10:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617448259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OzFRPu+Nm+e9yuaN9KuxleKGq2Ac7ej2gDAjXcsSXXo=;
        b=JVmDnnNzhaKILaxZGYxNeR9FnqfbV3Mmo4FEHp2Yy7LwrlYOcmpnWz5+Dn2NYCBUhOMC4g
        OdBQMhBjPqiZW6IFnCy0J3LVrvw3gZB1JHqLaZo7zQS4xMEErSX3oC91HL0QbcQoy75qMm
        eWRoqHK5QrhJsa+aAUk+gIP4qAgQc916r4L2FZ2p5CdXYjcyoraU1TxbuzhgdbG0tvudPl
        w4d1HNWFKNCrYgwHBvqQdIXPr6ON/xMrlscNVw1FnbNqko3aQQO7RfIXJocyThuA3ghy2Y
        +2OJwUchkHHH6KVm1X47xU9+yvVzbiTJlB25gKiEITUAq73VuIihUb2NlmeUBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617448259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OzFRPu+Nm+e9yuaN9KuxleKGq2Ac7ej2gDAjXcsSXXo=;
        b=saDFhWYArKI+lsIGk6kieH0K8/7G2Esj74X4cJCPMf6I9tVlR4ltT8onahSyGV566MJONA
        aBoZNXaa8swYnxBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Handle per arch retpoline naming
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326151259.630296706@infradead.org>
References: <20210326151259.630296706@infradead.org>
MIME-Version: 1.0
Message-ID: <161744825899.29796.12887563327129296317.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     530b4ddd9dd92b263081f5c7786d39a8129c8b2d
Gitweb:        https://git.kernel.org/tip/530b4ddd9dd92b263081f5c7786d39a8129c8b2d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:04 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 Apr 2021 12:43:02 +02:00

objtool: Handle per arch retpoline naming

The __x86_indirect_ naming is obviously not generic. Shorten to allow
matching some additional magic names later.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/20210326151259.630296706@infradead.org
---
 tools/objtool/arch/x86/decode.c      |  5 +++++
 tools/objtool/check.c                |  9 +++++++--
 tools/objtool/include/objtool/arch.h |  2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index ba9ebff..782894e 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -648,3 +648,8 @@ int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
 
 	return 0;
 }
+
+bool arch_is_retpoline(struct symbol *sym)
+{
+	return !strncmp(sym->name, "__x86_indirect_", 15);
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 519af4b..6fbc001 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -850,6 +850,11 @@ static int add_ignore_alternatives(struct objtool_file *file)
 	return 0;
 }
 
+__weak bool arch_is_retpoline(struct symbol *sym)
+{
+	return false;
+}
+
 /*
  * Find the destination instructions for all jumps.
  */
@@ -872,7 +877,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21)) {
+		} else if (arch_is_retpoline(reloc->sym)) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.
@@ -1026,7 +1031,7 @@ static int add_call_destinations(struct objtool_file *file)
 				return -1;
 			}
 
-		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21)) {
+		} else if (arch_is_retpoline(reloc->sym)) {
 			/*
 			 * Retpoline calls are really dynamic calls in
 			 * disguise, so convert them accordingly.
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 6ff0685..bb30993 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -86,4 +86,6 @@ const char *arch_nop_insn(int len);
 
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
 
+bool arch_is_retpoline(struct symbol *sym);
+
 #endif /* _ARCH_H */
