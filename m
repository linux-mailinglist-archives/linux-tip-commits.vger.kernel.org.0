Return-Path: <linux-tip-commits+bounces-7556-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B44C8F66B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Nov 2025 16:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 929133512B4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Nov 2025 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F32D336EEF;
	Thu, 27 Nov 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IbSyHXHg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yFtAlU/w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B460E2C158D;
	Thu, 27 Nov 2025 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259063; cv=none; b=nH1MvWOz7NTS5ho52JlhVWbRYd25wTaxryNBG2x1cc9A+wyrm57PeUFmlsZpZkO4I3918MBJcZZZXNmUjKlV9zZKJTpX00xr8tPLxiOQE0PDB5T+Ppd2lUjATp0SOK6/EqeTxoY3NVGhxXD1MLlYb5mgexz9m/muHl04TN50jK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259063; c=relaxed/simple;
	bh=VCIRZGN7ByFhIseUsZ5FZBvtrwheEjMnNMiWJbB09dw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HlD3brLSiU363GLKhvgutC1csXz3rLCZokdjonT2oA0mrhNKBksm27jIwC/DuwdiS75CTW7GcjMGg0Q2sfimQRpKRPc65JECQSuvUMb47UJg6RVHBmZ2k0bEYYcmesirNFTVzRaKOzi6uD/ZnxWphyBbkSbuP1H6sbw7kUBpYoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IbSyHXHg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yFtAlU/w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Nov 2025 15:57:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764259060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WvhKPnGlcTSt4BID21FW7xM1rdZ0ZfzQax7G0gAlwDY=;
	b=IbSyHXHgUUmvpotcwcbQV9JuKLFoSECZR3daIrfFJfBl6emeCJSMcwEBjAwX3FcsVGFT/g
	UltgdlCsIpaVHBMDqWuPO2uuJtA7rcr+GgCBR0JFbeuZbo4zkf0UR9rL6u1nInYdUNBxdq
	syn/CleoU4YfxaLU4wdlNyOsS6++BZNra84aL3BvLBj1fsp7MhV7kAxnXWOLnqtS4rkXAb
	jNLAHn0VjBzGBiYWlfmLBip0Lhq9kJIUIHsrjSpgXrEaAtqDzsTUDUrSpGlldGE0tDJNmI
	Z6jQIhNSRwUtpC8IddBUy3HwH+ixWpjXz/11kHzAEP1agNyJ0d4qITpdv+HKkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764259060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WvhKPnGlcTSt4BID21FW7xM1rdZ0ZfzQax7G0gAlwDY=;
	b=yFtAlU/wd0YOeES3LV+nGfw1gJJ4OfRufUVRza49RrQ3PTUkZ11uvqn5Cib/NslqMnzx4A
	o+lYxM4JLauPiBCw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Allow to refill the pool
 before SYSTEM_SCHEDULING
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251127153652.291697-2-bigeasy@linutronix.de>
References: <20251127153652.291697-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176425905908.498.4130513060411020638.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     06e0ae988f6e3499785c407429953ade19c1096b
Gitweb:        https://git.kernel.org/tip/06e0ae988f6e3499785c407429953ade19c=
1096b
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 27 Nov 2025 16:36:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 27 Nov 2025 16:55:34 +01:00

debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING

The pool of free objects is refilled on several occasions such as object
initialisation. On PREEMPT_RT refilling is limited to preemptible
sections due to sleeping locks used by the memory allocator. The system
boots with disabled interrupts so the pool can not be refilled.

If too many objects are initialized and the pool gets empty then
debugobjects disables itself.

Refiling can also happen early in the boot with disabled interrupts as
long as the scheduler is not operational. If the scheduler can not
preempt a task then a sleeping lock can not be contended.

Allow to additionally refill the pool if the scheduler is not
operational.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251127153652.291697-2-bigeasy@linutronix.de
---
 lib/debugobjects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7f50c44..7017e5c 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -714,7 +714,7 @@ static void debug_objects_fill_pool(void)
 	 * raw_spinlock_t are basically the same type and this lock-type
 	 * inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYSTE=
M_SCHEDULING) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to WAIT_SLEEP, matching

