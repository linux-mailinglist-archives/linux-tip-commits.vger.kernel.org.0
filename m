Return-Path: <linux-tip-commits+bounces-7279-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E87EFC4647D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Nov 2025 12:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B52E4ED6F8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Nov 2025 11:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09706306B00;
	Mon, 10 Nov 2025 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mxgwW4fA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EBy6pZAQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD672F5A18;
	Mon, 10 Nov 2025 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774160; cv=none; b=BjJei56dFF/rx95KScc2cG1YwsJ2STy/g28b6uVlRxCaScVfprugVrwnHmR2aDTsMGg3jYkDcefmTvjPtZiaNWY2S28nhGQMdY9twjJ3haaQ80BWztiMUJw4dzUy2CrrciAULMvrrlCEe7MbuDjrcf0cIvB658gyBOVBP+mRY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774160; c=relaxed/simple;
	bh=RLuzaiAuzICVtnurlg4PwpKgn7z3taOihGHdcvgTsos=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bNYa3gNFk+TV5lmv0Tnq+dTrAJvKjp/l1U6qT+0tH2a0CLPPdkLHSTIplH8afPcJTbmcM54/U5eh/vrxW+OGA13uu7a1zd0+HJlIS2jy+leblV8SXkpKpAU1vXn52QKPZD2hrcAtxfbeaKO85SFoekaRa2M7iYjefSeRqs6DIDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mxgwW4fA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EBy6pZAQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Nov 2025 11:29:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762774157;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jxwhu9vpUvZSUWzqZWfnJraiHnt6LMWNCOG5LPlM8Zw=;
	b=mxgwW4fAbE8ipLBVN+O124beH7+sXFSg9ym8iYtwvYRxKpU5U1nltXN/eAmlyKZ3LKC1Gz
	QDc9YlsLMWNn/+TC5hRqfvFpGJpVzgKSHNW66vBwkPafsWZm4l7nl+umDTJ1fRJp2IvA4N
	flDImFdtUdBsBIeHfF7d+LT6RK/NTrvxFWpmaTV6Rm1gZgSq+r9rC8+6qU+sjUwDJTwTS5
	PKwk8NxRGlLPV+8XXmAH67vfK4YCMvFsCQZzW6HboOfGxI4cd9OskEnJbaUuk2YDMCBYcB
	7hNXDHjBRfBaI+enLL8DVMR2OumnpI0yLp2VN5ROoRgE3yI6hvWsyy5a6M2jkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762774157;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jxwhu9vpUvZSUWzqZWfnJraiHnt6LMWNCOG5LPlM8Zw=;
	b=EBy6pZAQ5K+Q2IkCNDCbH+vax+EfCFgSCBF4uYMf2H0a6Fox5Q5kaDuY5exZ0UP0J8dtz3
	pUtDPj/7w/EukWBA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/percpu: Use BIT_WORD() and BIT_MASK() macros
Cc: Uros Bizjak <ubizjak@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250907184915.78041-1-ubizjak@gmail.com>
References: <20250907184915.78041-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176277415642.498.10303464175048641694.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     fd4e0255269bca311c90f0d0c1d5bd53c8846a59
Gitweb:        https://git.kernel.org/tip/fd4e0255269bca311c90f0d0c1d5bd53c88=
46a59
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 07 Sep 2025 20:48:46 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 10 Nov 2025 11:55:54 +01:00

x86/percpu: Use BIT_WORD() and BIT_MASK() macros

Use BIT_WORD() and BIT_MASK() macros from <linux/bits.h>
in <arch/x86/include/asm/percpu.h> instead of open-coding them.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20250907184915.78041-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 332428c..725d0ef 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -23,6 +23,7 @@
 #else /* !__ASSEMBLY__: */
=20
 #include <linux/args.h>
+#include <linux/bits.h>
 #include <linux/build_bug.h>
 #include <linux/stringify.h>
 #include <asm/asm.h>
@@ -572,9 +573,9 @@ do {									\
 #define x86_this_cpu_constant_test_bit(_nr, _var)			\
 ({									\
 	unsigned long __percpu *addr__ =3D				\
-		(unsigned long __percpu *)&(_var) + ((_nr) / BITS_PER_LONG); \
+		(unsigned long __percpu *)&(_var) + BIT_WORD(_nr);	\
 									\
-	!!((1UL << ((_nr) % BITS_PER_LONG)) & raw_cpu_read(*addr__));	\
+	!!(BIT_MASK(_nr) & raw_cpu_read(*addr__));			\
 })
=20
 #define x86_this_cpu_variable_test_bit(_nr, _var)			\

