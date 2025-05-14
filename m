Return-Path: <linux-tip-commits+bounces-5540-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B905AB69A4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 May 2025 13:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F9257B5676
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 May 2025 11:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D55825A350;
	Wed, 14 May 2025 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Esml3Evf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1p0rl9Ht"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33139221721;
	Wed, 14 May 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747221495; cv=none; b=i6xp8vDLlSm95DamlPA2dbcGZ+w6HISnoGkTjV0surMMOPIvoZpOMSL84nLBuuNLhuDzYJ42d/84C3x+CYnPbRmJXTW1LSp7x9M8spCac+OGKfjp3kmmdZHZiDuipDodnXAjmiGATJ+fp+lyY7ELDG0kupPrE3gMBERNRZ54jjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747221495; c=relaxed/simple;
	bh=4f8Z+7epIpiBcxMeDi1y6we01Z096thqUtKYrJUyTbY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YqW1zWb+tK8VJR68/fa4MmW9cXjkRtSq5JI8No7NKQUv7iYb5+HCPmcEPE89yI2kXXC4lWIwH+pgVOzGYqKdIFYnZhuO7b3CzcwDE02ZOzX0EAFyEwWDZRGBp6ki2brsHy7YjUZPCwAY7OJ6SzZ5mg28fPPf35FmzgG4GabUz1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Esml3Evf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1p0rl9Ht; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 May 2025 11:18:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747221492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cAQwsnpQQu4Xz7KOoBAx4WdOO3GgendAUyq+FiVcdQ=;
	b=Esml3Evf0N0XXyb4wK5Mnoytz/GL9aC17/ThnIS+Oa7Tmu+lCf7UyJ+ySVP1yi7G6AaBxB
	GbpuY5xiW2GOOZdAdKE98iTXzSuI6M94vR0YBzxeWIxOV/ZdtAOgvmRU3ZR8CMmOsWiQDy
	bWE9jTsS8x1SmF+4Wb7hn78I4dPHq9fLCtDNq5BC6Oa4pPrN+Rzi2GdZrAT0osHd+iyo0b
	+B61uVtS6+q8kkOMslkAL065qIR+m0XxJLwwnfNBrfDoJFIuyZQuFGz3vPZna8u7QF34g0
	w7bRi5oQHM5Ur450MGAwHJqsJXurEmOgF6awW9VyEJuNyi4oUN8Eg+tOTZWLwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747221492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cAQwsnpQQu4Xz7KOoBAx4WdOO3GgendAUyq+FiVcdQ=;
	b=1p0rl9HtzOO5cgA8wRati9JyWhUuFU7JAYtL6HZxmcLisDmhIR7sOv7+83uAett/gIzQee
	0IEt0kRWLwqnJ7Dg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Speed up SHT_GROUP reindexing
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Rong Xu <xur@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <2a33e583c87e3283706f346f9d59aac20653b7fd.1746662991.git.jpoimboe@kernel.org>
References:
 <2a33e583c87e3283706f346f9d59aac20653b7fd.1746662991.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174722149156.406.8813570845147463596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4ed9d82bf5b21d65e2f18249eec89a6a84df8f23
Gitweb:        https://git.kernel.org/tip/4ed9d82bf5b21d65e2f18249eec89a6a84df8f23
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 07 May 2025 16:56:55 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 14 May 2025 13:09:02 +02:00

objtool: Speed up SHT_GROUP reindexing

After elf_update_group_sh_info() was introduced, a prototype version of
"objtool klp diff" went from taking ~1s to several minutes, due to
looping almost endlessly in elf_update_group_sh_info() while creating
thousands of local symbols in a file with thousands of sections.

Dramatically improve the performance by marking all symbols' correlated
SHT_GROUP sections while reading the object.  That way there's no need
to search for it every time a symbol gets reindexed.

Fixes: 2cb291596e2c ("objtool: Fix up st_info in COMDAT group section")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Rong Xu <xur@google.com>
Link: https://lkml.kernel.org/r/2a33e583c87e3283706f346f9d59aac20653b7fd.1746662991.git.jpoimboe@kernel.org
---
 tools/objtool/elf.c                 | 47 +++++++++++++++++-----------
 tools/objtool/include/objtool/elf.h |  1 +-
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 8dffe68..ca5d77d 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -572,28 +572,32 @@ err:
 	return -1;
 }
 
-/*
- * @sym's idx has changed.  Update the sh_info in group sections.
- */
-static void elf_update_group_sh_info(struct elf *elf, Elf32_Word symtab_idx,
-				     Elf32_Word new_idx, Elf32_Word old_idx)
+static int mark_group_syms(struct elf *elf)
 {
-	struct section *sec;
+	struct section *symtab, *sec;
+	struct symbol *sym;
+
+	symtab = find_section_by_name(elf, ".symtab");
+	if (!symtab) {
+		ERROR("no .symtab");
+		return -1;
+	}
 
 	list_for_each_entry(sec, &elf->sections, list) {
-		if (sec->sh.sh_type != SHT_GROUP)
-			continue;
-		if (sec->sh.sh_link == symtab_idx &&
-		    sec->sh.sh_info == old_idx) {
-			sec->sh.sh_info = new_idx;
-			mark_sec_changed(elf, sec, true);
-			/*
-			 * Each ELF group should have a unique symbol key.
-			 * Return early on match.
-			 */
-			return;
+		if (sec->sh.sh_type == SHT_GROUP &&
+		    sec->sh.sh_link == symtab->idx) {
+			sym = find_symbol_by_index(elf, sec->sh.sh_info);
+			if (!sym) {
+				ERROR("%s: can't find SHT_GROUP signature symbol",
+				      sec->name);
+				return -1;
+			}
+
+			sym->group_sec = sec;
 		}
 	}
+
+	return 0;
 }
 
 /*
@@ -787,7 +791,11 @@ __elf_create_symbol(struct elf *elf, struct symbol *sym)
 		if (elf_update_sym_relocs(elf, old))
 			return NULL;
 
-		elf_update_group_sh_info(elf, symtab->idx, new_idx, first_non_local);
+		if (old->group_sec) {
+			old->group_sec->sh.sh_info = new_idx;
+			mark_sec_changed(elf, old->group_sec, true);
+		}
+
 		new_idx = first_non_local;
 	}
 
@@ -1060,6 +1068,9 @@ struct elf *elf_open_read(const char *name, int flags)
 	if (read_symbols(elf))
 		goto err;
 
+	if (mark_group_syms(elf))
+		goto err;
+
 	if (read_relocs(elf))
 		goto err;
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index c7c4e87..0a2fa3a 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -72,6 +72,7 @@ struct symbol {
 	u8 ignore	     : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
+	struct section *group_sec;
 };
 
 struct reloc {

