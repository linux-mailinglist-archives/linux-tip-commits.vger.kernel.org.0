Return-Path: <linux-tip-commits+bounces-6251-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C2BB27DD2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Aug 2025 12:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AE8626085
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Aug 2025 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BF72FE066;
	Fri, 15 Aug 2025 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sk0FNlZn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wO9XVhVv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC68E227E82;
	Fri, 15 Aug 2025 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252037; cv=none; b=urrMo1pdXYSXGXflrzFGW8C/nSMVqTBF1lKfuyCG7a/3bE/HQ481jW7knpJxKzaEXX8yOk8UcHcW3/86iIZ6bb2tJFt+PTa4cxAHSWX4/xzZGJPDMf1Ylluc/BGu/LzEfpD98l8ySu29pKEfuDpJMF53aortPTWDvryJoD4Tono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252037; c=relaxed/simple;
	bh=+XeaNJCr0AIqk7PSRgXEwTfKZRcDsaAJ5Qho1qrExlw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pMf7CZ7udEE7Exqps7FlnNBqgf+FUb+Y8d5dhKALPVxdsIkq2KbV4xEDn78Qr06prnxE3PgswA1A7yLtxcq+3O7dS1P8ByN8PsPZ8JItwRaZx1yxMH3rBDd6G6WtS17uK5FJk0eRsUU/6y7h7vuLyHJh9BQdhAP5eDrEz6IQVW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sk0FNlZn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wO9XVhVv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Aug 2025 09:58:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755252033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lapm86iGhUHkVIee0DYR+Jfzxg5BHALDG4NRR/d40Ik=;
	b=sk0FNlZnPXdfx0qxGY7W/faLB6Js71jBNxlxCXeVvUoaXbK+R1BUXHOxIjEGf0HHFpX3YJ
	yQ5ASieDG25C5lbrWNpYydMox4QWZruErjwQaf495eYR3kVgfmB64FpaHuyZM77BFKr7jU
	916474BS/Gr4IIMVdsGFacFgt0Rxtf9tGrqwpnXEp13cF9q5bIDwEQhs2MXQRYXy3kqcOY
	qMVvFmCcALykW0D4AyC7yG+ioIu7gDjElddRH12ppWHQvvtrhNSBN8OpdDsP5GJvJYV71G
	klFA0KejT2JSM+6Evq11fAUbFLBQCKryPuxKKkoZ/LMBAdmv63tv9mKcGVwwCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755252033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lapm86iGhUHkVIee0DYR+Jfzxg5BHALDG4NRR/d40Ik=;
	b=wO9XVhVvnKdTDdlX0gMSHaByErjLn3M5fh4RzOiD8KqsrQ7d1qTtr7U5jgCCWCnyqESBfL
	ewCU2UEXKfJtwjBg==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Remove cc-option for GCC retpoline flags
Cc: Nathan Chancellor <nathan@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250814-x86-min-ver-cleanups-v1-1-ff7f19457523@kernel.org>
References: <20250814-x86-min-ver-cleanups-v1-1-ff7f19457523@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175525193734.1420.17080036868685677686.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     5d6d30eca4dd1c9e8515a8d4b13106205d5c0ec4
Gitweb:        https://git.kernel.org/tip/5d6d30eca4dd1c9e8515a8d4b13106205d5=
c0ec4
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Thu, 14 Aug 2025 18:31:37 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 15 Aug 2025 11:25:48 +02:00

x86/build: Remove cc-option for GCC retpoline flags

The minimum supported version of GCC to build the x86 kernel was bumped
to GCC 8.1 in

  a3e8fe814ad1 ("x86/build: Raise the minimum GCC version to 8.1").

'-mindirect-branch' and '-mindirect-branch-register' were first supported in
GCC 8.1, so there is no need to call cc-option to inquire if it is supported.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3Dda99fd4a3ca06b43b08=
ba8d96dab84e83ac90aa7
Link: https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3Dd543c04b795f8af4ebe=
5b3d5f38156ef4e5734f1
Link: https://lore.kernel.org/20250814-x86-min-ver-cleanups-v1-1-ff7f19457523=
@kernel.org
---
 arch/x86/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1913d34..ed56573 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -13,8 +13,8 @@ else
 endif
=20
 ifdef CONFIG_CC_IS_GCC
-RETPOLINE_CFLAGS	:=3D $(call cc-option,-mindirect-branch=3Dthunk-extern -min=
direct-branch-register)
-RETPOLINE_VDSO_CFLAGS	:=3D $(call cc-option,-mindirect-branch=3Dthunk-inline=
 -mindirect-branch-register)
+RETPOLINE_CFLAGS	:=3D -mindirect-branch=3Dthunk-extern -mindirect-branch-reg=
ister
+RETPOLINE_VDSO_CFLAGS	:=3D -mindirect-branch=3Dthunk-inline -mindirect-branc=
h-register
 endif
 ifdef CONFIG_CC_IS_CLANG
 RETPOLINE_CFLAGS	:=3D -mretpoline-external-thunk

