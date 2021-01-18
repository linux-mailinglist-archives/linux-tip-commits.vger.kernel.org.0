Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4622F9DA8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Jan 2021 12:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbhARKsS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 18 Jan 2021 05:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389763AbhARKOh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 18 Jan 2021 05:14:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A68C0613ED;
        Mon, 18 Jan 2021 02:13:34 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:13:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610964812;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IvmVZPP0VndjtYa6L8VFCBF6N0RsHzRUtXE/hWwsACc=;
        b=4Uf2gEwafbqMpPzu+KOMsou5+iKxjSkRMnjx1SrS17iCwuvRwbaZk+WN5RfBEaDCq8dS94
        4ZnOU2TmffFMxLgNdASnzi6mPwROQdJrfIdvREl++DT360hFE33Ytpvm53zb9JQ/pWjfXK
        vDl07PnJW1b+jw2TgROLfxh+RyMMT11YfJSzxvGn4mSqX+Ry8Z7evmAGVASV2HXJjWom6/
        FUKbrhLLMMzugO6zWiq8STLoWX+qvPIfiUfpF1/BqzEX4wabLkfqECMSRow9Xku3Z/tLDX
        CifsNE6Sy8YRWIEu3gnZZXq0oRTusRoG9yBQsJ2YW30ZCeUie6UHRx2kBwN91w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610964812;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IvmVZPP0VndjtYa6L8VFCBF6N0RsHzRUtXE/hWwsACc=;
        b=7o6ScEduPFMcQTZ0/fa0gEd0Iy6dWxNXGRA6V3tqZqNarI2weEfMUOg1rZVSIf3nrM94oi
        YBc0yNuIVOicMJBg==
From:   "tip-bot2 for Martin Schwidefsky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix reloc generation on big endian
 cross-compiles
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161096481208.414.14523335310723551001.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a1a664ece586457e9f7652b0bc5b08386259e358
Gitweb:        https://git.kernel.org/tip/a1a664ece586457e9f7652b0bc5b08386259e358
Author:        Martin Schwidefsky <schwidefsky@de.ibm.com>
AuthorDate:    Fri, 13 Nov 2020 00:03:26 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Wed, 13 Jan 2021 18:13:12 -06:00

objtool: Fix reloc generation on big endian cross-compiles

Relocations generated in elf_rebuild_rel[a]_reloc_section() are broken
if objtool is built and run on a big endian system.

The following errors pop up during x86 cross-compilation:

  x86_64-9.1.0-ld: fs/efivarfs/inode.o: bad reloc symbol index (0x2000000 >= 0x22) for offset 0 in section `.orc_unwind_ip'
  x86_64-9.1.0-ld: final link failed: bad value

Convert those functions to use gelf_update_rel[a](), similar to what
elf_write_reloc() does.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index be89c74..c784122 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -855,25 +855,27 @@ static int elf_rebuild_rel_reloc_section(struct section *sec, int nr)
 {
 	struct reloc *reloc;
 	int idx = 0, size;
-	GElf_Rel *relocs;
+	void *buf;
 
 	/* Allocate a buffer for relocations */
-	size = nr * sizeof(*relocs);
-	relocs = malloc(size);
-	if (!relocs) {
+	size = nr * sizeof(GElf_Rel);
+	buf = malloc(size);
+	if (!buf) {
 		perror("malloc");
 		return -1;
 	}
 
-	sec->data->d_buf = relocs;
+	sec->data->d_buf = buf;
 	sec->data->d_size = size;
+	sec->data->d_type = ELF_T_REL;
 
 	sec->sh.sh_size = size;
 
 	idx = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list) {
-		relocs[idx].r_offset = reloc->offset;
-		relocs[idx].r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		reloc->rel.r_offset = reloc->offset;
+		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		gelf_update_rel(sec->data, idx, &reloc->rel);
 		idx++;
 	}
 
@@ -884,26 +886,28 @@ static int elf_rebuild_rela_reloc_section(struct section *sec, int nr)
 {
 	struct reloc *reloc;
 	int idx = 0, size;
-	GElf_Rela *relocs;
+	void *buf;
 
 	/* Allocate a buffer for relocations with addends */
-	size = nr * sizeof(*relocs);
-	relocs = malloc(size);
-	if (!relocs) {
+	size = nr * sizeof(GElf_Rela);
+	buf = malloc(size);
+	if (!buf) {
 		perror("malloc");
 		return -1;
 	}
 
-	sec->data->d_buf = relocs;
+	sec->data->d_buf = buf;
 	sec->data->d_size = size;
+	sec->data->d_type = ELF_T_RELA;
 
 	sec->sh.sh_size = size;
 
 	idx = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list) {
-		relocs[idx].r_offset = reloc->offset;
-		relocs[idx].r_addend = reloc->addend;
-		relocs[idx].r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		reloc->rela.r_offset = reloc->offset;
+		reloc->rela.r_addend = reloc->addend;
+		reloc->rela.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		gelf_update_rela(sec->data, idx, &reloc->rela);
 		idx++;
 	}
 
