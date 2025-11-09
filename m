Return-Path: <linux-tip-commits+bounces-7278-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BB4C449AE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Nov 2025 00:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0761884D59
	for <lists+linux-tip-commits@lfdr.de>; Sun,  9 Nov 2025 23:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB019221540;
	Sun,  9 Nov 2025 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yP/P8a+h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qsPL4QDc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FA5145B3E;
	Sun,  9 Nov 2025 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762729506; cv=none; b=YELh1O3l8Ky5zPLjVzLtl9vD7SHbMRNCGXztt15EQSZtb7a6oKbdLqjU8h7HV415mcvvY5zkHivtM/ijuusPDKJZyAmYldObJ0QfGp3v58MSR9O9PuaodwsnoiYOksKf53VNTmKsQAYXnK9GuPqUlHZqzgUb0L9pqA1PRg1h/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762729506; c=relaxed/simple;
	bh=4DHM1r8vp+/R1ZIPOXH5kYTlUS3PEogKbBIYrhR8qLI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G4Y6Y1Tyri5YqXNqDTqhrvHA7maI6ivaG3ckWy+EBBGE/1c4cjkLojvwL8X3tFirs/FUbzIQfYUFRI1afGcfaJv5iB+LAXYIcNtkrs/NqQoIHhnENViCa4+uQ9LB0QPljetnEzbQFSW3LVMAs9KBpWffLc485fZMNJraCAuLueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yP/P8a+h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qsPL4QDc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 09 Nov 2025 23:04:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762729497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2Fxot2YOy4o8RQS3yHKoYm/Gd14fGyQnYQ+O1h6hEw=;
	b=yP/P8a+hCJtqakNIMNzrvEQm0TKK/V/ucsi/ocE/k/Ga37H1c/ZyVyG5x8+Qvonb+F7ht+
	QHhlzz77a5S9YC3Iq+L+MvvlQVvrlNM/k7QpQeTfcMf9jDdcqhp3bx/ub3lw/sG4C8K2kT
	3vw9ShiH9NcsCkkHOoJGr1uyU0JIy+LJIpbA1TuSMjOXoZaTVmMK/NUdJOd7gRk5srfF4s
	fZ7q9sbR/6VLUZfZz2EQno3H8EWQEIsrRIhVtZCoQkFuEml0uYVeC1pAJ9jba+LHU8RvlD
	tjjrWO0iO8wczb836ZX3Vgoj7D2mZ5BsNGdslUDIc6j+sw4Wud/fNRwFsGW1Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762729497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2Fxot2YOy4o8RQS3yHKoYm/Gd14fGyQnYQ+O1h6hEw=;
	b=qsPL4QDc2gGyFyUA7FDy5m4aRqjXKjdBAGhHHKX3e7sLnXOVU3j+SWmITBNiXNgXD7RG/a
	3cIQkfNE9OBMTHBQ==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/math-emu: Fix div_Xsig() prototype
Cc: Arnd Bergmann <arnd@arndb.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250807205334.123231-1-arnd@kernel.org>
References: <20250807205334.123231-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176272949287.498.1639238092119699825.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     780813d7018067f2796f023b56b51385970be460
Gitweb:        https://git.kernel.org/tip/780813d7018067f2796f023b56b51385970=
be460
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Thu, 07 Aug 2025 22:53:28 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 09 Nov 2025 21:01:08 +01:00

x86/math-emu: Fix div_Xsig() prototype

The third argument of div_Xsig() is the output of the division, but is marked
'const', which means the compiler is not expecting it to be updated and may
generate bad code around the call. clang-21 now warns about the pattern since
an uninitialized variable is passed into two 'const' arguments by reference:

  arch/x86/math-emu/poly_atan.c:93:28: error: variable 'argSignif' is uniniti=
alized \
  when passed as a const pointer argument here [-Werror,-Wuninitialized-const=
-pointer]
     93 |         div_Xsig(&Numer, &Denom, &argSignif);
        |                                   ^~~~~~~~~
  arch/x86/math-emu/poly_l2.c:195:29: error: variable 'argSignif' is uninitia=
lized \
  when passed as a const pointer argument here [-Werror,-Wuninitialized-const=
-pointer]
    195 |                 div_Xsig(&Numer, &Denom, &argSignif);
        |                                           ^~~~~~~~~

The implementation is in assembly, so the problem has gone unnoticed since the
code was added in the linux-1.1 days. Remove the 'const' marker here.

Fixes: e19a1bdb835c ("Import 1.1.38")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20250807205334.123231-1-arnd@kernel.org
---
 arch/x86/math-emu/poly.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/math-emu/poly.h b/arch/x86/math-emu/poly.h
index fc1c887..654bfe4 100644
--- a/arch/x86/math-emu/poly.h
+++ b/arch/x86/math-emu/poly.h
@@ -39,7 +39,7 @@ asmlinkage void mul_Xsig_Xsig(Xsig *dest, const Xsig *mult);
 asmlinkage void shr_Xsig(Xsig *, const int n);
 asmlinkage int round_Xsig(Xsig *);
 asmlinkage int norm_Xsig(Xsig *);
-asmlinkage void div_Xsig(Xsig *x1, const Xsig *x2, const Xsig *dest);
+asmlinkage void div_Xsig(Xsig *x1, const Xsig *x2, Xsig *dest);
=20
 /* Macro to extract the most significant 32 bits from a long long */
 #define LL_MSW(x)     (((unsigned long *)&x)[1])

