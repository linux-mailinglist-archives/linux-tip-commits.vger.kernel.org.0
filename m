Return-Path: <linux-tip-commits+bounces-7691-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D409BCBB87D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBF713007B42
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFB72F2612;
	Sun, 14 Dec 2025 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jv1IkLjZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y4ky7G0s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C272EF64C;
	Sun, 14 Dec 2025 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701473; cv=none; b=pSO900xMS2zlaDcbLuqpJmKDmsO4JStoCFx90X4VC6hEUWLf6yUTcqBYcPVIHkRJ5hDYnAyWgHFxa6uJsLL0IPsEXpLhzk8b2gQ0XOVdW+RMuIcemvmxoaIqLuXkExAiI1gNlKCK0B+wvNm79sIJNqTcIWKr9C/WulNjf+DB0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701473; c=relaxed/simple;
	bh=xsSktNOaVMlaJUdzw0661gfsWe1bO9bxAxBZnX5fkks=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GYwHxMsgdLDU2SpAoXsXThNQuUWQkDQo6RXBjm4kKhtMRbclXLyjtL9RDlOU83svWczm37n9MTpTGuBI51fEgq5qBCFgbAjBKea1n4duzPdWpWc74p/NMX6mNxCA67YhnmCWDDqMKbgTKfvAyoEzFmm51IanimzAh4k/K5iUR0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jv1IkLjZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y4ky7G0s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701468;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saa3282xVxUjbI2wLDdvF09QiYQzKMH6m/pGgbdhGYc=;
	b=Jv1IkLjZxaKnhg9XnAvd2q8FGfWrWu7JeIDTHFmP/tNxtraApvGHAb2ZRbzyn/JjY/G9si
	6Fjz1fY1K4D4PX9qK8vOWtEAf92rx9U3atl1FZY+IEMU7yS0s85yHgehLlsMlvAX8mytC0
	LN+M4Go14rmEjdzG1W9F8/Nceyz7ghlszw9f8k7718ExnDOazUrQI568GrXXQlOofg5nVb
	Sm/LLyKPl0e4wsc0P3B9S/efJY3K3xe2348VQXGwYQkPv3ywJJ0y5cwX5B72SNd+PGdVc5
	opsOXzCS4ybQ3+5XMb2hRoXjkDIbv/0sHSlqDDrKc/WozytjwOq9RyeH6Cwq8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701468;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saa3282xVxUjbI2wLDdvF09QiYQzKMH6m/pGgbdhGYc=;
	b=Y4ky7G0sgIzqo3PMI5jFDPyK/te8XfvE6Xqu8U8rBcPN2Xg4kh9BIuqW8QHTxXs2onDVkS
	7Rr7jWFhqsladeAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Simplify e820__print_table() a bit
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Shevchenko <andy@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-3-mingo@kernel.org>
References: <20250515120549.2820541-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570146755.498.12934680374636966961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     0bb4a8bdbd22fda17660fdd4c086adaf4970239b
Gitweb:        https://git.kernel.org/tip/0bb4a8bdbd22fda17660fdd4c086adaf497=
0239b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:18 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:36 +01:00

x86/boot/e820: Simplify e820__print_table() a bit

Introduce 'entry' for the current table entry and shorten
repetitious use of e820_table->entries[i].

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://patch.msgid.link/20250515120549.2820541-3-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 4c3159d..cf2eb39 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -205,12 +205,14 @@ void __init e820__print_table(char *who)
 	int i;
=20
 	for (i =3D 0; i < e820_table->nr_entries; i++) {
+		struct e820_entry *entry =3D e820_table->entries + i;
+
 		pr_info("%s: [mem %#018Lx-%#018Lx] ",
 			who,
-			e820_table->entries[i].addr,
-			e820_table->entries[i].addr + e820_table->entries[i].size - 1);
+			entry->addr,
+			entry->addr + entry->size-1);
=20
-		e820_print_type(e820_table->entries[i].type);
+		e820_print_type(entry->type);
 		pr_cont("\n");
 	}
 }

