Return-Path: <linux-tip-commits+bounces-6909-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CD1BE2979
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 593C34FD244
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DEF338F3D;
	Thu, 16 Oct 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L3cnZqGP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u4z+vPl+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879B320CD6;
	Thu, 16 Oct 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608405; cv=none; b=kPdVvxnKSEWaitLWJ7zrvkk2Nn+i67kJhk6qmJ28fg5LFGy0ZRwPnvDMLA/DOlxr+jf/gMpY/LiH6kp+aBoBSRK5Umgp4JiFKHVjwMidsTAtAHrJamLCAouCDGQKpbHg1335/IdtjxTCZsRF/Kh0egnBC5PNXuEC6gnp0NzMhqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608405; c=relaxed/simple;
	bh=gbS4B0nWZlsTwLkElILYBekxjF1UfbQV8rvufEzBDfM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=tAVXEg8a95PL8fCFmePW6olk/y2nQ5dG1m5NOxYi+1+Lovk50Zmg9/n58IOfqmp368OMzqfgeG3acV1C5N4uVthzWo/2v0FctPCB/FMtyKYj2TamRIi9dUVXMmszi30y6I6vYHqrOpJRA1l8JiXJio8wClli28XHAmulODJkmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L3cnZqGP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u4z+vPl+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608385;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GljnXhwRygEgCtABSOSjLXbtYWY4Rm4x7H2ZqcziBp8=;
	b=L3cnZqGPhjfmFTr0zgxEyBStplfDgtMd35Y2uiRDFP93GHop6uNpmqQTmxu9MQs9OjHkHo
	3EkZJGnORjrFRUAywUiBcYpan/JeQPIJRx+cH+QoGIvqXDvPWHRSbZpgeLIvuTbZrjKINr
	TPEzh/qHfloxUyr9ARoo3b8cQVrKVY+CFhzp3knPOJrOBsex9WmXqHZQjnc6s7ek9I6xBp
	7wFRcO5482E1nSr5vuOrbnSDoZu9Ltp80+osjEwZPTqJghuN2MfUM5vX0Uor98z9j+fBqt
	2ffhHuoIujTXj5CNC9LT9dcx79S+/mlNgbOHB89iFEoDWHPZPgOiLHzu/DA2pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608385;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GljnXhwRygEgCtABSOSjLXbtYWY4Rm4x7H2ZqcziBp8=;
	b=u4z+vPl++A1kJYtistpNhBZdt2Y75PqUAGM3I7JnZ3DIoQspNuQVJ4KewIy53sq+VXwWJk
	6zfnBkzPfDZIDbAA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Make find_symbol_containing() less arbitrary
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060838453.709179.413070869789332949.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     07e1c3fd86d7a2ddce3ebc6b7390590c8524a484
Gitweb:        https://git.kernel.org/tip/07e1c3fd86d7a2ddce3ebc6b7390590c852=
4a484
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:21 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:23 -07:00

objtool: Make find_symbol_containing() less arbitrary

In the rare case of overlapping symbols, find_symbol_containing() just
returns the first one it finds.  Make it slightly less arbitrary by
returning the smallest symbol with size > 0.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index ca5d77d..1c1bb2c 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -193,14 +193,29 @@ struct symbol *find_func_by_offset(struct section *sec,=
 unsigned long offset)
 struct symbol *find_symbol_containing(const struct section *sec, unsigned lo=
ng offset)
 {
 	struct rb_root_cached *tree =3D (struct rb_root_cached *)&sec->symbol_tree;
-	struct symbol *iter;
+	struct symbol *sym =3D NULL, *tmp;
=20
-	__sym_for_each(iter, tree, offset, offset) {
-		if (iter->type !=3D STT_SECTION)
-			return iter;
+	__sym_for_each(tmp, tree, offset, offset) {
+		if (tmp->len) {
+			if (!sym) {
+				sym =3D tmp;
+				continue;
+			}
+
+			if (sym->offset !=3D tmp->offset || sym->len !=3D tmp->len) {
+				/*
+				 * In the rare case of overlapping symbols,
+				 * pick the smaller one.
+				 *
+				 * TODO: outlaw overlapping symbols
+				 */
+				if (tmp->len < sym->len)
+					sym =3D tmp;
+			}
+		}
 	}
=20
-	return NULL;
+	return sym;
 }
=20
 /*

