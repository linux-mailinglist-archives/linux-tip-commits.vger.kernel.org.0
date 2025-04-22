Return-Path: <linux-tip-commits+bounces-5099-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7338FA96AC5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 14:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B311635EE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 12:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24C325E823;
	Tue, 22 Apr 2025 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IyrkDUCN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gSEIaEBj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97B31F09B1;
	Tue, 22 Apr 2025 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745326076; cv=none; b=KAv+imQ4VgiPLO7Zhe6JoEtk8+n9XaQj5ms8uqc2q3fpRqsPOs1eo3NcFb6WS00URVMUvKoFPCS9lFEH/8BSzfZeA0DvFCh+ohNdLKnAAi6FyT1wQm4aKayGhTBJ30oTYWQq1T92/zEXyrJj178FGUO6lh4iFwPHSNtH/blWWX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745326076; c=relaxed/simple;
	bh=nXPbs8A5dt6z/JkCwNxw0+h8ZN58rPQtHIMURAwymeM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LY4PoXBTHT/tCWqkqvJOzpZrKd7ES77cMRn4LC4EXOVwkxPwkstCGQyRiS2Yj/6ruPKPkxHv4TQq4U9hMz+v74dEH45PJASE5xpHHCLJW4F4l9kDtv6hnpIX5SmKrPdCzNbbEuu6AEwtGE8ritb+0MgqYEr7iT1PesPPIz6BdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IyrkDUCN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gSEIaEBj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Apr 2025 12:47:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745326073;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ql9b6i2zSQYGcDt8W5lkvV2GEUKWfBKrkMiEWuE231w=;
	b=IyrkDUCN0eWGTx4z+sesE9A6xx8h1Q4OCkyzjsJRkDG1EaQrob7lmj5ir12KHlJV60KsQR
	ora00UEIaCJ2Z+D+3WM1lbRRutpfEPpe1tpFfqbYbE8pd54SwutLKh9RMP6tocmhNBzJA1
	TM/bKND2ZSiUtCK6sRvnmxNI5DMuclre1lpR6eSJ+mv40kL4GkRa0r8b8GKPhcOrZvjDz5
	UZIZDkB8bw07RLkFGljSLXosqv/i85jqqmwNC54EeJuHFNTkIGVean7+JP5Gor/Km+f2v/
	ZcIrFIoHtBGsx8ITVpsm0KjYsPdYS8DzNzpIb2pje1uBYjBfPc0tmHwZ9h5hZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745326073;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ql9b6i2zSQYGcDt8W5lkvV2GEUKWfBKrkMiEWuE231w=;
	b=gSEIaEBjSj0qK0HnmSurABR/wm+hnq7ex+hE58dYMW2ryHRKb3UDA0ACMwjV9WNPTnUnon
	aeXl5Bi5vaB3ouBw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/entry] x86/vdso: Remove #ifdeffery around page setup variants
Cc: thomas.weissschuh@linutronix.de, Ingo Molnar <mingo@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Eric Biederman <ebiederm@xmission.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
 Kees Cook <kees@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@surriel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240910-x86-vdso-ifdef-v1-1-877c9df9b081@linutronix.de>
References: <20240910-x86-vdso-ifdef-v1-1-877c9df9b081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174532607207.31282.2250932956675441767.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     2ce8043b1d34756509430675696aafcd6db601c7
Gitweb:        https://git.kernel.org/tip/2ce8043b1d34756509430675696aafcd6db=
601c7
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 10 Sep 2024 12:11:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Apr 2025 14:24:07 +02:00

x86/vdso: Remove #ifdeffery around page setup variants

Replace the open-coded ifdefs in C sources files with IS_ENABLED().
This makes the code easier to read and enables the compiler to typecheck
also the disabled parts, before optimizing them away.
To make this work, also remove the ifdefs from declarations of used
variables.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Link: https://lore.kernel.org/r/20240910-x86-vdso-ifdef-v1-1-877c9df9b081@lin=
utronix.de
---
 arch/x86/entry/vdso/vma.c   | 31 ++++++++++++-------------------
 arch/x86/include/asm/elf.h  |  4 ----
 arch/x86/include/asm/vdso.h |  8 --------
 3 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index adb299d..495fdd4 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -227,7 +227,6 @@ int map_vdso_once(const struct vdso_image *image, unsigne=
d long addr)
 	return map_vdso(image, addr);
 }
=20
-#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
 static int load_vdso32(void)
 {
 	if (vdso32_enabled !=3D 1)  /* Other values all mean "disabled" */
@@ -235,39 +234,33 @@ static int load_vdso32(void)
=20
 	return map_vdso(&vdso_image_32, 0);
 }
-#endif
=20
-#ifdef CONFIG_X86_64
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
-	if (!vdso64_enabled)
-		return 0;
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		if (!vdso64_enabled)
+			return 0;
+
+		return map_vdso(&vdso_image_64, 0);
+	}
=20
-	return map_vdso(&vdso_image_64, 0);
+	return load_vdso32();
 }
=20
 #ifdef CONFIG_COMPAT
 int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp, bool x32)
 {
-#ifdef CONFIG_X86_X32_ABI
-	if (x32) {
+	if (IS_ENABLED(CONFIG_X86_X32_ABI) && x32) {
 		if (!vdso64_enabled)
 			return 0;
 		return map_vdso(&vdso_image_x32, 0);
 	}
-#endif
-#ifdef CONFIG_IA32_EMULATION
-	return load_vdso32();
-#else
+
+	if (IS_ENABLED(CONFIG_IA32_EMULATION))
+		return load_vdso32();
+
 	return 0;
-#endif
-}
-#endif
-#else
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
-{
-	return load_vdso32();
 }
 #endif
=20
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 1286026..6c8fdc9 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -76,12 +76,8 @@ typedef struct user_i387_struct elf_fpregset_t;
=20
 #include <asm/vdso.h>
=20
-#ifdef CONFIG_X86_64
 extern unsigned int vdso64_enabled;
-#endif
-#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
 extern unsigned int vdso32_enabled;
-#endif
=20
 /*
  * This is used to ensure we don't load something for the wrong architecture.
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 80be0da..b7253ef 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -27,17 +27,9 @@ struct vdso_image {
 	long sym_vdso32_rt_sigreturn_landing_pad;
 };
=20
-#ifdef CONFIG_X86_64
 extern const struct vdso_image vdso_image_64;
-#endif
-
-#ifdef CONFIG_X86_X32_ABI
 extern const struct vdso_image vdso_image_x32;
-#endif
-
-#if defined CONFIG_X86_32 || defined CONFIG_COMPAT
 extern const struct vdso_image vdso_image_32;
-#endif
=20
 extern int __init init_vdso_image(const struct vdso_image *image);
=20

