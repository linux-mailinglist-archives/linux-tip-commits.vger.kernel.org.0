Return-Path: <linux-tip-commits+bounces-6885-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DC1BE28C8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E929F1A627F5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882D631DD94;
	Thu, 16 Oct 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1pgDsTL7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QtBw9177"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4679D32039B;
	Thu, 16 Oct 2025 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608380; cv=none; b=CgvmQIkTFA5yB1UedgOMGW+btkomfkaIQBopHeFuqONXYEF+XQu+vnMywIcfL2JkV29HR9lK6jveec/8GzarPvNjAKTxdeOk/hPn9MR6NASKy994Zc8i34I1pyVDa8GG7SHH21LZ6h1k7I5g8JtzDxLTl/mldB382F03RTLKI7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608380; c=relaxed/simple;
	bh=g4i0nWgRCgLOQ/klaY1v8WQkTOp1nd2j0CPvfYVvE70=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=PdQD9DNVi8MxyVwDh6EMt7GpTeatgftMrA66hNhA0yK40PEKl/Ro4ajyK29n7n1TIdzaQkQ1jyAi6ysUTOATHfSGGrwfJwVp6o6X1bWpcPWLjWHqxRJqxUojr08oeJME8qQQCPUrZme2LL2sgylmkZ3MqTfLyxUAJrs2CniRM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1pgDsTL7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QtBw9177; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608354;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=IK5p+qy1fer3zk/RZiVig8LZ/RX7OcmaevV5MoEOq0Q=;
	b=1pgDsTL7/f+Ns5sKMsU+rO6f3v3eO7RRVYhz0MSH987EMoPgsX/xQVr8ysU/wKmwpAgsGP
	S2I4W+BL6RCrgQ7Y0l+5sKopPD93OY12g3RWzr6LVBo5/fkyphApd9jntGCY84tBYNk7Is
	HYx+BVJa7s4aLloRd16qxklm4J4Af/7q2vDjulyP2Yww3bkUcFl/05zEPwo2TDoC5JNK/T
	9Ox4ly3pU2v7gEBopkbMWefuGNLdR0xFefML2lDuDRlqk4/dygZDXuJfEKe+sO1aqQSZ/P
	g3uoL/NQv7f2gRLB1dHhMOhMoL6rBoOV+HU8NYAXIB6RIE2q4kRpyKhz/evrSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608354;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=IK5p+qy1fer3zk/RZiVig8LZ/RX7OcmaevV5MoEOq0Q=;
	b=QtBw9177glfCU6mkfgj2vAb0h120I5dRSkfxoyOUy1VHwS1vLlaqJjRbwOCoj9McYKP3pA
	AfYXVnrsVpKJ6UDA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Simplify special symbol handling in
 elf_update_symbol()
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060835311.709179.822379593416546244.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     02cf323a7ee07621f47369c547ae7c7505a7312a
Gitweb:        https://git.kernel.org/tip/02cf323a7ee07621f47369c547ae7c7505a=
7312a
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:46 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:46:48 -07:00

objtool: Simplify special symbol handling in elf_update_symbol()

!sym->sec isn't actually a thing: even STT_UNDEF and other special
symbol types belong to NULL section 0.

Simplify the initialization of 'shndx' accordingly.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 775d017..c35726a 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -637,7 +637,7 @@ static int elf_update_sym_relocs(struct elf *elf, struct =
symbol *sym)
 static int elf_update_symbol(struct elf *elf, struct section *symtab,
 			     struct section *symtab_shndx, struct symbol *sym)
 {
-	Elf32_Word shndx =3D sym->sec ? sym->sec->idx : SHN_UNDEF;
+	Elf32_Word shndx;
 	Elf_Data *symtab_data =3D NULL, *shndx_data =3D NULL;
 	Elf64_Xword entsize =3D symtab->sh.sh_entsize;
 	int max_idx, idx =3D sym->idx;
@@ -645,8 +645,7 @@ static int elf_update_symbol(struct elf *elf, struct sect=
ion *symtab,
 	bool is_special_shndx =3D sym->sym.st_shndx >=3D SHN_LORESERVE &&
 				sym->sym.st_shndx !=3D SHN_XINDEX;
=20
-	if (is_special_shndx)
-		shndx =3D sym->sym.st_shndx;
+	shndx =3D is_special_shndx ? sym->sym.st_shndx : sym->sec->idx;
=20
 	s =3D elf_getscn(elf->elf, symtab->idx);
 	if (!s) {

