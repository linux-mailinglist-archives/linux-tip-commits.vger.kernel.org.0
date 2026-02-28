Return-Path: <linux-tip-commits+bounces-8303-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA0SG/wMo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8303-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:42:52 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5B71C40FD
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F256D31A170F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD91747DFAC;
	Sat, 28 Feb 2026 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HiTQ1h1z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nh7TuQSX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C4C47DF96;
	Sat, 28 Feb 2026 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292994; cv=none; b=dSKtBgNyhUWmhmTT7MdIFUVd0ozu02dxd3/RkHkhWfwAQ6iydc92AQcGGKnxAL8d0u3Aitea5YmyJIUZ3CoKOYlJQ1liI4q1AkEsShTZIOUq8FnupS9EFYqGiL8P6wmkm224lUS2ada9E7BBo/BQDLeNoTiGGy0JUSy9q+1wExs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292994; c=relaxed/simple;
	bh=cMFsGS/WbYbMRNxxPBfgcp9FOiT5vSXKjq0Se9vuQlQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Bn43goSJQfbQ7JRCblcN59yV8ESZ4y5ICwqGvfr/se8PaPyVZutMQUtB1mu7ylxWruvABadmB6i4OxFE+33hWQKHk3uCPHXsEUAo6vvrF71WCQyk2pNx21nyWet68hHCVUVu8R21GC2KArs4t2LwiNX6YRkgdktaVxh0DXAZcVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HiTQ1h1z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nh7TuQSX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292991;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAKOyU/YKV8AhKEOW2YwGv/EnW+L3iYiWjuzkQiuwHY=;
	b=HiTQ1h1zRuA9Vk29jcExdpJx00fB7F2xwYJ03GUYtLiElR2BRtQbdFLlwZ5W51wjxfGR8o
	AlOLCLDPy+hequkjLsy2UJeG+Ed8IL1uqw8qd079LXDo/DiKE5dhlU52J9ul4ghMEdlX+Q
	zJJxPiD0nxCc/f/+0geunnqtQoxxVJLzvziX6PUYYVSDBnvnOesEtNXZV4akLaxa6ba37t
	7XBo6O1AxeN0uDTc5jFofbqNEqbsugMZVhuo2DYXrHVwStcoUuBZ/S3Sz/Du2EwpA12zVc
	EsVHfV9knWtr01DyyNAVZvR7+IGHShIit/I/oXvr50dsQVQ5P52rM6tdY7C+YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292991;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAKOyU/YKV8AhKEOW2YwGv/EnW+L3iYiWjuzkQiuwHY=;
	b=nh7TuQSXpzFcpbyy/Op7uVVOGBqsTB283+BZV3qbS/1X+98cz8204X3Ak0T7Vp4H9VhDvn
	RiJw8b7S7Mx59+DQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Add hrtimer_rearm tracepoint
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163430.803669745@kernel.org>
References: <20260224163430.803669745@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229299064.1647592.1078598940212759533.tip-bot2@tip-bot2>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8303-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: BF5B71C40FD
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     8e10f6b81afbf60e48bb4a71676ede4c7e374e79
Gitweb:        https://git.kernel.org/tip/8e10f6b81afbf60e48bb4a71676ede4c7e3=
74e79
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:37:43 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:12 +01:00

hrtimer: Add hrtimer_rearm tracepoint

Analyzing the reprogramming of the clock event device is essential to debug
the behaviour of the hrtimer subsystem especially with the upcoming
deferred rearming scheme.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163430.803669745@kernel.org
---
 include/trace/events/timer.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index ab9a938..a54613f 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -325,6 +325,30 @@ DEFINE_EVENT(hrtimer_class, hrtimer_cancel,
 );
=20
 /**
+ * hrtimer_rearm - Invoked when the clockevent device is rearmed
+ * @next_event:	The next expiry time (CLOCK_MONOTONIC)
+ */
+TRACE_EVENT(hrtimer_rearm,
+
+	TP_PROTO(ktime_t next_event, bool deferred),
+
+	TP_ARGS(next_event, deferred),
+
+	TP_STRUCT__entry(
+		__field( s64,		next_event	)
+		__field( bool,		deferred	)
+	),
+
+	TP_fast_assign(
+		__entry->next_event	=3D next_event;
+		__entry->deferred	=3D deferred;
+	),
+
+	TP_printk("next_event=3D%llu deferred=3D%d",
+		  (unsigned long long) __entry->next_event, __entry->deferred)
+);
+
+/**
  * itimer_state - called when itimer is started or canceled
  * @which:	name of the interval timer
  * @value:	the itimers value, itimer is canceled if value->it_value is

