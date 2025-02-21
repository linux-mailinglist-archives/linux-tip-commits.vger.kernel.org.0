Return-Path: <linux-tip-commits+bounces-3563-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F0DA3F5EC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 14:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D231650A7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82D820A5CC;
	Fri, 21 Feb 2025 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AF2cCN7+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3xNJfC6b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A4618E025;
	Fri, 21 Feb 2025 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144431; cv=none; b=GQOT7CiUw+nsscdD1i2C6ScZD/qZp4M8DaOapUlTubwLtsvo+gDewixpS8pGLp0AX4Nn/kFKHrah7qf4MurQiK1ROQ9kSnOBvx2P6e0LqJYrdiePhHCMyLAxZ+x8rNWQ130lzeElBQQ5QEF7Bk6pkrwicahSGFjTk/pjVrmIGqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144431; c=relaxed/simple;
	bh=NrjYjGdX/DSaZNb4ZD7dPD37LjKsH70xB8T1h/eBvWw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZKue0ZfZ47IQhw9GNS3TAarBzW6nUKUq24wiAko9d3dADS2daaeZLp6RJIbzbwfuMfw9mHaVnGDcPbI7792MVfuR3ipIb1jz6LqVCXXWB4ufGcm7fp3VdhjiY+F6F+657wA+cxnL7lnkEJa5fo1XuU3rmjJfrO4lxGFrc+C9d80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AF2cCN7+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3xNJfC6b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 13:27:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740144428;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zr8l3h1h8InjBC4fssDf1u5u3IARApWGgCdOkRQY7V4=;
	b=AF2cCN7+mAUX9ChAzCDKs8pBbYXoywCI0IZctGRnnFm+Z4V8SR13filmwfnTtFKYUFJe0U
	pQ5kT2R1Jgo6iMBy1ExSObbM2OFdHAT2k4CeTSwgOk1tyKrQhsj3eppL27mkTRZfuXZPC0
	VCmCcX9n7di1WGtDHCrF6V2/Rls7Ues5zCxd0WeUTx+QxfBhXua7YXIybq4rlNpZZDq0hr
	RacwtPrrkxnVHp7FtHO5Ub7hLisk0CXKXXRD3sLXF+Phi/GLvqyZ9s8M0LmnjQ1oQEYp6R
	pS6B83dccYDduJ9qu/OmE09XqoLGhJXHjqSD5gHj6Vs5uMUCFSKOhsC2vvlarw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740144428;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zr8l3h1h8InjBC4fssDf1u5u3IARApWGgCdOkRQY7V4=;
	b=3xNJfC6bFwFfMlRqmh/HPt/SP4UFYAyZ0HJg+Eic/4l7X2rXiez/jBU15I4Hl/VYE2UCoO
	Oa+05bet9wUnsrAQ==
From: "tip-bot2 for Eric Biggers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpufeatures: Make AVX-VNNI depend on AVX
Cc: Eric Biggers <ebiggers@google.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250220060124.89622-1-ebiggers@kernel.org>
References: <20250220060124.89622-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174014442773.10177.2930248397076157689.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     517120728484df1ab8b71cba8d2cad19f52f18a1
Gitweb:        https://git.kernel.org/tip/517120728484df1ab8b71cba8d2cad19f52f18a1
Author:        Eric Biggers <ebiggers@google.com>
AuthorDate:    Wed, 19 Feb 2025 22:01:24 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 14:19:16 +01:00

x86/cpufeatures: Make AVX-VNNI depend on AVX

The 'noxsave' boot option disables support for AVX, but support for the
AVX-VNNI feature was still declared on CPUs that support it.  Fix this.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250220060124.89622-1-ebiggers@kernel.org
---
 arch/x86/kernel/cpu/cpuid-deps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 8bd8411..df838e3 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -45,6 +45,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AES,			X86_FEATURE_XMM2      },
 	{ X86_FEATURE_SHA_NI,			X86_FEATURE_XMM2      },
 	{ X86_FEATURE_GFNI,			X86_FEATURE_XMM2      },
+	{ X86_FEATURE_AVX_VNNI,			X86_FEATURE_AVX       },
 	{ X86_FEATURE_FMA,			X86_FEATURE_AVX       },
 	{ X86_FEATURE_VAES,			X86_FEATURE_AVX       },
 	{ X86_FEATURE_VPCLMULQDQ,		X86_FEATURE_AVX       },

