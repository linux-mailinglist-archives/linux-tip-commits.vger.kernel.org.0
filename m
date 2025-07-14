Return-Path: <linux-tip-commits+bounces-6113-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B48AB041C2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 16:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52413AA24B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B46D258CC0;
	Mon, 14 Jul 2025 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lWt8fCL4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hr3DsRzI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91C42571C6;
	Mon, 14 Jul 2025 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503622; cv=none; b=TzXEjHA/w0mPTHaLMcdwtT5Zqz/m9IelnsczDLZUwXAC6XOCiHPX5/k5NjR3M4pLKMS0EMgkJA/CUxl5A3Oy13OjMp1va2ozpBhkkQ3R0nuhpybcRpiMbPT6MKbEFQ1rWZkxrQCuekYPDzyDCUiH0RcxHwa9ZiggRKXWRTpTdcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503622; c=relaxed/simple;
	bh=kTKrUSY/fgs7lSAemOhQAiAnoB6aQLF7Jl/UZbNlo1U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j4pDlqHix24d3a0RNlx6BJCQf4ZRh3rENUzoea/iYS0r/SgMlM0y9xXX8faZqx1QFgXfpvWjL8ZUB1XOwFlNp4fSVl9iCrt9sxActAPPKHUCtdtdiV+5oZ2VPJUVEmFFDcE+tPzXUfPSMavk7c5sXK7av8qGsJkD0KNy1MdayRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lWt8fCL4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hr3DsRzI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 14:33:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752503618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASY/v/UqyNn4y0IYNT4jAUL6JNsDTNMyplfD5C/hs8o=;
	b=lWt8fCL4GWh26MUX7p+yG7X3rr4hG0CV+WRzG3xs7cP71++GZjhLTNWrRmbykT/to2DHHG
	QjGaQRWg45gT8oqygrMD7X+LiGfU3AIK7Dt8nAyIu3cHK7ctKKHDuHeUrWAvnVN02d5guF
	PtsX3xz5J7AzNqQ24phXfTadyr6psyafg49WVWUyRog/EV9VW1SFwsPt55i9n14Ik6kKRV
	zKWTLB8vyR6Gpt6a42eXe5JjTUUgtMqiIjSHGxQkyFGtAyW2F/wjHMt/R/1buuqVaEIdHM
	xMDfTi0NXGShJG82JbGU3m9JbQhfK3vuctyda9RI2/W7xDqv/whEeGITFoDbEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752503618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASY/v/UqyNn4y0IYNT4jAUL6JNsDTNMyplfD5C/hs8o=;
	b=hr3DsRzIDy/bBagva7Lz+JUZrBidUJIKGnLptVsuPZFBrZhDWrxrq6o1UXvoEB5XbZeV+q
	UrAghwSmUk1WMaAA==
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
Message-ID: <175250361749.406.15098136360352844564.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     14056ab8aa1d95a6948d5601c27b628a8a011ebc
Gitweb:        https://git.kernel.org/tip/14056ab8aa1d95a6948d5601c27b628a8a0=
11ebc
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:11 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 14 Jul 2025 16:25:51 +02:00

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

