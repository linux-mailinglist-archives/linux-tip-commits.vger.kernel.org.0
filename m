Return-Path: <linux-tip-commits+bounces-6924-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103E7BE2A0C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7124802DA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E567A33EAE5;
	Thu, 16 Oct 2025 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mIgX1ub0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zHn+nG7s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D11C33768B;
	Thu, 16 Oct 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608416; cv=none; b=VVfzJWGCiMQdhBmJ5xSi+dAOn3wjYfNjKUBFwEDN4fRV1AJJ5WQYz4eij74XMg9QMU8IRosftlqucHkqgbwoqrxU9EKjvAIDKfVXIY7uZEAGvQP9jAGgZaGDR7wR6enRwgXD3Q7368Gxt06uQwf16fZCZYotvFoNblZ+pacquKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608416; c=relaxed/simple;
	bh=wmrByKvj21060H/LB8z0hUTGFIl5M0E6+5MXZ8QnSXU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=H42q7Sp5txONulbh/Guy83rtOr4Is2Rjzu+CVuh8hEk4GC29OtkZHNHb0oaonPjdQpNG1oiN7eJ5ea+Mv3T7Vs/FdT9WTfouqtX5vKmw7egRX5ynqpE0HvH1MvCqaPaQKeJsnyYNpchNoj6lGcGXqTaKsEjxza7azY5QHen3wpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mIgX1ub0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zHn+nG7s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608398;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=sHFODucPvQ2EXCxNEUjSQ4sdw1S1ZqJx0upumWfW7A0=;
	b=mIgX1ub0iwPA7r7eAjzo4mDnATDxv7doqn7DQRG6ic12TsNtii9PoU5eF5EZu0x+f+Sap4
	ES7/4/Dc77sxyCGLkYi4dUHKl4AZS3cZud22PA0s38illwq0xp/xPGUDW81dnbtycrFGT+
	LitNUj2R+hNcYcX9Oxqw/dvEmovudwyYsj3JJVHG0U3zuv3bIsyf5wMqNi4wuBp0OwKb71
	KhObk+FuxAFDHpHRERuBNf1TGW9l54Py2Yr9UxYSSRRnnfXaH4eZ655PHBMwsKMI6f5CSc
	VAy+uVGi6JIxfXTeHMjReyVu9T/cQkSh7yeYms0mvXLJuWsL0pVaJvJvppFgYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608398;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=sHFODucPvQ2EXCxNEUjSQ4sdw1S1ZqJx0upumWfW7A0=;
	b=zHn+nG7sVo+6A1JAWhaK19b2KbNP25y3CCUD6C3vz1POyydD+OWMeZwkLwYq4+N+iuAtnG
	rnSomEuM/oxW5mDQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/module: Improve relocation error messages
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060839693.709179.17595631535499971067.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     bf770d6d2097a52d87f4d9c88d0b05bd3998d7de
Gitweb:        https://git.kernel.org/tip/bf770d6d2097a52d87f4d9c88d0b05bd399=
8d7de
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:11 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:21 -07:00

x86/module: Improve relocation error messages

Add the section number and reloc index to relocation error messages to
help find the faulty relocation.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/module.c | 15 +++++++++------
 kernel/livepatch/core.c  |  4 ++--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 0ffbae9..11c45ce 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -97,6 +97,7 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
 	DEBUGP("%s relocate section %u to %u\n",
 	       apply ? "Applying" : "Clearing",
 	       relsec, sechdrs[relsec].sh_info);
+
 	for (i =3D 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
 		size_t size;
=20
@@ -162,15 +163,17 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
=20
 		if (apply) {
 			if (memcmp(loc, &zero, size)) {
-				pr_err("x86/modules: Invalid relocation target, existing value is nonzer=
o for type %d, loc %p, val %Lx\n",
-				       (int)ELF64_R_TYPE(rel[i].r_info), loc, val);
+				pr_err("x86/modules: Invalid relocation target, existing value is nonzer=
o for sec %u, idx %u, type %d, loc %lx, val %llx\n",
+				       relsec, i, (int)ELF64_R_TYPE(rel[i].r_info),
+				       (unsigned long)loc, val);
 				return -ENOEXEC;
 			}
 			write(loc, &val, size);
 		} else {
 			if (memcmp(loc, &val, size)) {
-				pr_warn("x86/modules: Invalid relocation target, existing value does not=
 match expected value for type %d, loc %p, val %Lx\n",
-					(int)ELF64_R_TYPE(rel[i].r_info), loc, val);
+				pr_warn("x86/modules: Invalid relocation target, existing value does not=
 match expected value for sec %u, idx %u, type %d, loc %lx, val %llx\n",
+					relsec, i, (int)ELF64_R_TYPE(rel[i].r_info),
+					(unsigned long)loc, val);
 				return -ENOEXEC;
 			}
 			write(loc, &zero, size);
@@ -179,8 +182,8 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
 	return 0;
=20
 overflow:
-	pr_err("overflow in relocation type %d val %Lx\n",
-	       (int)ELF64_R_TYPE(rel[i].r_info), val);
+	pr_err("overflow in relocation type %d val %llx sec %u idx %d\n",
+	       (int)ELF64_R_TYPE(rel[i].r_info), val, relsec, i);
 	pr_err("`%s' likely not compiled with -mcmodel=3Dkernel\n",
 	       me->name);
 	return -ENOEXEC;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 0e73fac..7e443c2 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -217,8 +217,8 @@ static int klp_resolve_symbols(Elf_Shdr *sechdrs, const c=
har *strtab,
 	for (i =3D 0; i < relasec->sh_size / sizeof(Elf_Rela); i++) {
 		sym =3D (Elf_Sym *)sechdrs[symndx].sh_addr + ELF_R_SYM(relas[i].r_info);
 		if (sym->st_shndx !=3D SHN_LIVEPATCH) {
-			pr_err("symbol %s is not marked as a livepatch symbol\n",
-			       strtab + sym->st_name);
+			pr_err("symbol %s at rela sec %u idx %d is not marked as a livepatch symb=
ol\n",
+			       strtab + sym->st_name, symndx, i);
 			return -EINVAL;
 		}
=20

