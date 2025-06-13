Return-Path: <linux-tip-commits+bounces-5832-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053EBAD857D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 10:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A79E7B098C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D02291C0E;
	Fri, 13 Jun 2025 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nGup/eX3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Zc7j1EO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E636279DBF;
	Fri, 13 Jun 2025 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803116; cv=none; b=jj+CSQ8cm0FcVEPVtD8VNtxOOeoQu/3J6LStcSUTiCQ5e9IqXehRc5RAic/nW0x8ai67rRMuG7ufmSZZu/nmGxDID9vTapSoVPa2jwety2tzVQE3Xsytv7kDq8OlowrsCKZoqizwgt3sRlk7dBpQ9ZTkfYP9w1xPD83e+8+vXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803116; c=relaxed/simple;
	bh=UJntPncW3cbQnkL6d6c821uxBS+qGrsYVSwUg6Bd3u0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rR/04bQ/ZcwtyNeqy2NyjwDQOyRPQxIF6OEY5yFPTbfH+oPoXsflMkW9jqx4lOUV8XU5qJDidlZnUct+QQPIO7I1WZ5gdcynM/8pgMS1RWExwN2EtK8DMZzlSw1V72q55V4KoW2Ng16t4TFn+lrFW6Z9Z3Sb/olILssOYt9xOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nGup/eX3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Zc7j1EO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 08:25:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749803112;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGyT4Y7Je2SGiWYF1+fYYyyzEyBY12d4qrlqtrSuh7U=;
	b=nGup/eX3og0kqGfbfwLB0ILWO/WZ9aYGpyeRzDfsOSOC/2f8M4OdacLhUTjOH5i7tOOVrr
	lb4mECPDws43HaO17eTmRmhjXkwDJc4x4jxHeUbR42GcDAfxEKAvBqFKcC65spQI2JodHd
	a9nOGwHcLeERm5BVd5P9cjtg/nzXMWUwsj6l0uwPYAcIUhUeLK/3G8v6gskFhym9nlwWXc
	tKjNnmPuKWQ7HKYPFm8CX0vONzoldQkiElb4V4I8BQlw/P50cPBwlpHUYFal/aPMTlPQk4
	wYUjD5FNwm/bQDJqwdSCCiBIJAJue2Hz7/knu8NCWVqsOQe1Je5INOAIiPcocA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749803112;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGyT4Y7Je2SGiWYF1+fYYyyzEyBY12d4qrlqtrSuh7U=;
	b=3Zc7j1EOAYaGBNiz2g7suk7jYgr0I8Ae/qVBzTri7pWNgflhbRJOLoaf2XhvUTBffKNP3n
	rg+NxGTEt560rZBw==
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
Message-ID: <174980311177.406.4987077839608362955.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     5fda7f875a706421f7b47e995517bbc1265a1892
Gitweb:        https://git.kernel.org/tip/5fda7f875a706421f7b47e995517bbc1265=
a1892
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:11 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 10:01:06 +02:00

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

