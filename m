Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DE828638F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 18:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgJGQUW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 12:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgJGQUV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 12:20:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEC3C0613D2;
        Wed,  7 Oct 2020 09:20:20 -0700 (PDT)
Date:   Wed, 07 Oct 2020 16:20:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602087619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2CQOWLh81C1ASv08nLkbGSIyHBxPmkM+chlpE/DUPx0=;
        b=e1IzbuiUDmyzCgIsJjSixkr6J1PS6KWa913B0TQogaL7750s2WYvNvOMtnYl03cMB9XoUt
        zqpmhfExNzccKmZMys2a/djBmQeqV2HMt+x36+nACfPX72HNjPRCunwK8bQ+kDfLUA1d6V
        DT5HgDnJ5Gd9GCP/pim8iSKF4h7iENuAxUWJ0uUGSkYg6xay4umwWvYWNpL8HghBpJW3oM
        hE2E7bPjcx9B71YAVoAmcV6lIaosm6QssU9taBYNEmIs9o5CJaJ6g1yFu7v2ggf9uvtA6T
        8DrD1o+eLaRb8ATjHbnF+u4Js7Grwe7pvTO03oGVNi3eOGPYHc0I+6zPQSXgVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602087619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2CQOWLh81C1ASv08nLkbGSIyHBxPmkM+chlpE/DUPx0=;
        b=qTYNRXcmj7dEV3puEvYeYItkvr9B/qkL0bmW7m4tUDfHxokEk38jJi6u7zJHiWMlcH/3ub
        POHfcd+7VwC7XcDg==
From:   "tip-bot2 for Martin Schwidefsky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix reloc generation on big endian cross
 compiles
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160208761875.7002.3433729729331164826.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     317664a7fcc99d9bcc0cb33ac05e27764f3024e4
Gitweb:        https://git.kernel.org/tip/317664a7fcc99d9bcc0cb33ac05e27764f3024e4
Author:        Martin Schwidefsky <schwidefsky@de.ibm.com>
AuthorDate:    Sun, 04 Oct 2020 16:30:50 +02:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 06 Oct 2020 09:36:48 -05:00

objtool: Fix reloc generation on big endian cross compiles

Currently relocations generated in elf_rebuild_rel_reloc_section/
elf_rebuild_rela_reloc_section functions are broken if the objtool is
built and run on big endian system. E.g. the following errors pop up
during x86 cross compilation:
x86_64-9.1.0-ld: fs/efivarfs/inode.o: bad reloc symbol index (0x2000000 >=
		0x22) for offset 0 in section `.orc_unwind_ip'
x86_64-9.1.0-ld: final link failed: bad value

To address that convert those functions to do things similar to
elf_write_reloc(), reuse gelf_update_rel/gelf_update_rela libelf library
functions.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4e1d746..5c0341b 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -829,25 +829,27 @@ static int elf_rebuild_rel_reloc_section(struct section *sec, int nr)
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
 
@@ -858,26 +860,28 @@ static int elf_rebuild_rela_reloc_section(struct section *sec, int nr)
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
 
