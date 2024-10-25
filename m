Return-Path: <linux-tip-commits+bounces-2564-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727489B0672
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DC11C20506
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8C1231CA1;
	Fri, 25 Oct 2024 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lIAcUCV6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="11aH1RKc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B878820BB5F;
	Fri, 25 Oct 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868039; cv=none; b=goumPVZ5vDJgR/85Ir0AB4EU5ChenjVUGnAb0QMDAWRN93S8ilF3ZOD0dF+ng8wxGvL9QuVXcgnjiJxac1UueV13kYjwazdWVFe+U3Cf7+KouIXmGOh+yRyfpk+c3tjj+tk9HZH10yH9P8hSzvqlUAxdCH286tX4VommzxCTHhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868039; c=relaxed/simple;
	bh=FApSlPZbe5Paq297Ev+TyXMK8lFNRjzf69EGGzl9bLE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=saqIUuk4ZSliRdYoMJpWj6ZBUA8URDYlyCnGlVv1WqNegEky/W6HhOaAvg7DJQT66HAcakc5r/SllTEpsraQCUoeKjfTq8ckFXUPHLECZARBxcpK7mfaRTrCxC0I01TRDEDDecADWlpLeEDl5FHsEU4LgfsP+kUU5S5sEW932oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lIAcUCV6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=11aH1RKc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:53:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuI6JVLMZ9YuXZ0wF0M2p4+3ODDIDmVFfu/PStBodOQ=;
	b=lIAcUCV6Q94M8128y46zfZUgMXTI5ZpY5qYq4LMNAkO0DlGmOjWkXeggSk1Wh+pRtz26A1
	ebMs5Q7j0r0agE6eRtpKUxWLxcnqm4PNRfGyTYujbr5B/KvuPU8pdgBFk85sAf3NLdMJ6t
	xKnik1SsHkbEIhR2JazlwiDjrusGt/5DvcAaDngcswUU1uDnkeLoPftfOfnXN6LHLsjJn8
	s17ANua22Vu+hg8YcVRbgOIDvZTYf7jh6NxGOlnQueSeigWYE01mbFwcy/0HY6fbH/Kf8c
	hnugjuY8K21+0GNXqKOnQZIX6VAQdUQo81VV88NJRpRdUHIoz4MLid4rxCLSJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuI6JVLMZ9YuXZ0wF0M2p4+3ODDIDmVFfu/PStBodOQ=;
	b=11aH1RKcXro9ff81HhqUd9I3SEhgXXXU40ovyiUaRKMUUIG5KrhIjo1cM/fAqYL2H2HZAP
	lc/OdnGoqH1Kv3Ag==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Define a struct type for tk_core to
 make it reusable
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-10-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-10-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172986803467.1442.8648601627993749977.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     206db8b13619beedf8a3660abf02c2eb543853d4
Gitweb:        https://git.kernel.org/tip/206db8b13619beedf8a3660abf02c2eb543853d4
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:41:12 +02:00

timekeeping: Define a struct type for tk_core to make it reusable

The struct tk_core uses is not reusable. As long as there is only a single
timekeeper, this is not a problem. But when the timekeeper infrastructure
will be reused for per ptp clock timekeepers, an explicit struct type is
required.

Define struct tk_data as explicit struct type for tk_core.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-10-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5392a66..d520c11 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -45,12 +45,14 @@ enum timekeeping_adv_mode {
  * The most important data for readout fits into a single 64 byte
  * cache line.
  */
-static struct {
+struct tk_data {
 	seqcount_raw_spinlock_t	seq;
 	struct timekeeper	timekeeper;
 	struct timekeeper	shadow_timekeeper;
 	raw_spinlock_t		lock;
-} tk_core ____cacheline_aligned;
+} ____cacheline_aligned;
+
+static struct tk_data tk_core;
 
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;

