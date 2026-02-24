Return-Path: <linux-tip-commits+bounces-8252-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E5KIQNtnWkkQAQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8252-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:18:59 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1440B184706
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5195431B1102
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 09:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9A236C5B9;
	Tue, 24 Feb 2026 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qlx79k8D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pUQiiiSH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B5A36BCD8;
	Tue, 24 Feb 2026 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924407; cv=none; b=NifAvSkxwOPrZhoO5kIOUhc3Mjojz4kjpBFUvsIoq/ZczI9a46HVJICaUhP8Fk2fxTrSUhAr7hY8gDr5dMSCu4dB1Xypkk3ow83Cee9u/n3o7cw7D3zUI3PrdTleSDUXciNYbHDK8ch3UdM2uqRR7YMH4zqn4rsjLsp1BabShvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924407; c=relaxed/simple;
	bh=SfDAKICzM2yLUAOzsl7m+GpTlcW2J4GYjFxyuUy3+yQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NXk7UjJFaHjddSchs8hSKliLL6/8yH6PuNvXh3qFiyV2dmZGXfrvIYYu7HJdvVPEV1GEOY3Z9/FoOCjrj0MFiX57UbzY4zoIy8lKn751GOaP+B3JLO1Ws2Dz11HVk7hp/okAn7q0QwFTmU2Upv5fMvgQKQq/MIh+h1sqPl9nHVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qlx79k8D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pUQiiiSH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 09:13:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771924404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrFXH0hHyI/CWEN2P+kjQCMg1+Nz/o3W7b+gx738e1s=;
	b=Qlx79k8DIn5zAiYbSIXoW6dj4/anrp/NO5b//sk+K8hYbxN9qD20MPrQjN5w/OvJMtCAYs
	7woSSe0xD/PpgHBUVyFrUMGC29qw0M1MpXlKBzHq1yEZ9INmBh5wPOR+BNqJDeLvI94ibV
	5Xy9EdqDFO0EEp8ORwu0DYJxTGuqaPULnq09gw2N8JU5mJr99Vvqr5WPqJBMOK69rTiHnO
	CatjCZ3B9LS2W1juIbc1cDJ9qeVCvYlUdSsbfAptwvcyfqzZjXKattfTaMy4bKp82Z8iCm
	jKVRuB60omMAzqK9I5EqxBtC3QBxViw74f3jvPQWk4M0phn0hwAVUfQiYE6XIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771924404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrFXH0hHyI/CWEN2P+kjQCMg1+Nz/o3W7b+gx738e1s=;
	b=pUQiiiSHzk/ZYBYlq1OouA/V8THjjnOGttwuA+k2GUir7Xm5lgqxhaRBMRj/qK8IfjAuBm
	HW6egLOQDL6uerBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: More complex proportional newidle balance
Cc: Mario Roy <marioeroy@gmail.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260127151748.GA1079264@noisy.programming.kicks-ass.net>
References: <20260127151748.GA1079264@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177192440315.1647592.12980900000665697680.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8252-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,infradead.org:email,vger.kernel.org:replyto,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,amazon.com,infradead.org,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 1440B184706
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9fe89f022c05d99c052d6bc088b82d4ff83bf463
Gitweb:        https://git.kernel.org/tip/9fe89f022c05d99c052d6bc088b82d4ff83=
bf463
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 27 Jan 2026 16:17:48 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 18:04:09 +01:00

sched/fair: More complex proportional newidle balance

It turns out that a few workloads (easyWave, fio) have a fairly low
success rate on newidle balance, but still benefit greatly from having
it anyway.

Luckliky these workloads have a faily low newidle rate, so the cost if
doing the newidle is relatively low, even if unsuccessfull.

Add a simple rate based part to the newidle ratio compute, such that
low rate newidle will still have a high newidle ratio.

This cures the easyWave and fio workloads while not affecting the
schbench numbers either (which have a very high newidle rate).

Reported-by: Mario Roy <marioeroy@gmail.com>
Reported-by: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Mario Roy <marioeroy@gmail.com>
Tested-by: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Link: https://patch.msgid.link/20260127151748.GA1079264@noisy.programming.kic=
ks-ass.net
---
 include/linux/sched/topology.h |  1 +
 kernel/sched/fair.c            | 27 +++++++++++++++++++++++++--
 kernel/sched/features.h        |  1 +
 kernel/sched/topology.c        |  3 +++
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 45c0022..a1e1032 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -95,6 +95,7 @@ struct sched_domain {
 	unsigned int newidle_call;
 	unsigned int newidle_success;
 	unsigned int newidle_ratio;
+	u64 newidle_stamp;
 	u64 max_newidle_lb_cost;
 	unsigned long last_decay_max_lb_cost;
=20
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bf948db..66afa0a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12289,7 +12289,30 @@ static inline void update_newidle_stats(struct sched=
_domain *sd, unsigned int su
 	sd->newidle_success +=3D success;
=20
 	if (sd->newidle_call >=3D 1024) {
-		sd->newidle_ratio =3D sd->newidle_success;
+		u64 now =3D sched_clock();
+		s64 delta =3D now - sd->newidle_stamp;
+		sd->newidle_stamp =3D now;
+		int ratio =3D 0;
+
+		if (delta < 0)
+			delta =3D 0;
+
+		if (sched_feat(NI_RATE)) {
+			/*
+			 * ratio  delta   freq
+			 *
+			 * 1024 -  4  s -  128 Hz
+			 *  512 -  2  s -  256 Hz
+			 *  256 -  1  s -  512 Hz
+			 *  128 - .5  s - 1024 Hz
+			 *   64 - .25 s - 2048 Hz
+			 */
+			ratio =3D delta >> 22;
+		}
+
+		ratio +=3D sd->newidle_success;
+
+		sd->newidle_ratio =3D min(1024, ratio);
 		sd->newidle_call /=3D 2;
 		sd->newidle_success /=3D 2;
 	}
@@ -12996,7 +13019,7 @@ static int sched_balance_newidle(struct rq *this_rq, =
struct rq_flags *rf)
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
 			unsigned int weight =3D 1;
=20
-			if (sched_feat(NI_RANDOM)) {
+			if (sched_feat(NI_RANDOM) && sd->newidle_ratio < 1024) {
 				/*
 				 * Throw a 1k sided dice; and only run
 				 * newidle_balance according to the success
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 136a658..37d5928 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -126,3 +126,4 @@ SCHED_FEAT(LATENCY_WARN, false)
  * Do newidle balancing proportional to its success rate using randomization.
  */
 SCHED_FEAT(NI_RANDOM, true)
+SCHED_FEAT(NI_RATE, true)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 32dcdda..061f8c8 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -4,6 +4,7 @@
  */
=20
 #include <linux/sched/isolation.h>
+#include <linux/sched/clock.h>
 #include <linux/bsearch.h>
 #include "sched.h"
=20
@@ -1642,6 +1643,7 @@ sd_init(struct sched_domain_topology_level *tl,
 	struct sched_domain *sd =3D *per_cpu_ptr(sdd->sd, cpu);
 	int sd_id, sd_weight, sd_flags =3D 0;
 	struct cpumask *sd_span;
+	u64 now =3D sched_clock();
=20
 	sd_weight =3D cpumask_weight(tl->mask(tl, cpu));
=20
@@ -1679,6 +1681,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		.newidle_call		=3D 512,
 		.newidle_success	=3D 256,
 		.newidle_ratio		=3D 512,
+		.newidle_stamp		=3D now,
=20
 		.max_newidle_lb_cost	=3D 0,
 		.last_decay_max_lb_cost	=3D jiffies,

