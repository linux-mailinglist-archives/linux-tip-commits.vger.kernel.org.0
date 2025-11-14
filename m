Return-Path: <linux-tip-commits+bounces-7357-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB596C5E468
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 17:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 271AB381007
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 16:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABDF32A3CF;
	Fri, 14 Nov 2025 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PrL0qEPd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9RXq+39u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FD0329E4A;
	Fri, 14 Nov 2025 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136146; cv=none; b=r23B3kZbdHO262CUU6XFbTho9zEv7sZDYnSRuVkc9kghfRaiyU33cz31rYN7J5aD6dgUIhaqlztt6/f57M9qEB5rX3uVztfNyIFaHG+AANetuHI4HNLgUqTKlTmN66m7UM6DDf64X8R5e/OEgdLBEA6tPyB9AQcptVmKmkWwJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136146; c=relaxed/simple;
	bh=Kv2/INIsYh4Lx93TfSbqF7cvbP/XuTdvpefIcxlxEDg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jZj1f0LfndGqNL8C4klq0rAUbtBCWV5fplOxstncmi2m7lUA+YSCxfftTGqW4y/QP69a0pv6pGEpO3xmQklNGaw3Cm7AOYjnuuV82HUe2it3JLzjiiIRSldwcZUwPTpRGNa267Nx0yX7jYo4Mf7vUkUCgmy4bPIS5blnLbyySJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PrL0qEPd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9RXq+39u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 16:02:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763136142;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mo/E9U0Q5CDi6BorXZGuTjfHe7B4Gso4VX3TrudaekY=;
	b=PrL0qEPd4b3ImcgTl8EiX48aJZJrPX+AHjeXJGMi1aeddqH7FyjLm42fHkhAR/w4qHwz4T
	E7rnmqi+Z3A2Fi5gq1Z76HJeRAOxd9lnLp52YsQ+CMTXInAvUh49JC2q4Mly796NHnXEA0
	Fevr7xn0XQKuV+XlMnfX0V5sxSTPw19mm0+ORX3JYvO2X4NeQT0BNZ1g7DGvMntkMNxhk4
	6B9S+wS6xTsp/RZCcip7DlcH5qnEGiBVbRFBjLtbO6hRCD63v8rOf+u5MrfkJKXCc4o1s2
	YFIfVMCP3CfTkJmyEB3/pmVVfRuKC2SdugHDXJliD870rkS46tVcS3qSHsjFTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763136142;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mo/E9U0Q5CDi6BorXZGuTjfHe7B4Gso4VX3TrudaekY=;
	b=9RXq+39uXLT7DmWXFo0zZmgbGcEtAC43UHM+tU6kvn8GZnB/fK41MXMiEuiYciZbo3nWMZ
	Tpc79hYJEWO50SBQ==
From: "tip-bot2 for Eslam Khafagy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] posix-timers: Plug potential memory leak in
 do_timer_create()
Cc: syzbot+9c47ad18f978d4394986@syzkaller.appspotmail.com,
 Cyrill Gorcunov <gorcunov@gmail.com>,
 Eslam Khafagy <eslam.medhat1993@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251114122739.994326-1-eslam.medhat1993@gmail.com>
References: <20251114122739.994326-1-eslam.medhat1993@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176313614130.498.17182887909136117382.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     e0fd4d42e27f761e9cc82801b3f183e658dc749d
Gitweb:        https://git.kernel.org/tip/e0fd4d42e27f761e9cc82801b3f183e658d=
c749d
Author:        Eslam Khafagy <eslam.medhat1993@gmail.com>
AuthorDate:    Fri, 14 Nov 2025 14:27:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 14 Nov 2025 16:58:31 +01:00

posix-timers: Plug potential memory leak in do_timer_create()

When posix timer creation is set to allocate a given timer ID and the
access to the user space value faults, the function terminates without
freeing the already allocated posix timer structure.

Move the allocation after the user space access to cure that.

[ tglx: Massaged change log ]

Fixes: ec2d0c04624b3 ("posix-timers: Provide a mechanism to allocate a given =
timer ID")
Reported-by: syzbot+9c47ad18f978d4394986@syzkaller.appspotmail.com
Suggested-by: Cyrill Gorcunov <gorcunov@gmail.com>
Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://patch.msgid.link/20251114122739.994326-1-eslam.medhat1993@gmail=
.com
Closes: https://lore.kernel.org/all/69155df4.a70a0220.3124cb.0017.GAE@google.=
com/T/
---
 kernel/time/posix-timers.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index aa31201..56e17b6 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -475,12 +475,6 @@ static int do_timer_create(clockid_t which_clock, struct=
 sigevent *event,
 	if (!kc->timer_create)
 		return -EOPNOTSUPP;
=20
-	new_timer =3D alloc_posix_timer();
-	if (unlikely(!new_timer))
-		return -EAGAIN;
-
-	spin_lock_init(&new_timer->it_lock);
-
 	/* Special case for CRIU to restore timers with a given timer ID. */
 	if (unlikely(current->signal->timer_create_restore_ids)) {
 		if (copy_from_user(&req_id, created_timer_id, sizeof(req_id)))
@@ -490,6 +484,12 @@ static int do_timer_create(clockid_t which_clock, struct=
 sigevent *event,
 			return -EINVAL;
 	}
=20
+	new_timer =3D alloc_posix_timer();
+	if (unlikely(!new_timer))
+		return -EAGAIN;
+
+	spin_lock_init(&new_timer->it_lock);
+
 	/*
 	 * Add the timer to the hash table. The timer is not yet valid
 	 * after insertion, but has a unique ID allocated.

