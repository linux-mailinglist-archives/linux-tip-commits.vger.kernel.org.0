Return-Path: <linux-tip-commits+bounces-8146-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNPpDvRzfGmAMwIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8146-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 10:03:48 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89674B8B25
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 10:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96456300CE67
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 09:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4332C32D7FB;
	Fri, 30 Jan 2026 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XCGW8T0s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HOyK8yzn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCFA258CE7;
	Fri, 30 Jan 2026 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769763796; cv=none; b=Rd7VoAz3VxdaU2HQzLhnsln4fG/Wv6VSimZEqrwZUm7TGTuy4vHUA9KW4uZ9BZHozfVLVfRNvBXM1m+d96KuwDfXCjwSI+WpcyHetFE3p4V4enBXDYEK7siNoQsPC05rT6b0yMa286aq1C+yjBrZLd4DYCxrbXp0SONoy4rrKq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769763796; c=relaxed/simple;
	bh=fd+a0tJdPyrdsZxfcRxiGtmIV2qleJetn1Qi5GgWG6I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VLS3Cu2tpEp+4FxarkDkjK4mhqKJaROU5+VpHmOb9JzRa7loH8dMhbg7fNPTCWjGixneRGFG29MyrhPvi0GcDm4FaobjhJVaEHgkGOuwWOT/a1V9syvB9j9R76MtM0lcyWrGKncRMJsHuo4FkGimMxw5uQb4PqYbiagbG9/C2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XCGW8T0s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HOyK8yzn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 30 Jan 2026 09:03:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769763793;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZjhgiJeedvLqBRk6t+/QuImXBGcfBbrru8hvi5pjuQ=;
	b=XCGW8T0s5PSMxhsAzugzbbdkNo7nrbgXwc7r9+0SOZeFJvCHjCLNZg52KiGyI/jpydTVO3
	I8fshl70nVxXC/F8GXBfhTRQK62VC8hX7QA+1JWBG5axtZkKj8g6XrstE67HeHGZBiTjev
	dCkE8Ibcl4ZUPWol4bdDD3awazUMnfebA0r2QuriTaCWWO2WMm/26stErWZ0osjpYk/7Pn
	2RtAWnyL5GsnlZihmklPJa89kBIeZdVwNYLxHd/9Yz2JMuZ6E/08Z835cpXrMgtgw8ullI
	BP35Y93c1dM3l97z6Wid8X/83Urg7zb08OwqmGZAK0/G4szj7H0B8FKApMdjjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769763793;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZjhgiJeedvLqBRk6t+/QuImXBGcfBbrru8hvi5pjuQ=;
	b=HOyK8yzny99LZv0JBh4Np54IblTsuJp15Ryork+h0O864l2HgBMmcH1hLWMGtGESvZVlrq
	6gOehcxZ2rwgd0CQ==
From: "tip-bot2 for Ionut Nechita (Sunlight Linux)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/nohz: Optimize check_tick_dependency() with
 early return
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Ionut Nechita <ionut_n2001@yahoo.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260128074558.15433-3-sunlightlinux@gmail.com>
References: <20260128074558.15433-3-sunlightlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176976379185.2495410.11245114356600942879.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8146-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:email,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,yahoo.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 89674B8B25
X-Rspamd-Action: no action

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8f9e1849402b34744cf3e4c8174b1907d1f99fe3
Gitweb:        https://git.kernel.org/tip/8f9e1849402b34744cf3e4c8174b1907d1f=
99fe3
Author:        Ionut Nechita (Sunlight Linux) <sunlightlinux@gmail.com>
AuthorDate:    Wed, 28 Jan 2026 09:45:43 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 30 Jan 2026 09:59:34 +01:00

tick/nohz: Optimize check_tick_dependency() with early return

There is no point in iterating through individual tick dependency bits when
the tick_stop tracepoint is disabled, which is the common case.

When the trace point is disabled, return immediately based on the atomic
value being zero or non-zero, skipping the per-bit evaluation.

This optimization improves the hot path performance of tick dependency
checks across all contexts (idle and non-idle), not just nohz_full CPUs.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260128074558.15433-3-sunlightlinux@gmail.com
---
 kernel/time/tick-sched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8ddf74e..fd928d3 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -344,6 +344,9 @@ static bool check_tick_dependency(atomic_t *dep)
 {
 	int val =3D atomic_read(dep);
=20
+	if (likely(!tracepoint_enabled(tick_stop)))
+		return !val;
+
 	if (val & TICK_DEP_MASK_POSIX_TIMER) {
 		trace_tick_stop(0, TICK_DEP_MASK_POSIX_TIMER);
 		return true;

