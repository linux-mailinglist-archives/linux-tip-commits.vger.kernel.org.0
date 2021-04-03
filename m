Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D0E353394
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 Apr 2021 13:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbhDCLLD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 3 Apr 2021 07:11:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42366 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbhDCLLB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 3 Apr 2021 07:11:01 -0400
Date:   Sat, 03 Apr 2021 11:10:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617448257;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UNPE4d/oWmUADnSXnDyfXg57dZHkC45EtWI+RW9T5tA=;
        b=eQMnU6CBp5ywRQL/lST37m2ai0Ke/AkU1LGKfRyKW4YANXxkh847JyVOIWUAc1gHIPB2+a
        Ks8QiN2XgwmJ+3gsoI462pySwsHQt7v7mXQxQlwJ+G/M/wpTcXjzLoDwvyR/vklv0RIcy6
        hTnYW/9hsIgJXnia5ZlDKgjcOVjxDYDeM+MgsyfkESlyIFKu+Hv169r3XMyprrunxe1fOU
        XxOXrlrQCIBhoxjmoOVM5QzI29z9/kHQKR76iaAnlvpcX90IIouNXz0Xt2k+RFs2syh3j9
        ny+FOLQH598Yc0YMalnsQN5XFe/pZTQZN8aDXEA4HxjRM5Kh4/cz+7ZI6WdIOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617448257;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UNPE4d/oWmUADnSXnDyfXg57dZHkC45EtWI+RW9T5tA=;
        b=yKN8a2EOoIUxqNIiTNtRvuJHiH8HhsB8pN1NIXRSE6FSCJlSIhOtooAftCLSxHlAtJBAZK
        14pZYp31nRml7PBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Extract elf_strtab_concat()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326151259.941474004@infradead.org>
References: <20210326151259.941474004@infradead.org>
MIME-Version: 1.0
Message-ID: <161744825705.29796.13759934651137424590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     417a4dc91e559f92404c2544f785b02ce75784c3
Gitweb:        https://git.kernel.org/tip/417a4dc91e559f92404c2544f785b02ce75784c3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:09 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 Apr 2021 12:44:56 +02:00

objtool: Extract elf_strtab_concat()

Create a common helper to append strings to a strtab.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/20210326151259.941474004@infradead.org
---
 tools/objtool/elf.c | 60 +++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 7b65ae3..c278a04 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -673,13 +673,48 @@ err:
 	return NULL;
 }
 
+static int elf_add_string(struct elf *elf, struct section *strtab, char *str)
+{
+	Elf_Data *data;
+	Elf_Scn *s;
+	int len;
+
+	if (!strtab)
+		strtab = find_section_by_name(elf, ".strtab");
+	if (!strtab) {
+		WARN("can't find .strtab section");
+		return -1;
+	}
+
+	s = elf_getscn(elf->elf, strtab->idx);
+	if (!s) {
+		WARN_ELF("elf_getscn");
+		return -1;
+	}
+
+	data = elf_newdata(s);
+	if (!data) {
+		WARN_ELF("elf_newdata");
+		return -1;
+	}
+
+	data->d_buf = str;
+	data->d_size = strlen(str) + 1;
+	data->d_align = 1;
+
+	len = strtab->len;
+	strtab->len += data->d_size;
+	strtab->changed = true;
+
+	return len;
+}
+
 struct section *elf_create_section(struct elf *elf, const char *name,
 				   unsigned int sh_flags, size_t entsize, int nr)
 {
 	struct section *sec, *shstrtab;
 	size_t size = entsize * nr;
 	Elf_Scn *s;
-	Elf_Data *data;
 
 	sec = malloc(sizeof(*sec));
 	if (!sec) {
@@ -736,7 +771,6 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	sec->sh.sh_addralign = 1;
 	sec->sh.sh_flags = SHF_ALLOC | sh_flags;
 
-
 	/* Add section name to .shstrtab (or .strtab for Clang) */
 	shstrtab = find_section_by_name(elf, ".shstrtab");
 	if (!shstrtab)
@@ -745,27 +779,9 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 		WARN("can't find .shstrtab or .strtab section");
 		return NULL;
 	}
-
-	s = elf_getscn(elf->elf, shstrtab->idx);
-	if (!s) {
-		WARN_ELF("elf_getscn");
+	sec->sh.sh_name = elf_add_string(elf, shstrtab, sec->name);
+	if (sec->sh.sh_name == -1)
 		return NULL;
-	}
-
-	data = elf_newdata(s);
-	if (!data) {
-		WARN_ELF("elf_newdata");
-		return NULL;
-	}
-
-	data->d_buf = sec->name;
-	data->d_size = strlen(name) + 1;
-	data->d_align = 1;
-
-	sec->sh.sh_name = shstrtab->len;
-
-	shstrtab->len += strlen(name) + 1;
-	shstrtab->changed = true;
 
 	list_add_tail(&sec->list, &elf->sections);
 	elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
