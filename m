Return-Path: <linux-tip-commits+bounces-8249-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLdeKOhrnWnhPwQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8249-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:14:16 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 041F118460F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9028F30B6F38
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 09:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B920136A025;
	Tue, 24 Feb 2026 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fHWXfGyV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SiH32dV8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C6036B073;
	Tue, 24 Feb 2026 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924406; cv=none; b=ek90+aGrD1P2L3LhrJf/h08AltDW5bpzoMezK2Z4m3zPGttRC97Z06pqNNBbMuvUX/CkPT858d52N8UkaYMoh426dgKHaYmOLlGqn6ApSOOXKglP5iZ/3DQM34exveIL9x4btpuTDK5Frum0EdKl5QjOlzAS1vb+UvgbiTFTYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924406; c=relaxed/simple;
	bh=DJWu2dAufeocvDnkQDGSHDBRU+t6xYfvZ/10VvqSkBc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=FM68WtJvVcH6h8yunXmx28UrDAGK1NICbSr9HNj67TYU/iEUhN6COnUcvBs0ogdQ/ZZxNLIJbtFyBPNTx4Pmt1YBXpUo6MXMERUhfcNAPY9KSwHGpec8LIQTiMUQSBQxT/YGwj/AbgFaD04OrbYPghAaGZ7gKyyLcK2SOkbQ1ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fHWXfGyV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SiH32dV8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 09:13:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771924401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9EMUl7BOfIMHwJj+YS6OWH4c7x7O7/l4cKduHmrOP1M=;
	b=fHWXfGyVq2gBJNt2dGbTnc/DT0OSeo6V3/LdPy0Q8/1IOevvP9QAc+hHWfbL60UKfS0ELR
	R6OL8W7usnpl5R2tyb7Vi537m0lUGzXPb5aBdtgBcVVbLESnioq3UdiKFoXxwWybFDOyjd
	Ddv6MCciV9rsIwQQ326mgYpmMJbytZfATpYDMrAUGa/4ayU/ebLdNzegNIYQ9fp0Vz1LXM
	gfz+8Dr0wWOPl7dHv2hyP7q9IxmeLJS2fB4/oc80QNFWSaU2sSLHRKbyaxODEzORMmqxCJ
	P3GEcLZyBEJ58rkYlZ2mlVIZVMsgolTesk78OZiCeQzmbAnTminhHd9XzLLgTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771924401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9EMUl7BOfIMHwJj+YS6OWH4c7x7O7/l4cKduHmrOP1M=;
	b=SiH32dV8JmN9JHKhP56Gq2TmQK++O/ItIhVJvS4kZmPT6jXL20GXjmgmQuackn4h/DEEVT
	ZPMXHvKosNgLZeCw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use full weight to __calc_delta()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177192439980.1647592.13441614490792468961.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8249-lists,linux-tip-commits=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,msgid.link:url,vger.kernel.org:replyto,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,linutronix.de:dkim]
X-Rspamd-Queue-Id: 041F118460F
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     db4551e2ba346663b7b16f0b5d36d308b615c50e
Gitweb:        https://git.kernel.org/tip/db4551e2ba346663b7b16f0b5d36d308b61=
5c50e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 11 Feb 2026 17:07:58 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 18:04:10 +01:00

sched/fair: Use full weight to __calc_delta()

Since we now use the full weight for avg_vruntime(), also make
__calc_delta() use the full value.

Since weight is effectively NICE_0_LOAD, this is 20 bits on 64bit.
This leaves 44 bits for delta_exec, which is ~16k seconds, way longer
than any one tick would ever be, so no worry about overflow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
Link: https://patch.msgid.link/20260219080625.183283814%40infradead.org
---
 kernel/sched/fair.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2b98054..23315c2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -225,6 +225,7 @@ void __init sched_init_granularity(void)
 	update_sysctl();
 }
=20
+#ifndef CONFIG_64BIT
 #define WMULT_CONST	(~0U)
 #define WMULT_SHIFT	32
=20
@@ -283,6 +284,12 @@ static u64 __calc_delta(u64 delta_exec, unsigned long we=
ight, struct load_weight
=20
 	return mul_u64_u32_shr(delta_exec, fact, shift);
 }
+#else
+static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_we=
ight *lw)
+{
+	return (delta_exec * weight) / lw->weight;
+}
+#endif
=20
 /*
  * delta /=3D w

