Return-Path: <linux-tip-commits+bounces-7704-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BD0CBCE87
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 09:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECE493042483
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 07:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F8532A3F9;
	Mon, 15 Dec 2025 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V4J3ftPn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P3dHUkj5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FADB32A3C2;
	Mon, 15 Dec 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765785563; cv=none; b=ntpQOGibcfmwO1d9XXZI44h1wTsI2wSRIf4x9i3yyZ6qenGKbjVSvbBuSZ25aadZOCRPcmeUOX4uUp4Xbk4k6gxtMFc1LglzbCiyEGmvw6XieuUgCdu2x4LwxMVpaipSNVGU9jJYjJM9wNBd0jPdbNgnlX5VydskSl4V0WGTGKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765785563; c=relaxed/simple;
	bh=FshHX6c3HVoJwsuMTIWHxjlL9nieV+GVDbEJDfKyupI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DoHuHbfUepw1Md5ZRATkWLcHfaJ+TZRkFQ8FrUYqtRvhSrZrpdB5M2oAtM6k4qI13I5irV1VkYSlxLvbd2T4I/HfFgr9VWaifaWwNV/tKd8KnrZ923XW6L6vU0VBgKxEkNrLhUcljmjcfeuHM3epqaOxhBLLHbndovpDtZrJgsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V4J3ftPn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P3dHUkj5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 07:59:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765785555;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjPWJiWce27Ywo837aqoukPI/HAvyNkmpXWi0/k/Fq8=;
	b=V4J3ftPn3PRpHLWEzqFmUkueBdpirb14B9BP1YoNPHHA9kdo5Y/uXCR72eFLRDRnuZqJA3
	7ErbDIHZHgwWcAQ74FT7A7hfkEdf9moaS2HzyJpUue4LrxKrC4Bcb2bo6BMz0/1cmuR958
	zgzVoRmzL8QjDqxnDpkU3yW3YWtS6nDFuWgFFTuZeeUw881cwEBtfpbCcMh2XpkDGwl8u3
	otTZd1vIw4R88JHcexxzeGGieHsvNvVzFqpUspxIp9IX+RFjrmGifqEWb/W5Zhn+4UW/Hl
	rnDsOJpHj+8x15XJgTPoDRHrVma5SiMA8XnY65BX8L/lJv7q6WUde0za8eK5uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765785555;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjPWJiWce27Ywo837aqoukPI/HAvyNkmpXWi0/k/Fq8=;
	b=P3dHUkj5EibHRDJYskueKFvV/HLH1gylS723s52P/RbxiuLSCHUmgPAWvvuyZT2N3N5bHY
	1mGMSs1sNnNpB/BQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Clean up comments in 'struct cfs_rq'
Cc:
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251201064647.1851919-3-mingo@kernel.org>
References: <20251201064647.1851919-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176578555402.498.12683563603998883879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fb9a7458e508ef1beae8d80ee40c2cd1b5b45f3a
Gitweb:        https://git.kernel.org/tip/fb9a7458e508ef1beae8d80ee40c2cd1b5b=
45f3a
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 26 Nov 2025 11:29:18 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 15 Dec 2025 07:52:44 +01:00

sched/fair: Clean up comments in 'struct cfs_rq'

 - Fix vertical alignment
 - Fix typos
 - Fix capitalization

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251201064647.1851919-3-mingo@kernel.org
---
 kernel/sched/sched.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2173e3d..82522c9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -670,13 +670,13 @@ struct balance_callback {
 	void (*func)(struct rq *rq);
 };
=20
-/* CFS-related fields in a runqueue */
+/* Fair scheduling SCHED_{NORMAL,BATCH,IDLE} related fields in a runqueue: */
 struct cfs_rq {
 	struct load_weight	load;
 	unsigned int		nr_queued;
-	unsigned int		h_nr_queued;       /* SCHED_{NORMAL,BATCH,IDLE} */
-	unsigned int		h_nr_runnable;     /* SCHED_{NORMAL,BATCH,IDLE} */
-	unsigned int		h_nr_idle; /* SCHED_IDLE */
+	unsigned int		h_nr_queued;		/* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		h_nr_runnable;		/* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		h_nr_idle;		/* SCHED_IDLE */
=20
 	s64			avg_vruntime;
 	u64			avg_load;
@@ -690,7 +690,7 @@ struct cfs_rq {
 	struct rb_root_cached	tasks_timeline;
=20
 	/*
-	 * 'curr' points to currently running entity on this cfs_rq.
+	 * 'curr' points to the currently running entity on this cfs_rq.
 	 * It is set to NULL otherwise (i.e when none are currently running).
 	 */
 	struct sched_entity	*curr;
@@ -739,7 +739,7 @@ struct cfs_rq {
 	 */
 	int			on_list;
 	struct list_head	leaf_cfs_rq_list;
-	struct task_group	*tg;	/* group that "owns" this runqueue */
+	struct task_group	*tg;	/* Group that "owns" this runqueue */
=20
 	/* Locally cached copy of our task_group's idle value */
 	int			idle;

