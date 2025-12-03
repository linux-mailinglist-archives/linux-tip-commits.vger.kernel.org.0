Return-Path: <linux-tip-commits+bounces-7592-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41356CA13F0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 20:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 616B43249C7B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A973164D0;
	Wed,  3 Dec 2025 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H3DKM0OE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DRtYAveW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1330C342;
	Wed,  3 Dec 2025 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786312; cv=none; b=TFc+12pV0jBLJO2ekRkgGY1kw0D1C1vwZjzp4ZY0fp2vSzzsHsaf9cruGnFEHrUsth+fkNsbsq5UHYZoZU7zs90JfRNcRTZ9JMDMWwDQIGXLCKr51LHLpNhd32FB1Qrbgj4q8XK9UiNOvk6pfldyrcNAOYCaYdZhVL08rkgnDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786312; c=relaxed/simple;
	bh=ARfI3hoaPXqAAGKgBz05pwl6S3owjNfFp1GEmcaGsuw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tqP2P+abMqr3d7YAfnlrEZWg8D6nStYV6kuYXBXSNwLkwAfZRUqtXAmBQn3C6Vafuy1YjZrUcbPPPYdiIY7PZYQsVxccHRUXzUuo88kEhYXcsjUK8etx5Wcz0vu88TIwSSZJvflt3X2iTK+a2sst7GuwWr86KwSnBG9z/V8IFVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H3DKM0OE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DRtYAveW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 18:25:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764786305;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jmr1BZ5lDLnSrEBjSsWKaSHk/WzSfIJrE4HjTTT0P6w=;
	b=H3DKM0OEzCDYrBubonbE6cCrQRR8g1i7qCBS9Ql1E/QfhRr0tSCjmv//N2Sz4s6/V4QM0F
	K13L/yGuKBgoJ5oF+8KhKdBSJJblBJnMDMHrbvosWtcH3OHblyAXYYY2xWWx0ROQ7R9s46
	wY3VH9VkwyT+CXws/RL/cbtoAKeO19iJ4H+5TtxmuwI/pmNcDIkPrRb8rP7gh9O95NXgWb
	SufwoKCuQ06CMv/zVLkWLD9QpJSqIY6ERCw0kOb34TBORCjX1otqE7Q3W7JW6Oqh+UY8wY
	QHfcGP6h7vg9DSrMSSmhIfOZv9ODf/kWDn2oOQqKnoW38e1rWtTo1np5VXq7Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764786305;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jmr1BZ5lDLnSrEBjSsWKaSHk/WzSfIJrE4HjTTT0P6w=;
	b=DRtYAveWuzjJgbW+8WJ14PUxGMSFsy8JjSfRxGhMDMAYmSvPSnwkzfWLvI7uC5jT1SM0Bh
	jQOqojjwjS3J9wCg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/uprobes: Remove <space><Tab> whitespace noise
Cc:
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <176478594889.498.15611228524880763978.tip-bot2@tip-bot2>
References: <176478594889.498.15611228524880763978.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478630411.498.17592209148526349458.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     92546f6b523b1d4757c2ee606d4d0eefc98ea26b
Gitweb:        https://git.kernel.org/tip/92546f6b523b1d4757c2ee606d4d0eefc98=
ea26b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 03 Dec 2025 18:19:08=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 19:23:01 +01:00

perf/uprobes: Remove <space><Tab> whitespace noise

A few cases of space-Tab noise snuck in.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/176478594889.498.15611228524880763978.tip-bot2=
@tip-bot2
---
 kernel/events/uprobes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index f11ceb8..d546d32 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -79,7 +79,7 @@ struct uprobe {
 	 * The generic code assumes that it has two members of unknown type
 	 * owned by the arch-specific code:
 	 *
-	 * 	insn -	copy_insn() saves the original instruction here for
+	 *	insn -	copy_insn() saves the original instruction here for
 	 *		arch_uprobe_analyze_insn().
 	 *
 	 *	ixol -	potentially modified instruction to execute out of
@@ -107,8 +107,8 @@ static LIST_HEAD(delayed_uprobe_list);
  * allocated.
  */
 struct xol_area {
-	wait_queue_head_t 		wq;		/* if all slots are busy */
-	unsigned long 			*bitmap;	/* 0 =3D free slot */
+	wait_queue_head_t		wq;		/* if all slots are busy */
+	unsigned long			*bitmap;	/* 0 =3D free slot */
=20
 	struct page			*page;
 	/*
@@ -116,7 +116,7 @@ struct xol_area {
 	 * itself.  The probed process or a naughty kernel module could make
 	 * the vma go away, and we must handle that reasonably gracefully.
 	 */
-	unsigned long 			vaddr;		/* Page(s) of instruction slots */
+	unsigned long			vaddr;		/* Page(s) of instruction slots */
 };
=20
 static void uprobe_warn(struct task_struct *t, const char *msg)

