Return-Path: <linux-tip-commits+bounces-4636-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE1BA7A3B8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 15:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2431E1728AE
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F2024A05B;
	Thu,  3 Apr 2025 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bvo8OC8m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NDWhMSdE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1142F2066DB;
	Thu,  3 Apr 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687208; cv=none; b=sF83YMiqFl0NrTEk7619tLVOc/TGp6RcLEUdMSLe5d300JJ+2GXf3YCHPa7wBzWMP0bR+e0XvITkzsA3ohGE2kND5MNaIe+4TNb7h7OyoX3vqalbyXwrOQc52jLzc/2Z0tKf2Kw1upa0o9YJF1gcYJNM9rE2OcCUNJi0QAu4B44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687208; c=relaxed/simple;
	bh=xsV8cuNuBCwEg8E/ibRrQyVGLg0YS/zeFrnyD/zu+Lg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sXgdU4QNu5ucfMVwoamdnQLB0cWoUCEPJuEbywDPsmhM5cOya2CYWbDxoD1ptLSc7szmfaZfoiGVDao14C1DZ699DsDDOMalXNvrVoGGM3ahMv7sSpJhUqstTHQ/FUjEnHs3sY0JHDwFe0kS09F5np5O6l5xKAn9QKrQczV1fKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bvo8OC8m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NDWhMSdE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 13:33:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743687205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8REwVvz+MfRciet4lgb/OqymK+vKnqnfiK2HSzaYS6A=;
	b=Bvo8OC8mEh0VJslgOrFPx2uZoandu1dGlk4SLuqoJbkZqsp+5ePcJgYjOaTv5rx5WxnKEZ
	T2cZtPTbM0BdpD0VWVzGqnU1oTG0KqBXj9zG5WCzaCzuXT+gr2y7/HUY6HHqwSXILz8IPd
	qx9TrAf6HGwyy2U79/a1ZGOm3MMHkycI7ZTXpN7Ua/DSDGnNdq90tTsVIFd3JtkfAqEHka
	cDhT1kI2g8pB3oKdZLYcSWdJCUbmmPneobFc76nUohPQkxE0radNczJGEHUY0NNMEcr+5j
	ER/VOS+Pq+meKtJ45cQtrhquyTAXSLYQxs3qEQnPNSlL3UuBlYvvfrv2VlVBvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743687205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8REwVvz+MfRciet4lgb/OqymK+vKnqnfiK2HSzaYS6A=;
	b=NDWhMSdEzYM5h59JJ5A64CUkJne2HAF5L9ttiOsqoJekN9Ch/cb0c5h4onFxhv4kHDbTvx
	OE4ksjkCacD+HXBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kconfig] x86/kbuild/64: Test for the availability of the
 -mtune=native compiler flag
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@kernel.org>,
 Tor Vic <torvic9@mailbox.org>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324172723.49fb0416@canb.auug.org.au>
References: <20250324172723.49fb0416@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174368720454.30396.11966787075140474975.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     01412081863aa81db47423d5719f2726d2a00a32
Gitweb:        https://git.kernel.org/tip/01412081863aa81db47423d5719f2726d2a00a32
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 08:05:19 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 08:24:06 +01:00

x86/kbuild/64: Test for the availability of the -mtune=native compiler flag

Stephen reported this build failure when cross-compiling:

  cc1: error: bad value 'native' for '-march=' switch

Test for the availability of the -march=native flag.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Stephen Rothwell <sfr@canb.auug.org.au> # build test
Cc: Tor Vic <torvic9@mailbox.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324172723.49fb0416@canb.auug.org.au
---
 arch/x86/Kconfig.cpu | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 9d108a5..87bede9 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -245,10 +245,14 @@ config MATOM
 
 endchoice
 
+config CC_HAS_MARCH_NATIVE
+	# This flag might not be available in cross-compilers:
+	def_bool $(cc-option, -march=native)
+
 config X86_NATIVE_CPU
 	bool "Build and optimize for local/native CPU"
 	depends on X86_64
-	default n
+	depends on CC_HAS_MARCH_NATIVE
 	help
 	  Optimize for the current CPU used to compile the kernel.
 	  Use this option if you intend to build the kernel for your

