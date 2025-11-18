Return-Path: <linux-tip-commits+bounces-7392-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 736D3C6A4BF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 16:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 84B9B2C37F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 15:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1443538A1;
	Tue, 18 Nov 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YDFCQXuJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DTWDHwNr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA33590D7;
	Tue, 18 Nov 2025 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479604; cv=none; b=tfnmslnAX2XCUZv7y3f0fc9FqSgrFj8D48fvP2prJ3g657WYnvSjqshntrywLvBcmkjl3Eii7EgpOxvGpMuYEU2u0QUEIQ/Bre0JCJwjWFaI2HoyeOLOcgbxWNFDGLhI4r4b6TzhYzZnzd9G9PUPI7wZ5Jo6cqD6Lm7s1a+9o4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479604; c=relaxed/simple;
	bh=FGbgtAsjc10hVh/CpfdjNIQ2HE7Mis5K6u9KK52lgMs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F36UoBrKNGO0CyuBQ1VOhL2WurZgsYrjkRrlbtQKsoNYAsxTScZ5WukLsN/M0eSuJUTZax3M7I77XSRJcJuSK8EsDzkWG+bNgI5D93DyE6er+q3UAIAsXHOaAmSmiOS7bxmZizSn05KEjLihaSbCwwfRtkMwKYI30AU082eyp7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YDFCQXuJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DTWDHwNr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 15:26:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763479600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+nb0p/UkkchHnyTLADJKiavN/1dHpOdDcxWqKWSZUY=;
	b=YDFCQXuJozDxE9f9JpAzo5YQmjSviMSYsXfx9jJBRKhDdvneYboHm8QNAocqLem3bHvBKN
	9PT7HhIhuInxuVfKYe9aM02N1cjFZNLaGGjZlcJKDQs5wRmoyQ0uRBOvYDHywVF+t6wcsl
	WPHYAPRQcpoGvF5lYzNoWz65RS1cTpzk5kvFzKWYMBehInyA2HdYfiibMgE88JJ8dVFqzs
	kihWgDkd7jdXJtz6EmaFeO0WfLcsgoUVqGcx0X2Qt8A4iEYmmTzdfDP8F+89J0SLkmdCpY
	5pHTPTZhBkNTVGJftPCo8jMJZkirycuOSNL84BV+eGOXCoHLd3jbLXmOOe/39Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763479600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+nb0p/UkkchHnyTLADJKiavN/1dHpOdDcxWqKWSZUY=;
	b=DTWDHwNrazCTnhPKXIn1drFYZzYXbnp22l3QkQgmlglWA1qdNmH+GiE3qpIo9E+C1tny69
	Y9gxHrRgYY/0lFBw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove cpumask availability check on kthread
 affinity setting
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251118143052.68778-3-frederic@kernel.org>
References: <20251118143052.68778-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176347959899.498.9199479828569001355.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8b48f569fad938b2c45d0af0b6fe6c949f36ab57
Gitweb:        https://git.kernel.org/tip/8b48f569fad938b2c45d0af0b6fe6c949f3=
6ab57
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 18 Nov 2025 15:30:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Nov 2025 16:19:41 +01:00

genirq: Remove cpumask availability check on kthread affinity setting

Failing to allocate the affinity mask of an interrupt descriptor fails the
whole descriptor initialization. It is then guaranteed that the cpumask is
always available whenever the related interrupt objects are alive, such as
the kthread handler.

Therefore remove the superfluous check since it is merely just a historical
leftover. Get rid also of the comments above it that are either obsolete or
useless.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251118143052.68778-3-frederic@kernel.org
---
 kernel/irq/manage.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 3c55805..707face 100644
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
=20

