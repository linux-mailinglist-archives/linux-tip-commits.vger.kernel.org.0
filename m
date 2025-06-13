Return-Path: <linux-tip-commits+bounces-5833-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEFDAD8580
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 10:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3271896E0D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 08:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADFB291C24;
	Fri, 13 Jun 2025 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HjVKrwwR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="02KE7WWe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F8279DD6;
	Fri, 13 Jun 2025 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803116; cv=none; b=Yz5aSg0GhsVGpjmr6WPJVM3d+mxhvvfu6chzPf4a7+iK/69weczuwaynxVbytYFJ+/XqR8mFb8PUeYCypiiADGAsynuxTlikgGcuTZIy+wrkeJ1Psa+pn6x4fjkB6m6VSecLrz/ANsABnIlfhZiTyksLnaAybW4nB4S/YujeeZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803116; c=relaxed/simple;
	bh=tk0l7ip/pjuzNz/UL+oNASF1gVNRXnvrxUMjDLcWia4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b6ymyT896fmLNblNfrYoeguAeibwd8GCEJQkwLi12/IMSd0k/3H0s094Zs1CWTcP0XNkWxjttLRy5n9f7MHQ44d14FqwhOEQIM3TUeU8MeHMBUXYr05dftXbxKRLREwa8J6akclxtZ0hZXB7t8XTaiJQdp4GsByXc4XlCyKRKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HjVKrwwR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=02KE7WWe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 08:25:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749803113;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OipuxVR876uTN5Bmoi66QcMLdMgW9Iymq3u5OJ+vX8A=;
	b=HjVKrwwRgSfqWHcrpyI+s6VH8F1kPFlh491QZHu70tMBcquPN1/B+5lf1ePCKMNFqqFzrV
	r6265e+3hRw/VYFuuPfmQyVW4gSwnZr0OkwqPXnhJHelsVJ+S1ejmOAiiXqA0Gxa/50xpZ
	7K5cSFVOMA59IVWkMaFgbiI+pu5rCtkIZXoZmC8BvgY/28kG2qqBcIP5esbtlyAMAWjMcS
	dmFsIJzZ9zyLFj9JdHLhXGpIi2Jy3/KPCZdGKaz61gCdLWKv4RRuj6C4foSEaokzDtCEoh
	hvqmHYspVw5tPvCYcvRKv8IJ28W/f+UrJqztPIB39t3lxolyJaE9NYdLWMFGug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749803113;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OipuxVR876uTN5Bmoi66QcMLdMgW9Iymq3u5OJ+vX8A=;
	b=02KE7WWeOveXmAnD9S1ci9560+pPc9h7wYrFQMWETORaJSSNRga4HzAAaWgqeqq5jK+lhX
	LKDIWT46KKiDk9Bw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kconfig] x86/tools: insn_decoder_test.c: Emit standard
 build success messages
Cc: Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 "H. Peter Anvin" <hpa@zytor.com>, jgross@suse.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Peter Zijlstra <peterz@infradead.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515132719.31868-5-mingo@kernel.org>
References: <20250515132719.31868-5-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980311278.406.14176587531310722886.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     8d188ec9bef86be180e1eca6b7d23467d0d6a9cb
Gitweb:        https://git.kernel.org/tip/8d188ec9bef86be180e1eca6b7d23467d0d=
6a9cb
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:10 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 10:00:58 +02:00

x86/tools: insn_decoder_test.c: Emit standard build success messages

The standard 'success' output of insn_decoder_test spams build logs with:

  arch/x86/tools/insn_decoder_test: success: Decoded and checked 8258521 inst=
ructions

Prefix the message with the standard '  ' (two spaces) used by kbuild to deno=
te
regular build messages, making it easier for tools to filter out
warnings and errors.

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
Link: https://lore.kernel.org/r/20250515132719.31868-5-mingo@kernel.org
---
 arch/x86/tools/insn_decoder_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder=
_test.c
index 08cd913..8bf15c4 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -167,7 +167,7 @@ int main(int argc, char **argv)
 		pr_warn("Decoded and checked %d instructions with %d "
 			"failures\n", insns, warnings);
 	else
-		fprintf(stdout, "%s: success: Decoded and checked %d"
+		fprintf(stdout, "  %s: success: Decoded and checked %d"
 			" instructions\n", prog, insns);
 	return 0;
 }

