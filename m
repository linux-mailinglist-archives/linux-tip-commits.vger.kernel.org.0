Return-Path: <linux-tip-commits+bounces-7459-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B3AC7CABB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 09:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C38F3A65D2
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 08:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1594613AA2F;
	Sat, 22 Nov 2025 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RkPJvqXw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gc1h9mvf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0014036D4E6;
	Sat, 22 Nov 2025 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763800249; cv=none; b=JVH5sZp6T7PArthMgP66BlnFuyPBCChx1S020WM09HRHTr7+CYPTO8DRjcdZfLgdsgAaSmudUK5e/+SEKnALqhDjGzpn/C7AJdW40XqcyTD+1bzYKZxYCmt6XariI4TPpwPTyj0uPCOJ94LvJuOe8nBKElh/3PhLq6bzRh2kFe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763800249; c=relaxed/simple;
	bh=S5cvWn8sPI/9sgopU46c65jPiDILHw3Q14dSBvdUm1Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rwYB92Hi3yiW8adidYvbXxA+6FKuuBQYKa7CQ/yBXIgdgiSf6ry4hSK42uZB9e2x4Ti/2Ho+Z+uN00sJTPTiPGCIxMooF+Ln0QZH37jhsRwso3dES1VydwiEv9bSJP0z5A03D578rLDVAiTHbGAbblaoyrOqGqHYRunsQY91hV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RkPJvqXw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gc1h9mvf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Nov 2025 08:30:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763800244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTl4oUBGJmkrzCrfeMaJQp7RmQMRuao76zC4jjHO9NU=;
	b=RkPJvqXw4LjVlDSkW0Xliccg73R+u/fp0GfkJIEk/xMVtJfi+ItT8r4JZScoBVEIA/KTEr
	WHAcoDswEm7OD/QOy8are2w9pv21Sq3YXJzKNLuuCj3YmAywaIp9IVV12Ld16Z6/07+K/7
	9KIdozxZ18ll9Cgdl2e/UAHFt/bMBSDXNM1QvJZlmgEcUfcJGwUoabkA+HphMTK7CmE8wt
	wzYdUW87DkEJnkX9FzEQLZNtT7D2TYFf33DwDXoOs7AAB+3gP+HxtGQiZ3RIvEdRzcLHF9
	wQykM7EqCAk0qAG5g2LE18spXBoFqLmqXwgxqlKQ1eeOtEDDpkGE1o+wwirR7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763800244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTl4oUBGJmkrzCrfeMaJQp7RmQMRuao76zC4jjHO9NU=;
	b=gc1h9mvf8122AstgAP8dNkRuikWsWBTJ0xUBBqljSIlVOnIH9BNvSOyQhjmFGPeIoY0NtI
	XSabhVpWyHz56MAQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove cpumask availability check on kthread
 affinity setting
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251121143500.42111-4-frederic@kernel.org>
References: <20251121143500.42111-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176380024037.498.16015322633355247588.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3de5e46e50abc01a1cee7e12b657e083fc5ed638
Gitweb:        https://git.kernel.org/tip/3de5e46e50abc01a1cee7e12b657e083fc5=
ed638
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 21 Nov 2025 15:35:00 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Nov 2025 09:26:18 +01:00

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

