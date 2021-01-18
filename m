Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF072FABFF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Jan 2021 22:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbhARU7X (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 18 Jan 2021 15:59:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55236 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389756AbhARKOj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 18 Jan 2021 05:14:39 -0500
Date:   Mon, 18 Jan 2021 10:13:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610964810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kayVKj6f++jgcxg9yYA/wWSH3lFMtU23KnIBOLPPtsM=;
        b=jeM1wDl2y4nF2jhobxd5jhoNRB9epBSb6QcsnaRq00tAJGHxj/MkQdhJrKdLufZms3mpqx
        q7s3UluOYr3Ng4h74Z7+P75YS+Pi5SP/BkmanRCSFFA5bIrkbaBubhYKYUJPSQGC8hjtdS
        rd1Z4en1/YQ03PaaugAQL/VJ5BJgtgC6WzP2O2Lk2/EAJBOEFE9pgQfnjQ7YDKx4JBGc2E
        RVCVlNiwAUjXQOYJQCsxdsk7/Ot0y6cEtHae5V63p2PBPdxc2PxLiE5R5v8n0hEF0MvKiO
        QCN1x3PKI625ZQZdtU5wi4DAnZrO6dwPgG1D3zuZNl9wbsMrTc+VxLSzTK1K4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610964810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kayVKj6f++jgcxg9yYA/wWSH3lFMtU23KnIBOLPPtsM=;
        b=mKeJxf5hTNOP+GhhsNPDprm7AGgACRYtHNL4pGEzkM+JElSoMKeGauhScOpOVYTU2zPyZk
        O9etnzuxcaLd1dDA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add 'alt_group' struct
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161096481019.414.10000208469752390313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     b23cc71c62747f2e4c3e56138872cf47e1294f8a
Gitweb:        https://git.kernel.org/tip/b23cc71c62747f2e4c3e56138872cf47e1294f8a
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Fri, 18 Dec 2020 14:19:32 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Thu, 14 Jan 2021 09:53:48 -06:00

objtool: Add 'alt_group' struct

Create a new struct associated with each group of alternatives
instructions.  This will help with the removal of fake jumps, and more
importantly with adding support for stack layout changes in
alternatives.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c                 | 29 ++++++++++++++++++++------
 tools/objtool/include/objtool/check.h | 13 +++++++++++-
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8976047..9aa324b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -992,20 +992,28 @@ static int handle_group_alt(struct objtool_file *file,
 			    struct instruction *orig_insn,
 			    struct instruction **new_insn)
 {
-	static unsigned int alt_group_next_index = 1;
 	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
-	unsigned int alt_group = alt_group_next_index++;
+	struct alt_group *orig_alt_group, *new_alt_group;
 	unsigned long dest_off;
 
+
+	orig_alt_group = malloc(sizeof(*orig_alt_group));
+	if (!orig_alt_group) {
+		WARN("malloc failed");
+		return -1;
+	}
 	last_orig_insn = NULL;
 	insn = orig_insn;
 	sec_for_each_insn_from(file, insn) {
 		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
 			break;
 
-		insn->alt_group = alt_group;
+		insn->alt_group = orig_alt_group;
 		last_orig_insn = insn;
 	}
+	orig_alt_group->orig_group = NULL;
+	orig_alt_group->first_insn = orig_insn;
+	orig_alt_group->last_insn = last_orig_insn;
 
 	if (next_insn_same_sec(file, last_orig_insn)) {
 		fake_jump = malloc(sizeof(*fake_jump));
@@ -1036,8 +1044,13 @@ static int handle_group_alt(struct objtool_file *file,
 		return 0;
 	}
 
+	new_alt_group = malloc(sizeof(*new_alt_group));
+	if (!new_alt_group) {
+		WARN("malloc failed");
+		return -1;
+	}
+
 	last_new_insn = NULL;
-	alt_group = alt_group_next_index++;
 	insn = *new_insn;
 	sec_for_each_insn_from(file, insn) {
 		struct reloc *alt_reloc;
@@ -1049,7 +1062,7 @@ static int handle_group_alt(struct objtool_file *file,
 
 		insn->ignore = orig_insn->ignore_alts;
 		insn->func = orig_insn->func;
-		insn->alt_group = alt_group;
+		insn->alt_group = new_alt_group;
 
 		/*
 		 * Since alternative replacement code is copy/pasted by the
@@ -1098,6 +1111,10 @@ static int handle_group_alt(struct objtool_file *file,
 		return -1;
 	}
 
+	new_alt_group->orig_group = orig_alt_group;
+	new_alt_group->first_insn = *new_insn;
+	new_alt_group->last_insn = last_new_insn;
+
 	if (fake_jump)
 		list_add(&fake_jump->list, &last_new_insn->list);
 
@@ -2451,7 +2468,7 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 static void fill_alternative_cfi(struct objtool_file *file, struct instruction *insn)
 {
 	struct instruction *first_insn = insn;
-	int alt_group = insn->alt_group;
+	struct alt_group *alt_group = insn->alt_group;
 
 	sec_for_each_insn_continue(file, insn) {
 		if (insn->alt_group != alt_group)
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index df1e3e8..7893e97 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -19,6 +19,17 @@ struct insn_state {
 	s8 instr;
 };
 
+struct alt_group {
+	/*
+	 * Pointer from a replacement group to the original group.  NULL if it
+	 * *is* the original group.
+	 */
+	struct alt_group *orig_group;
+
+	/* First and last instructions in the group */
+	struct instruction *first_insn, *last_insn;
+};
+
 struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
@@ -34,7 +45,7 @@ struct instruction {
 	s8 instr;
 	u8 visited;
 	u8 ret_offset;
-	int alt_group;
+	struct alt_group *alt_group;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
