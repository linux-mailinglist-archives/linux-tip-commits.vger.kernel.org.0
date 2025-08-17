Return-Path: <linux-tip-commits+bounces-6261-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B9AB293F4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 17 Aug 2025 18:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C923B1ADE
	for <lists+linux-tip-commits@lfdr.de>; Sun, 17 Aug 2025 16:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8B72B9A8;
	Sun, 17 Aug 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t4Y1wYg/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IePmc6Ib"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E51F4FA;
	Sun, 17 Aug 2025 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755446538; cv=none; b=VKpNTk4axcoYNqPdlg03YiwBd+8pguRgaQdg1/HMW8dKbiUPh0y2bX250qOaGXx2UpIebwUAGIHLUemp6sANVUF2PwaTSstm892DfQXB0us0+pB5S6r+gzxVCgFddSkkADjcNwfZanWMkak2camOJYTLxDKV0mv8t6vOz0ktKbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755446538; c=relaxed/simple;
	bh=MMXn27OEplwXWUcwEO4tzcSlJZT5KRSyXkY1nkELCy4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kJNAQiIm6RQfOUOU9LFWGLqB0QUEBXYdX20JmrmzaLZY8MdnO6lEFODSPPJlU3PvHroi/C2Qb7UMAkcgpUl+YPjf0df4ghcmFUC/Z01LKqZHI/Xb5lJG+wlVRVNuRguNfEbOF1I6MkzAVFZ/1qyZ92H8tBqMMFpENOhmBHvNYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t4Y1wYg/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IePmc6Ib; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 17 Aug 2025 16:02:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755446533;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18Fuz6VmX4L7W+FDZrV0Pp1fjZoo/L/reDdeAndWJhE=;
	b=t4Y1wYg/37FI5QAsWBwOYo4IT5uoWfK8mETQbzwnhJUynzeYMzJuNsoBy0mjb2Vk/Qm6wo
	ynzyr8RqqZ9CFrZs8kYhsGMkvMC1yPSUVe91N2hii+9u9S89Mv0mord830RZqLx13X7MRu
	S7REpams/lEjfbULQxtO5xO9ETUXPyV9i8QhV3B8H2CHiYt681DaEAxKDpzIx0rV7VdNK2
	8AwgqKGXiejueMtgbIAX0qHub7RnH4MySgaV721Xov+5AsjhuX84tc8oq4zlW74I7YC/5c
	dAR4GMcRGpYjpmdTQRqsQtvSl+v7A9Scibj+u985ACXLJiFicuZ4XsFBO+kP4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755446533;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18Fuz6VmX4L7W+FDZrV0Pp1fjZoo/L/reDdeAndWJhE=;
	b=IePmc6IbY8wfEnWpl7QfrQ52QNoXYGriu4SXpIBguVjbIeldQVFHmw6jDsqupyTBDSuH66
	LqsdDVba1zAx/uBw==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/Kconfig: Clean up LLVM version checks in IBT
 configurations
Cc: Nathan Chancellor <nathan@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250814-x86-min-ver-cleanups-v1-6-ff7f19457523@kernel.org>
References: <20250814-x86-min-ver-cleanups-v1-6-ff7f19457523@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175544652925.1420.2858880325323032694.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     2c6a28f3ef729ed2d5b174b4e0f33172fb286bab
Gitweb:        https://git.kernel.org/tip/2c6a28f3ef729ed2d5b174b4e0f33172fb2=
86bab
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Thu, 14 Aug 2025 18:31:42 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 17 Aug 2025 13:10:39 +02:00

x86/Kconfig: Clean up LLVM version checks in IBT configurations

The minimum supported version of LLVM for building the x86 kernel
was bumped to 15.0.0 in

  7861640aac52 ("x86/build: Raise the minimum LLVM version to 15.0.0"),

so the checks for Clang 14.0.0 and ld.lld 14.0.0 or newer will always been
true. Clean them up.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250814-x86-min-ver-cleanups-v1-6-ff7f19457523=
@kernel.org
---
 arch/x86/Kconfig | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890f..85b9126 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1753,11 +1753,7 @@ config X86_UMIP
 config CC_HAS_IBT
 	# GCC >=3D 9 and binutils >=3D 2.29
 	# Retpoline check to work around https://gcc.gnu.org/bugzilla/show_bug.cgi?=
id=3D93654
-	# Clang/LLVM >=3D 14
-	# https://github.com/llvm/llvm-project/commit/e0b89df2e0f0130881bf6c39bf31d=
7f6aac00e0f
-	# https://github.com/llvm/llvm-project/commit/dfcf69770bc522b9e411c66454934=
a37c1f35332
-	def_bool ((CC_IS_GCC && $(cc-option, -fcf-protection=3Dbranch -mindirect-br=
anch-register)) || \
-		  (CC_IS_CLANG && CLANG_VERSION >=3D 140000)) && \
+	def_bool ((CC_IS_GCC && $(cc-option, -fcf-protection=3Dbranch -mindirect-br=
anch-register)) || CC_IS_CLANG) && \
 		  $(as-instr,endbr64)
=20
 config X86_CET
@@ -1769,8 +1765,6 @@ config X86_KERNEL_IBT
 	prompt "Indirect Branch Tracking"
 	def_bool y
 	depends on X86_64 && CC_HAS_IBT && HAVE_OBJTOOL
-	# https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231=
f9e579f2d0f
-	depends on !LD_IS_LLD || LLD_VERSION >=3D 140000
 	select OBJTOOL
 	select X86_CET
 	help

