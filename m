Return-Path: <linux-tip-commits+bounces-7376-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B98ECC651E8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 17:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C6FF728A42
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 16:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D382F2D77F1;
	Mon, 17 Nov 2025 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V5JTmhbE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XGo6iXo5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D720A2D594A;
	Mon, 17 Nov 2025 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396621; cv=none; b=DjtpwxWeOV7emYym0iV4Idr7MqFtHNDHKu4tE+tdUqLPRGVUdtleuvxmhER4XYwdJByrS/nG0bu9MjLkxVGcGw4FiA1BeuVHpuZRF+wiv8q2PayMFBcjKBh4pxJpzEM8B0snpwo3JcV9dDK2CIvbFBcbI0cKF4lkjiMGL72Vviw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396621; c=relaxed/simple;
	bh=qwmIzPOBqZLBCFfWHq/5fuucMOSsoO460Yd+kTugVk0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tnXdFZS+pfcdTxeHBwDpm8PvhjsRj8i8hTru3RvZxnbWDv25POPA15w4vkLP8roYxtBkpt8thKwg/ytTY2zUwAd4fyLD4StcN5Da7ltb9/wZYA71eVmXpnuY6wEgmRstMcmfw5WrjGeNdxXBjUTpqwoSnwE6wcUKWuu4bFheBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V5JTmhbE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XGo6iXo5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Nov 2025 16:23:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763396618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQ2MGQlVoda+95opyWnnB8M68DbAyFyzpRNcytKEk4Y=;
	b=V5JTmhbEQnOWKcB7NENBik62KQtol5GE3pklph6ESxboJSPaHv6UCmMkkS3Rf/lum90h9P
	cWjWG9gq3e2HYCBA/lo4XgDbwlogqadzLtq5cfX/hS+EJYKDR99Kh/A+hy2BflVZ4lDaeG
	blDqgzyzN71RRnFIM0KHQ/wEeJNUrp7X4yV4IyyJAW8UKkqR94cDyf8HAr/g1w05cSE+an
	wMSB7fYaQZpL634Mq3lBxzuZrqv+uESmjqiSb8Hqp7MEGaKSuFqPxspP5f3gacpAOCTpob
	4kHwC7h8lqMqhAm897EVElEc/4kuAqxwARLPLHmCjY6yG55bh8izIvy92Enxpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763396618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQ2MGQlVoda+95opyWnnB8M68DbAyFyzpRNcytKEk4Y=;
	b=XGo6iXo54biQrYZuL4N7GG10GYdJV3HHm0sX+Vp3MBgSGFqBoLhJD/LrxVVxD8c/5r+69E
	RqrDYNAUmcb6MyAQ==
From: "tip-bot2 for Phil Auld" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Increase sched_tick_remote timeout
Cc: Frederic Weisbecker <frederic@kernel.org>, Phil Auld <pauld@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250911161300.437944-1-pauld@redhat.com>
References: <20250911161300.437944-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176339661733.498.9804936328865542931.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     aaab6bb54ab9bc4c37ff33b816031918d2760517
Gitweb:        https://git.kernel.org/tip/aaab6bb54ab9bc4c37ff33b816031918d27=
60517
Author:        Phil Auld <pauld@redhat.com>
AuthorDate:    Thu, 11 Sep 2025 12:13:00 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Nov 2025 17:13:15 +01:00

sched: Increase sched_tick_remote timeout

Increase the sched_tick_remote WARN_ON timeout to remove false
positives due to temporarily busy HK cpus. The suggestion
was 30 seconds to catch really stuck remote tick processing
but not trigger it too easily.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://patch.msgid.link/20250911161300.437944-1-pauld@redhat.com
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 68f19aa..699db3f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5619,7 +5619,7 @@ static void sched_tick_remote(struct work_struct *work)
 				 * reasonable amount of time.
 				 */
 				u64 delta =3D rq_clock_task(rq) - curr->se.exec_start;
-				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 30);
 			}
 			curr->sched_class->task_tick(rq, curr, 0);
=20

