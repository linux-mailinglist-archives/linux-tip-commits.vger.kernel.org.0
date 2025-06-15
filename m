Return-Path: <linux-tip-commits+bounces-5851-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FCAADA1A8
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Jun 2025 13:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B0C188FDAF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Jun 2025 11:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C671FF1AD;
	Sun, 15 Jun 2025 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="18bUvjrR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uZyVA3Fo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714372608;
	Sun, 15 Jun 2025 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749987268; cv=none; b=GxO6cHyloeXLq2w9r+388ZeitcASeJkoe2JZxv8I6QQJSy36FmmBl9DiCNy1zRPNiy0gOmkdCpa04K0yfOcR6Fp8PHQGrS+ggA7SG+KJ9ESUsQDaJhKbtmfEf+7tEydPMuUPoMLTQB13Vz3q/zFj6ddd50JqX23uYuaJ32WmAeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749987268; c=relaxed/simple;
	bh=MacYbavYNz1W2ltzSnxcACSBdNDdF6JtM+xzGCJsEeA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ihgAdGwbp6H2RvalG0c5YcH0p70kf7b8GDmMV62hIYyWpO9xkr4clZZygbwg3yebTa+EuHXtJ2GcIJ38JB4AHMPzZU++tl2JpNC2c6bvSMSxN0cFOQcoVXTVdRoIWhax9HZjrS99qMbBSmbUZApPpnEQR9M1VbUi/7VdilxHvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=18bUvjrR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uZyVA3Fo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 15 Jun 2025 11:34:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749987264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qw5pDrYqD0EvEzP2/lkwtqDjFaiYp8P6jbtK5TPeAiQ=;
	b=18bUvjrRmMGuKRTqgXA76WBSy9VTohJKLS0gpm6Mp/tvYjUKPuoOYsBNgybMd+K5d566qF
	bKEqkBcQQA6EI6760/wGhx9TTNuwaEHOS6K9sfsJgYtyrPCj3njcc5HNardBxp9un6xj4i
	HVp7AL+QaHoFpZTAsFxAW8/CXWLUkcNTyRAcQRyY9sBo5crItg1s7CstgUCv6NemS3f99C
	paru3MXsWyMKrKge08BpVQpqmYKPUwh9cDd1B5vsKbYzlzcKkIAVQNT3HxSloVeLrrqySw
	t/LJGgne9a+mmy0XunN9fiWF3d7Kag0vqpQ+qR+0MIniiHL9FAnPjtetjeBiKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749987264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qw5pDrYqD0EvEzP2/lkwtqDjFaiYp8P6jbtK5TPeAiQ=;
	b=uZyVA3FoEQz+7ibilzRjIdB2UcY3Z9Opoz2oyTW6/cDDkyJVNaFpODCYVJDTW/o699L540
	RghayDHH27r9B0Aw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kconfig] x86/tools: insn_sanity.c: Emit standard build
 success messages
Cc: Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 "H. Peter Anvin" <hpa@zytor.com>, jgross@suse.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Peter Zijlstra <peterz@infradead.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515132719.31868-6-mingo@kernel.org>
References: <20250515132719.31868-6-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174998726275.406.9585779903946499168.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     1dbc32c1928d5a775df8e2953a2debae3054e11e
Gitweb:        https://git.kernel.org/tip/1dbc32c1928d5a775df8e2953a2debae305=
4e11e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:11 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 15 Jun 2025 13:24:39 +02:00

x86/tools: insn_sanity.c: Emit standard build success messages

The standard 'success' output of insn_decoder_test spams build logs with:

  arch/x86/tools/insn_sanity: Success: decoded and checked 1000000 random ins=
tructions with 0 errors (seed:0x2e263877)

Prefix the message with the standard '  ' (two spaces) used by kbuild
to denote regular build messages, making it easier for tools to
filter out warnings and errors.

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
Link: https://lore.kernel.org/r/20250515132719.31868-6-mingo@kernel.org
---
 arch/x86/tools/insn_sanity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/tools/insn_sanity.c b/arch/x86/tools/insn_sanity.c
index 213f35f..e743f0e 100644
--- a/arch/x86/tools/insn_sanity.c
+++ b/arch/x86/tools/insn_sanity.c
@@ -253,9 +253,9 @@ int main(int argc, char **argv)
 	}
=20
 	fprintf((errors) ? stderr : stdout,
-		"%s: %s: decoded and checked %d %s instructions with %d errors (seed:0x%x)=
\n",
+		"  %s: %s: Decoded and checked %d %s instructions with %d errors (seed:0x%=
x)\n",
 		prog,
-		(errors) ? "Failure" : "Success",
+		(errors) ? "failure" : "success",
 		insns,
 		(input_file) ? "given" : "random",
 		errors,

