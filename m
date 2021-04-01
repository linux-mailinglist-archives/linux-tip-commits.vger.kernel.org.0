Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713483518B0
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Apr 2021 19:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbhDARrL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Apr 2021 13:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbhDARln (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Apr 2021 13:41:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD0AC00F7DC;
        Thu,  1 Apr 2021 08:08:58 -0700 (PDT)
Date:   Thu, 01 Apr 2021 15:08:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617289736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SeTtPszGDJ59S+qO3YRjuhGF2E//RijgKqeT+FMvtGU=;
        b=RbBP5t5CMGs+U7EKbX0sBbTYCZhviTmEW1A0qdf0bQP91V1JHerFh4EGY4KjCzHeFIP5Am
        s+SkGZYBKGNxyTY28oC3p8mxd+hcP7VbfrK9oC9E4jYmDraNP6Wc8J1B3O44R3rw4PKXxw
        /Ef8aIjluvl2WaX0amHKU3pcT0R0t2dRh7LvH/m9Ra8R3LwBA+xeYyz54OE6wn+QL5RcfC
        +24uat3Y+EkyLv/v7mIkEX5/Bb3FQrBmuKPmKcxNmK/7quuy7qSsFK4g4iqp/+99C7z39C
        kxPaAooo0GSc/P5l4koUOxctFYX5AoHxq+LPcUPDjYE/+Uw7Af98T7QkBjboDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617289736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SeTtPszGDJ59S+qO3YRjuhGF2E//RijgKqeT+FMvtGU=;
        b=LX7FLZzOT31cLCpkIhjdp8HiwUi5PcQmxAWB9SCQwsHRWHgKWq89TYjhldSGkCK97qUlrx
        jp4OvTvoN3dQkzDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Extract elf_symbol_add()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210326151300.003468981@infradead.org>
References: <20210326151300.003468981@infradead.org>
MIME-Version: 1.0
Message-ID: <161728973564.29796.17344493642659515112.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d56a3568827ec4b8efcbcfc46fdc944995b6dcf1
Gitweb:        https://git.kernel.org/tip/d56a3568827ec4b8efcbcfc46fdc944995b6dcf1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:10 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 01 Apr 2021 13:08:52 +02:00

objtool: Extract elf_symbol_add()

Create a common helper to add symbols.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/20210326151300.003468981@infradead.org
---
 tools/objtool/elf.c | 56 ++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c278a04..8457218 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -290,12 +290,39 @@ static int read_sections(struct elf *elf)
 	return 0;
 }
 
+static void elf_add_symbol(struct elf *elf, struct symbol *sym)
+{
+	struct list_head *entry;
+	struct rb_node *pnode;
+
+	sym->type = GELF_ST_TYPE(sym->sym.st_info);
+	sym->bind = GELF_ST_BIND(sym->sym.st_info);
+
+	sym->offset = sym->sym.st_value;
+	sym->len = sym->sym.st_size;
+
+	rb_add(&sym->node, &sym->sec->symbol_tree, symbol_to_offset);
+	pnode = rb_prev(&sym->node);
+	if (pnode)
+		entry = &rb_entry(pnode, struct symbol, node)->list;
+	else
+		entry = &sym->sec->symbol_list;
+	list_add(&sym->list, entry);
+	elf_hash_add(elf->symbol_hash, &sym->hash, sym->idx);
+	elf_hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
+
+	/*
+	 * Don't store empty STT_NOTYPE symbols in the rbtree.  They
+	 * can exist within a function, confusing the sorting.
+	 */
+	if (!sym->len)
+		rb_erase(&sym->node, &sym->sec->symbol_tree);
+}
+
 static int read_symbols(struct elf *elf)
 {
 	struct section *symtab, *symtab_shndx, *sec;
 	struct symbol *sym, *pfunc;
-	struct list_head *entry;
-	struct rb_node *pnode;
 	int symbols_nr, i;
 	char *coldstr;
 	Elf_Data *shndx_data = NULL;
@@ -340,9 +367,6 @@ static int read_symbols(struct elf *elf)
 			goto err;
 		}
 
-		sym->type = GELF_ST_TYPE(sym->sym.st_info);
-		sym->bind = GELF_ST_BIND(sym->sym.st_info);
-
 		if ((sym->sym.st_shndx > SHN_UNDEF &&
 		     sym->sym.st_shndx < SHN_LORESERVE) ||
 		    (shndx_data && sym->sym.st_shndx == SHN_XINDEX)) {
@@ -355,32 +379,14 @@ static int read_symbols(struct elf *elf)
 				     sym->name);
 				goto err;
 			}
-			if (sym->type == STT_SECTION) {
+			if (GELF_ST_TYPE(sym->sym.st_info) == STT_SECTION) {
 				sym->name = sym->sec->name;
 				sym->sec->sym = sym;
 			}
 		} else
 			sym->sec = find_section_by_index(elf, 0);
 
-		sym->offset = sym->sym.st_value;
-		sym->len = sym->sym.st_size;
-
-		rb_add(&sym->node, &sym->sec->symbol_tree, symbol_to_offset);
-		pnode = rb_prev(&sym->node);
-		if (pnode)
-			entry = &rb_entry(pnode, struct symbol, node)->list;
-		else
-			entry = &sym->sec->symbol_list;
-		list_add(&sym->list, entry);
-		elf_hash_add(elf->symbol_hash, &sym->hash, sym->idx);
-		elf_hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
-
-		/*
-		 * Don't store empty STT_NOTYPE symbols in the rbtree.  They
-		 * can exist within a function, confusing the sorting.
-		 */
-		if (!sym->len)
-			rb_erase(&sym->node, &sym->sec->symbol_tree);
+		elf_add_symbol(elf, sym);
 	}
 
 	if (stats)
