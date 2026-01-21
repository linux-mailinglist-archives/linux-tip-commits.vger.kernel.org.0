Return-Path: <linux-tip-commits+bounces-8085-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFY6BP4GcWmPcQAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8085-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 18:03:58 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7B15A46F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 18:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A26BACD815
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C63A9009;
	Wed, 21 Jan 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CtNS3XhH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YROCuZQX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4D30FC05;
	Wed, 21 Jan 2026 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010630; cv=none; b=iUmSvibtqFexlRMB9fFaFKQ6bBYohok0mbKQNXibh8VBsL6yVDlVDdC/jRFkjc4tLL1gkQvpjQXp0f9eAG8S94PdNvVEjfjl/+tfNnbanfLexLM9VR+pCGSVBTIu2j+ws3zoE/V3+fwkgW3BLy5cqlg4cHi7/pfTrbZGwk/Bv7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010630; c=relaxed/simple;
	bh=Ka70t9Xnj/3hhnz2BBugdRa4CaqLyzoTg0hlY8FLuU8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Do6Z6n0O/id7al+X74aW3almRuSmFQqEm+x0ryZn1G+/+u33va424wRwJjFHgBLOlXoMPTopAT03uX9xE7A6tM069iqaHwjw32Hfz/KXTEVEcdmNql79IdNTbn46C4K3ZH7/UL2pVo8cRDWEXZvdZEjXCv3EYNxguRp0SjGMUR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CtNS3XhH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YROCuZQX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 Jan 2026 15:50:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769010626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lvk/AVOFaFRpw4T8zXvff75F2m4XNCW9M5bUN6SDusw=;
	b=CtNS3XhHFHusm+ZhBXampabjJ/TDSTxy9K+dTRdburS49ihEd0GmlrOMKnxhGbOu6iKzsv
	kgiPA3D+uyN2dV3SjFjMFhv0z/PJLDmjvb0QaIUL5NreMO7rKJc35tJ3kfgr01X7B4GjeV
	bl/s2UvcuenzFtOCF3iPox7b/AukOukgi14Im/l98/74hVVCBVIOZKDweKUNDI3sZJEnM0
	mGtlUyuqrZqiOpJb0Ej6xgpTNYhUq0hbunB2NgbAqfgtd1TxOjy8AZincAHSbCOuQNLNRa
	w4H1Z7GJ7qHJhHygaFF60S7KwP5p1ftX7BM+bezi2xdxJdaKcFTmUgg/0SA4jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769010626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lvk/AVOFaFRpw4T8zXvff75F2m4XNCW9M5bUN6SDusw=;
	b=YROCuZQXEGENUoPY/yhuJPTLlhzbOM2wN5Ov1+UJSOXUSj1JhfUvPN2nGa1kcRsY/R+lI4
	N+fJZg/uHT9z/4Dg==
From: "tip-bot2 for Will Rosenberg" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf: Fix refcount warning on event->mmap_count increment
Cc: Peter Zijlstra <peterz@infradead.org>, Will Rosenberg <whrosenb@asu.edu>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260119184956.801238-1-whrosenb@asu.edu>
References: <20260119184956.801238-1-whrosenb@asu.edu>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176901062532.510.14910823813937261424.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,vger.kernel.org:replyto,linutronix.de:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,msgid.link:url];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8085-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 6D7B15A46F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     d06bf78e55d5159c1b00072e606ab924ffbbad35
Gitweb:        https://git.kernel.org/tip/d06bf78e55d5159c1b00072e606ab924ffb=
bad35
Author:        Will Rosenberg <whrosenb@asu.edu>
AuthorDate:    Mon, 19 Jan 2026 11:49:56 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 Jan 2026 16:28:58 +01:00

perf: Fix refcount warning on event->mmap_count increment

When calling refcount_inc(&event->mmap_count) inside perf_mmap_rb(), the
following warning is triggered:

        refcount_t: addition on 0; use-after-free.
        WARNING: lib/refcount.c:25

PoC:

    struct perf_event_attr attr =3D {0};
    int fd =3D syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
    mmap(NULL, 0x3000, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    int victim =3D syscall(__NR_perf_event_open, &attr, 0, -1, fd,
                         PERF_FLAG_FD_OUTPUT);
    mmap(NULL, 0x3000, PROT_READ | PROT_WRITE, MAP_SHARED, victim, 0);

This occurs when creating a group member event with the flag
PERF_FLAG_FD_OUTPUT. The group leader should be mmap-ed and then mmap-ing
the event triggers the warning.

Since the event has copied the output_event in perf_event_set_output(),
event->rb is set. As a result, perf_mmap_rb() calls
refcount_inc(&event->mmap_count) when event->mmap_count =3D 0.

Disallow the case when event->mmap_count =3D 0. This also prevents two
events from updating the same user_page.

Fixes: 448f97fba901 ("perf: Convert mmap() refcounts to refcount_t")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Rosenberg <whrosenb@asu.edu>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260119184956.801238-1-whrosenb@asu.edu
---
 kernel/events/core.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5b5cb62..a0fa488 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6997,6 +6997,15 @@ static int perf_mmap_rb(struct vm_area_struct *vma, st=
ruct perf_event *event,
 		if (data_page_nr(event->rb) !=3D nr_pages)
 			return -EINVAL;
=20
+		/*
+		 * If this event doesn't have mmap_count, we're attempting to
+		 * create an alias of another event's mmap(); this would mean
+		 * both events will end up scribbling the same user_page;
+		 * which makes no sense.
+		 */
+		if (!refcount_read(&event->mmap_count))
+			return -EBUSY;
+
 		if (refcount_inc_not_zero(&event->rb->mmap_count)) {
 			/*
 			 * Success -- managed to mmap() the same buffer

