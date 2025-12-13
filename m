Return-Path: <linux-tip-commits+bounces-7642-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD41CBA29E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Dec 2025 02:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A0243012962
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Dec 2025 01:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9706219F13F;
	Sat, 13 Dec 2025 01:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c/iI2owp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="osy6YwT9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B589224AF7;
	Sat, 13 Dec 2025 01:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765589853; cv=none; b=bUf5UgWwJQbV088zjZit2CSNm9X7gTGSLBMdrHl4NLqh+chYqZ99PN4xi4kObq2t3OKIbfxRRrP1uoh1xRVUsYCMgfwVdsnbnqJPXki1zFnZjR/vlCireUXocozRzI2uaTCB7C1ev5rHg3zMqhklfSj7LkT30znjOsrc8VaU93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765589853; c=relaxed/simple;
	bh=4K3s1X9t/lIVUIfX/7hK9NPtuagveQ+9m6bJri/7Zvo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rjWyTsYstriDNqEcNEtlPT8bBEHYjLP8kYxyPu4WxMGS4E4/Lx8gb4jjkYQ5uOesBIdVExd//aDvxfeHX68PG0+unhzsVvC6BbuAa7YTXoQUiucsXQnfVkCYncoaVkNmYtXy/7LX2gi9Y5/TRIx77NHqzbQUA/skctsMe8tj03U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c/iI2owp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=osy6YwT9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Dec 2025 01:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765589844;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQvwGL6/fRpx0glYrTGkMjqZ+9PXZUEX6zx5wvrdcTA=;
	b=c/iI2owp02XOckQiO9gnFNABbiGp2ppiIWcYYchy2Lc9DR7z2ZkAgnkb9gmsB9vb+2J6Y6
	g3ZKQFvsbuw0pXRW/5lwwN8VCnXQnZWtAPPqJO9/0pmRzLira/8KXc0H8hbbxHe3xlNRRH
	IE7A8RkfM/C2Og52hfjPaqqAk94YZWmW/ixXZ4RRw8T9lfVpoiwX/x1BfKRuf/sOxA80VH
	4dRKpvHuawPt4Gshq/WOU5q9gOKezX4L1jlkXLOOHMSsyArhlFCoZ6vKX6UtkpLZD5DSs4
	OskP+2QUjFYEWmDn3E197uL82dM3AGavifuCrNjbraQuVDoMhNq+n/43Z/KbXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765589844;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQvwGL6/fRpx0glYrTGkMjqZ+9PXZUEX6zx5wvrdcTA=;
	b=osy6YwT9JrJqZ/3E051hzGHO74Y476UpRXxgsIEbJOZaInSI9PfZmzcY4wiX8GuVLpXqm1
	7qjdm4Ug4/fsZ6AA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] genirq: Don't overwrite interrupt thread flags on setup
Cc: Chris Mason <clm@meta.com>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <87ecp0e4cf.ffs@tglx>
References: <87ecp0e4cf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176558984007.498.14990363440965785655.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     fbbd7ce627af733ded7971b2495b0d099a0a80da
Gitweb:        https://git.kernel.org/tip/fbbd7ce627af733ded7971b2495b0d099a0=
a80da
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 Dec 2025 13:01:04 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 13 Dec 2025 10:29:33 +09:00

genirq: Don't overwrite interrupt thread flags on setup

Chris reported that the recent affinity management changes result in
overwriting the already initialized thread flags.

Use set_bit() to set the affinity bit instead of assigning the bit value to
the flags.

Fixes: 801afdfbfcd9 ("genirq: Fix interrupt threads affinity vs. cpuset isola=
ted partitions")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://patch.msgid.link/87ecp0e4cf.ffs@tglx
Closes: https://lore.kernel.org/all/20251212014848.3509622-1-clm@meta.com
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 8b1b4c8..349ae79 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1414,7 +1414,7 @@ setup_irq_thread(struct irqaction *new, unsigned int ir=
q, bool secondary)
 	 * Ensure the thread adjusts the affinity once it reaches the
 	 * thread function.
 	 */
-	new->thread_flags =3D BIT(IRQTF_AFFINITY);
+	set_bit(IRQTF_AFFINITY, &new->thread_flags);
=20
 	return 0;
 }

