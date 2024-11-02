Return-Path: <linux-tip-commits+bounces-2708-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E79329B9EA2
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B30F1F237DC
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336E3189F5F;
	Sat,  2 Nov 2024 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tcntrLji";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wk7g9W/q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEA617ADF7;
	Sat,  2 Nov 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542219; cv=none; b=UdIcetU9+3tgqeoUKb1teXvPhMcsp3h+IKy7TIiO9TkFCUg58zghVC3LZFY7/QqNJtfNaP7+rpwiSw2hJHt1X2mHIKKSF08FZN3u2E5Pfn5N3Q//pQ5ucBeLkP5s26B73p5WZw6BayxEcNKFD/JxGjAVxB2mZqjA2hRgbGXDxyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542219; c=relaxed/simple;
	bh=V+kFPGhL9DHToGZ4VYB6fPurB6zH4QWMASPtp9lHOXQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U0PlpdiuqAXJdTGiyVbWi6y83/n0fefOA2wPukxy3rGK4lb67Rvc4pgGWLZYwjkyw1KKavRBUUwNVu/NrI9uQ1qnM9sryJGBdB8zjRCQX60MOmXcqTqZD26WraAIzWr8nO0uFOGI85fTNRDfci5FKiKArOni6T6rH8gUfwwU3gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tcntrLji; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wk7g9W/q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542212;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2uMFht1qqhZrQB+4glhBZMcpGllskGJtv6wbNUtaJc=;
	b=tcntrLjiLY6uryo41HqMDBwugK1iLBVDobvbw9EStZq8/DYQEMYr7a6ZbuQpSHqxAYYZwY
	oOHlr6aFw0E/altWQiors7XWtXgnmJG7iX+E6XdXRBByWg9kkZRZ+3v/0KX7QgVW+7yCqk
	x496Jt1nSyl+zsEkYyj7Cv/WjSZpdWViXh/mWfGspdqa5zhOjwQPaQaRwo1ltUgzu44/2K
	TpHFu2hgjuqRsCpR9E3ZfLzjc1Xl8Dg4Em31pBJa3mGOaps/ym8ZvY8BkdvoariviiV/I8
	2gXM2mzQgmFEPcWp94DUJUkyxMZxuiiQ1qmwbbUMY1p6CuNW0OKuqR6hohzqDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542212;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2uMFht1qqhZrQB+4glhBZMcpGllskGJtv6wbNUtaJc=;
	b=Wk7g9W/q5BuwrNQ7GtIyb0Z6/ftkQmOs7pwLQZ6G4dsASW6ExSR3kxvvqfnGX/bK1G6Mz4
	OnpuHWvGVUFApFCw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/vdso: Allocate vvar page from C code
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-14-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-14-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054221158.3137.15064892110787509020.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     fc8127f9caa5ebc6609d0e6a2a8a52fbfd0c484e
Gitweb:        https://git.kernel.org/tip/fc8127f9caa5ebc6609d0e6a2a8a52fbfd0=
c484e
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:14 +01:00

x86/vdso: Allocate vvar page from C code

Allocate the vvar page through the standard union vdso_data_store
and remove the custom linker script logic.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-14-b64f0842d5=
12@linutronix.de

---
 arch/x86/entry/vdso/vma.c            | 16 +++++-----------
 arch/x86/include/asm/vdso/vsyscall.h |  6 ++++--
 arch/x86/kernel/vmlinux.lds.S        | 23 -----------------------
 arch/x86/tools/relocs.c              |  1 -
 4 files changed, 9 insertions(+), 37 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 8437906..5731dc3 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -20,25 +20,19 @@
 #include <asm/vgtod.h>
 #include <asm/proto.h>
 #include <asm/vdso.h>
-#include <asm/vvar.h>
 #include <asm/tlb.h>
 #include <asm/page.h>
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
 #include <clocksource/hyperv_timer.h>
