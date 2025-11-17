Return-Path: <linux-tip-commits+bounces-7371-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0144C6526D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 17:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88E513512D0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60BA25B305;
	Mon, 17 Nov 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YseiFUiL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="759fkKZS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCF02C237C;
	Mon, 17 Nov 2025 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396616; cv=none; b=WD2B1I2/I3Dxj6svdWH9JErhQww3ewxUd30q0MHZ8sdRcNPUavgr+odhWI1OP9CmGZzbSDI8RaGLdAoD3/qqNqpmoQcZrmSBA1yLMA/tRX7YQa5CDIJ2I2G4BufYoxKkxeQrNx82ME9daOdmSdLYnjRihVDiIqsONr03Y1iNlqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396616; c=relaxed/simple;
	bh=Kt7jonBtQQepXe9gghyhdML/2WIpCjijt9omPvbO8t4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JeBBbeVdmH8AUl1uiFEkVTBN7zWnqw8AhMCoURXvHREV5wRQuWxv9av/NjCRFsVDb6OaBF+E8MS9rLYZF7p/seILzWVxcaer3U6+uGZ4kP5PnJPJ8rQUo1z0JXpkI+LmWg3WF67EZP7Eo+QwKT+oBOFz3bjDDlS5htIQvUkkJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YseiFUiL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=759fkKZS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Nov 2025 16:23:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763396613;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cd1x9SBfMon5QwOPPNLDQXPli2+k2kmz6+St510IGk0=;
	b=YseiFUiL030YuY9RhdrpP4qk0zYwLBND7GA4d/QCbLA2n1X/Yk0VTKn4gBksj2YeCaugDB
	0alfqAejcYScGM47mwx5BN2OMf5roro2FGqJNo6TiI1ag5Q4hvsIgQi21BfqCRDTbAniTZ
	rgv34mFHUmLSegT/l3dHArVHSi9kLs6R01h/Mb+GFwm/WyKa2zFO0Ay4Tr/yKESXPmS8/z
	bBa0I1j0CLgZOgHPGkutIi9n3uKxzZTqIIKowTFx3lhz7i4/4O/ub7/lVm81pDyUeHB3ZN
	2YnxnRY7CtHrUOlfoq9vfraIGd04+vy/s/sSarcX+Oy9E3pJ5uxi4u6DR5AC4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763396613;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cd1x9SBfMon5QwOPPNLDQXPli2+k2kmz6+St510IGk0=;
	b=759fkKZSNXvVCr4eWaB15kr+8J5uvH5T9m08oO8npjoUDiCVgff8r+DxtNEG84xFbX69/1
	f1lcrCch1FjLrlAA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Small cleanup to update_newidle_cost()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Mason <clm@meta.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251107161739.655208666@infradead.org>
References: <20251107161739.655208666@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176339661206.498.9675451827179214873.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     08d473dd8718e4a4d698b1113a14a40ad64a909b
Gitweb:        https://git.kernel.org/tip/08d473dd8718e4a4d698b1113a14a40ad64=
a909b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Nov 2025 17:01:27 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Nov 2025 17:13:15 +01:00

sched/fair: Small cleanup to update_newidle_cost()

Simplify code by adding a few variables.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Chris Mason <clm@meta.com>
Link: https://patch.msgid.link/20251107161739.655208666@infradead.org
---
 kernel/sched/fair.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 75f891d..abcbb67 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12226,22 +12226,25 @@ void update_max_interval(void)
=20
 static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
 {
+	unsigned long next_decay =3D sd->last_decay_max_lb_cost + HZ;
+	unsigned long now =3D jiffies;
+
 	if (cost > sd->max_newidle_lb_cost) {
 		/*
 		 * Track max cost of a domain to make sure to not delay the
 		 * next wakeup on the CPU.
 		 */
 		sd->max_newidle_lb_cost =3D cost;
-		sd->last_decay_max_lb_cost =3D jiffies;
-	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
+		sd->last_decay_max_lb_cost =3D now;
+
+	} else if (time_after(now, next_decay)) {
 		/*
 		 * Decay the newidle max times by ~1% per second to ensure that
 		 * it is not outdated and the current max cost is actually
 		 * shorter.
 		 */
 		sd->max_newidle_lb_cost =3D (sd->max_newidle_lb_cost * 253) / 256;
-		sd->last_decay_max_lb_cost =3D jiffies;
-
+		sd->last_decay_max_lb_cost =3D now;
 		return true;
 	}
=20

