Return-Path: <linux-tip-commits+bounces-8095-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFIQDxv6cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8095-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:21:15 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE14A6527F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF3708611B9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A6F37F739;
	Thu, 22 Jan 2026 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sQRN2OKp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U4B2FSgk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06808312831;
	Thu, 22 Jan 2026 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076942; cv=none; b=cWS+znIwot22V6HvL92TR8T7r6/omRLXpb15kiyf+03uMaCarzrEKWR0l1tBgc7aaBsUN6zIwwsHeMAlc3kfpqq15Xoa0yhSlhm7o6al/m9EYQnQZtESnfThn92nEFHRJJ6SyM8kMR6ccUDSP8bsrZBTWrpuhdMNZm6CcNs3618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076942; c=relaxed/simple;
	bh=2FdVrCa5m4uBNPeKFRKrFIHKsRUAn8z/QfUOW+3Di0o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KqvfgNfBP7E9B9e3p3s5DyTfOjNksE39cktTSqmknGnSe8uMyHRLJK9kzxrj1Yu2hS0EZBZjdxj5SUYh1Fdxu0ErFlONuyuWyHUtbBCG4W+9sKh8yz0Cj3bYwlNmgE5MxEBUSqsDD4mS1Y9cnemWAGE3QonHmN9Y0ndebTVPKGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sQRN2OKp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U4B2FSgk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:15:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076938;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4d/Gg95IeMFzHJeR8S3kTzTS+TuAQoAIEhR9rwjrvNk=;
	b=sQRN2OKpcuZT6aHbZQcloHn1Wt3FhTN/B9QbKfGSfkbqL2T/0L+ahrj6TKoi3t/3Y8iTjW
	hNRzrDTnZQL0nAkFNoWTw7WswZUQsOmpRBd+aSBUVGz60l2JyJ9nLJG2Pb7BL1LaicE8tl
	iETdpAbkLAQhVQ3INMrEMxKt3eHhWkshLoP4R6F9S2X0iGJv/+3T7ha818o1bEYhUi++R3
	S7irSdN0+ffEw6ryQNxzN5J8jAMmhH8rw/mv2hY9ThUb0dlsadnG+UWBuvMALubTJ/DgA2
	pVBSMByJ53b7zuIKKhMht3o8ChAdGydlVXchC32M6FRQLjIazs5aOhYQRbrzZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076938;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4d/Gg95IeMFzHJeR8S3kTzTS+TuAQoAIEhR9rwjrvNk=;
	b=U4B2FSgkfHeFVbyKRnNV72vhIes4gyWJjmlZhx49AXmS/7ubKhT5EGjufXbGVjDY3AwlFt
	EBmK9PoAE4ZUGyCw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Lower default slice extension
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260121143208.073200729@infradead.org>
References: <20260121143208.073200729@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907693734.510.9935582863534596484.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8095-lists,linux-tip-commits=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,infradead.org:email,linutronix.de:dkim,msgid.link:url]
X-Rspamd-Queue-Id: DE14A6527F
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     21c0e92d0681fbd10ac024311bd09bca439e0bb1
Gitweb:        https://git.kernel.org/tip/21c0e92d0681fbd10ac024311bd09bca439=
e0bb1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 21 Jan 2026 14:25:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:20 +01:00

rseq: Lower default slice extension

Change the minimum slice extension to 5 usec.

Since slice_test selftest reaches a staggering ~350 nsec extension:

Task: slice_test    Mean: 350.266 ns
  Latency (us)    | Count
  ------------------------------
  EXPIRED         | 238
  0 us            | 143189
  1 us            | 167
  2 us            | 26
  3 us            | 11
  4 us            | 28
  5 us            | 31
  6 us            | 22
  7 us            | 23
  8 us            | 32
  9 us            | 16
  10 us           | 35

Lower the minimal (and default) value to 5 usecs -- which is still massive.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260121143208.073200729@infradead.org
---
 Documentation/userspace-api/rseq.rst | 2 +-
 kernel/rseq.c                        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/rseq.rst b/Documentation/userspace-a=
pi/rseq.rst
index 29af6c3..468f6bb 100644
--- a/Documentation/userspace-api/rseq.rst
+++ b/Documentation/userspace-api/rseq.rst
@@ -79,7 +79,7 @@ slice extension by setting rseq::slice_ctrl::request to 1. =
If the thread is
 interrupted and the interrupt results in a reschedule request in the
 kernel, then the kernel can grant a time slice extension and return to
 userspace instead of scheduling out. The length of the extension is
-determined by debugfs:rseq/slice_ext_nsec. The default value is 10 usec; whi=
ch
+determined by debugfs:rseq/slice_ext_nsec. The default value is 5 usec; which
 is the minimum value. It can be incremented to 50 usecs, however doing so
 can/will affect the minimum scheduling latency.
=20
diff --git a/kernel/rseq.c b/kernel/rseq.c
index e423a9b..b0973d1 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -517,7 +517,7 @@ struct slice_timer {
 	void		*cookie;
 };
=20
-static const unsigned int rseq_slice_ext_nsecs_min =3D 10 * NSEC_PER_USEC;
+static const unsigned int rseq_slice_ext_nsecs_min =3D  5 * NSEC_PER_USEC;
 static const unsigned int rseq_slice_ext_nsecs_max =3D 50 * NSEC_PER_USEC;
 unsigned int rseq_slice_ext_nsecs __read_mostly =3D rseq_slice_ext_nsecs_min;
 static DEFINE_PER_CPU(struct slice_timer, slice_timer);

