Return-Path: <linux-tip-commits+bounces-2974-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997809E556C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 13:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86131166741
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 12:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1024F2185A1;
	Thu,  5 Dec 2024 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ec5dqXBi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jZcbGKuV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6838B21859F;
	Thu,  5 Dec 2024 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401693; cv=none; b=YtjnSW/Q957NnqOOm+seqvwx5O2SnGBu9KrBK+xXWKRJrIrH5JG4BMYv7CfvFUNFaRXPMbuRhpVt9xkYmsaggHFgKhLwbZOqFbmjkGqNQkxWLtwDIT/xNZYZJPCIaChZ6Iq/HGsTbWx6DvbqoGl5GI24Y+qXRJW3bsaJyzCK2tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401693; c=relaxed/simple;
	bh=mt+Vx5Rdss5xqWWdUogebcuDKvMZH0sGo2y7pFge/ZY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B01CcVStBKWv2Ce1/VaLdKh60NjU+DKtk4MJ2gzUCnSu1uHm2I+++ghfoB9TWBNZSWm/EmS9jdxTR+MQ86AJaU39qIQrr45MgCyf7lTtY11EBSzG8g1tea7z+i7BuOEBAjTyVIu0XjfivGrdjJeKMgby76c/iMq9ziPmmvs0dzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ec5dqXBi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jZcbGKuV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Dec 2024 12:28:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733401689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dY1HLL9+pe1ZOkuiiqONakKXgE2qMc+dvCFonqK8WVg=;
	b=ec5dqXBi702seg+FcdrNG8nQwyU/xjzbgF8RJ1M1MOSkxTfYUxDzduRaTx37zI7ueyglom
	2AOQMmeNr5OdXYDYgjj4Ke+9/Tt18Rf31JDQylNTCQBRrMC46rI13YhHA3f6x2AVxX8m2i
	+ApLe3NAWzqtmmpqnxqqdQ1E4us3EMrXqDk3qCJlOCoTlGKXV9cKxwXQjmc0BUk0N8kNC8
	g5qk52go5/hItT9OcKOo7vOopwm0FNSMOycFDa3zfmz+7kd/EI2Bk3pU/4Z+/okTV8OXVm
	kYi7GvkvZl22oXgkBCL4WyKMtwfFHM9ctprcya85ZhASUpfElZAFmyG9opHFDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733401689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dY1HLL9+pe1ZOkuiiqONakKXgE2qMc+dvCFonqK8WVg=;
	b=jZcbGKuV9BmvGMZDLO7joZO1D3Oz2ybPdPseQ3elwygcNa8dP/iPVVVV+QZ2kJJ8Q/ll4s
	1hlbbsFZQroc2DDA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Reject absolute references in .head.text
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241205112804.3416920-16-ardb+git@google.com>
References: <20241205112804.3416920-16-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173340168872.412.736819374842826448.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     faf0ed487415f76fe4acf7980ce360901f5e1698
Gitweb:        https://git.kernel.org/tip/faf0ed487415f76fe4acf7980ce360901f5e1698
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 05 Dec 2024 12:28:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Dec 2024 13:18:55 +01:00

x86/boot: Reject absolute references in .head.text

The .head.text section used to contain asm code that bootstrapped the
page tables and switched to the kernel virtual address space before
executing C code. The asm code carefully avoided dereferencing absolute
symbol references, as those will fault before the page tables are
installed.

Today, the .head.text section contains lots of C code too, and getting
the compiler to reason about absolute addresses taken from, e.g.,
section markers such as _text[] or _end[] but never use such absolute
references to access global variables [*] is intractible.

So instead, forbid the use of absolute references in .head.text
entirely, and rely on explicit arithmetic involving VA-to-PA offsets
generated by the asm startup code to construct virtual addresses where
needed (e.g., to construct the page tables).

Note that the 'relocs' tool is only used on the core kernel image when
building a relocatable image, but this is the default, and so adding the
check there is sufficient to catch new occurrences of code that use
absolute references before the kernel mapping is up.

[*] it is feasible when using PIC codegen but there is strong pushback
    to using this for all of the core kernel, and using it only for
    .head.text is not straight-forward.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20241205112804.3416920-16-ardb+git@google.com
---
 arch/x86/tools/relocs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 27441e5..e937be9 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -841,10 +841,10 @@ static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
 static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		      const char *symname)
 {
+	int headtext = !strcmp(sec_name(sec->shdr.sh_info), ".head.text");
 	unsigned r_type = ELF64_R_TYPE(rel->r_info);
 	ElfW(Addr) offset = rel->r_offset;
 	int shn_abs = (sym->st_shndx == SHN_ABS) && !is_reloc(S_REL, symname);
-
 	if (sym->st_shndx == SHN_UNDEF)
 		return 0;
 
@@ -900,6 +900,12 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 			break;
 		}
 
+		if (headtext) {
+			die("Absolute reference to symbol '%s' not permitted in .head.text\n",
+			    symname);
+			break;
+		}
+
 		/*
 		 * Relocation offsets for 64 bit kernels are output
 		 * as 32 bits and sign extended back to 64 bits when

