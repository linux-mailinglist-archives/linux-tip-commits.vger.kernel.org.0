Return-Path: <linux-tip-commits+bounces-5098-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F07BA96AC4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 14:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B921F162C72
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 12:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BC3201262;
	Tue, 22 Apr 2025 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WyK9UO6x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u7k7KIJg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF8119B5B8;
	Tue, 22 Apr 2025 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745326076; cv=none; b=H2gZswEcObNxM9qCvFMH02giBUeFhdkMIUfvPeG0xpK6njZJEv/KtZ5KiebTyrHKnsfjzI8Jh0M6xn7fHG/XwiSY0qH7ocpYdJtfpqQPaqM49dRwfCEAUKF46tU/T2rra+JZmowet+Vp583fd/gihmBMhXosbxrot3u0LlhqEDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745326076; c=relaxed/simple;
	bh=LspiZrANmO1lbSpnn/bN1TnE2ZvYMx3NlSkOpKix63U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R+AeE+GSbh+xFQvItAhlWTUVlKthvNy3da08EXT4osQ12BaoLAz/qj23CgpuCbQ3RdHqO2qDkXerLkOcXSx3z5/ilPZ2r3zqgejjTF+q6JkOKCD4rLEgPWU7apR/uqabJ8AZ8T2Y0Z91BDmRsESM6pet6aEVhzplmEfngnjYV0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WyK9UO6x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u7k7KIJg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Apr 2025 12:47:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745326072;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8t5WHJbg6GyeoUY7pz2AAGZaOE1UO8z7QLLwY7gkHFs=;
	b=WyK9UO6xfX6qFgclxePIg8xh8Bq2z48QXBrtFA5Dcj7SWlIyNTFxkH1KWl1FbKZlYfDxth
	xMxTFPuEfDr8TC+znKzEJnoX6LxoqEtmtXEwMbN7s2yNgCKTUfNvY6ujqrpxxmQIRDt8g9
	WPum9PK/dYUTkZZX9/liqSXZM4w+W0GaQnXM3lmrH5e/CXVvplimYHaMMLc9rIwHThlITe
	x9F+zJ0nHvfgfV6shokxFvQlOMmx3afFoeLZkmMtanBUlp4VCCCNYCp2kD6y92HdQ7FE37
	EtVb7Ek7mqkQ6x9KB88dOWWJ+1UJA9qmtLLAaOg9I8uEkzadZ6mUvj8WVKpOnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745326072;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8t5WHJbg6GyeoUY7pz2AAGZaOE1UO8z7QLLwY7gkHFs=;
	b=u7k7KIJgjFUHwzMVP5nBxWHwOnngahiZClCl8pPLABmijwoHfQmwujT9C+pqpYs/0bpXIN
	cipQxFA249e6c7Bg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/vdso: Remove redundant #ifdeffery around
 in_ia32_syscall()
Cc: thomas.weissschuh@linutronix.de, Ingo Molnar <mingo@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Eric Biederman <ebiederm@xmission.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
 Kees Cook <kees@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@surriel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240910-x86-vdso-ifdef-v1-2-877c9df9b081@linutronix.de>
References: <20240910-x86-vdso-ifdef-v1-2-877c9df9b081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174532606651.31282.9842098661104140762.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     bdb30d565f4b53e91abaccf83ecd718e5ba0f7c1
Gitweb:        https://git.kernel.org/tip/bdb30d565f4b53e91abaccf83ecd718e5ba=
0f7c1
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 10 Sep 2024 12:11:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Apr 2025 14:24:07 +02:00

x86/vdso: Remove redundant #ifdeffery around in_ia32_syscall()

The #ifdefs only guard code that is also guarded by in_ia32_syscall(),
which already contains the same #ifdef itself.

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
Link: https://lore.kernel.org/r/20240910-x86-vdso-ifdef-v1-2-877c9df9b081@lin=
utronix.de
---
 arch/x86/entry/vdso/vma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 495fdd4..afe105b 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -65,7 +65,6 @@ static vm_fault_t vdso_fault(const struct vm_special_mappin=
g *sm,
 static void vdso_fix_landing(const struct vdso_image *image,
 		struct vm_area_struct *new_vma)
 {
-#if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 	if (in_ia32_syscall() && image =3D=3D &vdso_image_32) {
 		struct pt_regs *regs =3D current_pt_regs();
 		unsigned long vdso_land =3D image->sym_int80_landing_pad;
@@ -76,7 +75,6 @@ static void vdso_fix_landing(const struct vdso_image *image,
 		if (regs->ip =3D=3D old_land_addr)
 			regs->ip =3D new_vma->vm_start + vdso_land;
 	}
-#endif
 }
=20
 static int vdso_mremap(const struct vm_special_mapping *sm,
@@ -266,7 +264,6 @@ int compat_arch_setup_additional_pages(struct linux_binpr=
m *bprm,
=20
 bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
 {
-#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
 	const struct vdso_image *image =3D current->mm->context.vdso_image;
 	unsigned long vdso =3D (unsigned long) current->mm->context.vdso;
=20
@@ -275,7 +272,6 @@ bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
 		    regs->ip =3D=3D vdso + image->sym_vdso32_rt_sigreturn_landing_pad)
 			return true;
 	}
-#endif
 	return false;
 }
=20

