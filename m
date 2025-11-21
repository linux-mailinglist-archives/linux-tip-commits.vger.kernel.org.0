Return-Path: <linux-tip-commits+bounces-7450-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E267EC784A7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 11:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B49F72D89A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 10:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29253346A06;
	Fri, 21 Nov 2025 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VTWEE63U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hpUot0Z2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04D345738;
	Fri, 21 Nov 2025 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719083; cv=none; b=nr1z5nn3Gzgz3dSdUOYDuCoEoBQpM2gtkJlHNvQsor4Vm6VZupWjwNG1IGJppgRJOEicckeOoF3e3zsEsvoWm6zw++PJbkJabK5Omgbk5fmi86IYeikvPyxvREiHK+QrfN+hLO/DqCpGKoLldDMHCUbbdCYtZt1Obxn/G0OTtn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719083; c=relaxed/simple;
	bh=w2h9wMyKVl36yNGp42WX+oX+mI08AtYQW9clOt7wn/o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U8tBXngc4y6bJoTWNr7qQHvyWgGUSxXsEk+aZj3jLxVhhJI7Yn9yGUTqJtdGQitZrXc/wukJAqOy9TaiXLiqJYCY4rRfnkfWcNms3Rk8vnb44WpIPORuxq8YaZA4MOuHvkwz9dzaK2wDliCmZQZ+zOI+sPuC/6v3/shmBWN/9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VTWEE63U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hpUot0Z2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 09:57:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763719079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEWUGh8keVVE1HAGj3mIOR0dFXAFZIPrmunGr3Y0Z+Q=;
	b=VTWEE63Uk7TdHYJNpee5r30eabkhe3+8ujp9OuvNyug1txsTAz4DJbBDE2pSmH4AyC7rS6
	ldLuMPfHkHzIiK91LQTEwtX5MwVGH/K0CBfhlwUevPUTWYsDrdH+VQ6hsMfv+Kab4np21v
	xJvrIF81kh2es26fVxVVnN1uiDc4tu6vN9+Ho+dQOlRQKZ1j/X71+OgfNliAA/CRhKmcxv
	pEdb6JYAWVLg37Rdd49FVWh6fwHo0hKsd4ZO06UOeLLni/aGojGUtJ3v/p2pqMPoyfHWi2
	ya+28JeyvnY27MX4SccAObFWc2GtZG37JobVVbZOuLADB5rtvNra41PL6ZX4zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763719079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEWUGh8keVVE1HAGj3mIOR0dFXAFZIPrmunGr3Y0Z+Q=;
	b=hpUot0Z2o9j62rK8cS5eF+iJqqU3Jbt9kK8h135C0iCLPLsybBYSghY0ZniJ6IwdwM558x
	MQaZuG9CyKh60rDQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Return canonical symbol when aliases
 exist in symbol finding helpers
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <450470a4897706af77453ad333e18af5ebab653c.1763671318.git.jpoimboe@kernel.org>
References:
 <450470a4897706af77453ad333e18af5ebab653c.1763671318.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176371907782.498.4895430525784956919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9205a322cf96f16a49e412dfa3f09431f3e02fc5
Gitweb:        https://git.kernel.org/tip/9205a322cf96f16a49e412dfa3f09431f3e=
02fc5
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 20 Nov 2025 12:52:18 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 10:04:08 +01:00

objtool: Return canonical symbol when aliases exist in symbol finding helpers

When symbol alias ambiguity exists in the symbol finding helper
functions, return the canonical sym->alias, as that's the one which gets
used by validate_branch() and elsewhere.

This doesn't fix any known issues, just makes the symbol alias behavior
more robust.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/450470a4897706af77453ad333e18af5ebab653c.17636=
71318.git.jpoimboe@kernel.org
---
 tools/objtool/elf.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4f15643..7e2c0ae 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -172,11 +172,11 @@ static struct symbol *find_symbol_by_index(struct elf *=
elf, unsigned int idx)
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offs=
et)
 {
 	struct rb_root_cached *tree =3D (struct rb_root_cached *)&sec->symbol_tree;
-	struct symbol *iter;
+	struct symbol *sym;
=20
-	__sym_for_each(iter, tree, offset, offset) {
-		if (iter->offset =3D=3D offset && !is_sec_sym(iter))
-			return iter;
+	__sym_for_each(sym, tree, offset, offset) {
+		if (sym->offset =3D=3D offset && !is_sec_sym(sym))
+			return sym->alias;
 	}
=20
 	return NULL;
@@ -185,11 +185,11 @@ struct symbol *find_symbol_by_offset(struct section *se=
c, unsigned long offset)
 struct symbol *find_func_by_offset(struct section *sec, unsigned long offset)
 {
 	struct rb_root_cached *tree =3D (struct rb_root_cached *)&sec->symbol_tree;
-	struct symbol *iter;
+	struct symbol *func;
=20
-	__sym_for_each(iter, tree, offset, offset) {
-		if (iter->offset =3D=3D offset && is_func_sym(iter))
-			return iter;
+	__sym_for_each(func, tree, offset, offset) {
+		if (func->offset =3D=3D offset && is_func_sym(func))
+			return func->alias;
 	}
=20
 	return NULL;
@@ -220,7 +220,7 @@ struct symbol *find_symbol_containing(const struct sectio=
n *sec, unsigned long o
 		}
 	}
=20
-	return sym;
+	return sym ? sym->alias : NULL;
 }
=20
 /*
@@ -266,11 +266,11 @@ int find_symbol_hole_containing(const struct section *s=
ec, unsigned long offset)
 struct symbol *find_func_containing(struct section *sec, unsigned long offse=
t)
 {
 	struct rb_root_cached *tree =3D (struct rb_root_cached *)&sec->symbol_tree;
-	struct symbol *iter;
+	struct symbol *func;
=20
-	__sym_for_each(iter, tree, offset, offset) {
-		if (is_func_sym(iter))
-			return iter;
+	__sym_for_each(func, tree, offset, offset) {
+		if (is_func_sym(func))
+			return func->alias;
 	}
=20
 	return NULL;

