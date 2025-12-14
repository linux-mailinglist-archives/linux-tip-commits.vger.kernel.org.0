Return-Path: <linux-tip-commits+bounces-7683-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFDECBB86E
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BE8B301EC4E
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487FF2DE1E0;
	Sun, 14 Dec 2025 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S0LL2Oid";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QBf5TWaY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9BB2C15A2;
	Sun, 14 Dec 2025 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701465; cv=none; b=mpmUGNEhac8490krws6U+ATWmJr/3P59ACi001x3RzBiA2dHXQxMFHIi8CS1tfsczUX6lstGqwCiETH4s1UlNELazAQcmsxd6z/VAt1hhRiJ3y8U9WOXS+ELtcCn2BmyK2Vjjhbd1ofSYXuHgKl2nAcJ3e/R8cg47XnCWz7hSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701465; c=relaxed/simple;
	bh=kPhndc5q3Y5cupq59Ig8XUfnQbwUSBXCIhuBLxgutT4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M7eDfyFA8XrWANTQv1EfmPJXvFOQSYbOOsoePiMn6ALPwsqpmEpjb06eV5PMvW39hwGY+6gmuHjVHM6MbpRXs/2FYMeU2+1D1aDqm8zsD2J32zsM2m0fs8L6YAhaST6jsX+onPIIdUkE0j1BfP5DjX56zG9BkoHStgeSKDmZnbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S0LL2Oid; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QBf5TWaY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701457;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RwbbSHTKdw/uZS3D8E1WqTL6aZDiIS6sENoOnZVxgEQ=;
	b=S0LL2OidRv11F6S70KvcoFZA1b+pHegbkVEFdR6Il+4MxJe7VUetzxrUeDJKXMh1E65iJz
	/AZSXm4+tPNB7/5A5vIXouJ2Ak01EF0K3a3Uth+537cS63WYSYJpAe9JPQdEp+0sOTxjEn
	L80XJkUVQfXfoYphp0g+hKKVx2P2xOGy/ewCXNpM8YkxkpuP+R99SoqGWP3cfGE63bJO3e
	GW0YMrV9R4plw/LIWADViprlvhZsNSMzqlr5mY3GbiIpuehIVZ985EoQhZX8SFKorull/Z
	VUlv3AB3QOwVHenj5ebtzt4sDp8X62OZO8kksJGUU5MGDkTGEVquD67H0kplKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701457;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RwbbSHTKdw/uZS3D8E1WqTL6aZDiIS6sENoOnZVxgEQ=;
	b=QBf5TWaYDYsS6FxC2E2F2nksxVsxj5vKPIRn2DexvCnc0a+CWvChrVkQyLxXQx12T52XCB
	PHV4MJsda5d1I8CQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Improve e820_print_type() messages
Cc: Ingo Molnar <mingo@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Juergen Gross <jgross@suse.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-14-mingo@kernel.org>
References: <20250515120549.2820541-14-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570145628.498.4935045625771974144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     4a7a13e04c0528771e5006cd781934f7bc4f8fa0
Gitweb:        https://git.kernel.org/tip/4a7a13e04c0528771e5006cd781934f7bc4=
f8fa0
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:29 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:39 +01:00

x86/boot/e820: Improve e820_print_type() messages

For E820_TYPE_RESERVED, print:

  'reserved'  -> 'device reserved'

For E820_TYPE_PRAM and E820_TYPE_PMEM:

  'persistent' -> 'persistent RAM'

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://patch.msgid.link/20250515120549.2820541-14-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 0316a18..0c3f12f 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -188,15 +188,15 @@ void __init e820__range_add(u64 start, u64 size, enum e=
820_type type)
 static void __init e820_print_type(enum e820_type type)
 {
 	switch (type) {
-	case E820_TYPE_RAM:		pr_cont(" System RAM");			break;
-	case E820_TYPE_RESERVED:	pr_cont(" reserved");			break;
-	case E820_TYPE_SOFT_RESERVED:	pr_cont(" soft reserved");		break;
-	case E820_TYPE_ACPI:		pr_cont(" ACPI data");			break;
-	case E820_TYPE_NVS:		pr_cont(" ACPI NVS");			break;
-	case E820_TYPE_UNUSABLE:	pr_cont(" unusable");			break;
+	case E820_TYPE_RAM:		pr_cont(" System RAM");				break;
+	case E820_TYPE_RESERVED:	pr_cont(" device reserved");			break;
+	case E820_TYPE_SOFT_RESERVED:	pr_cont(" soft reserved");			break;
+	case E820_TYPE_ACPI:		pr_cont(" ACPI data");				break;
+	case E820_TYPE_NVS:		pr_cont(" ACPI NVS");				break;
+	case E820_TYPE_UNUSABLE:	pr_cont(" unusable");				break;
 	case E820_TYPE_PMEM:		/* Fall through: */
-	case E820_TYPE_PRAM:		pr_cont(" persistent (type %u)", type);	break;
-	default:			pr_cont(" type %u", type);		break;
+	case E820_TYPE_PRAM:		pr_cont(" persistent RAM (type %u)", type);	break;
+	default:			pr_cont(" type %u", type);			break;
 	}
 }
=20

