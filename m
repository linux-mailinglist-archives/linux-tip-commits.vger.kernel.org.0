Return-Path: <linux-tip-commits+bounces-6114-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9C5B041C4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 16:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC837189F5C2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 14:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B175259C92;
	Mon, 14 Jul 2025 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dqqQFAk7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dAQW4Niu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52AD2580F0;
	Mon, 14 Jul 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503623; cv=none; b=iiXICdiHDxW7zjxpDptToNANpjaDZgFTdkbHmlaERg3W/o1ACDuSPjttCEFquI15OPAiqCOtNBq67UZOpD6Mk3qSEAsPjKLfagCcaCwivopPueyDG7HqGkfEyIVyCO1dDd60Qj4mhBVCm9WwDr/qXjfZgWhrFRncBA1yZ438rL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503623; c=relaxed/simple;
	bh=yKbXrTMw49+Ifbo0Iua5kgBWWmjOLf1jhJ9bUR1z7sc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LywCSwCwGvbkpw18Lr2NTQDnUCzr2p0DBsT/FCcaU8XyyqOjqvLBRd2URYvxBtEA1eXchgYtFFFYOEbrYP9dTg/8aO9hYAyWvxIb2eLILlah0j3YbNS93CVgJTF8enmBo2bCfzttgJ0xhrpddP08CUWYYedM5ethAfVB4S7IJOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dqqQFAk7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dAQW4Niu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 14:33:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752503620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASak9SST6hSBCxigerFZwNh8yXYxu2sNGnn9/O3M+ek=;
	b=dqqQFAk7r4tMGZadj7r77B7vo9YyE1eamWKidA6sayZVdqy76OnE76mcp0uIeulUqMO/EA
	U4pyrS8P4YhZPL05cTgA7AOVEfwNoQERbzNDUg17KNWoCzKg3xmaiSSy5h3NqZvuFHk3fJ
	hftfiJd9b5JK7jUsAkOlWQ65sgqgpmci/IMkUSdlYU9Az07fSpQb8q4Fe6AaM5ToLmk8iv
	354p/LOpA/BEf51AHo+6Ll//sfecOXRIGeBA+tQjDABeCqlcw9ctebvM6/hWQvemyMXh2Y
	MkbfnVkmrSPMSPbTQ8xOAhZ8EfPt9QsOEaBJx5Paiis4PEVstYw4ewvesP9ISg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752503620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASak9SST6hSBCxigerFZwNh8yXYxu2sNGnn9/O3M+ek=;
	b=dAQW4NiuOQN9FGeNKwJi+8wlP8nps5oKxBefWzCFIco5z/MVEzS2ry4LvDSWoAH8Gm+88w
	sHrBZkUFWAT2+5Bg==
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
Message-ID: <175250361866.406.597212826571904506.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     122b69a53b3f081d450ab4eb40596456d9f2cdd1
Gitweb:        https://git.kernel.org/tip/122b69a53b3f081d450ab4eb40596456d9f=
2cdd1
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:10 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 14 Jul 2025 16:25:51 +02:00

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

