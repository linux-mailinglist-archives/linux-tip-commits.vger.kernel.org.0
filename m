Return-Path: <linux-tip-commits+bounces-7033-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6418DC16A9A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 Oct 2025 20:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC311B27E13
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 Oct 2025 19:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F8E2264CC;
	Tue, 28 Oct 2025 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oW6/Q4gh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pxyzsi5s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C813811713;
	Tue, 28 Oct 2025 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681035; cv=none; b=Y5ZckG/GJtvVZ+sg1qOofgFcxmR1rwuAieI3ZLT05X7qL77vhHktzGCoIqQm+NPcjjBKbCJWZge4yq3B0NeToZqM4/RHozQIZZlwomeeO6MixA4CTKXba5kMH9zRZwUYs1SnPpH9r71YJvKIxYZjuS4WfIwjmBXahL29DQjmFf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681035; c=relaxed/simple;
	bh=IS8ccZLS8O1aMrPVdz9Hrh+q286L75IRFKSxIOKS5hU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=a+MufwWhlWSR3KGWOhBPUEfQhGJVPWA/57e2XPifOTAAKG7Pmi7fMlVRWxU2IUpLw8/xEOXDcG47kKxIzh87utA1n+kwwI/WHOFJYattSsWyfkQuMJaNWr0tJMv0JiYK5GSfjYEGQeXJt9IjULQ6OLfXMD9sw/lXhUWReIj/cMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oW6/Q4gh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pxyzsi5s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Oct 2025 19:50:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761681031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3Ge8z2GiK9Te8yH78nPCxopQPTjbsz26hqVqPjdEWLA=;
	b=oW6/Q4ghqQOdSIce6xk5cXjq6qnXEcXHLVUnxo0yei5HwSRcoCOsd50xsAtQ5GwIphLKsb
	QMYoduuz5roIxMkCAj9H7IpKkppru6+ln33TERoNT9FyT0C3BO90AL2XObcEhNNrr+a11J
	Z0BJkBDZF1wp5Ux4Ulisgd//sgTc33UsqJ49C1WTei56QaudkJnca7wO3AtO+XoJXAGAAs
	Rlu14f8dDQ7+YInaler7zZUip+1osRHOR5x3BPAwXRgK5boqbm2oUD7utS3jPkagIs8AcA
	xy3/Aycwea2IAGwnQLzWl70ZfL+J3iDqTfWnVLpJOOx59BaQbaMsg3J7im+xdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761681031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3Ge8z2GiK9Te8yH78nPCxopQPTjbsz26hqVqPjdEWLA=;
	b=Pxyzsi5sj5/rKERu8wEegZ3TWebD83wXX0S0xH8NG/MClf1a1jo+GdiLLQj2ETWY79WKEE
	KViP1gi/nwGf8ECg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/build: Disable SSE4a
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Arisu Tachibana <arisu.tachibana@miraclelinux.com>, christian.koenig@amd.com,
 Harry Wentland <harry.wentland@amd.com>,  <stable@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176168102963.2601451.953876733690125275.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0d6e9ec80cebf9b378a1d3a01144e576d731c397
Gitweb:        https://git.kernel.org/tip/0d6e9ec80cebf9b378a1d3a01144e576d73=
1c397
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 27 Oct 2025 12:40:59 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 28 Oct 2025 20:43:36 +01:00

x86/build: Disable SSE4a

Leyvi Rose reported that his X86_NATIVE_CPU=3Dy build is failing because our
instruction decoder doesn't support SSE4a and the AMDGPU code seems to be
generating those with his compiler of choice (CLANG+LTO).

Now, our normal build flags disable SSE MMX SSE2 3DNOW AVX, but then
CC_FLAGS_FPU re-enable SSE SSE2.

Since nothing mentions SSE3 or SSE4, I'm assuming that -msse (or its negative)
control all SSE variants -- but why then explicitly enumerate SSE2 ?

Anyway, until the instruction decoder gets fixed, explicitly disallow SSE4a
(an AMD specific SSE4 extension).

Fixes: ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to =
locally optimize the kernel with '-march=3Dnative'")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Cc: <stable@kernel.org>
---
 arch/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 4db7e4b..8fbff31 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -75,7 +75,7 @@ export BITS
 #
 #    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D53383
 #
-KBUILD_CFLAGS +=3D -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
+KBUILD_CFLAGS +=3D -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -mno-sse4a
 KBUILD_RUSTFLAGS +=3D --target=3D$(objtree)/scripts/target.json
 KBUILD_RUSTFLAGS +=3D -Ctarget-feature=3D-sse,-sse2,-sse3,-ssse3,-sse4.1,-ss=
e4.2,-avx,-avx2
=20