=20
-#undef _ASM_X86_VVAR_H
-#define EMIT_VVAR(name, offset)	\
-	const size_t name ## _offset =3D offset;
-#include <asm/vvar.h>
-
 struct vdso_data *arch_get_vdso_data(void *vvar_page)
 {
-	return (struct vdso_data *)(vvar_page + _vdso_data_offset);
+	return (struct vdso_data *)vvar_page;
 }
-#undef EMIT_VVAR
=20
-DEFINE_VVAR(struct vdso_data, _vdso_data);
+static union vdso_data_store vdso_data_store __page_aligned_data;
+struct vdso_data *vdso_data =3D vdso_data_store.data;
=20
 unsigned int vclocks_used __read_mostly;
=20
@@ -153,7 +147,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapp=
ing *sm,
 	if (sym_offset =3D=3D image->sym_vvar_page) {
 		struct page *timens_page =3D find_timens_vvar_page(vma);
=20
-		pfn =3D __pa_symbol(&__vvar_page) >> PAGE_SHIFT;
+		pfn =3D __pa_symbol(vdso_data) >> PAGE_SHIFT;
=20
 		/*
 		 * If a task belongs to a time namespace then a namespace
@@ -200,7 +194,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapp=
ing *sm,
 		if (!timens_page)
 			return VM_FAULT_SIGBUS;
=20
-		pfn =3D __pa_symbol(&__vvar_page) >> PAGE_SHIFT;
+		pfn =3D __pa_symbol(vdso_data) >> PAGE_SHIFT;
 		return vmf_insert_pfn(vma, vmf->address, pfn);
 	}
=20
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso=
/vsyscall.h
index ce8d5c8..aac7d2b 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -8,20 +8,22 @@
 #include <asm/vgtod.h>
 #include <asm/vvar.h>
=20
+extern struct vdso_data *vdso_data;
+
 /*
  * Update the vDSO data page to keep in sync with kernel timekeeping.
  */
 static __always_inline
 struct vdso_data *__x86_get_k_vdso_data(void)
 {
-	return _vdso_data;
+	return vdso_data;
 }
 #define __arch_get_k_vdso_data __x86_get_k_vdso_data
=20
 static __always_inline
 struct vdso_rng_data *__x86_get_k_vdso_rng_data(void)
 {
-	return (void *)&__vvar_page + __VDSO_RND_DATA_OFFSET;
+	return (void *)vdso_data + __VDSO_RND_DATA_OFFSET;
 }
 #define __arch_get_k_vdso_rng_data __x86_get_k_vdso_rng_data
=20
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 6726be8..e7e1984 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -193,29 +193,6 @@ SECTIONS
=20
 	ORC_UNWIND_TABLE
=20
-	. =3D ALIGN(PAGE_SIZE);
-	__vvar_page =3D .;
-
-	.vvar : AT(ADDR(.vvar) - LOAD_OFFSET) {
-		/* work around gold bug 13023 */
-		__vvar_beginning_hack =3D .;
-
-		/* Place all vvars at the offsets in asm/vvar.h. */
-#define EMIT_VVAR(name, offset)				\
-		. =3D __vvar_beginning_hack + offset;	\
-		*(.vvar_ ## name)
-#include <asm/vvar.h>
-#undef EMIT_VVAR
-
-		/*
-		 * Pad the rest of the page with zeros.  Otherwise the loader
-		 * can leave garbage here.
-		 */
-		. =3D __vvar_beginning_hack + PAGE_SIZE;
-	} :data
-
-	. =3D ALIGN(__vvar_page + PAGE_SIZE, PAGE_SIZE);
-
 	/* Init code and data - will be freed after init */
 	. =3D ALIGN(PAGE_SIZE);
 	.init.begin : AT(ADDR(.init.begin) - LOAD_OFFSET) {
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index c101bed..6afe2e5 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -89,7 +89,6 @@ static const char * const	sym_regex_kernel[S_NSYMTYPES] =3D=
 {
 	"init_per_cpu__.*|"
 	"__end_rodata_hpage_align|"
 #endif
-	"__vvar_page|"
 	"_end)$"
 };
=20

