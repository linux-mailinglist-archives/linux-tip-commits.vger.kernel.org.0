Return-Path: <linux-tip-commits+bounces-6116-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ADFB04316
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 17:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B914A7DA1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 15:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE9625CC6C;
	Mon, 14 Jul 2025 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IvXfGQBT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vTUor/Xw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE0923D280;
	Mon, 14 Jul 2025 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505837; cv=none; b=fJQ6P/ULqcNTtnO/mfu0nNENiak238Q5F8/ypMar2Ovwi0yW1tWQ/pilIfO5Th5DSaykSFlI5uENwyKyruASGGtZerioDTqJv3i3QrqxplO9a9hgh2fTdAigk54CtFixhf8pXS0rKEd20RcoPAHmBnT9V56qEyUraeyWVjIpLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505837; c=relaxed/simple;
	bh=1MN4YleHeULwA7ML0NzXj2x1alfCjCBJblnwS8dal0E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KleFxtUGyj/M67ldR+4UURCkGhiJVS4pQYihR468H2/J4VACIHVl8or64Hc9PNddTlaHVHX573wHhR00OgFVqyue6KdQWksTL/zYo90r8k+vwFI1nkwAdOkqBSJ5PWRVyTXZzjeTvIdvcfAY46cORfT06RdDXFRZIxe4ahB92Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IvXfGQBT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vTUor/Xw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 15:10:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752505833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t++zzIsoFH5FeLFQ8XRO90auk85cfa9re9e114oLPrU=;
	b=IvXfGQBT6zv88dtoi4EVhQLiTVcTXtcD7kcYXER7yR3H4w5DxDKPV6QdVwW4h+83zWefG3
	T/szQkRE30YMAqWiguyk+bw4OCdKTOCSwmxxtzrssmQEpnSdr0c4oXLYwzqCW6r1FPxsei
	42zc20mgKRiAsjfPW3f6TKDgHrrf/mKGcx0iXpluG0pNJgz7nO5BxxkadDh8A/fAoToBxS
	C/2UfSQLZe/zhzygPB+HzW9bzj8Urpr5j+xIdGOvHrd+DdUbXlk4s3i0QN2SAR25owbeMz
	hWyDiw3mVW9oG7V7SlFNxHdF9d9+9WT1Fkk89KDuv6qlpwKX/8KFPViOsLgiDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752505833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t++zzIsoFH5FeLFQ8XRO90auk85cfa9re9e114oLPrU=;
	b=vTUor/Xw3c26k8ZLzD6sqKU0/9aWbfezVq8g+LIDeaNT4+DP/K7KL36L+iTQLCer2cfklG
	MHGsS8cKYmEnfsAg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kconfig] x86/tools: insn_sanity.c: Emit standard build
 success messages
Cc: Ingo Molnar <mingo@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 David Woodhouse <dwmw@amazon.co.uk>, "H. Peter Anvin" <hpa@zytor.com>,
 jgross@suse.com, Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <175250583269.406.7015623796932010861.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     9df5e79bf1a30b94dc068ab2ed2279e40f430b88
Gitweb:        https://git.kernel.org/tip/9df5e79bf1a30b94dc068ab2ed2279e40f4=
30b88
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:11 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 14 Jul 2025 17:04:43 +02:00

x86/tools: insn_sanity.c: Emit standard build success messages

The standard 'success' output of insn_decoder_test spams build logs with:

  arch/x86/tools/insn_sanity: Success: decoded and checked 1000000 random ins=
tructions with 0 errors (seed:0x2e263877)

Prefix the message with the standard '  ' (two spaces) used by kbuild
to denote regular build messages, making it easier for tools to
filter out warnings and errors.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
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

