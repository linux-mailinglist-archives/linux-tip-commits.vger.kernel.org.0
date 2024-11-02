Return-Path: <linux-tip-commits+bounces-2705-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779EC9B9E9B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D861281F78
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FA7189B83;
	Sat,  2 Nov 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PV1t0kwJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pafGlyKd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1BB176231;
	Sat,  2 Nov 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542218; cv=none; b=HZu7Bwpdv77iuj5JiaFqgZYCN9H8NEJZH9OLV0UX+hrgR7gKdPEV9XBl0fVI7A7JigA2wmHxENq6FxiLtey/uBQXt4VhKwZUsRGzaBvxVx1Ao6abC+jgjhfLwQdNwn7Z3+2ux5een0V9rOUU/lC9dSKWynj55BYg7D/RlGVetCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542218; c=relaxed/simple;
	bh=V7scyLj4V9GLr/fs+8sDbbRk6P6yny5I98xdylj0uYI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m6htYhlQJ7HynheChurwYnkhDdfoKBiZDv+fYg5uItMA+3QQLC8jSnQTpMYo2bPeBqPPzLaveD7wbRm/x+L1mhHidfrBTknam1BnyAY0ESEBCGFuml5mYNAN+0PX4WF+wLRghL4+6Ddb+mCIcOI3WsVlTY8fk7RyDJLt8UODTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PV1t0kwJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pafGlyKd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlGbePz+UO8j+pXZqFMFObPMK2iN3xVNvMaLo03IfWg=;
	b=PV1t0kwJw5sd0zYF5/cCkYUWIz+84AQ2zo50D7jldjjrKI1kgg99jwYUJeNezB7JeQI/59
	OMXMjH2CkqLssmDYAVPwd5wdcLYvlVQGsRET0AUvfLsZI5Q+OYuGjGI7nn9K3oMaHkV1pF
	OoAHEZuVoCsjUiejT0o5acoTm4MEVOl1WvSO7m0R1gy5JYLG2O8YcR1XfqcevUaC931OWR
	JPjD6hGimht/zVGm/3/khkwVHtyXt368XnFCyC1hBE7Fn5iSyX3m6iYkD3bRHUgzEVMqC9
	rQBtDtcUTCtmUOcwM/yIjvWv1L9He++WnKmHf67eeoMFwuHkYe9vtuvpkfHs1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlGbePz+UO8j+pXZqFMFObPMK2iN3xVNvMaLo03IfWg=;
	b=pafGlyKdvOGTMjDHmzz6FC9eZ5yWeGbjsHSiDrqAdf1Xs7DF+1/fmNsxSbxF/v6sBKKFaS
	bveUcyqmf9qQPvBQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/vdso: Move the rng offset to vsyscall.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-17-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-17-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054220955.3137.7312296795076846844.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     c0dfe50a0fac0376ab8d534511e48ef9ab2c8910
Gitweb:        https://git.kernel.org/tip/c0dfe50a0fac0376ab8d534511e48ef9ab2=
c8910
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:14 +01:00

x86/vdso: Move the rng offset to vsyscall.h

vvar.h will go away, so move the last useful bit into vsyscall.h.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-17-b64f0842d5=
12@linutronix.de

---
 arch/x86/entry/vdso/vdso-layout.lds.S | 1 +
 arch/x86/include/asm/vdso/vsyscall.h  | 2 ++
 arch/x86/include/asm/vvar.h           | 2 --
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso=
-layout.lds.S
index acce607..c7e194b 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm/vdso.h>
+#include <asm/vdso/vsyscall.h>
=20
 /*
  * Linker script for vDSO.  This is an ELF shared object prelinked to
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso=
/vsyscall.h
index aac7d2b..622dd17 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
=20
+#define __VDSO_RND_DATA_OFFSET  640
+
 #ifndef __ASSEMBLY__
=20
 #include <vdso/datapage.h>
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index b605914..d95cf92 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -19,8 +19,6 @@
 #ifndef _ASM_X86_VVAR_H
 #define _ASM_X86_VVAR_H
=20
-#define __VDSO_RND_DATA_OFFSET  640
-
 #ifdef EMIT_VVAR
 /*
  * EMIT_VVAR() is used by the kernel linker script to put vvars in the

