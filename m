Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703A73518B3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Apr 2021 19:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbhDARrS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Apr 2021 13:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbhDARlp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Apr 2021 13:41:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE503C00F7DD;
        Thu,  1 Apr 2021 08:08:58 -0700 (PDT)
Date:   Thu, 01 Apr 2021 15:08:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617289736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=07q5Zv6n+ClCM4VgUm68AYE7WpZ/SxJN4Zis1PoC5tw=;
        b=2mR8UHosoqb7ttvbjzcCHJ/okJkRcVFHGLtXFioDa3zejsM3FFZqzazP2KlGq3miEBEjiS
        7C5L48BcuS8OsIPDyTpf9THt/p9fgUKmWZ5yErdel18Hs/VB1hx6UWAYWm1DdhF6vxN6l4
        JUDGuBfXIuZ5F2C0zWxqdj4iUVyrQcKr91tbAGqNjPQ7Vo/klrQoU/vM+2pdY7t1F9srIz
        7JzEVzQti+PfHUV8Qove29aGFXGOuoTZc4cGykWYvENatRS0ipGbR1Ex19RJDeqrW95weM
        i783SEi9a+rCzkN96quoPLmVDI0IGu1Q1e0Fl7FHSZtYsHSNNO5sQchMNw/JyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617289736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=07q5Zv6n+ClCM4VgUm68AYE7WpZ/SxJN4Zis1PoC5tw=;
        b=/zt1zzWl+85xmgJNSca8WaWYEVsDw40WXMBEb7gWkH+7SIvYfrWmPmwKJMFf8qg1+A+HKT
        5/rpW3QBQyTCh+AQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Extract elf_strtab_concat()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210326151259.941474004@infradead.org>
References: <20210326151259.941474004@infradead.org>
MIME-Version: 1.0
Message-ID: <161728973595.29796.675571073397423036.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     557c25be3588971caf21364b6fd240769e37c47c
Gitweb:        https://git.kernel.org/tip/557c25be3588971caf21364b6fd240769e37c47c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:09 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 01 Apr 2021 13:05:50 +02:00

objtool: Extract elf_strtab_concat()

Create a common helper to append strings to a strtab.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
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
