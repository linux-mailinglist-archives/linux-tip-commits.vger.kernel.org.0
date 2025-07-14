Return-Path: <linux-tip-commits+bounces-6117-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45A1B04317
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 17:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6033A7DF8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 15:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FB125D546;
	Mon, 14 Jul 2025 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4KIr0Rv2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jAhcusAq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1B25A2C0;
	Mon, 14 Jul 2025 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505838; cv=none; b=UeSowNSjtm8BDxAnuFZA4RuFvDtyeolkEsEbbMWpSfo8D021YsIand+k+8Z7DgIRaL9GY+jyAUDMol3SOaMQmnFmk8yvHOlOEF/PMXDVBdkANyChHTN/bmgrVU1HSUI3/NFtb9/wordjjkvs2jL9q9Uj/H20rfGIWLL3i9lq9ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505838; c=relaxed/simple;
	bh=q/wOm0atZt8CRsFrwgmRPggLkoEdLETa0UojHPFlzP0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kd/VHw4sHU4QmdrA3iL7ilQ5n+N5G0gSFy7yDouwLCvs4lt2j9ahobbLeobyYjFsNhgMTVe0XW3jXcYP53q8Cv35vZ6xnI/qQZ557tGgu6rG/7tEiYryi8ffar0oQSxc/EZIx/IJ+49TkBerx+eBq6CdK/OECeiO8YtVO2jNe8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4KIr0Rv2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jAhcusAq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 15:10:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752505834;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACyBryN2uLfTpsm6Khmya+wm8acf7FcnBKUnXI6IVOE=;
	b=4KIr0Rv2T9LYhYIl+vmEhICUuPTSA+UDz+h6Bjm66XlnJyBRwQ4OvK/PA07+GP4MvqZdZJ
	08BL8YTesiPzDRVje3s7iwDbFWIXkFMoHOWEb8wn4HX+7EPZak742+KeK/Rksk92KdtxCL
	6pM9ZxTLnT6V+k+vVSdUqSiFWaoXjW9m7HdYP6Y6T8dkr5sSSCwBJzj7k0n9BjEblvJ/9x
	SVKE8A9D84YTrcpiwPm0tlD72mCD4bIG0EDpTEAg6WRdbvVF7pXOMC+3ebA2X3+8dNei7p
	MyXcIHA9EO3ZVaWM76HwkgqdTH0RzlD2BY48G/Zpr+/zIaYVY4tOWvfk4YmUYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752505834;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACyBryN2uLfTpsm6Khmya+wm8acf7FcnBKUnXI6IVOE=;
	b=jAhcusAqBGw//5V2WQVoaVaWoXPedUnRRjU+bMY1ZrtRPzKqb/DRd4/8IcYAn0Pv+8bp08
	lF981R6HcVkBwgAQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kconfig] x86/tools: insn_decoder_test.c: Emit standard
 build success messages
Cc: Ingo Molnar <mingo@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 David Woodhouse <dwmw@amazon.co.uk>, "H. Peter Anvin" <hpa@zytor.com>,
 jgross@suse.com, Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <175250583372.406.10435498314163046323.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     b238e382bb140ead4fddc8e0de9c30e6c3381799
Gitweb:        https://git.kernel.org/tip/b238e382bb140ead4fddc8e0de9c30e6c33=
81799
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:10 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 14 Jul 2025 17:04:38 +02:00

x86/tools: insn_decoder_test.c: Emit standard build success messages

The standard 'success' output of insn_decoder_test spams build logs with:

  arch/x86/tools/insn_decoder_test: success: Decoded and checked 8258521 inst=
ructions

Prefix the message with the standard '  ' (two spaces) used by kbuild to deno=
te
regular build messages, making it easier for tools to filter out
warnings and errors.

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

