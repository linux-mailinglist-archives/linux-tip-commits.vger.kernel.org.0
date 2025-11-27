Return-Path: <linux-tip-commits+bounces-7555-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F95C8F67D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Nov 2025 16:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E6A3AE953
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Nov 2025 15:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58E3334C3F;
	Thu, 27 Nov 2025 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2G16hwXr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EL54+CGd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E9D246BC7;
	Thu, 27 Nov 2025 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259062; cv=none; b=VpAgSw55m4rjo3QXPPWUx6UIEeaXH5C0U7sTmIQcG/AaolsTIthp5MXsLBWRZlFq/8EcVdUqBu/I2buBrd+NzB/HmLruU0/KlSDHQI2JH2LqFV7aC4doM8g7tKz3ZeULJsCyWaNPEHyqggWZstz1H4BIpVrhviutN0LD5Ee/vH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259062; c=relaxed/simple;
	bh=AshkHPjwz2XrTMPGXjaUEPiicXh0KVXyzXiM6dnkcWI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IBx7sqk8ICN7PL5Z56R7PFckPoRxCqghhz5hP8X3qjjgo8935znEyu1htpzJNoGwFHxvAZdh29hJ3wsYx/mAl7pqR+xzjeNIJaDdyoUXBVi1oNARzbPTvR2rSl4OwYkw3RZmqd7qVpPjLFv8Gv+5zGunjIqww4USAfiKac6Kalo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2G16hwXr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EL54+CGd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Nov 2025 15:57:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764259059;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tblc7e3G98Vx292TyVAVPicMlkcoPuBb0D5EJNtIxcs=;
	b=2G16hwXrEtcxULaVOTSxbe+NZL9rhh6k62O0Sgm1hxZ2NRYS1UGBkwz8vFYXpVI+apYYJF
	k2OIi+TCdvoxW28y4YIf7NQWTyKP1BfUDX1+ZfHavF1Q++G4ACSp2QKA6g8pHyEN/3MiNC
	S6b8lCecdzL6PvhqSUnrLmMams34ftlWC4t3HCIig+gtdoEaUmMeV/1JuTxPUIUtt25eyY
	Ck2w0awqcXyiAt3/PQZ5SpOLp4wOxFtiK4njragCqClOVc/lvZxdXwirUXNJkHmkrG6CXS
	QZDaRYypIyLpJXucYjnfKI88BRIIgQ0BoTklx6P1PNp9vO5mg0nRTZw6KU5umQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764259059;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tblc7e3G98Vx292TyVAVPicMlkcoPuBb0D5EJNtIxcs=;
	b=EL54+CGdE3IShV9jacmGFni0+EiTAM+tcKJLRp2ULsg7o541KJullLA/kMAwdOOxYcYr7q
	k3aof91J+LwZcoCw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251127153652.291697-3-bigeasy@linutronix.de>
References: <20251127153652.291697-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176425905776.498.15467742827330761737.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     37de2dbc318ee10577c1c2704de5a803e75e55a2
Gitweb:        https://git.kernel.org/tip/37de2dbc318ee10577c1c2704de5a803e75=
e55a2
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 27 Nov 2025 16:36:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 27 Nov 2025 16:55:34 +01:00

debugobjects: Use LD_WAIT_CONFIG instead of LD_WAIT_SLEEP

fill_pool_map is used to suppress nesting violations caused by acquiring
a spinlock_t (from within the memory allocator) while holding a
raw_spinlock_t. The used annotation is wrong.

LD_WAIT_SLEEP is for always sleeping lock types such as mutex_t.
LD_WAIT_CONFIG is for lock type which are sleeping while spinning on
PREEMPT_RT such as spinlock_t.

Use LD_WAIT_CONFIG as override.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251127153652.291697-3-bigeasy@linutronix.de
---
 lib/debugobjects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7017e5c..ecf8e7f 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -717,10 +717,10 @@ static void debug_objects_fill_pool(void)
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYSTE=
M_SCHEDULING) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
-		 * by temporarily raising the wait-type to WAIT_SLEEP, matching
+		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching
 		 * the preemptible() condition above.
 		 */
-		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_SLEEP);
+		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_CONFIG);
 		lock_map_acquire_try(&fill_pool_map);
 		fill_pool();
 		lock_map_release(&fill_pool_map);

