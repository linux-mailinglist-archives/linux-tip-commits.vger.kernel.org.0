Return-Path: <linux-tip-commits+bounces-5852-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E54ADA1A9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Jun 2025 13:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC9316FCB0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Jun 2025 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DE020C476;
	Sun, 15 Jun 2025 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q4zwbC5d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ajPU1EqA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAAC1E231E;
	Sun, 15 Jun 2025 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749987268; cv=none; b=Tev3Wd2ZjO0+y+t4ikx2Utx4SaAy6GplRjEfdOEgPyk0XGzyvABB6iS7zWrYFUP+O3n9Xxitis5H6RB/2iGucu/WAPRKAhuZl7uhflPrSh9VbmKMg1ZXZQU2lrUBMww53OkSsZ/LyL+6baFxU+WTfSczKPoaZuFAps/Cu1AAQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749987268; c=relaxed/simple;
	bh=IPxOXHq7/st0tXQEMsjTpWFdHIsTVy3qzXhjJyT/CMI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lsYdrdUaXBYfpBLEDCLLtvT8tlXt4gcN6odb5XwLNmHF7DFucINR0lkbdOVTyPKxm6gBM/JlSgS2JYXsceqBSUMf3aaMgRCTKy9an25FmBlRlTg8D8M6emDSdJM914GnGjP73ajLdJN7uc+NXLOtRkhIBfEVglrACbNpxQnujfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q4zwbC5d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ajPU1EqA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 15 Jun 2025 11:34:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749987264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ij36ox6iq5IgTPRX8CZmxr/sEB7mVcz0JwjyvoXFpxM=;
	b=q4zwbC5dArAmi8MGMN/oIyXKvKCQvx7aCfSEu/z8tC/jF6EfuJGNU1WgtUabpqiTkKHqtt
	j2EOyPZvUgrqzfhp5cnsjIpdPmU7X/lhcp99eWsx9qb2lHsv8nJg3mq2N0kzNSy5ZgSTKV
	92AvzTiUCz3hBU4KbBIrw/0gR2ddGu7lqJ2Exm8Wcgn+uk2yqAw+sMywA9FcRMt9WNQnoy
	Mj9BNQMNYUACno9HHc1d9QW5/PTMFtRZJJTjVcDxKVKIfk6PZ99Wh7r1TQit0XVTfJlwYO
	m5gfMZT2AnynkszZL+vjKeKXtrmQ/QkkmAtr9OHsCPkjnnJZHUBJ7SJkFZB+8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749987264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ij36ox6iq5IgTPRX8CZmxr/sEB7mVcz0JwjyvoXFpxM=;
	b=ajPU1EqALBrUVBvoA0/acMLMdx6pJiQS21QSlfOlrNRz2Vhnji6cIpMW8z5hQsrvVD8f3N
	QRa9kh7ihvq26XCQ==
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
Message-ID: <174998726376.406.8625158673061666506.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     ad2062c81e6362937eddb388c2c09de753d135d0
Gitweb:        https://git.kernel.org/tip/ad2062c81e6362937eddb388c2c09de753d=
135d0
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:10 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 15 Jun 2025 13:24:39 +02:00

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

