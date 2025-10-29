Return-Path: <linux-tip-commits+bounces-7063-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 040F8C19B5D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25B8E4F861D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990CE3321BB;
	Wed, 29 Oct 2025 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZrtuMcEy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l78rMJtC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29942331A47;
	Wed, 29 Oct 2025 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733424; cv=none; b=Nx6uQjQElxHI1rmVpWwBw9cPUfpIIP4LP1x1GsboCG60x2ksH1EbZ6KIXlLcT0ULDB0NXJ5EQ+IOFkkb1PCgUFHYeb8xTsKM4ZbaN+up3iUpXj0WRwn0e8OrmdSV9/SymgbHIsl2zk74SMEhG/k7xl+ou6nTNTUgoBYD18NdSxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733424; c=relaxed/simple;
	bh=2sPISW/xarqyWMa6Pkx6cePAyUiqDVKLrHVVowKpALs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mv1nNMVjlo7DoUKp3HeLbYP8SvF9591PQFyVe6noc3LVgRU/pOTuTnpgSIGnFxcUEfiyK/Cxz9nTH3eUAsWsby7XkW/12NzKn8wArFvo820xqSfmUHs438KDBp3xUa4dqKB6x2cAotCiIj+yxtxjvTWAyWPpP8pvJFOMuBfidyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZrtuMcEy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l78rMJtC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHnGQkvrOW9SWQvyo8O6gl4MrQ1+zm4mnjK3WAeHth0=;
	b=ZrtuMcEyka2E9/RWoy1LJNkfgvX2UW6y/Pmc84bjn/JH4dBjenpA/utIIYz+Q7vSd0sLUA
	l26Ay9RBf6nISUJOD2Tu/XXpr1GxwkEM2jXLRz7rLlYn2OyVwWwkT2AstlEuvGmBYmbxYa
	xujMsFTiRsooyar4iru2GAsDYm1BwgZrTzb9TEM4sO0VtfxzgLeRpAOiMNxZj1yV8w37kx
	MN12fcZ/tGkUAfDVkD77ArLOnJ95WV0PKShduuQCLzUb2xr8YB0m/urPDypYHpZy6djxy3
	sAr4QaYg2hyoPNnk9J4jqrG+2v/XtJIOFwstRDm/LHy1xgWa98UJxJqQkeKr8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHnGQkvrOW9SWQvyo8O6gl4MrQ1+zm4mnjK3WAeHth0=;
	b=l78rMJtCRDMOF5cF7WIai/2B2QFV1VpvTI0VSeWH7yWD5yYl8WO9MrTJPhWVmhPSkrroDR
	oXG/z3JgmRCkYfCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Make exit debugging static branch based
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084307.272660745@linutronix.de>
References: <20251027084307.272660745@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173341883.2601451.10555933563551716093.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     0042fe6474333f3e29984054fe4b3b56d1611847
Gitweb:        https://git.kernel.org/tip/0042fe6474333f3e29984054fe4b3b56d16=
11847
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:17 +01:00

rseq: Make exit debugging static branch based

Disconnect it from the config switch and use the static debug branch. This
is a temporary measure for validating the rework. At the end this check
needs to be hidden behind lockdep as it has nothing to do with the other
debug infrastructure, which mainly aids user space debugging by enabling a
zoo of checks which terminate misbehaving tasks instead of letting them
keep the hard to diagnose pieces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084307.272660745@linutronix.de
---
 include/linux/rseq_entry.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index f9510ce..5bdcf5b 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -285,7 +285,7 @@ static __always_inline void rseq_exit_to_user_mode(void)
=20
 	rseq_stat_inc(rseq_stats.exit);
=20
-	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
+	if (static_branch_unlikely(&rseq_debug_enabled))
 		WARN_ON_ONCE(ev->sched_switch);
=20
 	/*

