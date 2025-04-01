Return-Path: <linux-tip-commits+bounces-4602-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FE7A77502
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 09:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BB418898C2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 07:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4BF1EA7CF;
	Tue,  1 Apr 2025 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hX/b8hTo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kFmHDvUQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9E51E9B09;
	Tue,  1 Apr 2025 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743491723; cv=none; b=snFCgp80dWerAXQdxg+WnLtUr9UfmHfPCU52Ku0hS8bKDNvuOFdL+AQNmeC/wBveprQNjXRyy4vwmLRwhgxwHPROAuCHYyTrXDFGAaCSSujZNb223d6xQuMObBy/6PRkB0EhqUFo37FHNlmSTBw+oz6+RWv7GxDFZpIqHO1Mek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743491723; c=relaxed/simple;
	bh=AV7Jt/B/edN9deL6Blala/bWrQHyXgNxZe24V1cIDyE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vAZXZPHPbC3kz3XcNkar/7dbfC23diqmVm0UwRSela8RJSjwZ6iWzohdfSku8kxmU0U/56qDrz77N0CXuhEB+KDIUnAgWyYf1r+Xeh5aEDoXY6yoBJ8AVQ8q5sVTlHY+kJQeYT+2nGACWjLZiWg0us98FevKFASIg68X2AVPfeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hX/b8hTo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kFmHDvUQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 07:15:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743491720;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHPfmNgtqvmhQdxAPumC6Sx0F5ZR0FBFz1XaDHn4ZRk=;
	b=hX/b8hToH+pVYbYsp6SZeZmqoBVZmbvdaqF9mMN5eeu4mx19LPG9UojmXiAS6ul2tBRmnO
	QcCO7nEmkjV9S3qQ7+2aROp+F6v4bbcjroE2MJDilO3+I4oPsie0lFGQOVSnGiCrixzqDu
	XGUdxFEbSEjIbYK1l6La3r0Zu9mENxoAZVZKb127IWDwsSrTVaCqCYbP19dh3tzeifCMPD
	Vc3+C8lPvHwprRk1MHdl3ccfrP+4b8yU1k7Lr0WXfCJFoB+84bhj9QRVhSyGbjCArV/35o
	vCcpzKnAH8tw39LV9mADFyKmP1Lw7KLIlgftEVXMnOUgL0RZYqPT9Os/D8MP/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743491720;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHPfmNgtqvmhQdxAPumC6Sx0F5ZR0FBFz1XaDHn4ZRk=;
	b=kFmHDvUQX9qx/cItShsG9lq+kejwnd8zfB+vkQjUlx2E02UDBSj2/n+hRBK+eRjYQlvnji
	qAioCbEi8UNk4qCQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] Revert "objtool: Increase per-function
 WARN_FUNC() rate limit"
Cc: Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <e5abe5e858acf1a9207a5dfa0f37d17ac9dca872.1743481539.git.jpoimboe@kernel.org>
References:
 <e5abe5e858acf1a9207a5dfa0f37d17ac9dca872.1743481539.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174349171954.14745.12146555759231129514.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     c5610071a69d1c94c70e681874298b4fc6942098
Gitweb:        https://git.kernel.org/tip/c5610071a69d1c94c70e681874298b4fc6942098
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 31 Mar 2025 21:26:39 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 09:07:13 +02:00

Revert "objtool: Increase per-function WARN_FUNC() rate limit"

This reverts commit 0a7fb6f07e3ad497d31ae9a2082d2cacab43d54a.

The "skipping duplicate warnings" warning is technically not an actual
warning, which can cause confusion.  This feature isn't all that useful
anyway.  It's exceedingly rare for a function to have more than one
unrelated warning.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/e5abe5e858acf1a9207a5dfa0f37d17ac9dca872.1743481539.git.jpoimboe@kernel.org
---
 tools/objtool/check.c                |  4 ++--
 tools/objtool/include/objtool/elf.h  |  2 +-
 tools/objtool/include/objtool/warn.h | 14 +++-----------
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bd0c78b..c8b3c8e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3545,7 +3545,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn_func(insn)->name);
-			func->warnings++;
+			func->warned = 1;
 
 			return 1;
 		}
@@ -4576,7 +4576,7 @@ static void disas_warned_funcs(struct objtool_file *file)
 	char *funcs = NULL, *tmp;
 
 	for_each_sym(file, sym) {
-		if (sym->warnings) {
+		if (sym->warned) {
 			if (!funcs) {
 				funcs = malloc(strlen(sym->name) + 1);
 				if (!funcs) {
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index eba0439..c7c4e87 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -65,11 +65,11 @@ struct symbol {
 	u8 return_thunk      : 1;
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
+	u8 warned	     : 1;
 	u8 embedded_insn     : 1;
 	u8 local_label       : 1;
 	u8 frame_pointer     : 1;
 	u8 ignore	     : 1;
-	u8 warnings	     : 2;
 	struct list_head pv_target;
 	struct reloc *relocs;
 };
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index b29ac14..e3ad9b2 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -57,22 +57,14 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 	free(_str);					\
 })
 
-#define WARN_LIMIT 2
-
 #define WARN_INSN(insn, format, ...)					\
 ({									\
 	struct instruction *_insn = (insn);				\
-	BUILD_BUG_ON(WARN_LIMIT > 2);					\
-	if (!_insn->sym || _insn->sym->warnings < WARN_LIMIT) {		\
+	if (!_insn->sym || !_insn->sym->warned)				\
 		WARN_FUNC(format, _insn->sec, _insn->offset,		\
 			  ##__VA_ARGS__);				\
-		if (_insn->sym)						\
-			_insn->sym->warnings++;				\
-	} else if (_insn->sym && _insn->sym->warnings == WARN_LIMIT) {	\
-		WARN_FUNC("skipping duplicate warning(s)",		\
-			  _insn->sec, _insn->offset);			\
-		_insn->sym->warnings++;					\
-	}								\
+	if (_insn->sym)							\
+		_insn->sym->warned = 1;					\
 })
 
 #define BT_INSN(insn, format, ...)				\

