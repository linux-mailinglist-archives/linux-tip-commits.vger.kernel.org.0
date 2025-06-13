Return-Path: <linux-tip-commits+bounces-5835-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9440BAD8584
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 10:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A31716D64E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 08:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3633A2C15A4;
	Fri, 13 Jun 2025 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JRuAWkhr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="En4wNO8v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8D2C1592;
	Fri, 13 Jun 2025 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803120; cv=none; b=gUcdbCbColWju8IQU0Ikb4jWN/O6qIS+v/HBKCPy6OZF3BYdGjySGfd5uvU4wCGzv35yRfYJ0KNL6Cru1jMf2GHW5oAzK1mL4WtTpYFhcTwVXoaNPXRW9XtPY5H32yyEpNKGL77Mpi+sqCefZ1JZ/tszHNa+YIWJdX/pr9WLQcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803120; c=relaxed/simple;
	bh=GdLnBia2HPccz6TzEdJXOJoDhycjN6qOsxlFUExveFM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oLrt68OPtbhO/gxSrcQNBwyb2RZVLDv5T7h1n/AoJrBqgcLLzeXXipraOMPKuv8f/uoQFdOBB6FvCIsobIG0w7GeFIg6mLLuSrVvv9JkTplEr9CGVJyv+A4+RHJY09M9ycrXAJ5qEfY7/i2r+penIifSL8QdgwNvRMCtOddif8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JRuAWkhr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=En4wNO8v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 08:25:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749803114;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXC0iFchWvp/C1LBfiZz+dwkOuM/QkuWvKfiawBhpoY=;
	b=JRuAWkhrvWGpYGRmgCmGED4ENFFmXZXIJtWhUk5098tPZoYnBFssjMZtt+SmckuFo2B6Dr
	vJVskRAt9uAF3meqbSgSxZWpfZ3dsxWMOug86e94J2H/JLzWb2rvsVwTK1VzDaqtRSzjFm
	Gw9N7sJgUrG6A3PZQ9kRPuYTobNxnPncmmGJvybhBzh/TPkqtLKRnMUMQGRQGpBYec+FKa
	bkgnz+HKS4f8Xe7yJ2uEH9w4bTEGu5HBS74weoxuDJWEKyfO804I7LIjxa/bH9cK1Td1+9
	EbQJZgj2rYEOdaFbuvi7tDu+Z8qrReZGx7DXvc3Z7g91MGJJZJatJw2MpUcUzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749803114;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXC0iFchWvp/C1LBfiZz+dwkOuM/QkuWvKfiawBhpoY=;
	b=En4wNO8vtpCFSHIHWC/WcoAgoZO2f6ftx9Y6FfjBz3lZrlW4emMkgItspDIfjcIM8ioAqu
	GScyvkWznEM7FwDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kconfig] x86/kbuild: Remove ancient 'arch/i386/' and
 'arch/x86_64/' directory removal 'archclean' target
Cc: Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 "H. Peter Anvin" <hpa@zytor.com>, jgross@suse.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Peter Zijlstra <peterz@infradead.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515132719.31868-4-mingo@kernel.org>
References: <20250515132719.31868-4-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980311383.406.667996435218519105.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     0b68a9116b2c0c513edb9a746b67ec3eb08f9207
Gitweb:        https://git.kernel.org/tip/0b68a9116b2c0c513edb9a746b67ec3eb08=
f9207
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:09 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 10:00:50 +02:00

x86/kbuild: Remove ancient 'arch/i386/' and 'arch/x86_64/' directory removal =
'archclean' target

We have to go back 17 years into Git history, to kernels that won't
even build or boot with modern build environments, to come across
the obsolete arch/i386/ and arch/x86_64/ directories.

Remove some of their last functional residuals in the 'archclean' target.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: J=C3=BCrgen Gro=C3=9F <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20250515132719.31868-4-mingo@kernel.org
---
 arch/x86/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1913d34..156a5d2 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -354,10 +354,6 @@ $(orc_hash_h): $(srctree)/arch/x86/include/asm/orc_types=
.h $(orc_hash_sh) FORCE
 archprepare: $(orc_hash_h)
 endif
=20
-archclean:
-	$(Q)rm -rf $(objtree)/arch/i386
-	$(Q)rm -rf $(objtree)/arch/x86_64
-
 define archhelp
   echo  '* bzImage		- Compressed kernel image (arch/x86/boot/bzImage)'
   echo  '  install		- Install kernel using (your) ~/bin/$(INSTALLKERNEL) or'

