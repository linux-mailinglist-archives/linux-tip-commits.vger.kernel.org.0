Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E094264DEB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Sep 2020 20:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgIJSzs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Sep 2020 14:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgIJSyq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Sep 2020 14:54:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A742AC061786;
        Thu, 10 Sep 2020 11:54:39 -0700 (PDT)
Date:   Thu, 10 Sep 2020 18:54:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599764077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=61oRPn745OPXQYvvPgFYlmmnz82duZF95/OBTvfMDXM=;
        b=D4E2KnfN5OAftAUCB7pBOYtlxsJ8qqdLtYj8U/ij+/15jbx6JHbORlZuC8pC4YgRXBxXbC
        ETAkD3i78o6KGlQ0b7I1Wp0FWRP3DUWEcIx4/teYQBa9YhYOfa1nu1slph1MsImu1CiL0N
        jMmlmfQjUzrZJYMq1J6KsmH4WU1dJdAiLCbtJJiCURnydYGj7x+REn5BjjPoshxQHexNEk
        VoK/4T4cq2zFZyUPGjX3GD3O3Jg7hRNhiTBfPnR1D5U79HbSeSpNSSkD3awTgYGAOl09pL
        OmB2qA890DRcdMPzCjNxLffopc5j99nBfjHT47MOctrX5DsRYON5P7H5gks0nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599764077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=61oRPn745OPXQYvvPgFYlmmnz82duZF95/OBTvfMDXM=;
        b=SFTYEpOj9tNBazgLtgRszBiq/ug1ghWxujbxlJi/tDl+ZMMANVwMt4icHUQBLDPqBs4T7y
        YvBnOthEMy5B2XDg==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Make relocation in alternative handling
 arch dependent
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159976407687.20229.3914095065201070493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     45245f51f9a4b9a883a8c94468473c1de9b88153
Gitweb:        https://git.kernel.org/tip/45245f51f9a4b9a883a8c94468473c1de9b88153
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Fri, 04 Sep 2020 16:30:23 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Thu, 10 Sep 2020 10:43:13 -05:00

objtool: Make relocation in alternative handling arch dependent

As pointed out by the comment in handle_group_alt(), support of
relocation for instructions in an alternative group depends on whether
arch specific kernel code handles it.

So, let objtool arch specific code decide whether a relocation for
the alternative section should be accepted.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/arch/x86/special.c | 13 +++++++++++++
 tools/objtool/check.c            | 19 ++++++-------------
 tools/objtool/check.h            |  6 ++++++
 tools/objtool/special.h          |  4 ++++
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 823561e..34e0e16 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -35,3 +35,16 @@ void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 		break;
 	}
 }
+
+bool arch_support_alt_relocation(struct special_alt *special_alt,
+				 struct instruction *insn,
+				 struct reloc *reloc)
+{
+	/*
+	 * The x86 alternatives code adjusts the offsets only when it
+	 * encounters a branch instruction at the very beginning of the
+	 * replacement group.
+	 */
+	return insn->offset == special_alt->new_off &&
+	       (insn->type == INSN_CALL || is_static_jump(insn));
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4afc2d5..1796a7c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -110,12 +110,6 @@ static struct instruction *prev_insn_same_sym(struct objtool_file *file,
 	for (insn = next_insn_same_sec(file, insn); insn;		\
 	     insn = next_insn_same_sec(file, insn))
 
-static bool is_static_jump(struct instruction *insn)
-{
-	return insn->type == INSN_JUMP_CONDITIONAL ||
-	       insn->type == INSN_JUMP_UNCONDITIONAL;
-}
-
 static bool is_sibling_call(struct instruction *insn)
 {
 	/* An indirect jump is either a sibling call or a jump to a table. */
@@ -972,6 +966,8 @@ static int handle_group_alt(struct objtool_file *file,
 	alt_group = alt_group_next_index++;
 	insn = *new_insn;
 	sec_for_each_insn_from(file, insn) {
+		struct reloc *alt_reloc;
+
 		if (insn->offset >= special_alt->new_off + special_alt->new_len)
 			break;
 
@@ -988,14 +984,11 @@ static int handle_group_alt(struct objtool_file *file,
 		 * .altinstr_replacement section, unless the arch's
 		 * alternatives code can adjust the relative offsets
 		 * accordingly.
-		 *
-		 * The x86 alternatives code adjusts the offsets only when it
-		 * encounters a branch instruction at the very beginning of the
-		 * replacement group.
 		 */
-		if ((insn->offset != special_alt->new_off ||
-		    (insn->type != INSN_CALL && !is_static_jump(insn))) &&
-		    find_reloc_by_dest_range(file->elf, insn->sec, insn->offset, insn->len)) {
+		alt_reloc = find_reloc_by_dest_range(file->elf, insn->sec,
+						   insn->offset, insn->len);
+		if (alt_reloc &&
+		    !arch_support_alt_relocation(special_alt, insn, alt_reloc)) {
 
 			WARN_FUNC("unsupported relocation in alternatives section",
 				  insn->sec, insn->offset);
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 6cac345..1de1188 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -48,6 +48,12 @@ struct instruction {
 #endif
 };
 
+static inline bool is_static_jump(struct instruction *insn)
+{
+	return insn->type == INSN_JUMP_CONDITIONAL ||
+	       insn->type == INSN_JUMP_UNCONDITIONAL;
+}
+
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
 
diff --git a/tools/objtool/special.h b/tools/objtool/special.h
index 44da89a..1dc1bb3 100644
--- a/tools/objtool/special.h
+++ b/tools/objtool/special.h
@@ -7,6 +7,7 @@
 #define _SPECIAL_H
 
 #include <stdbool.h>
+#include "check.h"
 #include "elf.h"
 
 struct special_alt {
@@ -30,4 +31,7 @@ int special_get_alts(struct elf *elf, struct list_head *alts);
 
 void arch_handle_alternative(unsigned short feature, struct special_alt *alt);
 
+bool arch_support_alt_relocation(struct special_alt *special_alt,
+				 struct instruction *insn,
+				 struct reloc *reloc);
 #endif /* _SPECIAL_H */
