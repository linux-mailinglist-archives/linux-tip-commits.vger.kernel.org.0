Return-Path: <linux-tip-commits+bounces-8128-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GOFClfNeWnEzgEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8128-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 09:48:23 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D319E60D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 09:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B88A3301C16B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 08:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218F93382C4;
	Wed, 28 Jan 2026 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CJoVFYsN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xS03tqcD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE2275AE3;
	Wed, 28 Jan 2026 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590000; cv=none; b=R+j8iyjThe+empettJLPZUPOMsF4J1D9Tx5z3xMkYPHVO7ABlWdvGf2a7sMfgPAhO53pLvbm/fLn9EHbAwnyLZZUId7lmZ2Xy64C1fK8vdHItTHZ9MlzUC7dQ7/M1fJb/LSti4t85knRC5kIGSKETGw4dVfyER9Ky2UAJmgF1B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590000; c=relaxed/simple;
	bh=LCYjoq4Mnmy+CEqhdf0j7W8CfwYYQUXP+RHdAWRHEok=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XZmK56R0uXfzvJ3oYDeRvq1JAZz5i0PMUmkzZSmT/d+HCMezgYaI6bvh8qUWtgumPU+MqpKYctPNwpts6BHcCxkC2IY5TVN/dcQE8T0eXoDWzmTlEazLCRVzIOMpEtkblFtYTvwdEdis6JlUKiqVcktVzW1l6vykerVa6Aj7Ei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CJoVFYsN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xS03tqcD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Jan 2026 08:46:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769589997;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XqAPsO+gsQOAOcjcV87sjEhe31qDVecVuQtFXL7oJdg=;
	b=CJoVFYsNltznoPEpiKlWAOc4hq4oWhG27vVf3ZwpTXA6t3Q0wib/io06eS9+CI9hiHV4Pn
	VxjHEtN7g1eUSzvhPsQnsNLtOIq32rkKG+Ucnl8KAtJHUb6Cw2oFDej74b00F1HVR/MYlc
	qoliw256KtiKxeHN4UJiDdmg3ZFLOkvpYmwBvh5K9FmoFxtLCerqAO7EPht2tSQ4BduyBY
	dZm1ul/g3cFApTk2yh5B9lya9dsrGtM+Erqg0yMN7lym46BdPg8AWE0wxQhc/hkhH664pW
	aak8LxmKzIFOtPvZKUTIrKykDVKiS9wR0D5pmvvP7s60wDvDCnYqUTXMu4Zm6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769589997;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XqAPsO+gsQOAOcjcV87sjEhe31qDVecVuQtFXL7oJdg=;
	b=xS03tqcDmUgfCoOXiMR2McSOHPkC28G9SFj+27f2mPE2WZiup0Fwwvh3yEdRyT+wYSkJe0
	jcCyHxqs8cAEobCQ==
From: "tip-bot2 for Petr Pavlu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Replace custom macros in elf.c with
 shared ones
Cc: Petr Pavlu <petr.pavlu@suse.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260126151356.3924887-1-petr.pavlu@suse.com>
References: <20260126151356.3924887-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176958999592.510.17354879667836553653.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linutronix.de:dkim,vger.kernel.org:replyto,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8128-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 89D319E60D
X-Rspamd-Action: no action

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     d107b3265aa5e61a1e326b2815a767526ddb12ac
Gitweb:        https://git.kernel.org/tip/d107b3265aa5e61a1e326b2815a767526dd=
b12ac
Author:        Petr Pavlu <petr.pavlu@suse.com>
AuthorDate:    Mon, 26 Jan 2026 16:13:48 +01:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 27 Jan 2026 08:20:41 -08:00

objtool: Replace custom macros in elf.c with shared ones

The source file tools/objtool/elf.c defines the macros ALIGN_UP(),
ALIGN_UP_POW2() and MAX(). These macros unnecessarily duplicate
functionality already available under tools/include/, specifically ALIGN(),
roundup_pow_of_two() and max().

More importantly, the definition of ALIGN_UP_POW2() is incorrect when the
input is 1, as it results in a call to __builtin_clz(0), which produces an
undefined result. This issue impacts the function elf_alloc_reloc(). When
adding the first relocation to a section, the function allocates an
undefined number of relocations.

Replace the custom macros with the shared functionality to resolve these
issues.

Fixes: 2c05ca026218 ("objtool: Add elf_create_reloc() and elf_init_reloc()")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Link: https://patch.msgid.link/20260126151356.3924887-1-petr.pavlu@suse.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 6a8ed9c..2c02c7b 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -18,15 +18,14 @@
 #include <errno.h>
 #include <libgen.h>
 #include <ctype.h>
+#include <linux/align.h>
+#include <linux/kernel.h>
 #include <linux/interval_tree_generic.h>
+#include <linux/log2.h>
 #include <objtool/builtin.h>
 #include <objtool/elf.h>
 #include <objtool/warn.h>
=20
-#define ALIGN_UP(x, align_to) (((x) + ((align_to)-1)) & ~((align_to)-1))
-#define ALIGN_UP_POW2(x) (1U << ((8 * sizeof(x)) - __builtin_clz((x) - 1U)))
-#define MAX(a, b) ((a) > (b) ? (a) : (b))
-
 static inline u32 str_hash(const char *str)
 {
 	return jhash(str, strlen(str), 0);
@@ -1336,7 +1335,7 @@ unsigned int elf_add_string(struct elf *elf, struct sec=
tion *strtab, const char=20
 		return -1;
 	}
=20
-	offset =3D ALIGN_UP(strtab->sh.sh_size, strtab->sh.sh_addralign);
+	offset =3D ALIGN(strtab->sh.sh_size, strtab->sh.sh_addralign);
=20
 	if (!elf_add_data(elf, strtab, str, strlen(str) + 1))
 		return -1;
@@ -1378,7 +1377,7 @@ void *elf_add_data(struct elf *elf, struct section *sec=
, const void *data, size_
 	sec->data->d_size =3D size;
 	sec->data->d_align =3D 1;
=20
-	offset =3D ALIGN_UP(sec->sh.sh_size, sec->sh.sh_addralign);
+	offset =3D ALIGN(sec->sh.sh_size, sec->sh.sh_addralign);
 	sec->sh.sh_size =3D offset + size;
=20
 	mark_sec_changed(elf, sec, true);
@@ -1502,7 +1501,7 @@ static int elf_alloc_reloc(struct elf *elf, struct sect=
ion *rsec)
 	rsec->data->d_size =3D nr_relocs_new * elf_rela_size(elf);
 	rsec->sh.sh_size   =3D rsec->data->d_size;
=20
-	nr_alloc =3D MAX(64, ALIGN_UP_POW2(nr_relocs_new));
+	nr_alloc =3D max(64UL, roundup_pow_of_two(nr_relocs_new));
 	if (nr_alloc <=3D rsec->nr_alloc_relocs)
 		return 0;
=20

