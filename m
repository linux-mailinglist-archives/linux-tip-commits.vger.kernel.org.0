Return-Path: <linux-tip-commits+bounces-6905-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C12BE2924
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2A3D34DDA5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AA9337695;
	Thu, 16 Oct 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4eF2UFIB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eZ979ls2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4B3330D52;
	Thu, 16 Oct 2025 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608402; cv=none; b=YgrOjcv3S8e4fkm+NZBW3wiXPvOzjk2n3Jm88HI5gwsQLnooTU6IotpibmNESYIFNiNHdX+b9qeA43fsclokAqU59aKykXgte1zhGYsEs+AM4zZY1Fm3dwD5+hGXa9huye1aPQevXo4K5tQfgkNlONb3IYw537UmgipOAcaks9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608402; c=relaxed/simple;
	bh=cZi1rPHVL54gob0IGQAnZlWVjEn4gZcVaVNjYnkSVU0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=hVEtr8HzSJvfWfCzjlCJ2bgHXnBbgFb08hD4CrjecA2UvbBTdbG52GT8l4Ry1CPcmjuDF8q3rUOjo1siZfP4hjV/v1WZlvqa1OQG4212L6LXjM2ZvpLEWvajUMwxVQ9zktNVs/YZBZwMr49xIlXHuj3QdRNUG3D0sHZEbJUL+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4eF2UFIB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eZ979ls2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608378;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4PIVJJnPUdTG7xo1yCyK2xYumgar8T5tX8kSzYA7Wk0=;
	b=4eF2UFIBe56GkAvuBD7ZubthM62km2Z0HinqIZIJ2S/IGltfErw46O702+ztPPSleQGj00
	CZvIrmyq0WTTE6i3HBsfp5lrsyvv7qcdlD4dRib9oXECJoaIOWofpWmax4yxFlhQhGFSJ4
	NoEahY8WB/DWQfOZGV/JbdG8erFZeeltzXIvb3QF8kUszUp7JDG7+2aMSeEJdVZMUxEH2C
	fz/6iCzS1orlV4WWjcdFm8lA3/V/4YdxCEtoZMZAhwWHcCbb6+mcqgoAXa6GoS5ojKBNxe
	Tj/ThDUhHIM8plkbejAzeUOM2uXayvOagUGBQwlJObVKpzDV4Pl+FAtJYtKmrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608378;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4PIVJJnPUdTG7xo1yCyK2xYumgar8T5tX8kSzYA7Wk0=;
	b=eZ979ls2UZKrW6i9d43rFThm5tpOL9kYZQEm1e77aRRhPIQcDxt9Nep5ukISkDlIGwXmV2
	XkZvSuzPxr7P7JDg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix weak symbol detection
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060837740.709179.15954898643494638439.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     72567c630d32bc31f671977f78228c80937ed80e
Gitweb:        https://git.kernel.org/tip/72567c630d32bc31f671977f78228c80937=
ed80e
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:27 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:23 -07:00

objtool: Fix weak symbol detection

find_symbol_hole_containing() fails to find a symbol hole (aka stripped
weak symbol) if its section has no symbols before the hole.  This breaks
weak symbol detection if -ffunction-sections is enabled.

Fix that by allowing the interval tree to contain section symbols, which
are always at offset zero for a given section.

Fixes a bunch of (-ffunction-sections) warnings like:

  vmlinux.o: warning: objtool: .text.__x64_sys_io_setup+0x10: unreachable ins=
truction

Fixes: 4adb23686795 ("objtool: Ignore extra-symbol code")
Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c024937..d7fb3d0 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -109,7 +109,7 @@ struct symbol_hole {
 };
=20
 /*
- * Find !section symbol where @offset is after it.
+ * Find the last symbol before @offset.
  */
 static int symbol_hole_by_offset(const void *key, const struct rb_node *node)
 {
@@ -120,8 +120,7 @@ static int symbol_hole_by_offset(const void *key, const s=
truct rb_node *node)
 		return -1;
=20
 	if (sh->key >=3D s->offset + s->len) {
-		if (s->type !=3D STT_SECTION)
-			sh->sym =3D s;
+		sh->sym =3D s;
 		return 1;
 	}
=20
@@ -428,7 +427,8 @@ static void elf_add_symbol(struct elf *elf, struct symbol=
 *sym)
 	sym->len =3D sym->sym.st_size;
=20
 	__sym_for_each(iter, &sym->sec->symbol_tree, sym->offset, sym->offset) {
-		if (iter->offset =3D=3D sym->offset && iter->type =3D=3D sym->type)
+		if (iter->offset =3D=3D sym->offset && iter->type =3D=3D sym->type &&
+		    iter->len =3D=3D sym->len)
 			iter->alias =3D sym;
 	}
=20

