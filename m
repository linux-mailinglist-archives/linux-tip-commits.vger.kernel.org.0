Return-Path: <linux-tip-commits+bounces-6463-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B552AB43A2D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837C816ACFC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A452FF166;
	Thu,  4 Sep 2025 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kxc66g8W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iwpfFgrh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F182FE05B;
	Thu,  4 Sep 2025 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984856; cv=none; b=lLhQzUB0hFvFzJ7NQtKET08epr8krBwtfEA260rhLG3kYD3HK8JCwIlQMsGtxte8uVfQNk4sKg5Q2GnOLQpwuwGXVeRt0nzCgd78u+IAzsnCYmoI/jWssfFUQm5TVeAKO1oR14mfk0u77izDN17PgP5Q3kr1Syxy+Ut3NvIl+P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984856; c=relaxed/simple;
	bh=6dtv5de9nVDDmWHYmXf5ocqL1/ILemD6s/sYL0R0H+U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BEy9xxk4FucAnUq20eHBKEJiZ0+b7ps5NDq1ODrODELec38wYVfYIFuRsWkLhYh9nucV4QDcR4XENIc8Emrr/dTTmJiqqu3or7znMbqlTbI3XxMSIaiYsxLWkEhw/nDUn+9z++K1z+7f3NzXi4N+1VqVXMSZG8mEnAzouyzafQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kxc66g8W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iwpfFgrh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:20:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984852;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WUracaxxlBOPiL8I1T90IsCuZiCzhJBMEaXmM22mAl4=;
	b=Kxc66g8WGarhaMBXKKhk2yacjfaSY14D/ePVZODjItQWjnEdyIRON/RYwsMA6lI+MqZy7K
	yLt1qDOqUtMvM0QSC0oSn1LbO2ktGkkBvKqrsuJcSpRBpdam1emRg1070aOzuYkLZTo5IP
	i1CzIsVwMeFmVc0XwBj4+SLU5EuxJ2XYKsETwyx04IN+5z9uuuqv7O0FgbaJD/0vuBJ9th
	Yz8M1haQMm0/au7lQoVnpSl7hbDkt5daWXhGFjhjnEt99rxlXoX4yOPWxTiALsftkk4krf
	s6s1+wUUbNsJv8Hv2ZYfVmKpGf+sQ9UxYuaZePVbU7w4c7CQqflrEWXQNBUgLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984852;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WUracaxxlBOPiL8I1T90IsCuZiCzhJBMEaXmM22mAl4=;
	b=iwpfFgrhV5RdiIQRk4hb/zbW3Rdb3TnOCpJsSacBhkAWQsvg63ZK7m5uTFddtquVzPmXlT
	kJx0CRbZSmcrl9Cg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/boot: Revert "Reject absolute references in .head.text"
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-41-ardb+git@google.com>
References: <20250828102202.1849035-41-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698485140.1920.7820468106468532581.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     2578560d2259735d7d51364e7991ea92d85fd56c
Gitweb:        https://git.kernel.org/tip/2578560d2259735d7d51364e7991ea92d85=
fd56c
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:20 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Sep 2025 17:59:56 +02:00

x86/boot: Revert "Reject absolute references in .head.text"

This reverts commit

  faf0ed487415 ("x86/boot: Reject absolute references in .head.text")

The startup code is checked directly for the absence of absolute symbol
references, so checking the .head.text section in the relocs tool is no
longer needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250828102202.1849035-41-ardb+git@google.com
---
 arch/x86/tools/relocs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 5778bc4..e5a2b9a 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -740,10 +740,10 @@ static void walk_relocs(int (*process)(struct section *=
sec, Elf_Rel *rel,
 static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		      const char *symname)
 {
-	int headtext =3D !strcmp(sec_name(sec->shdr.sh_info), ".head.text");
 	unsigned r_type =3D ELF64_R_TYPE(rel->r_info);
 	ElfW(Addr) offset =3D rel->r_offset;
 	int shn_abs =3D (sym->st_shndx =3D=3D SHN_ABS) && !is_reloc(S_REL, symname);
+
 	if (sym->st_shndx =3D=3D SHN_UNDEF)
 		return 0;
=20
@@ -783,12 +783,6 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel,=
 ElfW(Sym) *sym,
 			break;
 		}
=20
-		if (headtext) {
-			die("Absolute reference to symbol '%s' not permitted in .head.text\n",
-			    symname);
-			break;
-		}
-
 		/*
 		 * Relocation offsets for 64 bit kernels are output
 		 * as 32 bits and sign extended back to 64 bits when

