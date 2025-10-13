Return-Path: <linux-tip-commits+bounces-6789-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D613BD6550
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Oct 2025 23:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C91A435008A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Oct 2025 21:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD70A26561D;
	Mon, 13 Oct 2025 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kiyj9mpm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MVnuUtlf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356B7219E8;
	Mon, 13 Oct 2025 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389960; cv=none; b=OwsW/i2HjQ338J4bVO+Gxi75ZI6rntsUGd3J70iY3iBZBVkdMLctdyeylyTHnUz99TN6Q6fm85N8iWVM3Tx3HAB1rbSATbPcFKUXZQH6fZelsFSZLGf3o4aDbv+NvNgGxt6rQKlbo81myC1cc4eSWSxrFpoFP36ngcU7iY8wemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389960; c=relaxed/simple;
	bh=DCmFey32iTvvyMWOEHtXxQ9ym3WbxvdIyIpXYB2mx7k=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oDJqewSfnck4lZcQ7cwaPCIIoJdcF7tuVNDi+5WsKOUdAIsCWhd5aum3DS644xpDdL91Txzep4n5CQzGT+4uE4473rxAYrYEoptVOfleW9VlUiArYTIdQEAWy4c/Nxs8ENyRxHfB4Nc/7Gy77WjIF3dvABdEDPjm68a2PXA35Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kiyj9mpm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MVnuUtlf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 13 Oct 2025 21:12:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760389957;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ie7Ds8B86MVRkqypNsfvaNXFVQ5eGbkxlCz6XVnQmCs=;
	b=Kiyj9mpmNF0Kwf5eKfQAmTpxqZTze715sr+ukB538a2eVANBiBp5CfIF/gby0GINxjA8ZQ
	KvpcZQkDP08eEh8O5MxETpxFuyXrGoJcCznbrQ/YEoFyeNnZnhVtU+QuNJXUwZC5PHXRRt
	i98RuUy87pHgA62ENGVEEp5bxmdsa9T89IYTCsM90xvkWAstgQID9ppTPwGxZeXjCcM38I
	6GrEu8uK4i6hNH9mUix6nPFHDeilKxF984OwjTJ4NvK+sw8yqNhtnpuAg/ZWyei/uEp84U
	XYk/mmU2sl5dkk+B072zOKQQZWA3Zs7U6Ir1PpPmeHyVF62uDSTnI6GE0hhdbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760389957;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ie7Ds8B86MVRkqypNsfvaNXFVQ5eGbkxlCz6XVnQmCs=;
	b=MVnuUtlfX8MH4xkLa5E+pKtn403oYbyFaO4mj1d9N6L7bn5+Vq4OJxTmgWsAmhZGiy2Eji
	P9cwgdjQtTo0suDQ==
From: "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/fred: Fix 64bit identifier in fred_ss
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "Xin Li (Intel)" <xin@zytor.com>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176038995604.709179.16080488698468273330.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     4ab13be5ed12f4954d1f46cc6298e1adb2d6681b
Gitweb:        https://git.kernel.org/tip/4ab13be5ed12f4954d1f46cc6298e1adb2d=
6681b
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Wed, 03 Sep 2025 00:01:17 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 13 Oct 2025 14:05:42 -07:00

x86/fred: Fix 64bit identifier in fred_ss

FRED can only be enabled in Long Mode.  This is the 64bit mode (as opposed to
compatibility mode) identifier, rather than being something hard-wired at 1.

No functional change.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Xin Li (Intel) <xin@zytor.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/entry/entry_fred.c   | 4 ++--
 arch/x86/include/asm/fred.h   | 2 +-
 arch/x86/include/asm/ptrace.h | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index f004a4d..94e626c 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -78,13 +78,13 @@ static noinstr void fred_intx(struct pt_regs *regs)
 static __always_inline void fred_other(struct pt_regs *regs)
 {
 	/* The compiler can fold these conditions into a single test */
-	if (likely(regs->fred_ss.vector =3D=3D FRED_SYSCALL && regs->fred_ss.lm)) {
+	if (likely(regs->fred_ss.vector =3D=3D FRED_SYSCALL && regs->fred_ss.l)) {
 		regs->orig_ax =3D regs->ax;
 		regs->ax =3D -ENOSYS;
 		do_syscall_64(regs, regs->orig_ax);
 		return;
 	} else if (ia32_enabled() &&
-		   likely(regs->fred_ss.vector =3D=3D FRED_SYSENTER && !regs->fred_ss.lm))=
 {
+		   likely(regs->fred_ss.vector =3D=3D FRED_SYSENTER && !regs->fred_ss.l)) {
 		regs->orig_ax =3D regs->ax;
 		regs->ax =3D -ENOSYS;
 		do_fast_syscall_32(regs);
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 12b34d5..2bb6567 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -79,7 +79,7 @@ static __always_inline void fred_entry_from_kvm(unsigned in=
t type, unsigned int=20
 		.type   =3D type,
 		.vector =3D vector,
 		.nmi    =3D type =3D=3D EVENT_TYPE_NMI,
-		.lm     =3D 1,
+		.l      =3D 1,
 	};
=20
 	asm_fred_entry_from_kvm(ss);
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 50f7546..37370c3 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -84,8 +84,8 @@ struct fred_ss {
 			:  4,
 		/* Event was incident to enclave execution */
 		enclave	:  1,
-		/* CPU was in long mode */
-		lm	:  1,
+		/* CPU was in 64-bit mode */
+		l	:  1,
 		/*
 		 * Nested exception during FRED delivery, not set
 		 * for #DF.

