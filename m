Return-Path: <linux-tip-commits+bounces-6380-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 331ABB37AA9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 08:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F20D04E1E22
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 06:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E983148BD;
	Wed, 27 Aug 2025 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kbJ2+pgw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AbTDELE3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B733148B6;
	Wed, 27 Aug 2025 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277138; cv=none; b=UKGl8vBB9PraoZ2y7qGn0TlZMYmdiSvYXS+PULIK8sYA1OlW/rM9N7w1lcnfH6WR+UvoEL7PBQKtmfs+7C/Ucj8hGr6quU89DEeCmAKxUXjRQSp7uh5vEjSAm2s2jkvxrdyORgaMvBtLypnadeaPO1Dj9p0jlR1+IUJCJS5d+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277138; c=relaxed/simple;
	bh=9XwfCPDi+UZjzTqSCbyGK/ai0/nErTgKZ6CvRK6VyzI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dgUHb9ojwSGDEcDohDK6RGdPZkvmMoU0ZRvcf+6eKIYmQDuBNxrBjC1vAhKTFV326K5XqNSUa2h3VPBIldyJjsR0fliqCE8BEq1ODQD+dmXJOZgeXhHM3YFY9GnICz6VvhYoeRhrVBhjYe9VnLSpkbZ6krBXm1bdPG5G63S78hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kbJ2+pgw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AbTDELE3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 06:45:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756277135;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ox52PwipwptOv1iZRfWw0p+K14qmzrCSmbCM10l8PE=;
	b=kbJ2+pgwJvVEFwhmu+/lOqK5kR1JPxjOMlBeJ6cwl0ZsRgjiXbWlh6POo95VU+EP4Bdglm
	E41wqsCKlK52NnMFkM4XWYi/cxqSCDBvpYASpXrQ3dSyfkNDD/gWKOttJSQxnvYxI+SzF0
	srAOi/xSKQ5Gq4MO36+M4nb2vOHYXsKgbap+crw3DFBuLp2yqFs/B8vbT6hB/hB0gD7gzq
	TIaQ6KDl6IISf8XqgnKOLU1IWh4jPEmwEu+BnEheQju2tLHONOqI/hYnHQWWDd6m/MvPNE
	MMGQ3PQp5xXVh3mSIMAUBK+qNihYbtFbO53PbuiKg10+Km8mw4CePQJF/pxUww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756277135;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ox52PwipwptOv1iZRfWw0p+K14qmzrCSmbCM10l8PE=;
	b=AbTDELE3MiRRRuZlrYvvcQbJuQP+xrrujcaXX00F0aFZTsSG1ar6awZiRxSExgHNDmO68s
	MDO9ivfirtUpzRDQ==
From: "tip-bot2 for kuyo chang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Fix RT task potential starvation
 when expiry time passed
Cc: kuyo chang <kuyo.chang@mediatek.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jiri Slaby <jirislaby@kernel.org>,
 Diederik de Haas <didi.debian@cknow.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250615131129.954975-1-kuyo.chang@mediatek.com>
References: <20250615131129.954975-1-kuyo.chang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175627713346.1920.3076480184782246210.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     421fc59cf58c64f898cafbbbbda0bc705837e7df
Gitweb:        https://git.kernel.org/tip/421fc59cf58c64f898cafbbbbda0bc70583=
7e7df
Author:        kuyo chang <kuyo.chang@mediatek.com>
AuthorDate:    Sun, 15 Jun 2025 21:10:56 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 26 Aug 2025 10:46:01 +02:00

sched/deadline: Fix RT task potential starvation when expiry time passed

[Symptom]
The fair server mechanism, which is intended to prevent fair starvation
when higher-priority tasks monopolize the CPU.
Specifically, RT tasks on the runqueue may not be scheduled as expected.

[Analysis]
The log "sched: DL replenish lagged too much" triggered.

By memory dump of dl_server:
    curr =3D 0xFFFFFF80D6A0AC00 (
      dl_server =3D 0xFFFFFF83CD5B1470(
        dl_runtime =3D 0x02FAF080,
        dl_deadline =3D 0x3B9ACA00,
        dl_period =3D 0x3B9ACA00,
        dl_bw =3D 0xCCCC,
        dl_density =3D 0xCCCC,
        runtime =3D 0x02FAF080,
        deadline =3D 0x0000082031EB0E80,
        flags =3D 0x0,
        dl_throttled =3D 0x0,
        dl_yielded =3D 0x0,
        dl_non_contending =3D 0x0,
        dl_overrun =3D 0x0,
        dl_server =3D 0x1,
        dl_server_active =3D 0x1,
        dl_defer =3D 0x1,
        dl_defer_armed =3D 0x0,
        dl_defer_running =3D 0x1,
        dl_timer =3D (
          node =3D (
            expires =3D 0x000008199756E700),
          _softexpires =3D 0x000008199756E700,
          function =3D 0xFFFFFFDB9AF44D30 =3D dl_task_timer,
          base =3D 0xFFFFFF83CD5A12C0,
          state =3D 0x0,
          is_rel =3D 0x0,
          is_soft =3D 0x0,
    clock_update_flags =3D 0x4,
    clock =3D 0x000008204A496900,

 - The timer expiration time (rq->curr->dl_server->dl_timer->expires)
   is already in the past, indicating the timer has expired.
 - The timer state (rq->curr->dl_server->dl_timer->state) is 0.

[Suspected Root Cause]
The relevant code flow in the throttle path of
update_curr_dl_se() as follows:

  dequeue_dl_entity(dl_se, 0);                // the DL entity is dequeued

  if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(dl_se))) {
      if (dl_server(dl_se))                   // timer registration fails
          enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);//enqueue immediately
      ...
  }

The failure of `start_dl_timer` is caused by attempting to register a
timer with an expiration time that is already in the past. When this
situation persists, the code repeatedly re-enqueues the DL entity
without properly replenishing or restarting the timer, resulting in RT
task may not be scheduled as expected.

[Proposed Solution]:
Instead of immediately re-enqueuing the DL entity on timer registration
failure, this change ensures the DL entity is properly replenished and
the timer is restarted, preventing RT potential starvation.

Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Closes: https://lore.kernel.org/CAMuHMdXn4z1pioTtBGMfQM0jsLviqS2jwysaWXpoLxWY=
oGa82w@mail.gmail.com
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Jiri Slaby <jirislaby@kernel.org>
Tested-by: Diederik de Haas <didi.debian@cknow.org>
Link: https://lkml.kernel.org/r/20250615131129.954975-1-kuyo.chang@mediatek.c=
om
---
 kernel/sched/deadline.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index bb813af..88c3bd6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1496,10 +1496,12 @@ throttle:
 		}
=20
 		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(dl_se))) {
-			if (dl_server(dl_se))
-				enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
-			else
+			if (dl_server(dl_se)) {
+				replenish_dl_new_period(dl_se, rq);
+				start_dl_timer(dl_se);
+			} else {
 				enqueue_task_dl(rq, dl_task_of(dl_se), ENQUEUE_REPLENISH);
+			}
 		}
=20
 		if (!is_leftmost(dl_se, &rq->dl))

