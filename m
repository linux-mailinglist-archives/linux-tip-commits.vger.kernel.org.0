Return-Path: <linux-tip-commits+bounces-5523-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B69FAB4D40
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 May 2025 09:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8263AE89A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 May 2025 07:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBAC1F151D;
	Tue, 13 May 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KK+tiFR9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FTj6W0SK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433251EA7C1;
	Tue, 13 May 2025 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122409; cv=none; b=eKn+Sxww/PUfEL1gTnsLKTT3kG+WATm9kMKazoKKIoj6tXs59HRLU3IQM5mr5nWPGSdTVdwZlu6OzDu5dAaRE0v46XXQKWUZLmZVnnA6v2Og4bxt7tWXThqm0hWJZhmqRGpUFfFRbE0TkGFNfKRyZe4dLaqgIFYaVal6vpZTEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122409; c=relaxed/simple;
	bh=hq0kWEbfDKodGH0XPZl3XBzV4DpW952Hu1/ZjTD7av8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dkO0wwJbsS/K6IPlEjnbL6tWoZh8Rk7ckT6DxfWTjFR2HdEXk5gYzZG7S06J5UPiUp3p8qTRuJbpW4HqJsqBmpBDmTpyqtv43vRfnJ4+aEydNRgZ/b8KCl3OolFWcTDUFrfvFkdyvqa1DXVZE/uuuIzFBbMjUsvqMpb1hxCW4S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KK+tiFR9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FTj6W0SK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 May 2025 07:46:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747122405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FomZnUBNxP9JTQdisg9RS4mqRlOQcURtKST8r8QQS3w=;
	b=KK+tiFR9YB78mcTv9dZUK1Cl2kxhB3XYMxUgpwkfi1iDrp49HvSoCma4FquHpJJmeY8iFy
	x5zv/lS5XW+MWPgTzTk9ajPuNlGb1voONy5wqwEkKwvXSkf5w271wzlAsDJTlz5I+KQ08/
	dR6rKDwBUkvFRcz/Z/RCFIxVbcGFV8AwRjhR2cPrIS/xwBrivJSKmHhaJ5xyeAI8+r7y9j
	emizty35M9GRY4/At9YE7TZDHD8azsZ230F0x+eD4SGIsZXmvBPo8egTYBuzQUwBUVfRpL
	0tT5dpJpWu4Zkq0zhwDwKyTWCiG7kjkwKvTGz+BcYwtaON07mv6n8uSjg6aYFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747122405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FomZnUBNxP9JTQdisg9RS4mqRlOQcURtKST8r8QQS3w=;
	b=FTj6W0SKuZh508nltLZt9p0j4PODQikgFQAopDkSvPmsZxhrDiZCx3Uuf2s1XnOFrLGUYT
	IHv2bW8fz40qbKAg==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Ensure flags in lock guard is consistently
 initialized
Cc: Nathan Chancellor <nathan@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jirislaby@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250513-irq-guards-fix-flags-init-v1-1-1dca3f5992d6@kernel.org>
References: <20250513-irq-guards-fix-flags-init-v1-1-1dca3f5992d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174712240447.406.13492998074191262965.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b5fcb6898202858ae8425bf0cd9cb5704735bd02
Gitweb:        https://git.kernel.org/tip/b5fcb6898202858ae8425bf0cd9cb5704735bd02
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Tue, 13 May 2025 00:16:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 May 2025 09:37:18 +02:00

genirq: Ensure flags in lock guard is consistently initialized

After the conversion to locking guards within the interrupt core code,
several builds with clang show the "Interrupts were enabled early"
WARN() in start_kernel() on boot.

In class_irqdesc_lock_constructor(), _t.flags is initialized via
__irq_get_desc_lock() within the _t initializer list. However, the C11
standard 6.7.9.23 states that the evaluation of the initialization list
expressions are indeterminately sequenced relative to one another,
meaning _t.flags could be initialized by __irq_get_desc_lock() then be
initialized to zero due to flags being absent from the initializer list.

To ensure _t.flags is consistently initialized, move the call to
__irq_get_desc_lock() and the assignment of its result to _t.lock out of
the designated initializer.

Fixes: 0f70a49f3fa3 ("genirq: Provide conditional lock guards")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/all/20250513-irq-guards-fix-flags-init-v1-1-1dca3f5992d6@kernel.org

---
 kernel/irq/internals.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index bd2db6e..476a20f 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -176,10 +176,10 @@ __DEFINE_UNLOCK_GUARD(irqdesc_lock, struct irq_desc,
 static inline class_irqdesc_lock_t class_irqdesc_lock_constructor(unsigned int irq, bool bus,
 								  unsigned int check)
 {
-	class_irqdesc_lock_t _t = {
-		.bus	= bus,
-		.lock	= __irq_get_desc_lock(irq, &_t.flags, bus, check),
-	};
+	class_irqdesc_lock_t _t = { .bus = bus, };
+
+	_t.lock = __irq_get_desc_lock(irq, &_t.flags, bus, check);
+
 	return _t;
 }
 

