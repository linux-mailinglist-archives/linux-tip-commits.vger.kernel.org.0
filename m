Return-Path: <linux-tip-commits+bounces-7751-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E73DACC7D43
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 14:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91378300DBB0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D98D34A784;
	Wed, 17 Dec 2025 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QKyh7rvm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lRYm2OK1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60A34A3B0;
	Wed, 17 Dec 2025 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975101; cv=none; b=cSzMyalMRfeyFi7e4ES24OWq3Oh2VTAiQqX1mTuaiEtEWaytG0umqzdqz9k1JcsIJHgClgOwr6mjHqe0SMss8vx01dx2/gxvEkxq7KDH13pfw1v33mQFFor7R1cGkuWSauJhU4OvkjJdJhPahNa6huO1AJr6gPVSQph4mre4kQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975101; c=relaxed/simple;
	bh=/CX5btYMfSQDqvkEuUQwgdpu3bhfEHC1liks4BSuT4c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DuokhoMVSsWCqrYvOyJQqeyJN7V544zGbkA+vFOxLEpxeCR9iaaxQ89HLPIFd5bnyjEKJjINuF44LTzp7GGzKDtoprE75JCMNGKvrUXemeNNkVOTxcPvmj97ifQ5CoYKFcAevxqcuZHJLCAUQZqYQkEO40ZLrRcrlH0Yusav7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QKyh7rvm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lRYm2OK1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975097;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkYsvYA4BVbfv6N5XOZGkRE/GAS4ynE4iz4LTA3QQbM=;
	b=QKyh7rvmCx40PBQj69pis2iJCO3VujVrOvqDv1gs++dO+ARrkUQcOqkuvCvn2NujuHw868
	mHAyB+qdnGWYh01FGnYBWJn5DWuDas+GMS6Tzay0MyrJe84KY9nwhGQ9GR8OdV23eFHBmR
	AqwLg8qgz0vN12aK8v3OhC2CFubTpaIerVl8V7HDigNX2APzgwRdbr6qRF7aFRRwluXmq7
	KS+U3eIzt3l50/kd1TnXVJl6c9n+V1OWH3kVznHlajgRIkTj0Ua1jIJToLEKveYUlZ4RI5
	IqIX82UHBJ2Ia8zE0tF/yYesKRoxocJLw5Mdcw5i59Xmkv1v+vgBkpQxS/My4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975097;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkYsvYA4BVbfv6N5XOZGkRE/GAS4ynE4iz4LTA3QQbM=;
	b=lRYm2OK1cseQc1RJYbZhVXJ1WTdHmlTMrLessKMoKsdeRYJcPKBJWgWsRUFk3914xxkweo
	wJNDygLjNyM+HfBg==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf: Move security_perf_event_free() call to __free_event()
Cc: Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Xudong Hao <xudong.hao@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251206001720.468579-4-seanjc@google.com>
References: <20251206001720.468579-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597509645.510.5364980686283921892.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     991bdf7e9d6cc74c1de215d1a05c23ff61076bf0
Gitweb:        https://git.kernel.org/tip/991bdf7e9d6cc74c1de215d1a05c23ff610=
76bf0
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Fri, 05 Dec 2025 16:16:39 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:04 +01:00

perf: Move security_perf_event_free() call to __free_event()

Move the freeing of any security state associated with a perf event from
_free_event() to __free_event(), i.e. invoke security_perf_event_free() in
the error paths for perf_event_alloc().  This will allow adding potential
error paths in perf_event_alloc() that can occur after allocating security
state.

Note, kfree() and thus security_perf_event_free() is a nop if
event->security is NULL, i.e. calling security_perf_event_free() even if
security_perf_event_alloc() fails or is never reached is functionality ok.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Link: https://patch.msgid.link/20251206001720.468579-4-seanjc@google.com
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fab358d..6973483 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5601,6 +5601,8 @@ static void __free_event(struct perf_event *event)
 {
 	struct pmu *pmu =3D event->pmu;
=20
+	security_perf_event_free(event);
+
 	if (event->attach_state & PERF_ATTACH_CALLCHAIN)
 		put_callchain_buffers();
=20
@@ -5664,8 +5666,6 @@ static void _free_event(struct perf_event *event)
=20
 	unaccount_event(event);
=20
-	security_perf_event_free(event);
-
 	if (event->rb) {
 		/*
 		 * Can happen when we close an event with re-directed output.

