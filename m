Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F77353390
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 Apr 2021 13:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbhDCLLC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 3 Apr 2021 07:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbhDCLLB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 3 Apr 2021 07:11:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B9DC06178C;
        Sat,  3 Apr 2021 04:10:57 -0700 (PDT)
Date:   Sat, 03 Apr 2021 11:10:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617448256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPcpNtgz4KTIecjxvgdRjx7oVpP9waOBVtsW1QzwMUc=;
        b=c+R8432JswXSiAD8MUx/KSt6qA6khOsrd8rGJeb8xW2l/0++WmW7Xfw7ReLE70anRyIgD0
        uBAslzNCAC34bmVntXSffbtarQizFlVAduHk2a0YEXbX1VWDJQnm+hBBcM9+hg7sThy6lU
        8JwHcfS2nmIupCUvbrwbsp6PnR3b1kJtNLcV1hqWFRIS/8odczIbsSo+aclWavcS5GdSR8
        RODhwdpUPEJJf3Tj0uaHYX7Hj4GWwTRJN11NRYavEw1OqDU4TaxZY99XOjv6LrWstyhoB+
        f2hgQKI3OK+RcBiYfdpG6QtxRguW23/IKSF1aS1I/tCXW4SuMYwYHiXzWGDIng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617448256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPcpNtgz4KTIecjxvgdRjx7oVpP9waOBVtsW1QzwMUc=;
        b=mYHA3lbZzhXvemaQrfkdzTdt73X82K+FQ8Ou0kgBVqe1yzU6enrL4rJygDe7UExcsC5QZn
        j74rWbXJhpLEQICg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Keep track of retpoline call sites
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326151300.130805730@infradead.org>
References: <20210326151300.130805730@infradead.org>
MIME-Version: 1.0
Message-ID: <161744825595.29796.16468442604173062127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     43d5430ad74ef5156353af7aec352426ec7a8e57
Gitweb:        https://git.kernel.org/tip/43d5430ad74ef5156353af7aec352426ec7a8e57
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 Apr 2021 12:45:27 +02:00

objtool: Keep track of retpoline call sites

Provide infrastructure for architectures to rewrite/augment compiler
generated retpoline calls. Similar to what we do for static_call()s,
keep track of the instructions that are retpoline calls.

Use the same list_head, since a retpoline call cannot also be a
static_call.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/20210326151300.130805730@infradead.org
---
 tools/objtool/check.c                   | 34 ++++++++++++++++++++----
 tools/objtool/include/objtool/arch.h    |  2 +-
 tools/objtool/include/objtool/check.h   |  2 +-
 tools/objtool/include/objtool/objtool.h |  1 +-
 tools/objtool/objtool.c                 |  1 +-
 5 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 600fa67..77074db 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -451,7 +451,7 @@ static int create_static_call_sections(struct objtool_file *file)
 		return 0;
 
 	idx = 0;
-	list_for_each_entry(insn, &file->static_call_list, static_call_node)
+	list_for_each_entry(insn, &file->static_call_list, call_node)
 		idx++;
 
 	sec = elf_create_section(file->elf, ".static_call_sites", SHF_WRITE,
@@ -460,7 +460,7 @@ static int create_static_call_sections(struct objtool_file *file)
 		return -1;
 
 	idx = 0;
-	list_for_each_entry(insn, &file->static_call_list, static_call_node) {
+	list_for_each_entry(insn, &file->static_call_list, call_node) {
 
 		site = (struct static_call_site *)sec->data->d_buf + idx;
 		memset(site, 0, sizeof(struct static_call_site));
@@ -829,13 +829,16 @@ static int add_jump_destinations(struct objtool_file *file)
 			else
 				insn->type = INSN_JUMP_DYNAMIC_CONDITIONAL;
 
+			list_add_tail(&insn->call_node,
+				      &file->retpoline_call_list);
+
 			insn->retpoline_safe = true;
 			continue;
 		} else if (insn->func) {
 			/* internal or external sibling call (with reloc) */
 			insn->call_dest = reloc->sym;
 			if (insn->call_dest->static_call_tramp) {
-				list_add_tail(&insn->static_call_node,
+				list_add_tail(&insn->call_node,
 					      &file->static_call_list);
 			}
 			continue;
@@ -897,7 +900,7 @@ static int add_jump_destinations(struct objtool_file *file)
 				/* internal sibling call (without reloc) */
 				insn->call_dest = insn->jump_dest->func;
 				if (insn->call_dest->static_call_tramp) {
-					list_add_tail(&insn->static_call_node,
+					list_add_tail(&insn->call_node,
 						      &file->static_call_list);
 				}
 			}
@@ -981,6 +984,9 @@ static int add_call_destinations(struct objtool_file *file)
 			insn->type = INSN_CALL_DYNAMIC;
 			insn->retpoline_safe = true;
 
+			list_add_tail(&insn->call_node,
+				      &file->retpoline_call_list);
+
 			remove_insn_ops(insn);
 			continue;
 
@@ -988,7 +994,7 @@ static int add_call_destinations(struct objtool_file *file)
 			insn->call_dest = reloc->sym;
 
 		if (insn->call_dest && insn->call_dest->static_call_tramp) {
-			list_add_tail(&insn->static_call_node,
+			list_add_tail(&insn->call_node,
 				      &file->static_call_list);
 		}
 
@@ -1714,6 +1720,11 @@ static void mark_rodata(struct objtool_file *file)
 	file->rodata = found;
 }
 
+__weak int arch_rewrite_retpolines(struct objtool_file *file)
+{
+	return 0;
+}
+
 static int decode_sections(struct objtool_file *file)
 {
 	int ret;
@@ -1742,6 +1753,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be before add_special_section_alts() as that depends on
+	 * jump_dest being set.
+	 */
 	ret = add_jump_destinations(file);
 	if (ret)
 		return ret;
@@ -1778,6 +1793,15 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be after add_special_section_alts(), since this will emit
+	 * alternatives. Must be after add_{jump,call}_destination(), since
+	 * those create the call insn lists.
+	 */
+	ret = arch_rewrite_retpolines(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index bb30993..48b540a 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -88,4 +88,6 @@ int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
 
 bool arch_is_retpoline(struct symbol *sym);
 
+int arch_rewrite_retpolines(struct objtool_file *file);
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index f5be798..e5528ce 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -39,7 +39,7 @@ struct alt_group {
 struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
-	struct list_head static_call_node;
+	struct list_head call_node;
 	struct list_head mcount_loc_node;
 	struct section *sec;
 	unsigned long offset;
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
index e68e374..e4084af 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -18,6 +18,7 @@ struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 20);
+	struct list_head retpoline_call_list;
 	struct list_head static_call_list;
 	struct list_head mcount_loc_list;
 	bool ignore_unreachables, c_file, hints, rodata;
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 7b97ce4..3a3ea1b 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -61,6 +61,7 @@ struct objtool_file *objtool_open_read(const char *_objname)
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
+	INIT_LIST_HEAD(&file.retpoline_call_list);
 	INIT_LIST_HEAD(&file.static_call_list);
 	INIT_LIST_HEAD(&file.mcount_loc_list);
 	file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");
