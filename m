Return-Path: <linux-tip-commits+bounces-2078-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEE8955B46
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACAA2824A4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CE47D405;
	Sun, 18 Aug 2024 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gBeiPQkb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="byrPGRCN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C643D25570;
	Sun, 18 Aug 2024 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962197; cv=none; b=l3atXeCBNmZ5vTcqqDIbbLZHMMVMMiILFy5NRTUvr+RfbN3GtU5uMDkCjNnrG6Mv1Whhv5M6JdtuP2MKMOm6Usn94CCBKPSOE0GLZx8ISLhkyPSxGc+xYobpzAH88YemmsL0PQrbrVxgknTgwAkxvabHf/mW+TLm3ZO0zEuswVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962197; c=relaxed/simple;
	bh=RCT1vw7GkOh44AOLZ/Rrzry2uj9NxrAN3qfjrgjN+7A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Gc/OEe2+rgwtVCvPJw1eUlhIcHHaJISGhG6aH7vclYrtSkiTx9tNGP22jCijkwvMTort804rkXWyFtoXugbTl5z80Z86eP9TVvGpeFzZ4duCQtzKDCZK3kkEhAECPEUp+7bW+G9hXXYyvj4ZrIqNS7VENeZ7GUH+i6+S1CGoTQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gBeiPQkb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=byrPGRCN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7UOPGAHn8IblAR5C9mHoZ01Ujbmcoae+rmg4Gp0T5M=;
	b=gBeiPQkbd+xbUG6/LyvbY8+OaqSPeWoxffiNHN3eYsApMs0tXypc76punrgWpS9AAAhvkv
	WP+UAVz+7zAoWz84mCTXgXOQH4jr1Zt0WTYi+Wh3Mj+7RB48oGKNJAx9RNB0w5UfQh0HX1
	rGvzq7KHG2jSZOo10zFopEn5nqnVCVYmFquBWf7AnlQqWVpOQOIBOrAVO21rNTCPKK8rRi
	87K2IEYY7zGYiK7xHbUWYLlZNsAUSmuHguu2mJwW/PA3SkG+RHOlaq4eFj6BUbfEFOY2pg
	c3NgDtE3iQP4zV/t97PShaWYOF29jeuXfu+k6hf4y+0c5bd1koz/rQ249unItw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7UOPGAHn8IblAR5C9mHoZ01Ujbmcoae+rmg4Gp0T5M=;
	b=byrPGRCNe750F7R/dW9dugT2Yh++/Jb3BQu5BCUEWnkhJpnI66j4zkK+BeMB14t72uoIJK
	FCOA+6shBDDK5SDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/eevdf: Add feature comments
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105028.287790895@infradead.org>
References: <20240727105028.287790895@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396219256.2215.1836630580131088615.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f25b7b32b0db6d71b07b06fe8de45b0408541c2a
Gitweb:        https://git.kernel.org/tip/f25b7b32b0db6d71b07b06fe8de45b0408541c2a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 14 Oct 2023 23:12:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:40 +02:00

sched/eevdf: Add feature comments

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105028.287790895@infradead.org
---
 kernel/sched/features.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 929021f..97fb2d4 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -5,7 +5,14 @@
  * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
  */
 SCHED_FEAT(PLACE_LAG, true)
+/*
+ * Give new tasks half a slice to ease into the competition.
+ */
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
+/*
+ * Inhibit (wakeup) preemption until the current task has either matched the
+ * 0-lag point or until is has exhausted it's slice.
+ */
 SCHED_FEAT(RUN_TO_PARITY, true)
 
 /*

