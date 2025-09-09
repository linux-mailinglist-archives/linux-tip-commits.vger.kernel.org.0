Return-Path: <linux-tip-commits+bounces-6523-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437EAB4AA47
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA827A8805
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0151031CA5D;
	Tue,  9 Sep 2025 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Xa5/TBj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tVPmbIdT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586002C08B0;
	Tue,  9 Sep 2025 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413186; cv=none; b=pdDYb/VW4KF/EPqLdoqvRz9GRYnijfb9jBdGmz4tgRm2yuF+GvfByZs+YPsCscLgjLCvdmE9ARe545XpxADHoPrUDRBez15FCyhoeftC7Gw/EBDXczRyB5F1IlF5D15C2/T8LKDhD6I9z7lAp989b4KJ37LLkyy4r7zvTcd/odk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413186; c=relaxed/simple;
	bh=6Ox+vJK2AZ38O/nZ2z4zcE/9mxd558VX+CpKAIYYJus=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=c+7+QHH1XX4v5VpBGWFjz3W40Bjoa0cSP4hfOldLO1B+W1jpmxfMSJH5Xc8mim0jPpnc6meXewRRQPgD20YfbBdzxPzvt2d6Z+1FfXGow0zORWDOPAcjByZup/C2S5IHORJoL6MY6RoPa7d+LoqLlhH2e6MYEEPxtDhaFgF7wlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Xa5/TBj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tVPmbIdT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 10:19:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757413183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mm5k+OhVPCdsrRLPCGmyBlUnUVlD1gZjpG9MzSMpzdY=;
	b=2Xa5/TBjIdNjRoD+3j04ukD7uQxznPzAkrqq/6Ub4v6U1RgPrbpHjb7K5oM89J3sXENuzb
	1dG2+zsjAnfIE743JtrxOGEQqf/3buKJS0OoSkaFd1izLsC7Drks8FyWuzPXBqRBbhfgZK
	woBxd2Mt6pmvtXultOvvRIlUIujUtsOV/7hm4xDm59ZL9oMHRMmRwAQV2pSKhyGWrY8Jjg
	dGYB9PjvqiEN/bUcDlCeyZCgLkobKxNo/zbkMuvULlBFkmBbVuimvnXTFtRcuQdaZzt99o
	e0mVIACZpcMbX5YBIp105pf/ETwXkSUIvdq/FLhdCShBaexZGwAXCBoiT5+aWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757413183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mm5k+OhVPCdsrRLPCGmyBlUnUVlD1gZjpG9MzSMpzdY=;
	b=tVPmbIdTourrNdCpBgQuNT4q3Fp6kqJPFWowDcGBFQ9G0ntvqgwYIyruHp1duDoxsOVj/J
	1wk71O1u54rAKHAw==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] objtool: Ignore __pi___cfi_ prefixed symbols
Cc: Nathan Chancellor <nathan@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741318151.1920.16288790087502809814.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     26a9f90b6101ea2c9d6f02802cf6d85108104b90
Gitweb:        https://git.kernel.org/tip/26a9f90b6101ea2c9d6f02802cf6d851081=
04b90
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Mon, 08 Sep 2025 13:04:18 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 09 Sep 2025 12:02:01 +02:00

objtool: Ignore __pi___cfi_ prefixed symbols

When building with CONFIG_CFI_CLANG=3Dy after the recent series to
separate the x86 startup code, there are objtool warnings along the
lines of:

  vmlinux.o: warning: objtool: __pi___cfi_startup_64_load_idt() falls through=
 to next function __pi_startup_64_load_idt()
  vmlinux.o: warning: objtool: __pi___cfi_startup_64_setup_gdt_idt() falls th=
rough to next function __pi_startup_64_setup_gdt_idt()
  vmlinux.o: warning: objtool: __pi___cfi___startup_64() falls through to nex=
t function __pi___startup_64()

As the comment in validate_branch() states, this is expected, so ignore
these symbols in the same way that __cfi_ and __pfx_ symbols are already
ignored for the rest of the kernel.

Fixes: 7b38dec3c5af ("x86/boot: Create a confined code area for startup code")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d0d2066..093fcd0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3565,6 +3565,7 @@ static int validate_branch(struct objtool_file *file, s=
truct symbol *func,
 			/* Ignore KCFI type preambles, which always fall through */
 			if (!strncmp(func->name, "__cfi_", 6) ||
 			    !strncmp(func->name, "__pfx_", 6) ||
+			    !strncmp(func->name, "__pi___cfi_", 11) ||
 			    !strncmp(func->name, "__pi___pfx_", 11))
 				return 0;
=20

