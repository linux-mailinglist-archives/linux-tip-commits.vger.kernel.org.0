Return-Path: <linux-tip-commits+bounces-5456-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B1CAAEFDB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 02:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9843A46F4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 00:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC36F4C92;
	Thu,  8 May 2025 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljVlaRij"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19243C17;
	Thu,  8 May 2025 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663063; cv=none; b=uYvBJ+BuHzD9uzr5eUHZg5KGgtZaFAXc/a4dZ2w1hSrfP2ERk2CkfWUydm1HKzQ+jQxCsXZd80sfy3IhOv+CiEj5KO8loDwhZ81utRzTuUATyhcgT1Xv8YoI+wx2I81YczkQbBMclj0vIeVQjx5mUMlnXC2MZJC/lfxwIYyXLvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663063; c=relaxed/simple;
	bh=4siQigJilw100npKcXGGark1//iTUMqBNxWax1BXEDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNauj624nIE08hCTadOmGai82fJNyOQ3j9fomz3w48zvctMF2lW7vQFPywo0/eRtLWdOGqnnfkVtIX5bF0tpNr9wj3VBrBqhZX76XQFoyEmGYKgeYxagwnhFmxERObL5k7R6C5jLOUy4XaTs52wr6P/tPAuC2c+EN8dSetJwyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljVlaRij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089FAC4CEE2;
	Thu,  8 May 2025 00:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746663063;
	bh=4siQigJilw100npKcXGGark1//iTUMqBNxWax1BXEDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ljVlaRij8/Jv9LCGzgJ5H5oGb9/0472rCmfL5E7hJ7HJYdvkbIVe68dZOYk0knMwg
	 sP6VX9YPpxTrb0+M2x2vibZLf8IgZW4bEqoJ+ioJu2c7qsIJ4g2P6/gdDcu1hz7+i0
	 TSvVTlmxdi30SBJ0fGbrjQjYFMKzTqNaohrSeKwVLiiA2eZSFbkg/u6oUNLr32EY1C
	 8cnJqBjublOUomG3BvkFPHQfs+lcQ1zXnlxbvExnHIdDCWV9QQF26zB6E3KlOds2H2
	 MHpU5yoJF95/VpmUjT86toa1qLyNhRBRQupJdCrnQFv8fLMQgIr3EYrtBfjuy3IgwK
	 EObxo+5TRGMrQ==
Date: Wed, 7 May 2025 17:11:01 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: tip-bot2 for Rong Xu <tip-bot2@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org, Rong Xu <xur@google.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: Speed up SHT_GROUP reindexing
Message-ID: <yrdh2fmzgqlrfe35wvxb3a2z7wdqod3liupdbriqzc5ihqjw5y@fsqeyi34cbgg>
References: <20250425200541.113015-1-xur@google.com>
 <174601619410.22196.10353886760773998736.tip-bot2@tip-bot2>
 <jj4fu243l7ap4bza5imrgjk5f5dhsoloxezgphdjwo7sb5iqsq@wkt46abbt45r>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jj4fu243l7ap4bza5imrgjk5f5dhsoloxezgphdjwo7sb5iqsq@wkt46abbt45r>

From 2a33e583c87e3283706f346f9d59aac20653b7fd Mon Sep 17 00:00:00 2001
Message-ID: <2a33e583c87e3283706f346f9d59aac20653b7fd.1746662991.git.jpoimboe@kernel.org>
From: Josh Poimboeuf <jpoimboe@kernel.org>
Date: Wed, 7 May 2025 16:56:55 -0700
Subject: [PATCH] objtool: Speed up SHT_GROUP reindexing

After elf_update_group_sh_info() was introduced, a prototype version of
"objtool klp diff" went from taking ~1s to several minutes, due to
looping almost endlessly in elf_update_group_sh_info() while creating
thousands of local symbols in a file with thousands of sections.

Dramatically improve the performance by marking all symbols' correlated
SHT_GROUP sections while reading the object.  That way there's no need
to search for it every time a symbol gets reindexed.

Fixes: 2cb291596e2c ("objtool: Fix up st_info in COMDAT group section")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 47 ++++++++++++++++++-----------
 tools/objtool/include/objtool/elf.h |  1 +
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 8dffe68d705c..ca5d77db692a 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -572,28 +572,32 @@ static int read_symbols(struct elf *elf)
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
index c7c4e87ebe88..0a2fa3ac0079 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -72,6 +72,7 @@ struct symbol {
 	u8 ignore	     : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
+	struct section *group_sec;
 };
 
 struct reloc {
-- 
2.49.0


