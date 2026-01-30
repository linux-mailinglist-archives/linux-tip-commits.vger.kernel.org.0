Return-Path: <linux-tip-commits+bounces-8154-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KETHEtgsfWmYQgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8154-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 23:12:40 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED6ABF0BE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 23:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60CFC300E726
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 22:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A3037AA64;
	Fri, 30 Jan 2026 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="boTZRv16";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xAzgJyZw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1203E155757;
	Fri, 30 Jan 2026 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811125; cv=none; b=CqomRSTDdnCAhZM/4UdapO+QC/bgEH+7l9MATrG0cZYk8GNYtO1jWTaewtb4RoO/BLn7dyzyjVmhfhmGi3KLJ6IWCtyQ6aSCS57tz9IN/zt6ooIA6tb7HWhqPl1GpS967JvesOHIwX5PaUjOizUT/odJ6rZBiXz8wUdGBuvmsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811125; c=relaxed/simple;
	bh=BvTXWL3Cruj7I4z1VCKd5m4wOfI2PtekiwsGWB6QY5s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OKaOF4siMERvsGaqjReVQcLmmNntY9OfVve5ZWvvDoEN/t/FeCzuN3gKycJ8Fsv2s+IzWXcoPCsmdtEIvSky7itby/+pMk/GurCpBW77oTt0XokYeV8EcZvgY7qCZ54adlPF4K+y+Q9QYesfs0Ls3KqZ6hpTNDdcBqAD9PZjg1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=boTZRv16; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xAzgJyZw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 30 Jan 2026 22:12:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769811122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/qPKRGJkrUmxJVT9vEqA3kL3IBbH43f2gsKUbMgdew=;
	b=boTZRv16gOQ+egaDfaeBhM16R2gJ+boGwMhDubgJMMxHzcvoc68EbxV7l7Eqi1S7EukXIM
	go8NjAyFMbtgC+fsmKUlXHCCvdffn8S2D0ca3dBg2yNbEyca22A/vV2jgsmr4ExbvGSz8+
	1B5Dwow0he2j9A3NjpHjwQsdHEF/eaQq+HXOpNi6n1Jq5d1PXU6JV04a0ALGkv6gDIugJx
	YbrKxJqTBO2ZQBKRGV28AhjDooiQUPIcbKzLfa/R/6zGRmSvjtqpoQHgHueZfwQdYEBuvx
	RONoHQwhbm+4sxXImj1L0s6mdVMOARvoHx66hHIaYnb+KuR9dkQBAvPh0z2ylQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769811122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/qPKRGJkrUmxJVT9vEqA3kL3IBbH43f2gsKUbMgdew=;
	b=xAzgJyZwO9nGC9gy1IP7rIe5fPwcXg3hgDcALvLQedfqMPaNHW4/dO68YMlhqR7bWwoxNr
	T4a2rZyj4iisgVDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Fix 'stuck' dl_server
Cc: Andrea@tip-bot2.tec.linutronix.de,
	Righi@tip-bot2.tec.linutronix.de, arighi@nvidia.com,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20260130124100.GC1079264@noisy.programming.kicks-ass.net>
References: <20260130124100.GC1079264@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176981112143.2495410.4348604834756100373.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8154-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:replyto,msgid.link:url,linutronix.de:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9ED6ABF0BE
X-Rspamd-Action: no action

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     115135422562e2f791e98a6f55ec57b2da3b3a95
Gitweb:        https://git.kernel.org/tip/115135422562e2f791e98a6f55ec57b2da3=
b3a95
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 30 Jan 2026 13:41:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 30 Jan 2026 23:06:06 +01:00

sched/deadline: Fix 'stuck' dl_server

Andrea reported the dl_server getting stuck for him. He tracked it
down to a state where dl_server_start() saw dl_defer_running=3D=3D1, but
the dl_server's job is no longer valid at the time of
dl_server_start().

In the state diagram this corresponds to [4] D->A (or dl_server_stop()
due to no more runnable tasks) followed by [1], which in case of a
lapsed deadline must then be A->B.

Now our A has dl_defer_running=3D=3D1, while B demands
dl_defer_running=3D=3D0, therefore it must get cleared when the CBS wakeup
rules demand a replenish.

Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Reported-by: Andrea Righi arighi@nvidia.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: Andrea Righi arighi@nvidia.com
Link: https://lkml.kernel.org/r/20260123161645.2181752-1-arighi@nvidia.com
Link: https://patch.msgid.link/20260130124100.GC1079264@noisy.programming.kic=
ks-ass.net
---
 kernel/sched/deadline.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c509f2e..7bcde71 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1034,6 +1034,12 @@ static void update_dl_entity(struct sched_dl_entity *d=
l_se)
 			return;
 		}
=20
+		/*
+		 * When [4] D->A is followed by [1] A->B, dl_defer_running
+		 * needs to be cleared, otherwise it will fail to properly
+		 * start the zero-laxity timer.
+		 */
+		dl_se->dl_defer_running =3D 0;
 		replenish_dl_new_period(dl_se, rq);
 	} else if (dl_server(dl_se) && dl_se->dl_defer) {
 		/*
@@ -1655,6 +1661,12 @@ void dl_server_update(struct sched_dl_entity *dl_se, s=
64 delta_exec)
  *   dl_server_active =3D 1;
  *   enqueue_dl_entity()
  *     update_dl_entity(WAKEUP)
+ *       if (dl_time_before() || dl_entity_overflow())
+ *         dl_defer_running =3D 0;
+ *         replenish_dl_new_period();
+ *           // fwd period
+ *           dl_throttled =3D 1;
+ *           dl_defer_armed =3D 1;
  *       if (!dl_defer_running)
  *         dl_defer_armed =3D 1;
  *         dl_throttled =3D 1;

