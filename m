Return-Path: <linux-tip-commits+bounces-2737-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2846F9B9FAC
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EDC1F21F37
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CE01ABEA0;
	Sat,  2 Nov 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G5vWdUg+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7CIrl/+R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A40A1AAE01;
	Sat,  2 Nov 2024 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548226; cv=none; b=I93SJTm2TA/XLrBZPJ26aaAmlcx3nxOWqhE4etThU3/vCRGnLGIv2XcPETmJu1uf4nRIOf/5od150Xf4yR2oWTnjNtQYcjsbLnN+0eJYuderPGN42ih7VO6TA5jw2ZoDQJc0k2u4ItcQH6KB7/Ay6SGwhLOPo5Q6ylJjdDwPjns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548226; c=relaxed/simple;
	bh=Z2h5o5O4mlCsyfEh4y+ta6wyfnuRpj4fx3Eq21OUeZk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W0c/CBMqC4/iy1G47fxapMb362VoPdkLQuFVjdD1TC2R6fHOMFoo5yeek2kvVnoTJUPZB0xoamGkpILqs+V7vO4swxNirs2mBG6hWMn3HpQ4rip7Ax/Rp484NN2SCZqDdrsfsvjKQuumtFMm57dG7AvA+uGm2KzRm78baGvWBsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G5vWdUg+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7CIrl/+R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgCD755TaMnjT2Sjh5hJu7N0OWT3fRpQc4ieJ12xDU8=;
	b=G5vWdUg+2W/kgMhrUoeJNwWuxs4uACeQsrCplbcorVaoPq0h67oP5T76BuT49Mvlvnd3VO
	ss00+q3Y8ZZh5aXlmSRfTgqqKibYt3zubc+CcAZuadl17tTbZyStoNMHN50xE81m48XPuR
	yqcjGPcplStmfE6QdpqoQJIwXfXJdvsabxlTivNj5tYgLEh1lhOe4zVw4APDTELv5vQlB/
	DphGVzshPIP3ebliIqH5+Pu1WB+usjLvgCpe25hFk8eg3GwtAYYCPYVmobzwFqfDUd++sV
	H8TOyRnYF1yV2WiU/pn5jX03+FOD2QRxuDvUQ82kLwRUaCJ/x6pABE+XGV4HAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgCD755TaMnjT2Sjh5hJu7N0OWT3fRpQc4ieJ12xDU8=;
	b=7CIrl/+RoqUQ+7E4+993dlQp42t0Zvmx1QmU7zVs/PbwIIZwn2p4VknDjZu4qOdIWXqoWz
	S4CeJellS/ykTQBA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/vdso: Access rng data from kernel without vvar
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-13-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-13-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054822231.3137.6490176705178257299.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     7821571be92f9c81f63d4639e652e85d258ce5f2
Gitweb:        https://git.kernel.org/tip/7821571be92f9c81f63d4639e652e85d258=
ce5f2
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:34 +01:00

x86/vdso: Access rng data from kernel without vvar

Remove the usage of the vvar _vdso_rng_data from the kernel-space code,
as the x86 vvar machinery is about to be removed.
The definition of the structure is unnecessary, as the data lives in a
page pre-allocated by the linker anyways.
The vdso user-space access to the rng data will be switched soon.

DEFINE_VVAR_SINGLE() is now unused. It will be removed later togehter
with the rest of vvar.h.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-13-b64f0842d5=
12@linutronix.de

---
 arch/x86/entry/vdso/vma.c            | 1 -
 arch/x86/include/asm/vdso/vsyscall.h | 2 +-
 arch/x86/include/asm/vvar.h          | 4 +++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index b8fed8b..8437906 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -39,7 +39,6 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 #undef EMIT_VVAR
=20
 DEFINE_VVAR(struct vdso_data, _vdso_data);
-DEFINE_VVAR_SINGLE(struct vdso_rng_data, _vdso_rng_data);
=20
 unsigned int vclocks_used __read_mostly;
=20
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso=
/vsyscall.h
index a1f916b..ce8d5c8 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -21,7 +21,7 @@ struct vdso_data *__x86_get_k_vdso_data(void)
 static __always_inline
 struct vdso_rng_data *__x86_get_k_vdso_rng_data(void)
 {
-	return &_vdso_rng_data;
+	return (void *)&__vvar_page + __VDSO_RND_DATA_OFFSET;
 }
 #define __arch_get_k_vdso_rng_data __x86_get_k_vdso_rng_data
=20
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index 01e60e0..fe3434d 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -19,6 +19,8 @@
 #ifndef _ASM_X86_VVAR_H
 #define _ASM_X86_VVAR_H
=20
+#define __VDSO_RND_DATA_OFFSET  640
+
 #ifdef EMIT_VVAR
 /*
  * EMIT_VVAR() is used by the kernel linker script to put vvars in the
@@ -62,7 +64,7 @@ DECLARE_VVAR(0, struct vdso_data, _vdso_data)
=20
 #if !defined(_SINGLE_DATA)
 #define _SINGLE_DATA
-DECLARE_VVAR_SINGLE(640, struct vdso_rng_data, _vdso_rng_data)
+DECLARE_VVAR_SINGLE(__VDSO_RND_DATA_OFFSET, struct vdso_rng_data, _vdso_rng_=
data)
 #endif
=20
 #undef DECLARE_VVAR

