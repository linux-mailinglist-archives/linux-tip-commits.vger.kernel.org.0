Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3971142CCFB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Oct 2021 23:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhJMVor (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 13 Oct 2021 17:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJMVor (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 13 Oct 2021 17:44:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BE7C061570;
        Wed, 13 Oct 2021 14:42:43 -0700 (PDT)
Date:   Wed, 13 Oct 2021 21:42:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634161362;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IIsrHKxHFuYkKL8EijlX0RS2UHCeNbh801MLICqzr0=;
        b=ol8jNUShAj+WJ9MWhuXsjeXj42bESb+mEbDLMSIO3IF8V8uLdGr2yXx1jNzdf5kbW+IBYX
        g+I1KA7wngjqt0HA5LPQ28F6hyRFjFC0II09CQjmI7ZihqlkAPOlVk9UpRTt/vP2NVRsoM
        T955lOi3alcOaZlUxB++O+fQhO8wOyectzzAvtKQcV5rQEpD3OTgJxUwKO4UaZ4AF0A7rH
        RZL1XFJ1+wRji2fyC1Zr5t3nUjgg4k5UI4vYZ3/VhfCZGBW13ibIWSeQkvc228inlYHTTj
        0hGZe/vU2x48pHbVLFXK4+Q50xXmMvIkkqCF5St4kka1L3ffioDqa8I7ej/Upw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634161362;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IIsrHKxHFuYkKL8EijlX0RS2UHCeNbh801MLICqzr0=;
        b=Ba3J8E6Pb0LMuhlfhVakAYyEgJXIy9oYqN0EXC5A5R9ENQC85VY/2aA7oBCobfbcqqDQ9r
        9c2nQaLm5cXm90Bw==
From:   "tip-bot2 for Michael Forney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Update section header before relocations
Cc:     Michael Forney <mforney@mforney.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210509000103.11008-2-mforney@mforney.org>
References: <20210509000103.11008-2-mforney@mforney.org>
MIME-Version: 1.0
Message-ID: <163416136123.25758.14592305159373285844.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     86e1e054e0d2105cf32b0266cf1a64e6c26424f7
Gitweb:        https://git.kernel.org/tip/86e1e054e0d2105cf32b0266cf1a64e6c26424f7
Author:        Michael Forney <mforney@mforney.org>
AuthorDate:    Sat, 08 May 2021 17:01:03 -07:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Wed, 06 Oct 2021 20:11:57 -07:00

objtool: Update section header before relocations

The libelf implementation from elftoolchain has a safety check in
gelf_update_rel[a] to check that the data corresponds to a section
that has type SHT_REL[A] [0]. If the relocation is updated before
the section header is updated with the proper type, this check
fails.

To fix this, update the section header first, before the relocations.
Previously, the section size was calculated in elf_rebuild_reloc_section
by counting the number of entries in the reloc_list. However, we
now need the size during elf_write so instead keep a running total
and add to it for every new relocation.

[0] https://sourceforge.net/p/elftoolchain/mailman/elftoolchain-developers/thread/CAGw6cBtkZro-8wZMD2ULkwJ39J+tHtTtAWXufMjnd3cQ7XG54g@mail.gmail.com/

Signed-off-by: Michael Forney <mforney@mforney.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20210509000103.11008-2-mforney@mforney.org
---
 tools/objtool/elf.c | 46 ++++++++++++++++----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d1d4491..fee03b7 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -508,6 +508,7 @@ int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 	list_add_tail(&reloc->list, &sec->reloc->reloc_list);
 	elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
 
+	sec->reloc->sh.sh_size += sec->reloc->sh.sh_entsize;
 	sec->reloc->changed = true;
 
 	return 0;
@@ -977,26 +978,23 @@ static struct section *elf_create_reloc_section(struct elf *elf,
 	}
 }
 
-static int elf_rebuild_rel_reloc_section(struct section *sec, int nr)
+static int elf_rebuild_rel_reloc_section(struct section *sec)
 {
 	struct reloc *reloc;
-	int idx = 0, size;
+	int idx = 0;
 	void *buf;
 
 	/* Allocate a buffer for relocations */
-	size = nr * sizeof(GElf_Rel);
-	buf = malloc(size);
+	buf = malloc(sec->sh.sh_size);
 	if (!buf) {
 		perror("malloc");
 		return -1;
 	}
 
 	sec->data->d_buf = buf;
-	sec->data->d_size = size;
+	sec->data->d_size = sec->sh.sh_size;
 	sec->data->d_type = ELF_T_REL;
 
-	sec->sh.sh_size = size;
-
 	idx = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list) {
 		reloc->rel.r_offset = reloc->offset;
@@ -1011,26 +1009,23 @@ static int elf_rebuild_rel_reloc_section(struct section *sec, int nr)
 	return 0;
 }
 
-static int elf_rebuild_rela_reloc_section(struct section *sec, int nr)
+static int elf_rebuild_rela_reloc_section(struct section *sec)
 {
 	struct reloc *reloc;
-	int idx = 0, size;
+	int idx = 0;
 	void *buf;
 
 	/* Allocate a buffer for relocations with addends */
-	size = nr * sizeof(GElf_Rela);
-	buf = malloc(size);
+	buf = malloc(sec->sh.sh_size);
 	if (!buf) {
 		perror("malloc");
 		return -1;
 	}
 
 	sec->data->d_buf = buf;
-	sec->data->d_size = size;
+	sec->data->d_size = sec->sh.sh_size;
 	sec->data->d_type = ELF_T_RELA;
 
-	sec->sh.sh_size = size;
-
 	idx = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list) {
 		reloc->rela.r_offset = reloc->offset;
@@ -1048,16 +1043,9 @@ static int elf_rebuild_rela_reloc_section(struct section *sec, int nr)
 
 static int elf_rebuild_reloc_section(struct elf *elf, struct section *sec)
 {
-	struct reloc *reloc;
-	int nr;
-
-	nr = 0;
-	list_for_each_entry(reloc, &sec->reloc_list, list)
-		nr++;
-
 	switch (sec->sh.sh_type) {
-	case SHT_REL:  return elf_rebuild_rel_reloc_section(sec, nr);
-	case SHT_RELA: return elf_rebuild_rela_reloc_section(sec, nr);
+	case SHT_REL:  return elf_rebuild_rel_reloc_section(sec);
+	case SHT_RELA: return elf_rebuild_rela_reloc_section(sec);
 	default:       return -1;
 	}
 }
@@ -1117,12 +1105,6 @@ int elf_write(struct elf *elf)
 	/* Update changed relocation sections and section headers: */
 	list_for_each_entry(sec, &elf->sections, list) {
 		if (sec->changed) {
-			if (sec->base &&
-			    elf_rebuild_reloc_section(elf, sec)) {
-				WARN("elf_rebuild_reloc_section");
-				return -1;
-			}
-
 			s = elf_getscn(elf->elf, sec->idx);
 			if (!s) {
 				WARN_ELF("elf_getscn");
@@ -1133,6 +1115,12 @@ int elf_write(struct elf *elf)
 				return -1;
 			}
 
+			if (sec->base &&
+			    elf_rebuild_reloc_section(elf, sec)) {
+				WARN("elf_rebuild_reloc_section");
+				return -1;
+			}
+
 			sec->changed = false;
 			elf->changed = true;
 		}
