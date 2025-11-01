Return-Path: <linux-tip-commits+bounces-7134-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0C5C286D1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C2B84EC564
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC23296BB5;
	Sat,  1 Nov 2025 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bMxx8tXw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SBau0WDS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5E302767;
	Sat,  1 Nov 2025 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026459; cv=none; b=jlkAbzYf/GnxcRlOL0e+n6Ztogp6yoyrXLxqlzGQOoMIiVWd9u670U3mmRacXMr29rA3rzhVqup0lEInOV5MWvkbom4/h31C/URX6fSwDBSbJEtBBjik7WmtXTi1LkXtw9+gNI7Q6QmR25z0QZhFpLxG9OZ9SBx3W7jHFdQCT48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026459; c=relaxed/simple;
	bh=GNYlsH/jxXM4Gt7zcsfgbNx2fiExdMQ3oLYdjk1J+XQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YDgG+u8OkSJhq/npNxIem/7OOXJ5my20WPKRdqCPVanm8KTcLBURgmoduLEh68QOmfIhKoKu5LXPzZqb8o9rd30nFI9CHox5MUrsBOrrHQsnDo66fdVY/zjtWE/m88T0qFp7zeZ3hXxDyEWyVp6Ec5K7jWFQdHArK0zGufzH5o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bMxx8tXw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SBau0WDS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026454;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPUEoIBIft/ZQ0DngVdx5UPYk2FzBpibKMwKTitRATA=;
	b=bMxx8tXwdBBUv4EAVadH6y1VEdKqXTlXPglXwYekyVrvQTdFmzh0VbR1rptLYKfgoOHThO
	FnvXbjbqJF0eCLP03/X6DVDv9iOz1mFaE73S7QcmwkC/rXwwc6T1FfZVTaEELQZ84/GMDJ
	bn/Iosk0Qq7vw3TMe68AckwVMUrY9JCr7Y0496OFelGFBEJQ2CInZePdjKJarPR1JREjQI
	kB4drM3f040wn2c1b8stQh/1oBVkN365UcCrpcjIUpEYYmaiC8rVYC18EtGQ25G1SgqBH/
	dxtutNhEZD7uB5twXuQVNY/zLdL/pFqHGUwHSYgDRLiy0EoANKFTwEoqmEx1pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026454;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPUEoIBIft/ZQ0DngVdx5UPYk2FzBpibKMwKTitRATA=;
	b=SBau0WDS8+HPae+/Yb04vgC8dSFVqDQB3YcyFHLqFusiHwAk/rvti6AE8KL0p6dtK6fF8c
	JfKgXVGYhQVMdqCw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] sparc64: vdso2c: Drop sym_vvar_start handling
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-32-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-32-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202645332.2601451.6136571013776972802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     38ddacdeafdb3a0a08632887ec63a5cedf87529f
Gitweb:        https://git.kernel.org/tip/38ddacdeafdb3a0a08632887ec63a5cedf8=
7529f
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:08 +01:00

sparc64: vdso2c: Drop sym_vvar_start handling

After the adoption of the generic vDSO library this symbol does not exist.

The alignment invariant is now guaranteed by the generic code.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-32-e0607bf4=
9dea@linutronix.de
---
 arch/sparc/include/asm/vdso.h | 2 --
 arch/sparc/vdso/vdso2c.c      | 6 ------
 arch/sparc/vdso/vdso2c.h      | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/arch/sparc/include/asm/vdso.h b/arch/sparc/include/asm/vdso.h
index 59e79d3..f08562d 100644
--- a/arch/sparc/include/asm/vdso.h
+++ b/arch/sparc/include/asm/vdso.h
@@ -8,8 +8,6 @@
 struct vdso_image {
 	void *data;
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
-
-	long sym_vvar_start;  /* Negative offset to the vvar area */
 };
=20
 #ifdef CONFIG_SPARC64
diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
index b97af5e..70b14a4 100644
--- a/arch/sparc/vdso/vdso2c.c
+++ b/arch/sparc/vdso/vdso2c.c
@@ -58,18 +58,12 @@
=20
 const char *outfilename;
=20
-/* Symbols that we need in vdso2c. */
-enum {
-	sym_vvar_start,
-};
-
 struct vdso_sym {
 	const char *name;
 	int export;
 };
=20
 struct vdso_sym required_syms[] =3D {
-	[sym_vvar_start] =3D {"vvar_start", 1},
 };
=20
 __attribute__((format(printf, 1, 2))) __attribute__((noreturn))
diff --git a/arch/sparc/vdso/vdso2c.h b/arch/sparc/vdso/vdso2c.h
index 60d69ac..ba07946 100644
--- a/arch/sparc/vdso/vdso2c.h
+++ b/arch/sparc/vdso/vdso2c.h
@@ -104,10 +104,6 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		}
 	}
=20
-	/* Validate mapping addresses. */
-	if (syms[sym_vvar_start] % 8192)
-		fail("vvar_begin must be a multiple of 8192\n");
-
 	if (!name) {
 		fwrite(stripped_addr, stripped_len, 1, outfile);
 		return;

