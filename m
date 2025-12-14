Return-Path: <linux-tip-commits+bounces-7687-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 542C6CBB889
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F1B630102B7
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDC32EAB6E;
	Sun, 14 Dec 2025 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mtOwqn5M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lJAl/IYv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF0A29D27A;
	Sun, 14 Dec 2025 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701468; cv=none; b=QPaPK/5sdcXoYNDI5bgztzaGYJMNLLH+l+hrvnSnMYHryWV5EIGxj69MKrQcjAchhRBeYgvTBEuwbspx04MQhHUv3NSi6mZL9fXFBKov8eKG7wSX9s7p90zkQnqm5GZi0OOvFbnrkXBizmWlOyaofvF/6JIGjEBzdTazMkfF8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701468; c=relaxed/simple;
	bh=ZV3k7kz2SuWc9UfGcLCE//LNHDqEYI2BjHiiFWs3jHo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DtDrEhloTmo9I2Y4LMnOl99gjQ/T9E4F0uCcucycJxtx0RQX+w8mv+SRCfW7vj8zGfLV0/WZAB6j4FaSMMwtMNa56Fx3Jizm5IMvXqkVUzqgMMQxbZF/nr97bbtRbfq3k/QbSc0Fcw+rmoglsfj1u5rDEJYyDGD9bediGx1jDlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mtOwqn5M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lJAl/IYv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701464;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwQ0Kx3uDBjY4o4VkQWlFJAat6Yv5CuEaNNq+LPt3pY=;
	b=mtOwqn5MwZGEx7gMC0OPwKFoQ9XvBLjsr6f1lgPMSZNBcyLain0mY1fp/Z0UE/SkYvlC9V
	3LnrFKNmziv0fYEGZjKemIfexfbCM8QHcwWMRdczWUvQ2KakaRSDTZuNfV6s9MgyalldZL
	maNGcUE+Kd6Fb+qT+B1aSwVAG0WFQpcM51ze7xU7xDFNokg+5LrpsK3iI6cDqd1tgLbdQ8
	ZmHUWg3zSW1vH7w+VVsOMeBIeROS1bLejWN7s0ZIvPkXnzfa71ss0Ciw1pAhrDzFN4k9RK
	VUd3he3KNczRwTuerbRvcyte76AC5hCnUZ2C1rfCR8CGd5lq7ep0yBd+HZV/Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701464;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwQ0Kx3uDBjY4o4VkQWlFJAat6Yv5CuEaNNq+LPt3pY=;
	b=lJAl/IYvraT3V0KhRieSMd/6Z6vXamFn7rbo9SSxOj/xYo17FKRcH+g4Is05PX5cBUEgjB
	faR3SJ7Cy3aWE8DA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Make the field separator space
 character part of e820_print_type()
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Shevchenko <andy@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-7-mingo@kernel.org>
References: <20250515120549.2820541-7-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570146306.498.1750999166966277476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     c87f94477740f35aafc208c85da784087c94a46e
Gitweb:        https://git.kernel.org/tip/c87f94477740f35aafc208c85da784087c9=
4a46e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:37 +01:00

x86/boot/e820: Make the field separator space character part of e820_print_ty=
pe()

We are going to add more columns to the E820 table printout,
so make e820_print_type()'s field separator (space character)
part of the function itself.

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
Link: https://patch.msgid.link/20250515120549.2820541-7-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 460645d..5800153 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -188,15 +188,15 @@ void __init e820__range_add(u64 start, u64 size, enum e=
820_type type)
 static void __init e820_print_type(enum e820_type type)
 {
 	switch (type) {
-	case E820_TYPE_RAM:		pr_cont("usable");			break;
-	case E820_TYPE_RESERVED:	pr_cont("reserved");			break;
-	case E820_TYPE_SOFT_RESERVED:	pr_cont("soft reserved");		break;
-	case E820_TYPE_ACPI:		pr_cont("ACPI data");			break;
-	case E820_TYPE_NVS:		pr_cont("ACPI NVS");			break;
-	case E820_TYPE_UNUSABLE:	pr_cont("unusable");			break;
+	case E820_TYPE_RAM:		pr_cont(" usable");			break;
+	case E820_TYPE_RESERVED:	pr_cont(" reserved");			break;
+	case E820_TYPE_SOFT_RESERVED:	pr_cont(" soft reserved");		break;
+	case E820_TYPE_ACPI:		pr_cont(" ACPI data");			break;
+	case E820_TYPE_NVS:		pr_cont(" ACPI NVS");			break;
+	case E820_TYPE_UNUSABLE:	pr_cont(" unusable");			break;
 	case E820_TYPE_PMEM:		/* Fall through: */
-	case E820_TYPE_PRAM:		pr_cont("persistent (type %u)", type);	break;
-	default:			pr_cont("type %u", type);		break;
+	case E820_TYPE_PRAM:		pr_cont(" persistent (type %u)", type);	break;
+	default:			pr_cont(" type %u", type);		break;
 	}
 }
=20
@@ -492,9 +492,9 @@ __e820__range_update(struct e820_table *table, u64 start,=
 u64 size, enum e820_ty
 		size =3D ULLONG_MAX - start;
=20
 	end =3D start + size;
-	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
+	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx]", start, end - 1);
 	e820_print_type(old_type);
-	pr_cont(" =3D=3D> ");
+	pr_cont(" =3D=3D>");
 	e820_print_type(new_type);
 	pr_cont("\n");
=20
@@ -569,7 +569,7 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e=
820_type old_type, bool
 		size =3D ULLONG_MAX - start;
=20
 	end =3D start + size;
-	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx] ", start, end - 1);
+	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx]", start, end - 1);
 	if (check_type)
 		e820_print_type(old_type);
 	pr_cont("\n");

