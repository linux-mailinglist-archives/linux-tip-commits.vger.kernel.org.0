Return-Path: <linux-tip-commits+bounces-7424-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C30C73B03
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A7D802AA0B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E87335570;
	Thu, 20 Nov 2025 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tK5LMV0T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J0A9OZFl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C84333731;
	Thu, 20 Nov 2025 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637615; cv=none; b=V3/3K/WV6lAvYkGqJyBgNBuD8lhyF5l/C/4qeAktl6Sdyak56NqYzJ5nQiYIuRagAGtR8CGY9uTaw0hRNhKi7yIu38LQUrWiTndhwf9rzoSZbPXHZDQfntdm6hu0lv5MtCXi4G041a0qtPIXsz33fuh3OAO0kVFtgYrs9u9IvWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637615; c=relaxed/simple;
	bh=kE7k429Iid5misEmy2ART5Dhk7OQJ01myRilHGlOGKQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JSDNr7cRea2eG27vTFwxNCsfQNfWexTy0RhRSRJzado5Vd+/7HMdjbY+IUGErjcGibAH92JSfas5CHdJexL0oir7AXz2qOGp1NZp92yyYBn9HKhxTt7oE0HoCrxlYRsOGqN0l3IDsXS0nvnVzY1nj5izk3Hb+A0g9ghF4KxRT4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tK5LMV0T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J0A9OZFl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:20:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c//UsD5ZtnlNB9N1xT6dxgsI+WmO5UaBu0472AMECmc=;
	b=tK5LMV0TQtZjtRRKQeyODLIotRsmPDsrQ5pYMmz1ZzHzklzJSaFBV6a9xc/MMOeeFZW+fb
	/XHdmxu5804WDxHdPo+ed3r+VU0H7EV3ZSwKy83HzKT9GpOr7KNcsjo9BCQDHn0mkbm1Wq
	h6OVvz4KN/pk6Nhu07iHF7E9SWwMx8Koi8fi2eo/L3nXHJKB6/eBVWps0qdD0juxAVmTxw
	wcbmJSdN9fcOe8QwFCuj5L+4sTdNyMQQJq+srDywcWPXLxDIhC+5oeM4N69BuABZzLTzfo
	RRl7158QYAl6kWveoQsMF6sWaW7TCIA0wQCD6h+zqS7zmAYOkvf/iibBiXUVSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c//UsD5ZtnlNB9N1xT6dxgsI+WmO5UaBu0472AMECmc=;
	b=J0A9OZFljmBUEKbXk/lztxt3wNpyuHtcs9zA3WR3Ku0PThjlc+u+9rNUOP56E053tiDbmq
	wXowXpTDh61EFxBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] sched/mmcid: Cacheline align MM CID storage
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172549.194111661@linutronix.de>
References: <20251119172549.194111661@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176363760634.498.1894935121666974461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     be4463fa2c7185823d2989562162d578b45a89ae
Gitweb:        https://git.kernel.org/tip/be4463fa2c7185823d2989562162d578b45=
a89ae
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:26:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:53 +01:00

sched/mmcid: Cacheline align MM CID storage

Both the per CPU storage and the data in mm_struct are heavily used in
context switch. As they can end up next to other frequently modified data,
they are subject to false sharing.

Make them cache line aligned.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251119172549.194111661@linutronix.de
---
 include/linux/rseq_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index e444dd2..d7e8071 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -112,7 +112,7 @@ struct sched_mm_cid {
  */
 struct mm_cid_pcpu {
 	unsigned int	cid;
-};
+}____cacheline_aligned_in_smp;
=20
 /**
  * struct mm_mm_cid - Storage for per MM CID data
@@ -126,7 +126,7 @@ struct mm_mm_cid {
 	struct mm_cid_pcpu	__percpu *pcpu;
 	unsigned int		nr_cpus_allowed;
 	raw_spinlock_t		lock;
-};
+}____cacheline_aligned_in_smp;
 #else /* CONFIG_SCHED_MM_CID */
 struct mm_mm_cid { };
 struct sched_mm_cid { };

