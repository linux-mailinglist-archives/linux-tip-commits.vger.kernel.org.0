Return-Path: <linux-tip-commits+bounces-7454-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C99C7B9A8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 21:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E11694E7F19
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 20:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13913019AA;
	Fri, 21 Nov 2025 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TPujZW3Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oOxrBGLM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89810305065;
	Fri, 21 Nov 2025 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763755294; cv=none; b=YKIOYdNQ5B2Ek0Qpy2yn9bx7n1V1xkQONjOwrf77LTt9KVU2j85Kjhuo8tGqA/6u9+cRqHKlKnQE1jijk0+bd8TQiFh2qLVzvmd8c8JzAReCAnbD4UoGn43w3LpXi4FegxjL4qCQ+zDcoVkXDItczQLMtbpXaYkGW1icdkFdyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763755294; c=relaxed/simple;
	bh=tNyhSkyCopWDLpWtUvkS5WzgjqVAWrRvINACPAI4fN8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jaYaqWRuRI5sL3BwUDrBFzT1yIE552Yh82JD+0BTrQlQPhA/h8kq1eIYK3QYD6p2GN0GmdxKNZaAy8kb6C77RO83zZL+Q0035FCWdyWvkIgh0iRYLN2zjIBoLG/9ZejseMDgLqbIr42GrB+thIS7/AnIoqIpgPKgLx86wrXC4TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TPujZW3Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oOxrBGLM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 20:01:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763755289;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHC9puzN1sfXTKV2NutxsJSHFiw/4TPsZiSVIR+Ql4o=;
	b=TPujZW3YuOmaErau0Tif7MsDUWQGDJn0CYisi4UYYrTok5B3eqeWuvjqImQksb8RjxEUqE
	5s1Gi5Q0DoXnwjomZWh/Q88kuyJIIb1f5Zg2qjSixLVmnOEXaNzpo2C2xKl3GJmiEN/ihs
	vuACjduxItyjiHkG3yYWoLzBTAPXbnYs4J/rmRmK8aH8a4ofgOhJmka/vj6dOkMUgTBB3V
	bXi+yS0kixQo5g+IqggMXw/7QUdyJNaLstsz97oBJS4pNxGo12OfVm3yiVlfAfu57ll4Bz
	gmt9aLKUMtfk0GO+xqTj1h24uIkXsGmXtSopJJ8uSFdSJ4927JoryVeFDcTcZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763755289;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHC9puzN1sfXTKV2NutxsJSHFiw/4TPsZiSVIR+Ql4o=;
	b=oOxrBGLMa+4ifiJd8P/Uu2R1xx2qQMtWE17iYkR2HW2Eet9oTJ0VVas1Ov4Wwqxs8ZmN1b
	u90Q2MEphG0eRUDQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove cpumask availability check on kthread
 affinity setting
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251121143500.42111-4-frederic@kernel.org>
References: <20251121143500.42111-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176375528791.498.12964356202300834909.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     15300e02321850105f9128992f12742f3cd78180
Gitweb:        https://git.kernel.org/tip/15300e02321850105f9128992f12742f3cd=
78180
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 21 Nov 2025 15:35:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Nov 2025 20:50:30 +01:00

genirq: Remove cpumask availability check on kthread affinity setting

Failing to allocate the affinity mask of an interrupt descriptor fails the
whole descriptor initialization. It is then guaranteed that the cpumask is
always available whenever the related interrupt objects are alive, such as
the kthread handler.

Therefore remove the superfluous check since it is merely a historical
leftover. Get rid also of the comments above it that are obsolete and
useless.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251121143500.42111-4-frederic@kernel.org
---
 kernel/irq/manage.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 61da1c6..1615b64 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1001,7 +1001,6 @@ static irqreturn_t irq_forced_secondary_handler(int irq=
, void *dev_id)
 static void irq_thread_check_affinity(struct irq_desc *desc, struct irqactio=
n *action)
 {
 	cpumask_var_t mask;
-	bool valid =3D false;
=20
 	if (!test_and_clear_bit(IRQTF_AFFINITY, &action->thread_flags))
 		return;
@@ -1018,21 +1017,13 @@ static void irq_thread_check_affinity(struct irq_desc=
 *desc, struct irqaction *a
 	}
=20
 	scoped_guard(raw_spinlock_irq, &desc->lock) {
-		/*
-		 * This code is triggered unconditionally. Check the affinity
-		 * mask pointer. For CPU_MASK_OFFSTACK=3Dn this is optimized out.
-		 */
-		if (cpumask_available(desc->irq_common_data.affinity)) {
-			const struct cpumask *m;
+		const struct cpumask *m;
=20
-			m =3D irq_data_get_effective_affinity_mask(&desc->irq_data);
-			cpumask_copy(mask, m);
-			valid =3D true;
-		}
+		m =3D irq_data_get_effective_affinity_mask(&desc->irq_data);
+		cpumask_copy(mask, m);
 	}
=20
-	if (valid)
-		set_cpus_allowed_ptr(current, mask);
+	set_cpus_allowed_ptr(current, mask);
 	free_cpumask_var(mask);
 }
 #else

