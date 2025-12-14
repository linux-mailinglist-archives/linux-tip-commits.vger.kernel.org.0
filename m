Return-Path: <linux-tip-commits+bounces-7688-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2612CBB8A7
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D12093028582
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6D32ED860;
	Sun, 14 Dec 2025 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="38fNCXB+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sUcXl+J+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0324A2E8B74;
	Sun, 14 Dec 2025 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701470; cv=none; b=aDh4VB0W7a36WvLwVq8Iy77rA44rCpkmVHbGu/UPjkCaNfycclf+UFzOVvHwXEayBihPhYhkv9nsSP6S44NtiRKUVl9H6TKu1xxDbz5lrdnzXqw29OnLgKSUbp8ViXBXXSWhJ2s34xQQMdYi7XFHU2VnVNRFqnsdzR+AuQAVicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701470; c=relaxed/simple;
	bh=scJbOyo+PkkRvdy61gO795kVhMqYAcPkQCrxprVxGR0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WzMbipUTjeMNZ3orNbY3gLJ+T3pm8GTWaeytIrtCv4EMzKmTnmdTg+D2mT2ZhCcQWd/9tw4l+PR+momUAGEEZwZbhmR33DHMWau+dptgaruwgxCMj45K1ZPzWZcnex4tflthlfWOAiOH7EYBHfkTmgy76O4HMtKZM61B8F1iuSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=38fNCXB+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sUcXl+J+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zf4TSE+0gXYoZz/DmzaYiZxTagyuc8THKYAf3S+XiA=;
	b=38fNCXB+SFW1D5PQGFNCrRueo6AZeoSJmU52hBpmDvQZatRYGx1980UpsMKyV+3xSSre2p
	2Tu6HpVlGnE6VpXiX20OshgpvtNV0x4BT2JcpwBJqYONAAh7vlR0hCnE0azPgohe3In1kN
	617nHpZdam6Az0s9SymRobDdK+RayisP/D+hGNhW2pRXcI9cdFPrYRh9gBs1w8PCf+5EGU
	xnhzMcL0boG7OT1JaDzGGS5GbSPUzIBso1WJ7Or1Ja/S9TkBl2T2ZXrOfUK8dKc5SIOiXr
	1rxZRqOo88dwTDhwFdyhOx5Zbl4Bnzw9x4mlYQ+QUCEnOm+FnOk1QHie8aJJOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zf4TSE+0gXYoZz/DmzaYiZxTagyuc8THKYAf3S+XiA=;
	b=sUcXl+J+6y4rJmJDE2NGFF81dLiqFbLqc/QyAwOts+G/JtR1EDg9KvC2lCnozIRnCuwirE
	6m7k+l9djme+28Bg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Mark e820__print_table() static
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Shevchenko <andy@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-5-mingo@kernel.org>
References: <20250515120549.2820541-5-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570146532.498.2430261545026771213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     3e57abd4556b0fe727a755f6b9d573d324105ab0
Gitweb:        https://git.kernel.org/tip/3e57abd4556b0fe727a755f6b9d573d3241=
05ab0
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:37 +01:00

x86/boot/e820: Mark e820__print_table() static

There are no external users of this function left.

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
Link: https://patch.msgid.link/20250515120549.2820541-5-mingo@kernel.org
---
 arch/x86/include/asm/e820/api.h | 1 -
 arch/x86/kernel/e820.c          | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index c83645d..54427b7 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -19,7 +19,6 @@ extern u64  e820__range_update(u64 start, u64 size, enum e8=
20_type old_type, enu
 extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type,=
 bool check_type);
 extern u64  e820__range_update_table(struct e820_table *t, u64 start, u64 si=
ze, enum e820_type old_type, enum e820_type new_type);
=20
-extern void e820__print_table(char *who);
 extern int  e820__update_table(struct e820_table *table);
 extern void e820__update_table_print(void);
=20
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index cf2eb39..09c712a 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -200,7 +200,7 @@ static void __init e820_print_type(enum e820_type type)
 	}
 }
=20
-void __init e820__print_table(char *who)
+static void __init e820__print_table(const char *who)
 {
 	int i;
=20

