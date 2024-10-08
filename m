Return-Path: <linux-tip-commits+bounces-2367-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB21994606
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 13:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818002830C5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 11:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1CE18D652;
	Tue,  8 Oct 2024 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NB1Ab8tA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VY3oTxy5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF418A94E;
	Tue,  8 Oct 2024 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385514; cv=none; b=EMm+TJM73FKKfP9dc1Vkp812SVlwiFO0H86OstBCRbLl0SSmeYBFNc7GXQtgL31bh3mAaUq3O+Vyzn6Ngky+d9uo1Fj7fA6X5jDAmOTZRoxnB0tURhbaQ8x/8qpePS49gdrJ3gxkHudZzRgHUaXLuO7/lXIY9XIkTwSKdn09dmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385514; c=relaxed/simple;
	bh=4LtgtWzprXLsPbS6kJuqVsH7ld5W7HAjs/XeShR/y7w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XYxG/tGVU6FcQ1gjnhUfNdo0AVtsfxkSyAjuZd32Ag/8f+uUa+RvqhxcK8Bqmb6mmVd0l76ZvM6pEt0gL/E16vs0MpyncMUdm0aK877ZYcDojhBJDoc/quHfoQfr0Df8QK4FbTNu2sIsJZHafKLCJvREB00Mwl96IlrcgQgliBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NB1Ab8tA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VY3oTxy5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 11:05:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728385511;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAqBU4zlbsiEUBcmOiuLprWc2KSGF+b7XuZew5etUC8=;
	b=NB1Ab8tAh6VhZhHvoO5faEuYAIWqU08Z31qSIh13fWcQnbvewATP0teWGuyFVaC1eLpVSU
	4A8SZW55+2yY3LxsgE3qCpmXqpcsnE1q/3UKdN0Ou6iPWxn0cHGkFTPfGuV1zJ1M+282XX
	znCXjOPwvE4vb1KF1Pe3/MoVyZuy7zsuzvZQ6X6L4QGWM11tG6f4HdJmpzVpy8b6eaxxqW
	GY9wg2rAXkFPT1Gj6G0/uKgYLlmi9/nOwp14dQWDShhLgPIsjiRuYPkZfmpgdK2nHznyX5
	fZWtQofIergmpcbU8wzbGY9eKkf9lfiVmrGRNa42YYkA57xkfn1ubO0NTQEbEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728385511;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAqBU4zlbsiEUBcmOiuLprWc2KSGF+b7XuZew5etUC8=;
	b=VY3oTxy54LH0rMWw0GmeXAZOwp8juWYLs0mLHXnOBYMd6eNY2sFEV1MkR9hgKqIF0QuM5+
	SzILr7M5vUBtytCA==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes: fold xol_take_insn_slot() into xol_get_insn_slot()
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241001142503.GA13633@redhat.com>
References: <20241001142503.GA13633@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172838551018.1442.3527533027258106388.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6c74ca7aa81a23c613b8ca52bfe0a4b3734dd287
Gitweb:        https://git.kernel.org/tip/6c74ca7aa81a23c613b8ca52bfe0a4b3734dd287
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Tue, 01 Oct 2024 16:25:03 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:45 +02:00

uprobes: fold xol_take_insn_slot() into xol_get_insn_slot()

After the previous change xol_take_insn_slot() becomes trivial, kill it.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20241001142503.GA13633@redhat.com
---
 kernel/events/uprobes.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a1c801e..2a00594 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1641,28 +1641,19 @@ static unsigned long xol_get_slot_nr(struct xol_area *area)
 }
 
 /*
- *  - search for a free slot.
- */
-static unsigned long xol_take_insn_slot(struct xol_area *area)
-{
-	unsigned long slot_nr;
-
-	wait_event(area->wq, (slot_nr = xol_get_slot_nr(area)) < UINSNS_PER_PAGE);
-
-	return area->vaddr + slot_nr * UPROBE_XOL_SLOT_BYTES;
-}
-
-/*
  * xol_get_insn_slot - allocate a slot for xol.
  */
 static bool xol_get_insn_slot(struct uprobe *uprobe, struct uprobe_task *utask)
 {
 	struct xol_area *area = get_xol_area();
+	unsigned long slot_nr;
 
 	if (!area)
 		return false;
 
-	utask->xol_vaddr = xol_take_insn_slot(area);
+	wait_event(area->wq, (slot_nr = xol_get_slot_nr(area)) < UINSNS_PER_PAGE);
+
+	utask->xol_vaddr = area->vaddr + slot_nr * UPROBE_XOL_SLOT_BYTES;
 	arch_uprobe_copy_ixol(area->page, utask->xol_vaddr,
 			      &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
 	return true;

