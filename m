Return-Path: <linux-tip-commits+bounces-2435-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4984199F218
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD9E1F23449
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5711E9096;
	Tue, 15 Oct 2024 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vQniCiVM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cFHU+FTE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896DD3BBF6;
	Tue, 15 Oct 2024 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007879; cv=none; b=c33DcQYemLJy8nv4IeyUEDWv3bkkhFi6gfeGjL1+gK4Wpgc9aBx6MHHLwrXq2fOIORay5iYCDL6GZjdLPmsGOrfaPy6cIhhE4d7LNvIiPPntoR+mwgg/G/BsAl6ktyl2cy5khX3xDzWhdAltOyKoNDOSCObGBGcCmw8Ym9khhYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007879; c=relaxed/simple;
	bh=vr3qFErM8lTN/jk2jix9kmcJs73tXpFnqqWdBPEEJ9g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S5Pilq7sJLdE4OzfJn16FW+CSpRDkZ5sXh2uNQeJRkMqO0f+BMzRFx2IkqGNJXNXySPnM3yH+Am5ktCkThgfDef9rwyw8Is7qtlLI6U0ikaYRiB/OfDrRdpTE4BhMvB2dh2R8tIxuNT9Olk6THAY6T7K8TWLjxNILGyS2xaVwHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vQniCiVM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cFHU+FTE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:57:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729007876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/SxG8O1hPYnDq6TPqNCwarVnB6Wwq8dxxZaEtAm+kg=;
	b=vQniCiVM2ZHTTjNWANwSJ0xHiKCncQfOo7Tfi02lP75YfWXtMdUmuUIppXkGazlcVbq3oP
	7SXxOKwL5Tv8fgdqYNCnhJR1KkAHAFcKjjaL+ZMiIAnmXBQbBjb/HR6oaPL7yYsyMVJ3RA
	2X3NmUnLRR8hk31LLGhCwX5bOLlP/p1tCTjRn/5Ea4vuvWIVRx/X3+qp82onZEVQ85f+cU
	C5q9UBpXPFT219RGID9ssE6+KBjvFHFlnTH7fO3bEb8U5shwtDwS4iFEfiWulruIIIZKhx
	9V1cmY2yoJ1jnso0ZHN3Gv2WW5gfBlf/SbF15WR//Ms3cjkKTOXGaP9kCoEOSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729007876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/SxG8O1hPYnDq6TPqNCwarVnB6Wwq8dxxZaEtAm+kg=;
	b=cFHU+FTE/2NRmzijCBDv9TPI2r5hQfnqxtoUnswnP4p6yaoY3zUbFyz7nqldY5uiAyUAlU
	dpQ+DxJS/Xl5bIAQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] LoongArch: vdso: Remove timekeeper includes
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20241010-vdso-generic-arch_update_vsyscall-v1-8-7fe5a3ea4382@linutronix.de>
References:
 <20241010-vdso-generic-arch_update_vsyscall-v1-8-7fe5a3ea4382@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900787624.1442.2259294902592829079.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     fc06b914c1ce8009d6f469c512aa993b1c601da8
Gitweb:        https://git.kernel.org/tip/fc06b914c1ce8009d6f469c512aa993b1c6=
01da8
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 17:44:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:50:29 +02:00

LoongArch: vdso: Remove timekeeper includes

Since the generic VDSO clock mode storage is used, this header file is
unused and can be removed.

This avoids including a non-VDSO header while building the VDSO,
which can lead to compilation errors.

Also drop the comment which is out of date and in the wrong place.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-arch_update_vsyscall-=
v1-8-7fe5a3ea4382@linutronix.de

---
 arch/loongarch/include/asm/vdso/vsyscall.h | 4 ----
 arch/loongarch/kernel/vdso.c               | 1 -
 2 files changed, 5 deletions(-)

diff --git a/arch/loongarch/include/asm/vdso/vsyscall.h b/arch/loongarch/incl=
ude/asm/vdso/vsyscall.h
index b1273ce..8987e95 100644
--- a/arch/loongarch/include/asm/vdso/vsyscall.h
+++ b/arch/loongarch/include/asm/vdso/vsyscall.h
@@ -4,15 +4,11 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
=20
 extern struct vdso_data *vdso_data;
 extern struct vdso_rng_data *vdso_rng_data;
=20
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
 static __always_inline
 struct vdso_data *__loongarch_get_k_vdso_data(void)
 {
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index f6fcc52..4d7cb94 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -15,7 +15,6 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/time_namespace.h>
-#include <linux/timekeeper_internal.h>
=20
 #include <asm/page.h>
 #include <asm/vdso.h>

