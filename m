Return-Path: <linux-tip-commits+bounces-2624-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3B49B3768
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Oct 2024 18:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8BB1F23802
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Oct 2024 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6921D6199;
	Mon, 28 Oct 2024 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BGhtzHDw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XUXZv2wu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66013AD11;
	Mon, 28 Oct 2024 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135619; cv=none; b=Zo3iE1qxZn/GuYj4+dMzkXnLM7nU1bFqwBhZO5Z5aun0WI0JZ0GJ+t6ChLb+1q/9dEZs1fR7mO0o2LL3EmU+g/d+gBGKjW1r3MyKq7lcjYRbiaF2TZjvWenbzQlM8q7ng6iqpQi/jjzMLrKfXwOi1wnD4sP2afPQH/PlsHOge3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135619; c=relaxed/simple;
	bh=twrkel/z7f0Uvz/nUCOczexz7YOWRebDG4ZY4DAKOd0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AfNv1IdOXrKmx324Rgk+LCxCtUK9xCZArH++/U4TRCFNdwl4WGoNreXCLDdAc3baPlCRQmj77MFJ++Eh4d7kxvFS3nyIn5XUDZ5TI/YtRV94mt/Z+c8VbT1fvAWygmKYI5U+7aZMIgvmi23dIgP4Gqa3+hRYySM03dDJgutItg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BGhtzHDw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XUXZv2wu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Oct 2024 17:13:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730135615;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhiEC9kMQKsbUqJTKW6Rf829+4GdeJNHJFIDaHCH6BE=;
	b=BGhtzHDw66KRmMbgdhVBog0+dQemknYba55bk2dXs2K2Sgf4UmsNOr+3lqfA2C+3KDENBY
	Bqo5qKFrygjSXxt8iiGyWpurO7DpdYd/b+ZP1TUQyL0k5utrkVqSpSFZVqmLQZgpxm03oK
	4Ww/yAH6JafQ/Z+SzbK4zYGXBBPoce5MZRTagtzS3Vwlkqec9ifDFSUFLQP2kElMYW7mT0
	6Nh4Ec9EYGL3m1fNG1HWBUNMajuNA2/lXatVuWKd+PuI50Ty6FX92+Zo/fakQCWqg7rDR2
	EQf0OA+PRzulrOodLLxblrQxDLund7fLNx6NJYcJVNWHCghQFiEDUekr9B2MRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730135615;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhiEC9kMQKsbUqJTKW6Rf829+4GdeJNHJFIDaHCH6BE=;
	b=XUXZv2wuIDCaIISlgZu/KjoeFk7qPRSiw9bhuhQlbonXxaa7NdW0O0At9wSieTJ/PwvKG6
	OqDEi8ydmnMdGsAQ==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Change PAGE_MASK to signed on all 32-bit
 architectures
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Anders Roxell <anders.roxell@linaro.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241024133447.3117273-1-arnd@kernel.org>
References: <20241024133447.3117273-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173013561467.1442.5521979410105153215.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     d4a65302dd849fade9e2ca712826c35b8d068ecb
Gitweb:        https://git.kernel.org/tip/d4a65302dd849fade9e2ca712826c35b8d068ecb
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Thu, 24 Oct 2024 13:34:26 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 28 Oct 2024 16:56:15 +01:00

vdso: Change PAGE_MASK to signed on all 32-bit architectures

With the introduction of an architecture-independent defintion of
PAGE_MASK, we had to make a choice between defining it as 'unsigned long'
as on 64-bit architectures, or as signed 'long' as required for
architectures with a 64-bit phys_addr_t.

To reduce the risk for regressions and minimize the changes in behavior,
the result was using the signed value only when CONFIG_PHYS_ADDR_T_64BIT
is set, but that ended up causing a regression after all in the
early_init_dt_add_memory_arch() function that uses 64-bit integers for
address calculation.

Presumably the same regression also affects mips32 and powerpc32 when
dealing with large amounts of memory on DT platforms: like arm32, they were
using the signed version unconditionally.

The two most sensible options for addressing the regression are either to
go back to an architecture specific definition, using a signed constant on
arm/powerpc/mips and unsigned on the others, or to use the same definition
everywhere.

Use the simpler of those two and change them all to the signed version, in
the hope that this does not cause a different type of bug. Most of the
other 32-bit architectures have no large physical address support and are
rarely used, so it seems more likely that using the same definition helps
than hurts here.

In particular, x86-32 does have physical addressing extensions, so it
already changed to the signed version after the previous patch, so it makes
sense to use the same version on non-PAE as well.

Fixes: efe8419ae78d ("vdso: Introduce vdso/page.h")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lore.kernel.org/all/20241024133447.3117273-1-arnd@kernel.org
Link: https://lore.kernel.org/lkml/CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com/

---
 include/vdso/page.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/vdso/page.h b/include/vdso/page.h
index 4ada1ba..710ae24 100644
--- a/include/vdso/page.h
+++ b/include/vdso/page.h
@@ -14,13 +14,14 @@
 
 #define PAGE_SIZE	(_AC(1,UL) << CONFIG_PAGE_SHIFT)
 
-#if defined(CONFIG_PHYS_ADDR_T_64BIT) && !defined(CONFIG_64BIT)
+#if !defined(CONFIG_64BIT)
 /*
- * Applies only to 32-bit architectures with a 64-bit phys_addr_t.
+ * Applies only to 32-bit architectures.
  *
  * Subtle: (1 << CONFIG_PAGE_SHIFT) is an int, not an unsigned long.
  * So if we assign PAGE_MASK to a larger type it gets extended the
- * way we want (i.e. with 1s in the high bits)
+ * way we want (i.e. with 1s in the high bits) while masking a
+ * 64-bit value such as phys_addr_t.
  */
 #define PAGE_MASK	(~((1 << CONFIG_PAGE_SHIFT) - 1))
 #else

