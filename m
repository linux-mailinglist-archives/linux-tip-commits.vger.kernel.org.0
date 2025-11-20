Return-Path: <linux-tip-commits+bounces-7428-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B11C75249
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 16:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3449135244A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 15:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341DB2EB85E;
	Thu, 20 Nov 2025 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MsbqAmxN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m/YMGKqX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499F376BDE;
	Thu, 20 Nov 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653467; cv=none; b=qD/2HDXv1vqogQYmccRgHisg3X9t/OuJRmPlpVu68tMvVz8lCNMY3v1lTzjTyRiTdC/0gDpPOWW/SwZMVibqNgR1eOLCwGqJTqx+CFQeV+AVRj5r0+9t3jgdX6DcfRXfaLDZfKYck9rD44TMloSJluqTNUEwdVfGgVvpxhibxKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653467; c=relaxed/simple;
	bh=i0BrrNQXRFBAVd0l9dltNsHqh4zSy7Vz8XLJcuieTKc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mr1K/Zh564uuPvczenorI0G4fnJUaxFC5zj7/jmoFZuSeTKmW+6RIkephOoBXzqJj5C0aYl7alUdhACGvbvtSZvBr2sz/szT6ezDUX5mTjJoA83lHD4hrlt0OaX1AKwoG3hwawhWkOiEY+UtTZ8w8CtZ1DCNLFqYzZE4XJd0Y+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MsbqAmxN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m/YMGKqX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 15:44:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763653463;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJqpSzRS3L3sXNEkM16jStbA17uyHWDnNM9Olz0LGWo=;
	b=MsbqAmxNRzmMr/xo9j1XkXDr84iE8GKlbPwttRI56/Wj1yBcGoNuUQjfHgxYTB/qwSoRmd
	sPo1w3EodqjGetJn+Myvk8/nkN909Q8L56nNMl9Ss9bsAlwUewSQgd9ALpZ0UdcY16mrnD
	L5jK7VQrqCfwXFdVw6W/TGaIu9qrMYvb/510rz7ju954b5oG9axkPJMowOv1qDHQ67s/Ax
	h+fUIrTARZhry0UPFrWc50ezcdYdNdHpmOkXWpwaKp0o8LZozmZEd9itTNjY6e7si7Cg8z
	6tJa4SG/9vypR3MmwlMreDlQEU0majCgOArjtnUreU+8Aak8s9FizwRhQOvBNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763653463;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJqpSzRS3L3sXNEkM16jStbA17uyHWDnNM9Olz0LGWo=;
	b=m/YMGKqXctyf2Do+TfN7+4GiA757ch1JtC8TPaXELeYaXbsC57GLXeSWZhVuwHUEJZSJqL
	FJTgJOASapf0QMCg==
From: "tip-bot2 for Wen Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] tick/sched: Fix bogus condition in report_idle_softirq()
Cc: Wen Yang <wen.yang@linux.dev>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251119174525.29470-1-wen.yang@linux.dev>
References: <20251119174525.29470-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176365346261.498.9615156883986148322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     807e0d187da4c0b22036b5e34000f7a8c52f6e50
Gitweb:        https://git.kernel.org/tip/807e0d187da4c0b22036b5e34000f7a8c52=
f6e50
Author:        Wen Yang <wen.yang@linux.dev>
AuthorDate:    Thu, 20 Nov 2025 01:45:25 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 19 Nov 2025 19:30:45 +01:00

tick/sched: Fix bogus condition in report_idle_softirq()

In commit 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle") the
new function report_idle_softirq() was created by breaking code out of the
existing can_stop_idle_tick() for kernels v5.18 and newer.

In doing so, the code essentially went from this form:

	if (A) {
		static int ratelimit;
		if (ratelimit < 10 && !C && A&D) {
                       pr_warn("NOHZ tick-stop error: ...");
		       ratelimit++;
		}
		return false;
	}

to a new function:

static bool report_idle_softirq(void)
{
       static int ratelimit;

       if (likely(!A))
               return false;

       if (ratelimit < 10)
               return false;
...
       pr_warn("NOHZ tick-stop error: local softirq work is pending, handler =
#%02x!!!\n",
               pending);
       ratelimit++;

       return true;
}

commit a7e282c77785 ("tick/rcu: Fix bogus ratelimit condition") realized
ratelimit was essentially set to zero instead of ten, and hence *no*
softirq pending messages would ever be issued, but "fixed" it as:

-       if (ratelimit < 10)
+       if (ratelimit >=3D 10)
                return false;

However, this fix introduced another issue:

When ratelimit is greater than or equal 10, even if A is true, it will
directly return false. While ratelimit in the original code was only used
to control printing and will not affect the return value.

Restore the original logic and restrict ratelimit to control the printk and
not the return value.

Fixes: 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle")
Fixes: a7e282c77785 ("tick/rcu: Fix bogus ratelimit condition")
Signed-off-by: Wen Yang <wen.yang@linux.dev>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251119174525.29470-1-wen.yang@linux.dev
---
 kernel/time/tick-sched.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c527b42..466e083 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1152,16 +1152,15 @@ static bool report_idle_softirq(void)
 			return false;
 	}
=20
-	if (ratelimit >=3D 10)
-		return false;
-
 	/* On RT, softirq handling may be waiting on some lock */
 	if (local_bh_blocked())
 		return false;
=20
-	pr_warn("NOHZ tick-stop error: local softirq work is pending, handler #%02x=
!!!\n",
-		pending);
-	ratelimit++;
+	if (ratelimit < 10) {
+		pr_warn("NOHZ tick-stop error: local softirq work is pending, handler #%02=
x!!!\n",
+			pending);
+		ratelimit++;
+	}
=20
 	return true;
 }

