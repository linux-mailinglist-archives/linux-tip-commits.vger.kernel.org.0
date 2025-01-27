Return-Path: <linux-tip-commits+bounces-3294-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A962EA1D45E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Jan 2025 11:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084383A77FE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Jan 2025 10:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748031FCCF6;
	Mon, 27 Jan 2025 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hVCMKx2A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MHOqGSve"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3261179BF;
	Mon, 27 Jan 2025 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737973543; cv=none; b=L9Su6F12AUX0adaE2t69LyFpbuJdwhBrnnEIUkoLdneCxZEnh3k9Yx8tD1bKg51PmuEUhhlPzuEcUcdgeFlRuYCFoAlrqw45e1UH6blSkMMJUmg1ulNJgkGh/1+rLRIANe2/THs3r8mQr4YEf+yOh54Mpn060l+AQ9da8M1PJdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737973543; c=relaxed/simple;
	bh=md3q0+bSVirh5RKQ7bXalgg6JMtMHoAe7AbV1dq0e1U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oci8wlIzYdhjWhLIBJ9uif0WNAKqlvbcWlOlCdk/7krRO9ljCbpjWufqCL69fhciBn7K5e10l7VwLUCkmpTcQ9c08JX6YMU2u51gI+m5I1JNJLnriCyDJFj7t7whAg+nC0S74HIOpgL1J06HX1C3WL/tqdGvzl2FNPEUWDuWOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hVCMKx2A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MHOqGSve; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Jan 2025 10:25:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737973539;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJ1mpf8QloJ8ySiPkJKNXsVNT5AVvMjfM7ipG371AU0=;
	b=hVCMKx2AlPwLtwJIhhREkPffoyHIf1LsFIxAhcEPYfHjUnqOPJm2BK6FhCk+m7lpMpiPqj
	FDd3piw3nfJtVzfhj6Z4CwEktqDO8CShBiK572euNm9pIWZfdWnD6A8JQzvjO/G/EDmco0
	PIVH94PCHwzPs1k8iVP7ew6lxsNW5sWrdMSfVnshcu941F4diO8OeSkEFn7MM4P5J1pwP3
	A6CCGvQbY+KoOIpvyjxejaxxiwo7saWz98X3ZJkabm02gLJm74nWYP40cg3KeAhT3kKAms
	Mk7yi4peSVG0ywzLbpomUrYJD8MaP9ae3zFd1bQS8JWgkhLfnohC8DyKbVPupw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737973539;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJ1mpf8QloJ8ySiPkJKNXsVNT5AVvMjfM7ipG371AU0=;
	b=MHOqGSvemzm9GoHAPMxK1ItiYxieA6iV/erMpYYOZlzs7dwXookLc7k/UqoWu4q496M9Us
	XghitO/xB6ouKoCQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] Revert "x86/boot: Reject absolute references in .head.text"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <CAHk-=wj7k9nvJn6cpa3-5Ciwn2RGyE605BMkjWE4MqnvC9E92A@mail.gmail.com>
References:
 <CAHk-=wj7k9nvJn6cpa3-5Ciwn2RGyE605BMkjWE4MqnvC9E92A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173797353863.31546.14997634746331823035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     fb1102a09a3b6710ac1e033690f0283696dc94dc
Gitweb:        https://git.kernel.org/tip/fb1102a09a3b6710ac1e033690f0283696dc94dc
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 27 Jan 2025 11:08:14 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 27 Jan 2025 11:08:14 +01:00

Revert "x86/boot: Reject absolute references in .head.text"

This reverts commit faf0ed487415f76fe4acf7980ce360901f5e1698.

As Linus reported, the hard build failure is entirely unhelpful
in tracking down the bug:

	Absolute reference to symbol '.rodata' not permitted in .head.text

... and to add insult to injury, the offending vmlinux gets deleted,
making it hard to figure out what's going on ...

So revert this until a (much) more developer-friendly version
is merged.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/CAHk-=wj7k9nvJn6cpa3-5Ciwn2RGyE605BMkjWE4MqnvC9E92A@mail.gmail.com
---
 arch/x86/tools/relocs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e937be9..27441e5 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -841,10 +841,10 @@ static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
 static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		      const char *symname)
 {
-	int headtext = !strcmp(sec_name(sec->shdr.sh_info), ".head.text");
 	unsigned r_type = ELF64_R_TYPE(rel->r_info);
 	ElfW(Addr) offset = rel->r_offset;
 	int shn_abs = (sym->st_shndx == SHN_ABS) && !is_reloc(S_REL, symname);
+
 	if (sym->st_shndx == SHN_UNDEF)
 		return 0;
 
@@ -900,12 +900,6 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 			break;
 		}
 
-		if (headtext) {
-			die("Absolute reference to symbol '%s' not permitted in .head.text\n",
-			    symname);
-			break;
-		}
-
 		/*
 		 * Relocation offsets for 64 bit kernels are output
 		 * as 32 bits and sign extended back to 64 bits when

