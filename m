Return-Path: <linux-tip-commits+bounces-3828-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE402A4CBC9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B64AA7A86DC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53AB23AE9B;
	Mon,  3 Mar 2025 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="El8cWFqG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o3zT3p8p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1151223A58B;
	Mon,  3 Mar 2025 19:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029187; cv=none; b=N9v6pfHKfC3JOES6N51Nu/W4+zFSSvC8n7mlEqK8w3k64nXxl9c64Ltn9edUEhZeaQ891jeK7cMioTfxWDOjGRFe7WL/12dAgIDJeJYZqhDiFz3rG3d0qcJVIQUkuWXW/JxX28ux0PR30brqc7jHoju4CHf2xraALhFZdDk5D3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029187; c=relaxed/simple;
	bh=qgGSwscuwPucdZtLWyF0KbycL8ltJBjYfwdnPE6lX1U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=go6PQXJjsAoN7w1N364mFxqUPpD6aFOizwfow69TypIO43pU2ym3HkB23/djCaN4TK8/LLb0I0rRedVguW2GI39BnFu6kz5dstmBT1wLOfI11l7hv5bFVmVAnIxknmiNhYlwz1z2aOyYzfPdP7mGte2KjrI6d8rSjui8MKXzzFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=El8cWFqG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o3zT3p8p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:13:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741029184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihzYVPBOOrnbT07DHWB2IMvm7x+jpZNB+H7CKT6rPME=;
	b=El8cWFqGckbfWu0TncqN4uRj1ipGtzlJnxFKHJ1KsQ5w+0PlAoLjmb5ssRsiFMSAmyue21
	wCJnIV0nGtOK9YHrnWzAl+2DFEodmlnLMK5Atydy5gnDcWYXmLHbzXWh8ITeU/3FklE/sr
	KksqiwQIDchIjuynANhDpNTDVk4v+tW4WgSXquYPvm4k7IqbHYlDkIZoyzejri3h/6uDo1
	0ikrzLpnW0IY9Td9Oap8tjhxHnILA5t3D209Fp/JWYdR/OAZBAEUepcwCXtQqXRSNR4aEU
	Y8A8VsX2TU/mrPgYhfs/lILQi/uZ3pahklRwXL+HYjNMUAqnzdIclyqsS9lNHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741029184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihzYVPBOOrnbT07DHWB2IMvm7x+jpZNB+H7CKT6rPME=;
	b=o3zT3p8pSshOlWS7+V+qswe6ShdQeCYJNy9SCrPiDaUXGX+X6OFKpN50h0xVY121SEdrnd
	ejPSPVMnRZBqC/CQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] elf, uapi: Add definition for DT_GNU_HASH
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Kees Cook <kees@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226-parse_vdso-nolibc-v2-3-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-3-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102918410.14745.15994752315378891052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     50881d1469cf35eec690d863276cf257c391eec5
Gitweb:        https://git.kernel.org/tip/50881d1469cf35eec690d863276cf257c39=
1eec5
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 12:44:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 20:00:11 +01:00

elf, uapi: Add definition for DT_GNU_HASH

The definition is used by tools/testing/selftests/vDSO/parse_vdso.c.

To be able to build the vDSO selftests without a libc dependency,
add the define to the kernels own UAPI headers.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://refspecs.linuxbase.org/LSB_5.0.0/LSB-Core-generic/LSB-Core-gene=
ric/libc-ddefs.html
Link: https://lore.kernel.org/all/20250226-parse_vdso-nolibc-v2-3-28e14e031ed=
8@linutronix.de
---
 include/uapi/linux/elf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 448695c..c5383cc 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -107,6 +107,7 @@ typedef __s64	Elf64_Sxword;
 #define DT_VALRNGLO	0x6ffffd00
 #define DT_VALRNGHI	0x6ffffdff
 #define DT_ADDRRNGLO	0x6ffffe00
+#define DT_GNU_HASH	0x6ffffef5
 #define DT_ADDRRNGHI	0x6ffffeff
 #define DT_VERSYM	0x6ffffff0
 #define DT_RELACOUNT	0x6ffffff9

