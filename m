Return-Path: <linux-tip-commits+bounces-5150-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 848B3AA4B29
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 14:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2599A188C7B0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 12:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D5423C4F0;
	Wed, 30 Apr 2025 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HswuOLiT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RcdF4UAZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472B02192F8;
	Wed, 30 Apr 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016198; cv=none; b=NlzoR4fFCxCjCiFl4YDg0K34gOb6LiVSoh8eZz1uB2+NByaOJl++UAWEbHP1LWsmNz5Q2QG/jA1b2GyOBncZ1WujxyKfzpGxmaDGFZXkcOjC0M16ES08+FCJpAFqbUrO/gkv8xAXgeR3PPywHgOlHMAEnIuTtcqrMLLw+3wG9fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016198; c=relaxed/simple;
	bh=03RoG5ssvYgphRPWuKpBy/oUEqjGDzfbNdKGvxo1NeU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GAs+let3zY6r9G6xsDwlshTeCRsOAYTX/qqgLlpVZcdDRvAYK1X5bgjLk8qufRKApYO6X+DAxbx3AGVV8bOAQIbHbVld+HgjlqBYY2lKHSkykbs5BthqQsKWNPGjEUJtLJIqxefPJ0tNaroi2mkKFrGkyFNNGsw2UOZ58SRMKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HswuOLiT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RcdF4UAZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Apr 2025 12:29:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746016195;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02vi3ByhvHgblNda280U9vFLDG5wlQrj8ahf/Zzze4k=;
	b=HswuOLiTp+yGzzo29mR6ul5bD/4v+VL26KiipQzMK3j0gFJ/JWR+Y7d6op3h4xRFtP+kfQ
	E/B568/P4ebwbAkEwJSae5qzfsMu0ZvXHalNfv9BjejPAtxO0EuYI4p/ONBkFn17IPlj3G
	eMfP8X3KnatzHvCoYresDr+/LyzH0thydnXkxNjEdIkSQTvX3FGuho3USrIzEZHYF3tsVX
	BRTJ9duyy1XpqC2BheGlozaTOEWbUsRwMjMWyA5LRorEuwQOQJ5uW6e0cRh8LJG+9rYYeb
	OoIl2yxnuq03dA/cW+2VzvDq3h+lZV0kgSunoEaZmrgavZtegSK6hHYD0Ubvqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746016195;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02vi3ByhvHgblNda280U9vFLDG5wlQrj8ahf/Zzze4k=;
	b=RcdF4UAZ8WWrNWAQWCK5my2aL/spOrfN2anCblIB1dVzzlT3YDBpMDA2DSEUhdbhBV0dS/
	oRmRb+1AUYFScfBQ==
From: "tip-bot2 for Rong Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix up st_info in COMDAT group section
Cc: Rong Xu <xur@google.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250425200541.113015-1-xur@google.com>
References: <20250425200541.113015-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174601619410.22196.10353886760773998736.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2cb291596e2c1837238bc322ae3545dacb99d584
Gitweb:        https://git.kernel.org/tip/2cb291596e2c1837238bc322ae3545dacb99d584
Author:        Rong Xu <xur@google.com>
AuthorDate:    Fri, 25 Apr 2025 13:05:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 30 Apr 2025 13:58:34 +02:00

objtool: Fix up st_info in COMDAT group section

When __elf_create_symbol creates a local symbol, it relocates the first
global symbol upwards to make space. Subsequently, elf_update_symbol()
is called to refresh the symbol table section. However, this isn't
sufficient, as other sections might have the reference to the old
symbol index, for instance, the sh_info field of an SHT_GROUP section.

This patch updates the `sh_info` field when necessary. This field
serves as the key for the COMDAT group. An incorrect key would prevent
the linker's from deduplicating COMDAT symbols, leading to duplicate
definitions in the final link.

Signed-off-by: Rong Xu <xur@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250425200541.113015-1-xur@google.com
---
 tools/objtool/elf.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 727a3a4..8dffe68 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -573,6 +573,30 @@ err:
 }
 
 /*
+ * @sym's idx has changed.  Update the sh_info in group sections.
+ */
+static void elf_update_group_sh_info(struct elf *elf, Elf32_Word symtab_idx,
+				     Elf32_Word new_idx, Elf32_Word old_idx)
+{
+	struct section *sec;
+
+	list_for_each_entry(sec, &elf->sections, list) {
+		if (sec->sh.sh_type != SHT_GROUP)
+			continue;
+		if (sec->sh.sh_link == symtab_idx &&
+		    sec->sh.sh_info == old_idx) {
+			sec->sh.sh_info = new_idx;
+			mark_sec_changed(elf, sec, true);
+			/*
+			 * Each ELF group should have a unique symbol key.
+			 * Return early on match.
+			 */
+			return;
+		}
+	}
+}
+
+/*
  * @sym's idx has changed.  Update the relocs which reference it.
  */
 static int elf_update_sym_relocs(struct elf *elf, struct symbol *sym)
@@ -745,7 +769,7 @@ __elf_create_symbol(struct elf *elf, struct symbol *sym)
 
 	/*
 	 * Move the first global symbol, as per sh_info, into a new, higher
-	 * symbol index. This fees up a spot for a new local symbol.
+	 * symbol index. This frees up a spot for a new local symbol.
 	 */
 	first_non_local = symtab->sh.sh_info;
 	old = find_symbol_by_index(elf, first_non_local);
@@ -763,6 +787,7 @@ __elf_create_symbol(struct elf *elf, struct symbol *sym)
 		if (elf_update_sym_relocs(elf, old))
 			return NULL;
 
+		elf_update_group_sh_info(elf, symtab->idx, new_idx, first_non_local);
 		new_idx = first_non_local;
 	}
 

