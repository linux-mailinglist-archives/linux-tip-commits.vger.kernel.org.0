Return-Path: <linux-tip-commits+bounces-8106-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HgdBwj8cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8106-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:29:28 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D86A26543E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6487D684C98
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B06840FD83;
	Thu, 22 Jan 2026 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ej/Rmc8n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FQzKM0vM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB643F23CC;
	Thu, 22 Jan 2026 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076974; cv=none; b=GCth8KZuzC5Kw/Ojdbrjt/hQkGwbMHygjNBBwJaNW+yGQoVgZQfsnu6Yt1ow3IgoVbuzJSlSkH0Y8jR5yXQEAffaU2Gabx74fKbx7agDb4LGemtAxjP01TB2Iwynri4h1jpIHtPNZvE3nI3EOOFjkRJIXpDMuCruYs/EcGjhSK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076974; c=relaxed/simple;
	bh=kByp/lDYf5Gf3+XjuZiCbc2jeia9Ng1TY/IbHNlVYas=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FL0B+NQrD1rDoeK8OTvwxh6zbaHP4IFNl9Pk6Ghyids71txiGoq01HyMXHxBhm/MHr3uCwn6U3QJb+y/WD5MgpcF2e75z+3m0CqtuiTeoynGwz9ojkgApL0V9NDvCUnE0T0Ij9WwFztvxPqySbclGkC+pjN4rPpgLI/pQk6Kwjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ej/Rmc8n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FQzKM0vM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:16:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQZodAkFcbIYjnhgXDvcwFXD9M5Pq4wzl3HIvyZlzZI=;
	b=ej/Rmc8n1JvBoiq/l+q11hwpiqwx501x43DJkWvSFdtCwFs5idG2oZqha0GIx2KtbJfvKV
	DTS35k+VD98+IkDTHbzR7smbwhwS+px86wAgE4L98gfWhNGPsmXCzppb2F2q8qZmiRtIXa
	N2RI+5+YKwHEWaEHlcys6o8FPSxftkbfLzGqCoY2ljZ99NmCyGyB7UfAz7jS7DH5lJAeby
	S4fajSFrL1RjRhsye0NJzYxzQclBPcYKSOFngV6ZIMRSS5yzonFXbloJezXF00ku5Ywoy1
	ExX1EzKnUl/0weesrfN9A8KnDkmLsFqrkXAzTFSV/cze6ndJmh38Y2IKJWOTwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQZodAkFcbIYjnhgXDvcwFXD9M5Pq4wzl3HIvyZlzZI=;
	b=FQzKM0vMM8oKw9ZTa98qu/KDg+q4WjNOYEQg85n/tMLcidkZP8kOS2jupq5iZ0BVofZGcN
	hFwAhZbhIuAoT+AA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Add statistics for time slice extensions
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251215155708.795202254@linutronix.de>
References: <20251215155708.795202254@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907696667.510.1401640948476649445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,msgid.link:url,linutronix.de:email,linutronix.de:dkim,vger.kernel.org:replyto];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8106-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: D86A26543E
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b5b8282441bc4f8f1ff505e19d566dbd7b805761
Gitweb:        https://git.kernel.org/tip/b5b8282441bc4f8f1ff505e19d566dbd7b8=
05761
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 15 Dec 2025 17:52:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:17 +01:00

rseq: Add statistics for time slice extensions

Extend the quick statistics with time slice specific fields.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251215155708.795202254@linutronix.de
---
 include/linux/rseq_entry.h |  5 +++++
 kernel/rseq.c              | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index d0ec471..54d8e33 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -15,6 +15,11 @@ struct rseq_stats {
 	unsigned long	cs;
 	unsigned long	clear;
 	unsigned long	fixup;
+	unsigned long	s_granted;
+	unsigned long	s_expired;
+	unsigned long	s_revoked;
+	unsigned long	s_yielded;
+	unsigned long	s_aborted;
 };
=20
 DECLARE_PER_CPU(struct rseq_stats, rseq_stats);
diff --git a/kernel/rseq.c b/kernel/rseq.c
index bf75268..415d75b 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -138,6 +138,13 @@ static int rseq_stats_show(struct seq_file *m, void *p)
 		stats.cs	+=3D data_race(per_cpu(rseq_stats.cs, cpu));
 		stats.clear	+=3D data_race(per_cpu(rseq_stats.clear, cpu));
 		stats.fixup	+=3D data_race(per_cpu(rseq_stats.fixup, cpu));
+		if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION)) {
+			stats.s_granted	+=3D data_race(per_cpu(rseq_stats.s_granted, cpu));
+			stats.s_expired	+=3D data_race(per_cpu(rseq_stats.s_expired, cpu));
+			stats.s_revoked	+=3D data_race(per_cpu(rseq_stats.s_revoked, cpu));
+			stats.s_yielded	+=3D data_race(per_cpu(rseq_stats.s_yielded, cpu));
+			stats.s_aborted	+=3D data_race(per_cpu(rseq_stats.s_aborted, cpu));
+		}
 	}
=20
 	seq_printf(m, "exit:   %16lu\n", stats.exit);
@@ -148,6 +155,13 @@ static int rseq_stats_show(struct seq_file *m, void *p)
 	seq_printf(m, "cs:     %16lu\n", stats.cs);
 	seq_printf(m, "clear:  %16lu\n", stats.clear);
 	seq_printf(m, "fixup:  %16lu\n", stats.fixup);
+	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION)) {
+		seq_printf(m, "sgrant: %16lu\n", stats.s_granted);
+		seq_printf(m, "sexpir: %16lu\n", stats.s_expired);
+		seq_printf(m, "srevok: %16lu\n", stats.s_revoked);
+		seq_printf(m, "syield: %16lu\n", stats.s_yielded);
+		seq_printf(m, "sabort: %16lu\n", stats.s_aborted);
+	}
 	return 0;
 }
=20

