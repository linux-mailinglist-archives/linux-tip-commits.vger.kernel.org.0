Return-Path: <linux-tip-commits+bounces-3559-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F23EA3EF77
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E702B7A855F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF18C205E00;
	Fri, 21 Feb 2025 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IXJgTLgm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q1aahflB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD02054F7;
	Fri, 21 Feb 2025 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128601; cv=none; b=drbO3q4ifArP7gBhRo0+cqCPVJN9WEvSsJGnbrkBbFGOXV9pnN5/XCtUhXYYaK21t+wX+B6W/P6iDd34PgQ8DYKstAZqUmkTNYcVQtU3Zz9GebzysU7UrCBZ9efqWX8Gh2X9FpaxXFAiGhDV/bI7RMxzIiO8lIx0PYHwuub7/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128601; c=relaxed/simple;
	bh=hwPLoYBLzX0jupI0jmMCJrZVPvRD5czVlxNaO3aJYY4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IfI4Xevi2qRSLty/Ws/TMQr0JDWiF2VUiAT5hcwpXh2+y5MvEphAz7aJqP6Qg2/1S/2nXnsiTLokzBtEIc5/eRHb6LJHkJ0yXhL3xN/OMgnMiv6H6rCM+NWW+68xWvx4yG6Z4E55Jm9qR02lCC4WSawZtvniLtxN5Dszg+GFv0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IXJgTLgm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q1aahflB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRJq18h6zsBYDDEPg6+d7jDg0WMjw8j/HQ4kTR07Acw=;
	b=IXJgTLgmTVoRh2Wnk/rlnhIIE7bpB9rGFV4YWmbiKh9t+DN17JXYRJx6+R9qpLpKRaAosN
	xEtO3iOjvq2Wq0hLguWp1VaghwDABWWHqka0ldhKdsC4xPBxY9XRyYm4V54PHdy7uGxmUi
	k+TIcFGUz89v0ong3a1In5Tzv8a5lTogVFG4mxpL8XlehZOER7UjBtOUswYyxNqDafjNU5
	nvfP5Bjf0wYzb312I/D4aPdIJGA2JFEKSIbQD0VTsmnqWIG5+z66aNxrsWvgIqqoHvsZOp
	frccRzQpUiC3Z9ApbPaC1zx6ugqx9EUHjgNOJK3ZbvsdjahL6DtJvhGAG59Lsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRJq18h6zsBYDDEPg6+d7jDg0WMjw8j/HQ4kTR07Acw=;
	b=Q1aahflBPQ96YK0tIW6duFbzbCkQGG+cp0TDMxT7iI3yVpVpBjDeTRUzKb7l47intGvkEc
	I3I9EZJRcHgDvkBw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] x86/vdso: Fix latent bug in vclock_pages calculation
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-1-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-1-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012859759.10177.14504433418628527411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     3ef32d90cdaa0cfa6c4ffd18f8d646a658163e3d
Gitweb:        https://git.kernel.org/tip/3ef32d90cdaa0cfa6c4ffd18f8d646a6581=
63e3d
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:00 +01:00

x86/vdso: Fix latent bug in vclock_pages calculation

The vclock pages are *after* the non-vclock pages. Currently there are both
two vclock and two non-vclock pages so the existing logic works by
accident.  As soon as the number of pages changes it will break however.
This will be the case with the introduction of the generic vDSO data
storage.

Use a macro to keep the calculation understandable and in sync between
the linker script and mapping code.

Fixes: e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapp=
ing")
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-1-13a4669dfc8c@l=
inutronix.de

---
 arch/x86/entry/vdso/vdso-layout.lds.S | 2 +-
 arch/x86/entry/vdso/vma.c             | 2 +-
 arch/x86/include/asm/vdso/vsyscall.h  | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso=
-layout.lds.S
index 872947c..918606f 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -24,7 +24,7 @@ SECTIONS
=20
 	timens_page  =3D vvar_start + PAGE_SIZE;
=20
-	vclock_pages =3D vvar_start + VDSO_NR_VCLOCK_PAGES * PAGE_SIZE;
+	vclock_pages =3D VDSO_VCLOCK_PAGES_START(vvar_start);
 	pvclock_page =3D vclock_pages + VDSO_PAGE_PVCLOCK_OFFSET * PAGE_SIZE;
 	hvclock_page =3D vclock_pages + VDSO_PAGE_HVCLOCK_OFFSET * PAGE_SIZE;
=20
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 39e6efc..aa62949 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -290,7 +290,7 @@ static int map_vdso(const struct vdso_image *image, unsig=
ned long addr)
 	}
=20
 	vma =3D _install_special_mapping(mm,
-				       addr + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
+				       VDSO_VCLOCK_PAGES_START(addr),
 				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
 				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
 				       VM_PFNMAP,
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso=
/vsyscall.h
index 37b4a70..88b31d4 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -6,6 +6,7 @@
 #define __VVAR_PAGES	4
=20
 #define VDSO_NR_VCLOCK_PAGES	2
+#define VDSO_VCLOCK_PAGES_START(_b)	((_b) + (__VVAR_PAGES - VDSO_NR_VCLOCK_P=
AGES) * PAGE_SIZE)
 #define VDSO_PAGE_PVCLOCK_OFFSET	0
 #define VDSO_PAGE_HVCLOCK_OFFSET	1
=20

